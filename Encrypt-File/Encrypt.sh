#!/bin/bash

#Function to encrypt the input string using AES-256-CBC
encrypt_input()
{
    input="$1"

    # Generate a random key and IV
    key=$(openssl rand -hex 32) #32 bytes for AES-256
    iv=$(openssl rand -hex 16)  #16 bytes for AES block size

    #Encrypt the input using openssl with AES-256
    encrypted=$(echo -n "$input" | openssl enc -aes-256-cbc -k "$key" -iv "$iv" -base64)

    #Output the key , IV, and encrypted data
    echo "Encryption Successful"
    echo "key: $key"
    echo "IV: $iv"
    echo "Encrypted Output: $encrypted"
}

#Function to encrypt a file
encrypt_file()
{
    file="$1"

    # Generate a random key and IV
    key=$(openssl rand -hex 32)  # 32 bytes for AES-256
    iv=$(openssl rand -hex 16)   # 16 bytes for AES block size

    # Encrypt the file using openssl with AES-256-CBC
    openssl enc -aes-256-cbc -K "$key" -iv "$iv" -in "$file" -out "${file}.enc" -base64

    echo "File Encryption Successful!"
    echo "Key: $key"
    echo "IV: $iv"
    echo "Encrypted file saved as: ${file}.enc"
}

# Main script execution
echo "Choose an option:"
echo "1. Encrypt a string"
echo "2. Encrypt a file"
read -p "Enter your choice (1-2):" choice

case $choice in
    1)
        echo "Please enter your random characters (including speciall characters) to encrypt:"
        read user_input
        encrypt_input "$user_input"
        ;;
    2)
        read -p "Please enter the file path to encrypt: " file_path
        if [[ -f "$file_path" ]]
        then
            encrypt_file "$file_path"
        else
            echo "File not found!"
        fi
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac