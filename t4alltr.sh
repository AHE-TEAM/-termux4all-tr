#!/bin/bash
# Dizileri tanımlama
pkg=("bash" "zsh" "fish" "exa" "bat" "fd" "zoxide" "wget" "curl" "git" "openssh" "python" "python2" "file" "tokei" "qpdf" "tree" "util-linux" "findutils" "coreutils" "diffutils" "ncurses-utils" "nmap" "openvpn" "whois" "tar" "zip" "unzip" "gzip" "rar" "nano" "vim" "micro" "net-tools" "gdb" "tmux" "tmate" "htop")
dev_pkg=("clang" "python" "python2" "pip" "php" "golang" "ruby" "perl" "openjdk-17" "dart" "nodejs" "nodejs-lts" "openssl" "nodejs" "php-apache" "nginx" "apache2" "phpmyadmin" "postgresql" "mariadb" "sqlite" "docker" "docker-compose" "kotlin" "rust" "swift")
sec_pkg=("nmap" "hashcat" "hydra" "john" "nikto" "sqlmap" "yara" "dnsrecon" "whois" "fierce" "dirb" "gobuster" "onesixtyone" "linkchecker" "crunch" "cupp" "gdb" "ffuf" "whatweb" "httrack" "recon-ng" "steghide" "netmask" "dnsenum" "dnsmap" "dnswalk" "proxychains" "openvpn" "hashid" "smbclient" "wig" "dirsearch" "urlextractor" "exif" "hashdeep" "weevely" "yersinia" "patator" "cewl" "searx")
editors=("nano" "vim" "neovim" "micro" "codiad web ide" "emacs" "joe" "hexcurse" "ired" "radare2" "dcraw" "gifsicle" "gmic" "graphicsmagick" "imagemagick" "netpbm" "optipng" "ffmpeg")
cool_pkg=("cmatrix" "hollywood" "neofetch" "figlet" "toilet" "cowsay" "fortune" "lolcat" "sl" "moon-buggy" "nyancat" "ninvaders" "nudoko" "nsnake")

# Seçilen paketleri yükleme fonksiyonu
install_pkg() {
    local pkg_manager="apt" 

    for pkg_to_install in "${@}"; do
        echo -e "\e[1;92m$pkg_to_install yükleniyor..."
        yes | "$pkg_manager" install "$pkg_to_install"  # Otomatik olarak "evet" yanıtını ver
        echo " "
        echo -e "\e[1;92m$pkg_to_install paketi yüklendi."
        echo " "
    done
    # Devam etmek için Enter tuşuna basın
    read -p "Devam etmek için Enter tuşuna basın..."
}

# Ana menü
while true; do
    clear

#ANSI renk kodları
green="\e[32m"
reset="\e[0m"
# Yeşil renkte yazı sanatı
art="${green}
░▀█▀░█▀▀░█▀▄░█▄█░█░█░█░█░█░█░█▀█░█░░░█░░
░░█░░█▀▀░█▀▄░█░█░█░█░▄▀▄░░▀█░█▀█░█░░░█░░
░░▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░░▀░▀░▀░▀▀▀░▀▀▀
${reset}"

