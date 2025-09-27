#!/bin/bash

echo "Choose your operating system:"
echo "1) Windows"
echo "2) Mac/Linux"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "Running keytool for Windows..."
        keytool -genkey -v -keystore ./android/upload-keystore.jks \
                -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 \
                -alias upload \
                -storepass codebase -keypass codebase \
                -dname "CN=Codebase App, OU=Development, O=Codebase Organization, L=City, ST=State, C=US"
        ;;
    2)
        echo "Running keytool for Mac/Linux..."
        keytool -genkey -v -keystore ./android/upload-keystore.jks -keyalg RSA \
                -keysize 2048 -validity 10000 -alias upload \
                -storepass codebase -keypass codebase \
                -dname "CN=Codebase App, OU=Development, O=Codebase Organization, L=City, ST=State, C=US"
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose 1 or 2."
        exit 1
        ;;
esac