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

# Create todo file
todo() {
    local current_week=$(date +%U)
    local existing_file=""
    for file in week-*-todo.md; do
        if [[ -f $file ]]; then
            local week_number=$(echo "$file" | grep -oP '(?<=week-)\d+(?=-todo\.md)')
            if [[ -z $existing_file || $week_number -gt $(echo "$existing_file" | grep -oP '(?<=week-)\d+(?=-todo\.md)') ]]; then
                existing_file=$file
            fi
        fi
    done

    if [[ -n $existing_file ]]; then
        local highest_week=$(echo "$existing_file" | grep -oP '(?<=week-)\d+(?=-todo\.md)')
        if [[ $current_week -le $highest_week ]]; then
            echo "File for week $current_week already exists: $existing_file"
            return
        fi
    fi

    local new_file="week-${current_week}-todo.md"
    if [[ -n $existing_file ]]; then
        # Copy template and modify its contents
        sed -E \
            -e "s/(# Week) [0-9]+( To Do:)/\1 ${current_week}\2/" \
            -e 's/^(- \[x\] )(.*)$/\1~~\2~~/' \
            "$existing_file" > "$new_file"
        echo "File for week $current_week created using $existing_file as a template: $new_file"
    else
        echo "# Week ${current_week} To Do:" > "$new_file"
        echo -e "\n## 1. Title\n- [ ] Task goes here" >> "$new_file"
        echo "File for week $current_week created: $new_file"
    fi
}

# Generate a Geekbot post from an input markdown file
todo_geekbot() {
  local input_file="$1"

  if [[ ! -f "$input_file" ]]; then
    echo "❌ File not found: $input_file"
    return 1
  fi

  local output_file="${input_file%.md}_geekbot.md"

  awk '
    BEGIN {
      todo     = "🔲"
      doing    = "⚒️"
      blocked  = "🟨"
      done     = "✅"
    }
    {
      # Replace list markers with emojis
      gsub(/- \[ \]/, "- " todo)
      gsub(/- \[o\]/, "- " doing)
      gsub(/- \[b\]/, "- " blocked)
      gsub(/- \[x\]/, "- " done)

      print
    }
  ' "$input_file" > "$output_file"

  echo "✅ Geekbot post saved to: $output_file"
}
