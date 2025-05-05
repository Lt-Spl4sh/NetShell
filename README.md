# NetShell
⚔️ NetShell v1.0 — Real Bash multi-tool for recon, spoofing, payloads &amp; anonymity | by Lt_Spl4sh
# NetShell v1.0 🔥
> A powerful Bash-based multipurpose cybersecurity tool by Lt_Spl4sh

## 🧰 Description
NetShell is an all-in-one shell-based cybersecurity toolkit designed for penetration testers, ethical hackers, and sysadmins. Built with simplicity and power in mind, NetShell combines essential network tools into a single sleek Bash interface, requiring no external GUI.

Created by Lt_Spl4sh, this tool features real-time reconnaissance, OSINT gathering, ARP scanning, anonymization via Tor, MAC spoofing, and even stealth payload generation. Every tool in NetShell is **functional** and built for practical usage.

## 🧠 Features
- 🌐 **Local Recon** – Gather info on your local machine and network.
- 🖥️ **ARP LAN Scanner** – Detect devices on your LAN using ARP requests.
- 🔍 **Silent Port Pinger** – Scan specific ports stealthily.
- 🕵️ **OSINT Lookup** – Pull public user data from GitHub, Instagram, Twitter, and Reddit.
- 🧢 **MAC Spoofer** – Temporarily change your MAC address.
- 💣 **Payload Generator** – Create basic Bash payloads for remote access or reverse shell.
- 🧭 **VPN/Proxy Detector** – Check if a target IP is behind a VPN/proxy.
- 🕶️ **Anonymizer** – Run your system through Tor with MAC spoofing and DNS leak protection.
- 👻 **Disappearing Mode** – Hide files/logs related to the tool during execution.

## 📦 Installation
```bash
git clone https://github.com/Lt-Spl4sh/NetShell.git
cd NetShell
chmod +x netshell.sh
./netshell.sh
```

## ⚙️ Requirements
- bash
- curl
- jq
- iproute2
- sudo/root access
- tor, proxychains (for Anonymizer)

Install dependencies on Debian-based systems:
```bash
sudo apt update && sudo apt install curl jq net-tools tor proxychains4 macchanger -y
```

## ⚠️ Disclaimer
For **educational purposes only**. Do not use NetShell on networks or devices you don't own or have explicit permission to test.

---

## 📄 License
```
MIT License

Copyright (c) 2025 Lt_Spl4sh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 📂 .gitignore
```
# Ignore temporary or generated files
*.log
*.tmp
*.bak
*.swp
payload.sh
output/
recon/
```
