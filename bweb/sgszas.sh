Hiding Data Inside an Audio File
I remember my teacher telling me that I was not going to code this assigment. Well, here I am. I don’t know if I did this because she told me I was not going to, or maybe because I wanted to feel like a neckbeard that codes on C++. That was irrelevant. I suck at intros. Let’s movee on

Little bit of background
Steganography is the technique used to hide data inside other data, for example, to hide a secret message inside a picture, or a secret picture inside a music file. There are several ways to do that, and there are several softwares out there too. Some use complex algorithms and are pretty good at doing their job (it’s difficult to say that there is actually hidden data, and even harder to retrieve it), some other use very simple algorithms and are easy to detect and break.

Hiding a file
Alright, so let’s set up our files before starting. First of all identify the arguments passed from the command line and.

For this explanation I am going to focus on hiding a file inside an wav file.
./program output.wav file.jpg

Note that this is not the actual project code structure, this is just simplified for explanation purposes
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
// Get input files into stream
ifstream input(inputPath, std::ios::binary );
if(!input.is_open())

binStremFile.open(string(argv[2]), std::ios::binary );
            binFileSize = binStremFile.tellg();
            msgBuffer.reserve(binFileSize); // Reserve the amount of the file size of memory to the vector

// Load the files into buffers so we can close the streams
vector<char> buffer(
                (istreambuf_iterator<char>(input)),
                (istreambuf_iterator<char>()));
msgBuffer.assign(
            (istreambuf_iterator<char>(binStremFile)),
            (istreambuf_iterator<char>()));

input.close();
binStremFile.close();
Here I load the files safely into vector buffers and then close them so they suffer no changes on the run. Now on I will only mess with the buffers.



1
2
3
4
5
int status = PlayWithWaveBuffer(buffer, msgBuffer, fileExt, inputExt);
if (status == SUCCESS)
    cout << "Hiding process has finished successfully.\nCleaning memory..." << endl;
else if (status == ERROR)
    cout << "Something failed.\nCleaning memory..." << endl;
Next, call the method “PlayWithBuffer” and pass our buffers as reference in order to waste the minimum amount of memory. This funcitons will told us if the hiding process was good or no.



