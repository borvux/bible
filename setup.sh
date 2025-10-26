#!/bin/bash

OLD_TESTAMENT_BOOKS="01-Genesis|genesis|Genesis|50
02-Exodus|exodus|Exodus|40
03-Leviticus|leviticus|Leviticus|27
04-Numbers|numbers|Numbers|36
05-Deuteronomy|deuteronomy|Deuteronomy|34
06-Joshua|joshua|Joshua|24
07-Judges|judges|Judges|21
08-Ruth|ruth|Ruth|4
09-1 Samuel|1samuel|1 Samuel|31
10-2 Samuel|2samuel|2 Samuel|24
11-1 Kings|1kings|1 Kings|22
12-2 Kings|2kings|2 Kings|25
13-1 Chronicles|1chronicles|1 Chronicles|29
14-2 Chronicles|2chronicles|2 Chronicles|36
15-Ezra|ezra|Ezra|10
16-Nehemiah|nehemiah|Nehemiah|13
17-Esther|esther|Esther|10
18-Job|job|Job|42
19-Psalms|psalms|Psalms|150
20-Proverbs|proverbs|Proverbs|31
21-Ecclesiastes|ecclesiastes|Ecclesiastes|12
22-Song of Solomon|songofsolomon|Song of Solomon|8
23-Isaiah|isaiah|Isaiah|66
24-Jeremiah|jeremiah|Jeremiah|52
25-Lamentations|lamentations|Lamentations|5
26-Ezekiel|ezekiel|Ezekiel|48
27-Daniel|daniel|Daniel|12
28-Hosea|hosea|Hosea|14
29-Joel|joel|Joel|3
30-Amos|amos|Amos|9
31-Obadiah|obadiah|Obadiah|1
32-Jonah|jonah|Jonah|4
33-Micah|micah|Micah|7
34-Nahum|nahum|Nahum|3
35-Habakkuk|habakkuk|Habakkuk|3
36-Zephaniah|zephaniah|Zephaniah|3
37-Haggai|haggai|Haggai|2
38-Zechariah|zechariah|Zechariah|14
39-Malachi|malachi|Malachi|4"

NEW_TESTAMENT_BOOKS="01-Matthew|matthew|Matthew|28
02-Mark|mark|Mark|16
03-Luke|luke|Luke|24
04-John|john|John|21
05-Acts|acts|Acts|28
06-Romans|romans|Romans|16
07-1 Corinthians|1corinthians|1 Corinthians|16
08-2 Corinthians|2corinthians|2 Corinthians|13
09-Galatians|galatians|Galatians|6
10-Ephesians|ephesians|Ephesians|6
11-Philippians|philippians|Philippians|4
12-Colossians|colossians|Colossians|4
13-1 Thessalonians|1thessalonians|1 Thessalonians|5
14-2 Thessalonians|2thessalonians|2 Thessalonians|3
15-1 Timothy|1timothy|1 Timothy|6
16-2 Timothy|2timothy|2 Timothy|4
17-Titus|titus|Titus|3
18-Philemon|philemon|Philemon|1
19-Hebrews|hebrews|Hebrews|13
20-James|james|James|5
21-1 Peter|1peter|1 Peter|5
22-2 Peter|2peter|2 Peter|3
23-1 John|1john|1 John|5
24-2 John|2john|2 John|1
25-3 John|3john|3 John|1
26-Jude|jude|Jude|1
27-Revelation|revelation|Revelation|22"

process_book() {
    local testament_path=$1
    local book_dir_name=$2
    local book_file_name=$3
    local book_title=$4
    local num_chapters=$5

    local book_dir_path="./${testament_path}/${book_dir_name}"
    local book_file_path="${book_dir_path}/${book_file_name}.md"

    if [ ! -d "${book_dir_path}" ]; then
        echo "!! Skipping: Directory not found at ${book_dir_path}"
        return
    fi

    echo "Processing: ${book_title} (${num_chapters} chapters)"

    cat > "${book_file_path}" <<- EOM
---
layout: default
title: ${book_title}
parent_title: Home
parent_url: /
---

## Chapters

EOM

    for i in $(seq 1 ${num_chapters}); do
        echo "* [${i}](./${i}.md)" >> "${book_file_path}"
    done

    for i in $(seq 1 ${num_chapters}); do
        local chapter_file_path="${book_dir_path}/${i}.md"
        
        if [ ! -f "${chapter_file_path}" ]; then
            cat > "${chapter_file_path}" <<- EOM
---
layout: default
title: Chapter ${i}
parent_title: ${book_title}
parent_url: ./${book_file_name}.md
---

# ${book_title} - Chapter ${i}
EOM
        fi
    done
}

echo "--- Starting Bible Structure Setup ---"
echo "This will overwrite main book files (e.g., genesis.md) to create chapter lists."
echo "It will NOT overwrite any chapter files you have already written notes in (e.g., 10-Ephesians/6.md)."
echo ""

echo "--- Processing Old Testament ---"
echo "${OLD_TESTAMENT_BOOKS}" | while IFS='|' read -r dir file title chapters; do
    process_book "1-Old-Testament" "$dir" "$file" "$title" "$chapters"
done

echo ""
echo "--- Processing New Testament ---"
echo "${NEW_TESTAMENT_BOOKS}" | while IFS='|' read -r dir file title chapters; do
    process_book "2-New-Testament" "$dir" "$file" "$title" "$chapters"
done

echo ""
echo "--- Structure Setup Complete! ---"