# Sanatı yazdır
    echo -e "$art"
    echo -e "\e[1;94m--------------------------------------"
    echo " "
    echo "1) Herkes için temel paketler (hepsi)"
    echo "2) Geliştirme paketleri"
    echo "3) Güvenlik paketleri (proot-distro)"
    echo "4) Editörler (metin/görüntü/hex/ses)"
    echo "5) Eğlenceli paketler"
    echo "6) Yukarıdaki tüm paketleri yükle (hepsi)"
    echo "7) Çıkış"
    echo " "
    read -p "Bir seçenek seçin (1-7): " choice

    case $choice in
    1)
        while true; do
            clear
            echo -e "\e[0;94mHerkes için Temel Paketler"
            echo "----------------------------"
            # Temel paketlerin listesini numaralarla göster
            for i in "${!pkg[@]}"; do
                echo "($((i+1))) ${pkg[$i]}"
            done
            echo "----------------------"
            echo "                        "
            echo "(1) Yüklemek istediğiniz paketleri seçin"
            echo "(2) Yukarıda listelenen tüm paketleri yükleyin"
            echo "(3) Geri"
            echo "(4) Çıkış"
            echo "                                              "
            read -p "Bir seçenek seçin (1-4): " basic_choice
            case $basic_choice in
            1)
                read -p "Yüklenecek paket numaralarını girin (örneğin, 1 2 3): " selected_pkg
                selected_pkg=($selected_pkg)
                if [[ "${selected_pkg[*]}" == *"geri"* ]]; then
                    break
                else
                    selected_packages=()
                    for index in "${selected_pkg[@]}"; do
                        selected_packages+=("${pkg[$((index-1))]}")
                    done
                    install_pkg "${selected_packages[@]}"
                fi
                ;;
            2)
                # Tüm temel paketleri birleştir
                all_basic_packages="${pkg[*]}"
                # Tüm temel paketleri yükle
                yes | install_pkg $all_basic_packages
                ;;
            3)
                break
                ;;
            4)
                exit
                ;;
            *)
                echo -e "\e[1;91mGeçersiz seçenek"
                ;;
            esac
        done
        ;;
    2)
        while true; do
            clear
            echo -e "\e[1;91mGeliştirme Paketleri"
            echo "---------------------"
            # Geliştirme paketlerinin listesini numaralarla göster
            for i in "${!dev_pkg[@]}"; do
                echo "($((i+1))) ${dev_pkg[$i]}"
            done
            echo "----------------------"
            echo "                        "
            echo "(1) Yüklemek istediğiniz paketleri seçin"
            echo "(2) Yukarıda listelenen tüm paketleri yükleyin"
            echo "(3) Geri"
            echo "(4) Çıkış"
            echo "                                              "
            read -p "Bir seçenek seçin (1-4): " dev_choice
            case $dev_choice in
            1)
                read -p "Yüklenecek paket numaralarını girin (örneğin, 1 2 3): " selected_dev_pkg
                selected_dev_pkg=($selected_dev_pkg)
                if [[ "${selected_dev_pkg[*]}" == *"geri"* ]]; then
                    break
                else
                    selected_dev_packages=()
                    for index in "${selected_dev_pkg[@]}"; do
                        selected_dev_packages+=("${dev_pkg[$((index-1))]}")
                    done
                    install_pkg "${selected_dev_packages[@]}"
                fi
                ;;
            2)
                # Tüm geliştirme paketlerini birleştir
                all_dev_packages="${dev_pkg[*]}"
                # Tüm geliştirme paketlerini yükle
                yes | install_pkg $all_dev_packages
                ;;
            3)
                break
                ;;
            4)
                exit
                ;;
            *)
                echo -e "\e[1;91mGeçersiz seçenek"
                ;;
            esac
        done
        ;;
    3)
        while true; do
            clear
            echo -e "\e[1;92mGüvenlik Paketleri"
            echo "-----------------"
            # Güvenlik paketlerinin listesini numaralarla göster
            for i in "${!sec_pkg[@]}"; do
                echo "($((i+1))) ${sec_pkg[$i]}"
            done
            echo "----------------------"
            echo "                        "
            echo "(1) Yüklemek istediğiniz paketleri seçin"
            echo "(2) Yukarıda listelenen tüm paketleri yükleyin"
            echo "(3) Geri"
            echo "(4) Çıkış"
            echo "                                              "
            read -p "Bir seçenek seçin (1-4): " sec_choice
            case $sec_choice in
            1)
                read -p "Yüklenecek paket numaralarını girin (örneğin, 1 2 3): " selected_sec_pkg
                selected_sec_pkg=($selected_sec_pkg)
                if [[ "${selected_sec_pkg[*]}" == *"geri"* ]]; then
                    break
                else
                    selected_sec_packages=()
                    for index in "${selected_sec_pkg[@]}"; do
                        selected_sec_packages+=("${sec_pkg[$((index-1))]}")
                    done
                    install_pkg "${selected_sec_packages[@]}"
                fi
                ;;
            2)
                # Tüm güvenlik paketlerini birleştir
                all_sec_packages="${sec_pkg[*]}"
                # Tüm güvenlik paketlerini yükle
                yes | install_pkg $all_sec_packages
                ;;
            3)
                break
                ;;
            4)
                exit
                ;;
            *)
                echo -e "\e[1;91mGeçersiz seçenek"
                ;;
            esac
        done
        ;;
    4)
        while true; do
            clear
            echo -e "\e[1;95mEditörler"
            echo "-------------------"
            # Editör paketlerinin listesini numaralarla göster
            for i in "${!editors[@]}"; do
                echo "($((i+1))) ${editors[$i]}"
            done
            echo "----------------------"
            echo "                        "
            echo "(1) Yüklemek istediğiniz paketleri seçin"
            echo "(2) Yukarıda listelenen tüm paketleri yükleyin"
            echo "(3) Geri"
            echo "(4) Çıkış"
            echo "                                              "
            read -p "Bir seçenek seçin (1-4): " editor_choice
            case $editor_choice in
            1)
                read -p "Yüklenecek paket numaralarını girin (örneğin, 1 2 3): " selected_editor_pkg
                selected_editor_pkg=($selected_editor_pkg)
                if [[ "${selected_editor_pkg[*]}" == *"geri"* ]]; then
                    break
                else
                    selected_editor_packages=()
                    for index in "${selected_editor_pkg[@]}"; do
                        selected_editor_packages+=("${editors[$((index-1))]}")
                    done
                    install_pkg "${selected_editor_packages[@]}"
                fi
                ;;
            2)
                # Tüm editör paketlerini birleştir
                all_editor_packages="${editors[*]}"
                # Tüm editör paketlerini yükle
                yes | install_pkg $all_editor_packages
                ;;
            3)
                break
                ;;
            4)
                exit
                ;;
            *)
                echo -e "\e[1;91mGeçersiz seçenek"
                ;;
            esac
        done
        ;;
    5)
        while true; do
            clear
            echo -e "\e[1;96mEğlenceli Paketler"
            echo "----------------"
            # Eğlenceli paketlerin listesini numaralarla göster
            for i in "${!cool_pkg[@]}"; do
                echo "($((i+1))) ${cool_pkg[$i]}"
            done
            echo "----------------------"
            echo "                        "
            echo "(1) Yüklemek istediğiniz paketleri seçin"
            echo "(2) Yukarıda listelenen tüm paketleri yükleyin"
            echo "(3) Geri"
            echo "(4) Çıkış"
            echo "                                              "
            read -p "Bir seçenek seçin (1-4): " cool_choice
            case $cool_choice in
            1)
                read -p "Yüklenecek paket numaralarını girin (örneğin, 1 2 3): " selected_cool_pkg
                selected_cool_pkg=($selected_cool_pkg)
                if [[ "${selected_cool_pkg[*]}" == *"geri"* ]]; then
                    break
                else
                    selected_cool_packages=()
                    for index in "${selected_cool_pkg[@]}"; do
                        selected_cool_packages+=("${cool_pkg[$((index-1))]}")
                    done
                    install_pkg "${selected_cool_packages[@]}"
                fi
                ;;
            2)
                # Tüm eğlenceli paketleri birleştir
                all_cool_packages="${cool_pkg[*]}"
                # Tüm eğlenceli paketleri yükle
                yes | install_pkg $all_cool_packages
                ;;
            3)
                break
                ;;
            4)
                exit
                ;;
            *)
                echo -e "\e[1;91mGeçersiz seçenek"
                ;;
            esac
        done
        ;;
    6)
        # Tüm paketleri birleştir
        all_packages=("${pkg[@]}" "${dev_pkg[@]}" "${sec_pkg[@]}" "${editors[@]}" "${cool_pkg[@]}")
        # Tüm paketleri yükle
        yes | install_pkg "${all_packages[@]}"
        ;;
    7)
        exit
        ;;
    *)
        echo -e "\e[1;91mGeçersiz seçenek"
        ;;
    esac
done
