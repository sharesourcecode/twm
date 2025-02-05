#!/bin/bash
# Script Name: create_language_po.sh
# This script facilitates the creation of a .po file for translations using the Disroot API.

# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

twm_dir="twm"
cd $HOME/$twm_dir
SCRIPT=$HOME/$twm_dir/${1}
TRANSLATE="$2"
SOURCE="en"  # Source language set to English
# List of target languages for translation
TARGET="de en es fr hi id it pl pt ro ru sr zh"

# Define the path to the LANGUAGE.po file
FILE="$HOME/$twm_dir/LANGUAGE.po"

# Define the text to be kept in the first line
TEXT="de Deutsch|en English|es Español|fr Français|hi hindi|id Indonesian|it Italiano|pl Polski|pt Português|ro Română|ru Русский|sr Srpski|zh 中文"

# Check if the file exists
if [ -f "$FILE" ]; then

# Check if the first line is empty
 if [ "$(head -n 1 "$FILE")" != "$TEXT" ]; then
# If the first line is empty, insert the text at the top and shift existing lines down
  echo "$TEXT" | cat - "$FILE" > temp && mv temp "$FILE"
 else
# If the first line is not empty, replace it with the desired text
  sed -i "1s/.*/$TEXT/" "$FILE"
 fi

else
# If the file does not exist, create it and add the text
 echo "$TEXT" > "$FILE"
fi

reset; clear  # Clear the terminal screen

# Function to extract and clean lines from files
#extract_lines() {
# local file_pattern="$1"
# grep -o --color 'GT ".*"' $file_pattern | \
#  awk -F':' '{print $2}' | \
#   awk '!/\//' | awk '!/;/' | awk '!/%/' | \
#    sed 's/\${[A-Z_a-z]*}//g;s/\$(.*)//g;s/(.*)//g' | \
#     sed 's/\\n//g' | sed 's/printf //g' | \
#      awk '/[A-Za-z0-9]/' | \
#       sed 's/🏳️👨‍🏴‍👩‍🏳️👧‍🏴‍👦🏳️//g;s/👫 //g;s/ 👣 //g;s/  👈//g;s/🏴🏳️ //g;s/🚶//g;s/ 😴 //g;s/   //g;s/ . //g;s/        //g;s/"//g;s/--------//g;s/\$[A-Z_a-z]*//g;s/\\033\[02m//g;s/ 💤...//g;s/\\//g;s/^[ \t]*//;s/[ \t]*$//' | \
#        awk 'length($0) > 2' | awk NF
#}

# Clear the TEXTS file before starting
#> TEXTS

# Process each file pattern
#for pattern in "$HOME/$twm_dir/allies.lib"; do
# extract_lines "$pattern" >> TEXTS
#done

# Remove lines with a single number between two letters
#sed -i '/[A-Za-z][0-9][A-Za-z]/d' TEXTS

# Remove specific unwanted lines
#sed -i '/=&/d;/⚔️/d' TEXTS

# Ensure no empty lines remain
#awk NF TEXTS > TEMP && mv TEMP TEXTS

ls
if [ -z "$SCRIPT" ]; then
 printf "\nScript name:\n"
 read SCRIPT
fi

if ! grep -q -o -E '\$\(G_T ["'\''"]([^"'\''"]*?)["'\''"]\)' $SCRIPT; then
 echo '** Function structure different from $(G_T "..."), or not existing. Please add the structures **'
 echo 'Opening the nano in 10 seconds...'
 read -t 10 var
 unset var
 nano -l -Y sh $SCRIPT
 wait
fi

grep -o -E '\$\(G_T ["'\''"]([^"'\''"]*?)["'\''"]\)' $SCRIPT | sed 's/\$(G_T "//g; s/")//g' >TEXT
#sed 's/\$\(G_T \(["'\'']\)\(.*\)\(["'\'']\)\)/\3/' >TEXT

# Remove duplicate lines directly from TEXTS
awk '!seen[$0]++' TEXT > TEMP && mv TEMP TEXT
cat -n TEXT >TEXTS
grep --color ".*" TEXTS

if [ -z "$TRANSLATE" ]; then
 printf "\nTerm to translate:\n"
 read TRANSLATE
fi

if grep -q -F "|$TRANSLATE|" "$HOME/$twm_dir/LANGUAGE.po"; then
 echo 'This term is already translated'

# Get the line number of the matched term
 LINE_NUMBER=$(grep -n -F "|$TRANSLATE|" "$HOME/$twm_dir/LANGUAGE.po" | head -n 1 | cut -d: -f1)

# Open nano at the specific line
 nano -l -S -Y po +$LINE_NUMBER "$HOME/$twm_dir/LANGUAGE.po"
 exit 0
fi

#while IFS= read -r TRANSLATE; do
 T=""

 for i in $TARGET; do
  url="https://translate.disroot.org/translate"  # API endpoint for translation
  data='{"q":"'"${TRANSLATE}"'","source":"'"${SOURCE}"'","target":"'"${i}"'","format":"text","alternatives":0,"api_key":""}'

  if [ "$i" == "$SOURCE" ]; then
   R="$TRANSLATE"
  else
# Make a POST request to the translation API and store the response
   R=$(curl -s -X POST "$url" -H "Content-Type: application/json" -d "$data")
# Extract the translated text from the JSON response
   R=$(echo "$R" | awk -F':' '{print $2}' | awk -F'"' '{for (i=2; i<NF; i+=2) print $i}')
  fi

  T="${T}|${R}"  # Append the translation to the result string

# Print the current language being translated
  case $i in
   de) echo "Deutsch: $R" ;;
   en) echo "English: $R" ;;
   es) echo "Español: $R" ;;
   fr) echo "Français: $R" ;;
   hi) echo "Hindi: $R" ;;
   id) echo "Indonesian: $R" ;;
   it) echo "Italiano: $R" ;;
   pl) echo "Polski: $R" ;;
   pt) echo "Português: $R" ;;
   ro) echo "Română: $R" ;;
   ru) echo "Русский: $R" ;;
   sr) echo "Srpski: $R" ;;
   zh) echo "中文: $R" ;;
  esac
 done

 echo "$T" | sed 's/^|//' >> ~/$twm_dir/LANGUAGE.po
#done < TEXTS

# Remove duplicate lines directly from TEXTS
awk '!seen[$0]++' LANGUAGE.po > TEMP && mv TEMP LANGUAGE.po
rm -rf TEXTS TEMP

nano -l -S -Y po +$(wc -l < LANGUAGE.po) LANGUAGE.po
