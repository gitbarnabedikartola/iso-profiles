#!/bin/bash


## changes in /usr/lib/manjaro-tools/  START ##
if [ -z $(grep BigLinux /usr/lib/manjaro-tools/util-iso-image.sh) ];then
    # Remove last } in /usr/lib/manjaro-tools/util-iso-image.sh
    sudo sed -i ':a;$!{N;ba;};s/\(.*\)}/\1/' /usr/lib/manjaro-tools/util-iso-image.sh
    # adicionar ao arquivo /usr/lib/manjaro-tools/util-iso-image.sh
    echo '  #BigLinux clean
        path=$1/usr/share/doc
        if [[ -d $path ]]; then
            rm -Rf $path/* &> /dev/null
        fi

        #BigLinux clean
        path=$1/usr/share/man
        if [[ -d $path ]]; then
            rm -Rf $path/* &> /dev/null
        fi

        #Clean LibreOffice
        path=$1/usr/lib/libreoffice/share/config
        if [[ -d $path ]]; then
        rm -f $path/images_karasa_jaga* &> /dev/null
        rm -f $path/images_elementary* &> /dev/null
        rm -f $path/images_sukapura* &> /dev/null
        rm -f $path/images_colibre_svg.zip &> /dev/null
        rm -f $path/images_sifr_dark_svg.zip &> /dev/null
        rm -f $path/images_sifr_svg.zip &> /dev/null
        rm -f $path/images_breeze_dark_svg.zip &> /dev/null
        rm -f $path/images_breeze_svg.zip &> /dev/null
        fi

        #Clean LibreOffice
        path=$1/usr/share/wallpapers
        if [[ -d $path ]]; then
            rm -Rf $path/Altai
            rm -Rf $path/BytheWater
            rm -Rf $path/Cascade
            rm -Rf $path/ColdRipple
            rm -Rf $path/DarkestHour
            rm -Rf $path/EveningGlow
            rm -Rf $path/Flow
            rm -Rf $path/FlyingKonqui
            rm -Rf $path/IceCold
            rm -Rf $path/Kokkini
            rm -Rf $path/Next
            rm -Rf $path/Opal
            rm -Rf $path/Patak
            rm -Rf $path/SafeLanding
            rm -Rf $path/summer_1am
            rm -Rf $path/Autumn
            rm -Rf $path/Canopee
            rm -Rf $path/Cluster
            rm -Rf $path/ColorfulCups
            rm -Rf $path/Elarun
            rm -Rf $path/FallenLeaf
            rm -Rf $path/Fluent
            rm -Rf $path/Grey
            rm -Rf $path/Kite
            rm -Rf $path/MilkyWay
            rm -Rf $path/OneStandsOut
            rm -Rf $path/PastelHills
            rm -Rf $path/Path
            rm -Rf $path/Shell
            rm -Rf $path/Volna
        fi

         }' | sudo tee -a /usr/lib/manjaro-tools/util-iso-image.sh
fi
## changes in /usr/lib/manjaro-tools/  END ##


## changes in /usr/share/manjaro-tools/  START ##
#bootsplash
if [ -z "$(grep bootsplash-biglinux /usr/share/manjaro-tools/mkinitcpio.conf)" ]; then
    sudo sed -i 's|keyboard keymap|keyboard keymap bootsplash-biglinux|g' /usr/share/manjaro-tools/mkinitcpio.conf
fi
    
#add big repository
if [ -z "$(grep biglinux-update-stable /usr/share/manjaro-tools/pacman-default.conf)" ];then
    sudo sed -i '/\[core\]/{h;s/.*/\[biglinux-update-stable\]/;p;x;}' /usr/share/manjaro-tools/pacman-default.conf
    sudo sed -i '/\[core\]/{h;s/.*/SigLevel = PackageRequired/;p;x;}' /usr/share/manjaro-tools/pacman-default.conf
    sudo sed -i '/\[core\]/{h;s/.*/Server = https:\/\/repo.biglinux.com.br\/update-stable\/$arch/;p;x;}' /usr/share/manjaro-tools/pacman-default.conf
    sudo sed -i '/\[core\]/{h;s/.*//;p;x;}' /usr/share/manjaro-tools/pacman-default.conf
fi
if [ -z "$(grep biglinux-stable /usr/share/manjaro-tools/pacman-default.conf)" ];then
    echo '
[biglinux-stable]
SigLevel = PackageRequired
Server = https://repo.biglinux.com.br/stable/$arch' | sudo tee -a /usr/share/manjaro-tools/pacman-default.conf
fi
if [ -z "$(grep biglinux-keyring /usr/share/manjaro-tools/pacman-default.conf)" ];then
    sudo sed -i '/SyncFirst/s/$/ biglinux-keyring/' /usr/share/manjaro-tools/pacman-default.conf
fi
## changes in /usr/share/manjaro-tools/  END ##


# ## remove in final version START ##
# # Disable remove pkgs cache
# sudo sed -i 's|path=$1/var/lib/pacman/sync|path=$1/usr/share/man|'g /usr/lib/manjaro-tools/util-iso-image.sh
# # Faster compression
sudo sed -i 's|-Xcompression-level 20|-Xcompression-level 6|g' /usr/lib/manjaro-tools/util-iso.sh
# ## remove in final version END ##

