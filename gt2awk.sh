#!/bin/sh
# Copyright (c) 2019-2024 Ueliton Alves Dos Santos
# Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License

# bourn shell
# Function to translate a string

twm_dir="twm-master"
content=$(cat "$HOME/$twm_dir/LANGUAGE.po")
gettext () {
    # Use awk to extract the appropriate translation based on the LANGUAGE variable
    translation=$(echo "$content" | awk -v lang="$LANGUAGE" -F'|' '
        NR==1 {
            # Store the index of each language in a variable
            for (i=1; i<=NF; i++) {
                if ($i ~ /en/) { idx_en = i; }
                else if ($i ~ /de/) { idx_de = i; }
                else if ($i ~ /es/) { idx_es = i; }
                else if ($i ~ /fr/) { idx_fr = i; }
                else if ($i ~ /hi/) { idx_hi = i; }
                else if ($i ~ /id/) { idx_id = i; }
                else if ($i ~ /it/) { idx_it = i; }
                else if ($i ~ /pl/) { idx_pl = i; }
                else if ($i ~ /pt/) { idx_pt = i; }
                else if ($i ~ /ro/) { idx_ro = i; }
                else if ($i ~ /ru/) { idx_ru = i; }
                else if ($i ~ /sr/) { idx_sr = i; }
                else if ($i ~ /zh/) { idx_zh = i; }
            }
        }
        NR > 1 {
            # If the corresponding line for the English translation is found, print the translation for the desired language
            if ($idx_en == "'"$1"'") {
                if (lang == 1) print $idx_de;
                else if (lang == 2) print $idx_en;
                else if (lang == 3) print $idx_es;
                else if (lang == 4) print $idx_fr;
                else if (lang == 5) print $idx_hi;
                else if (lang == 6) print $idx_id;
                else if (lang == 7) print $idx_it;
                else if (lang == 8) print $idx_pl;
                else if (lang == 9) print $idx_pt;
                else if (lang == 10) print $idx_ro;
                else if (lang == 11) print $idx_ru;
                else if (lang == 12) print $idx_sr;
                else if (lang == 13) print $idx_zh;
            }
        }
    ')

    # If no translation is found, return the original string
	if [ "$LANGUAGE" -eq '6' ]; then
		echo "${translation:-$1}" | awk -F'|' -v lang="$LANGUAGE" '{print $(lang)}' | awk 'NF'
	else
		echo "${translation:-$1}" | awk 'NF'
	fi
}

# Example usage for different languages
LANGUAGE=$1
echo "$(gettext "Command execution was interrupted!")"
