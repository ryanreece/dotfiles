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
