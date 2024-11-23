#!/bin/bash

# Function to decrypt the encrypted string using AES-256-CBC
decrypt_input() {
    encrypted="$1"
    key="$2"
    iv="$3"

    # Decrypt the input using openssl with AES-256-CBC
    decrypted=$(echo -n "$encrypted" | openssl enc -aes-256-cbc -d -K "$key" -iv "$iv" -base64)

    echo "Decrypted Output: $decrypted"
}

# Function to decrypt a file
decrypt_file() {
    file="$1"
    key="$2"
    iv="$3"

    # Decrypt the file using openssl with AES-256-CBC
    openssl enc -aes-256-cbc -d -K "$key" -iv "$iv" -in "$file" -out "${file%.enc}.dec" -base64

    echo "File Decryption Successful!"
    echo "Decrypted file saved as: ${file%.enc}.dec"
}

# Main script execution
echo "Choose an option:"
echo "1. Decrypt a string"
echo "2. Decrypt a file"
read -p "Enter your choice (1-2): " choice

case $choice in
    1)
        echo "Please enter the encrypted string to decrypt:"
        read encrypted_string
        echo "Please enter the key for decryption:"
        read user_key
        echo "Please enter the IV for decryption:"
        read user_iv
        decrypt_input "$encrypted_string" "$user_key" "$user_iv"
        ;;
    2)
        read -p "Please enter the encrypted file path to decrypt: " encrypted_file_path
        if [[ -f "$encrypted_file_path" ]]; then
            echo "Please enter the key for decryption:"
            read user_key
            echo "Please enter the IV for decryption:"
            read user_iv
            decrypt_file "$encrypted_file_path" "$user_key" "$user_iv"
        else
            echo "File not found!"
        fi
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac