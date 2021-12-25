#!/bin/sh
echo "\nHide your message in an image! \n"
echo "1. Download the image file in which you want to embed the data \n2. Save it in desktop for ease"
echo "\nEnter the image file name: "
read image_name
echo "\n1. Create a text file containing the message you want to embed.\n2. Save it in desktop"
echo "Enter the text file name: "
read text_name

sudo apt-get install steghide
#if any error while installing, rm the file;
cd Desktop
#steghide command gives its various options
steghide embed -cf $image_name -ef $text_name

echo "\nEmbedded data successfully"
echo "Remember the passphrase!"