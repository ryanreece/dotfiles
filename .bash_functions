# Generate a random string based on the input length 
generate_random_string() {
    # Set the default length to 12 if no parameter is provided
    local length=${1:-12}
    
    # Calculate the number of bytes needed to generate the desired base64 string length
    # Base64 encoding expands every 3 bytes of data to 4 characters
    local byte_count=$((length * 3 / 4))
    
    # Generate a random string using openssl and the calculated byte count
    openssl rand -base64 "$byte_count"
}

# Extract common file types
extract() {
    # Check if a file name is provided
    if [ -z "$1" ]; then
        echo "Usage: extract <filename>"
        return 1
    fi

    # Store the file name and extension
    local file="$1"
    
    # Determine the extraction command based on the file extension
    case "$file" in
        *.tar.gz|*.tgz) 
            tar -xzf "$file" 
            ;;
        *.tar.bz2|*.tbz) 
            tar -xjf "$file" 
            ;;
        *.tar.xz|*.txz) 
            tar -xJf "$file" 
            ;;
        *.tar) 
            tar -xf "$file" 
            ;;
        *.gz) 
            gunzip "$file" 
            ;;
        *.bz2) 
            bunzip2 "$file" 
            ;;
        *.zip) 
            unzip "$file" 
            ;;
        *.rar) 
            unrar x "$file" 
            ;;
        *.7z) 
            7z x "$file" 
            ;;
        *)
            echo "Unsupported file type: $file"
            return 1
            ;;
    esac

    # Success message
    echo "Extraction complete."
}