Logic
Let’s define how the function will work

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
int PlayWithWaveBuffer(vector<char>& buffer, vector<char>& msgBuffer, string& fileExtension, string& inputExt)
{
    char* modulusBytes = new char[4] {0}; // Max number of modulus in bytes
    char* customHeader = new char[MY_HEADER] {0}; // Custom header

    // Set end flag
    msgBuffer.push_back('@');
    msgBuffer.push_back('<');
    msgBuffer.push_back(';');
    msgBuffer.push_back(';');

    // How many times the buffer is bigger than the message
    // buffer.size() - (HEADER SIZE = 44 bytes) /  (msgBuffer + My own tags to de hidden file = 9 bytes)
    long modulus = ((buffer.size() - WAV_HEADER ) / (msgBuffer.size() + MY_HEADER));

    cout << "Spreading level: " << modulus << endl;

    // Verify if it is safe to hide the message. Must me at must half the size of the space avaible
    if(modulus <= 2)
    {
        cout << "The message might be to big for the audio file" << endl;
        return ERROR;
    }
First, allocate memory for to arrays we are going to use later on.

Then, set an end flag at the end of the file that consists on the characters '@<;;' in order to help the hidden-message-finder function.

Since the algorithm uses modulus to spread the bytes of the secret message, we need it to spread it all over the file as much as possible. So this makes our modulus = (*The space avaible to write in*) / (*The secret message*).



Note that the space avaible we have equals the *buffer size* - *his header* (in this example a wav header) that consist of 44 bytes [1].

Wave file format"

And the whole message that is goin to be written equals secret-message size + custom header



Custom header
The cusotm header is a header I made for the secret files in order to help de hidden-message-finder function. Consisting in only 9 bytes, will speed up things and make the life easier for the user.

1
2
3
4
5
int PlayWithWaveBuffer(vector<char>& buffer, vector<char>& msgBuffer, string& fileExtension, string& inputExt)
{
  ...

  CreateHeader(modulus, modulusBytes, customHeader, fileExtension, false);
So now, call this little funcition that si going to set our custom header.

Again pass everything possible as reference to optimize memory



1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
void CreateHeader(long& modulus, char* modulusBytes, char* customHeader, string& fileExtension, bool isBinaryType)
{
    /**
    * Create custom header (9 bytes):
    * Modulus value: 4 bytes
    * File extension: 4 bytes
    * Message type (text or file): 1 byte
    * */

    // If modulus is lesser than the max int value of 4 bytes assign it.
    // Otherwise, set a flag to use DEF_MODULE constant
    if (!(modulus > 429467295))
        modulusBytes = reinterpret_cast<char*>(&modulus);
    else
        modulusBytes[0] = DEF_MODULE;

    int y, i;
    // Assign modulus to header
    for (i = 0; i < 4; i++)
        customHeader[i] = modulusBytes[i];

    // Assign the file extension to recover later
    for(y = 0, i = 4; i < 8; i++, y++)
    {
        // Dinamically fill the 4 bytes of the file extension even if it's less than 4 characters
        if(fileExtension.size() > y )
            customHeader[i] = fileExtension.at(y);
        else
            customHeader[i] = ' ';
    }

    // Assign the type of the message
    if (isBinaryType)
        customHeader[8] = 'b';
    else
        customHeader[8] = 't';
}
Clear as crystal, right?.

Since the custom header consists in just 9 bytes, we need to take full advantage of it, and this is how it’s done:

Setting module
This will be used when retrieving the file in order let the finder function know the modulus that was assigned to this secret file. Doing it this way, the user does not have to put any kind of file keys or whatever to indicate the program where to find the secret file. this will make the process automated and user friendly.

Check first if the modulus we got from the above operation is bigger than the max int of 4 bytes (429467295).

 If it’s not then we are good to go. Convert that number into bytes:

modulusBytes = reinterpret_cast<char*>(&modulus); and put them into the first 4 bytes or the custom header array.

If the secret file is so small that has a bigger module, then use a constant (This will be very rare in a real case scenario).



Setting the file extension of the secret file
We will use this to assign it to the retrieved file, again, in order to be more automated and user friendly. This way if the user hid a mp3 he will get a mp3 in the recover, if he hid a jpg he will get a jpg directly too and so on.

 Here we just asssing the file extension (Max of 4 characters) into the next 4 bytes.

1
2
3
4
5
6
7
8
9
// Assign the file extension to recover later
for(y = 0, i = 4; i < 8; i++, y++)
{
    // Dinamically fill the 4 bytes of the file extension even if its less than 4 characters
    if(fileExtension.size() > y )
        customHeader[i] = fileExtension.at(y);
    else
        customHeader[i] = ' ';
}


Setting the type of file
 If the program detects the secret file as a text/string set character ’t’

 If it was detected a a binary file set character ‘b’



Moving on
Alright, now that we have defined the cusotm header lets continue.

Writing the header
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
int PlayWithWaveBuffer(vector<char>& buffer, vector<char>& msgBuffer, string& fileExtension, string& inputExt)
{ ...

  int n = 0, pos = 0;
  // Write my custom header first (Spread)
    for (vector<char>::iterator it = buffer.begin() + WAV_HEADER;
         it != buffer.end(); ++it)
    {
        if (n % MY_HEADER_MODULE == 0)
        {
            *it = customHeader[pos];
            pos++;

            if (pos == MY_HEADER)
            {
                cout << "Header wrote" << endl;
                break;
            }
        }
        n++;
    }

    // Delete arrays we are not using it anymore
    modulusBytes = new char[1]; // Relocate memory
    delete[] modulusBytes;
    delete[] customHeader;
Here we are going to write our custom header the C++ way, using vectors and iterators[2].

First we itinialize the iterator at the beginning of the buffer + the length of the header:

vector<char>::iterator it = buffer.begin() + WAV_HEADER.

Now, to make it spread each byte of the header over the file:

Write a byte every n % MY_HEADER_MODULE == 0 . Where MY_HEADER_MODULE is an already specified constant used for the header (ie: 64) and n the value of the iteration.

 This will make the program to write a byte every MY_HEADER_MODULE (ie: 64) bytes.

Finally just delete the arrays to free the memory.

1
2
delete[] modulusBytes;
delete[] customHeader;


Writing the secret file
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
int PlayWithWaveBuffer(vector<char>& buffer, vector<char>& msgBuffer, string& fileExtension, string& inputExt)
{ ...

  int j = 0;
    pos = 0;
    for (vector<char>::iterator it = buffer.begin() + WAV_HEADER + n + MY_HEADER_MODULE;
         it != buffer.end(); ++it)
    {
        if (j % modulus == 0)
        {
            *it = msg.at(pos);
            pos++;
            //cout << *it << endl; // Uncomment this to see the message being written

            if (pos >= msg.size())
                break;
        }
        j++;
    }

    return OutputBindedData(buffer, inputExt);
}
Here is pretty much the same as writting the header in the file.

Note that the iterator was now initializated like this :

1
vector<char>::iterator it = buffer.begin() + WAV_HEADER + n + MY_HEADER_MODULE;
because now that we wrote the header, we have a little bit of less space avaible.

 In order to write the actual data (finally) the funcition is the same as writing the header but instead of using MY_HEADER_MODULE, we will use the variable modulus we calculated before: j % modulus == 0

When writing is over, it will call OutputBindedData. This functions basically gets the modified buffer (with the header and the secret file on it) and output it as a file with the same extension.

We are almost done. 



Retrieving a file
Now in order to retrieve a secret file we now just need to specify the modded file because the header will tell us the module of the secret file.

./program output.wav -f

Where the flag -f or --find indicates that you want to find a secret file/text in it

Let’s get into it:

1
int status = FindHiddenMessage(buffer);
Here we this functions instead of PlayWithWaveBuffer one. Of course the buffer is the file given as a parameter once is loaded.



Get the header
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
int FindHiddenMessage(vector<char>& buffer)
{
    char* customHeader = new char[MY_HEADER] {0}; // Custom header

    int n = 0;
    int pos = 0;
    vector<char>::iterator tempIterator;
    for (vector<char>::iterator it = buffer.begin() + WAV_HEADER;
         it != buffer.end(); ++it)
    {
        if (n % MY_HEADER_MODULE == 0)
        {
            customHeader[pos] = *it;
            pos++;
            if (pos == MY_HEADER)
            {
                //cout << "Header has been read " << endl;
                break;
            }
        }
        n++;
    }

    ...
 Almost the same as writing the custom header, but in this case we are reading the bytes instead of writing them.

Note that we are using the same MY_HEADER_MODULE constant we used to write the header.



1
2
3
4
5
6
7
int FindHiddenMessage(vector<char>& buffer)
{ ...

  CustomHeader cHeader (customHeader);

    // Clean memory
    delete[] customHeader;
 So now that we have a char* array with the header data, we are going to use it to initialize a little class I made that will help us to access it’s attributes quickly and easier.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
CustomHeader::CustomHeader(char* header) {
    // Set modulus first
    char* bytes = new char[4];
    for (int i = 0; i < 4; i++)
        bytes[i] = header[i];

    mModulus = *reinterpret_cast<int*>(bytes);

    // Set extension
    char* ext = new char[4];
    for (int y = 0, i = 4; i < 8; i++, y++)
        ext[y] = header[i];

    mExtension = std::string(ext);
    boost::algorithm::trim(mExtension);

    // Set type
    mType = header[8];

    delete[] bytes;
    delete[] ext;
}
Get the secret file modulus from bytes to int.
1
2
3
4
5
char* bytes = new char[4];
for (int i = 0; i < 4; i++)
    bytes[i] = header[i];

mModulus = *reinterpret_cast<int*>(bytes);


Get the file extension.
1
2
3
4
5
6
char* ext = new char[4];
for (int y = 0, i = 4; i < 8; i++, y++)
    ext[y] = header[i];

mExtension = std::string(ext);
boost::algorithm::trim(mExtension);


Get the type of data and clean memory.
1
2
3
4
mType = header[8];

delete[] bytes;
delete[] ext;


Finding the data
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
int FindHiddenMessage(vector<char>& buffer)
{ ...
    if (cHeader.GetType() == 'b')
    {
        cHeader.SetLastPosition(n);
        return FindHiddenBinaryInWave(buffer, cHeader);
    }
    else if (cHeader.GetType() == 't'){
        cHeader.SetLastPosition(n);
        return FindHiddenTextInWave(buffer, cHeader);
    }
    else{
        // If it hits here it's because there was no message found in the file
        return ERROR;
    }
}
Now just check what kind of data is hidden (For this explanation, ‘b’). And get the last position of the byte (n) in the buffer (For this explanation, since MY_HEADER_MODULE} equals 64 and our custom header length is 9, the value of n will be 64 * 8 = 512, since n won’t hit the last n++, but we are going to add it when getting the secret file.)



1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
int FindHiddenBinaryInWave(vector<char>& buffer, CustomHeader& customHeader)
{
    vector<char> msgBuffer;

    int modulus = customHeader.GetModulus();
    int lastPos = customHeader.GetLastPosition();

    int n = 0;
    int pos = 0;
    vector<char>::iterator tempIterator;
    for (vector<char>::iterator it = buffer.begin() + WAV_HEADER + lastPos + MY_HEADER_MODULE;
         it != buffer.end(); ++it)
    {
        if (n % modulus == 0)
        {
            if (*it == 64)
            {
                // @
                //Setting the iterator to the next possible position
                tempIterator = buffer.begin() + n + 44 + MY_HEADER_MODULE + lastPos + modulus;

                if (*tempIterator == 60) {
                    //<
                    //Setting the iterator to the next possible position
                    tempIterator = buffer.begin() + n + 44 + MY_HEADER_MODULE + lastPos + (2* modulus);

                    if (*tempIterator == 59) {
                        // ;
                        // Setting the iterator to next possible flag
                        tempIterator = buffer.begin() + n + 44 + MY_HEADER_MODULE + lastPos + (3 * modulus);

                        if (*tempIterator == 59){
                          //;
                            // End of message reached
                            cout << "Message recovered size: " << pos << " bytes" << endl;
                            return OutputBinFile(msgBuffer, customHeader);
                        }
                    }
                }
            }

            msgBuffer.push_back(*it);
            //cout << "Data recovered: " << msgBuffer[pos] << endl; // Uncomment this if you want to see the characters being read
            pos++;

        }
        n++;
    }

    // If it hits here it's because there was no message found in the file
    cout << "Could not find the end tags of the hidden file :(" << endl;
    return ERROR;
}
And this is finally how it retrieves the hidde file.

 First we initialize the iterator like this:

1
itinialize = buffer.begin() + WAV_HEADER + lastPos + MY_HEADER_MODULE;
Where lastPos is the value of the past n and we add the MY_HEADER_MODULE to it to set the next position.

To iterate, it uses the modulus specified on his header n % modulus == 0 in order to find its bytes and realocate them in a buffer



1
2
3
4
if (*it == 64) // 64 = '@'
if (*it == 60) // 64 = '<'
if (*it == 59) // 64 = ';'
if (*it == 59) // 64 = ';'
When the iterator fonunds the characters @<;; in a “sequence” (using modulus because that sequence its spread as if part of the secret file) that would mean that the whole secret file bytes have been retrieved. This helps in the performance by making it stop reading the file when the retrieve has been completed.

And finally he can proceed to output the secret file with its extension previously setted in its header. This way everything posible is automated.



Tests on my code
I didn’t find any significant difference in the spectrum and the difference in the waveforms is minimal.

Mp3 test: Original below

Mp3 comparisson



Wave test: Original above

Wav comparisson



Run examples
If you want to hear some audio examples check these out:

Audio files
3 of them have a message on it and the other 3 are clean.

The zip with the answers and the audios:

Answers.zip


Conclusion
Steganography can be pretty cool and useful. This can maybe an alternative in those countries where cryptography is illegal. Also, the point of using stehanography is to communicate with “innocent” messages that does not attract attention in contrast with plain encrypted messages that certainly will atract attention.

You can find reliable and scientific information about steganography, digital watermarking (which is basically the same thing) and how to detect them on sites like the Neil Johnson site, the Fabien Petitcolas site, and several others.

The code of this project can be found on my repo, so check it out:  AudioStego.



References
[1] Standford.edu WAVE PCM soundfile format.

[2] Cplusplus documentaion Iterator.

assignment steganography

« RSA auth - Web service

Comments

Copyright © 2014 - Daniel Cardenas - Powered by Octopress - Theme by Alex Garibay
