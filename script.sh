#!/bin/bash

echo "Creating Old Testament directories and files..."

old_testament_books=(
    "Genesis" "Exodus" "Leviticus" "Numbers" "Deuteronomy" "Joshua" "Judges" "Ruth" 
    "1 Samuel" "2 Samuel" "1 Kings" "2 Kings" "1 Chronicles" "2 Chronicles" "Ezra" 
    "Nehemiah" "Esther" "Job" "Psalms" "Proverbs" "Ecclesiastes" "Song of Solomon" 
    "Isaiah" "Jeremiah" "Lamentations" "Ezekiel" "Daniel" "Hosea" "Joel" "Amos" 
    "Obadiah" "Jonah" "Micah" "Nahum" "Habakkuk" "Zephaniah" "Haggai" "Zechariah" "Malachi"
)

main_ot_dir="1-Old-Testament"
mkdir -p "${main_ot_dir}"

i=1
for book in "${old_testament_books[@]}"; do
    num=$(printf "%02d" $i)
    dir_path="${main_ot_dir}/${num}-${book}"
    mkdir -p "${dir_path}"

    file_name=$(echo "${book}" | tr '[:upper:]' '[:lower:]' | tr -d ' ')
    file_path="${dir_path}/${file_name}.md"

    echo "# ${book}" > "${file_path}"
    
    i=$((i+1))
done

echo "Creating New Testament directories and files..."

new_testament_books=(
    "Matthew" "Mark" "Luke" "John" "Acts" "Romans" "1 Corinthians" "2 Corinthians" 
    "Galatians" "Ephesians" "Philippians" "Colossians" "1 Thessalonians" "2 Thessalonians" 
    "1 Timothy" "2 Timothy" "Titus" "Philemon" "Hebrews" "James" "1 Peter" "2 Peter" 
    "1 John" "2 John" "3 John" "Jude" "Revelation"
)

main_nt_dir="2-New-Testament"
mkdir -p "${main_nt_dir}"

j=1
for book in "${new_testament_books[@]}"; do
    num=$(printf "%02d" $j)
    dir_path="${main_nt_dir}/${num}-${book}"
    mkdir -p "${dir_path}"

    file_name=$(echo "${book}" | tr '[:upper:]' '[:lower:]' | tr -d ' ')
    file_path="${dir_path}/${file_name}.md"

    echo "# ${book}" > "${file_path}"

    j=$((j+1))
done
