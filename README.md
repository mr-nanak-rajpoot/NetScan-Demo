# 🚀 NetScan-Demo

**NetScan-Demo** is an enhanced version of a Bash-based Nmap automation tool designed for fast, flexible, and user-friendly network reconnaissance. It supports advanced scan modes, timestamped result logging, and optional HTML report generation — all from a simple command-line interface.

![NetScan Terminal Preview](https://raw.githubusercontent.com/your-username/netscan-demo/main/screenshots/netscan-preview.png)

---

## 🔥 Key Features

- ✅ **Multiple Scan Modes**
  - Ping scan (host discovery)
  - TCP SYN port scan
  - Full port scan (`--full`)
  - Service and OS detection
  - Vulnerability scanning using default NSE scripts

- ✅ **Command-Line Options**
  - `--target` Specify target domain/IP
  - `--full` Enable full 65535 port scan
  - `--html` Generate an HTML report (if `aha` is installed)
  - `--help` Display help menu

- ✅ **Organized Reporting**
  - Saves output with timestamp
  - Stores results in structured folders (`results/txt`, `results/html`)
  - Quick summary printed in terminal

- ✅ **Optional HTML Output**
  - Generate a clean, colorized HTML report viewable in any browser

---

## 🛠️ Installation

Clone the repo:

    git clone https://github.com/HuzaifaDal/NetScan-Demo.git
    cd NetScan-Demo
    chmod +x dal_recon_pro.sh

Install dependencies:

    # Nmap is required
    sudo apt install nmap

    # Optional: for HTML report generation
    sudo apt install aha

---

## ⚙️ Usage Examples

Basic Scan:

    ./dal_recon_pro.sh --target scanme.nmap.org

Full Scan (all ports):

    ./dal_recon_pro.sh --target scanme.nmap.org --full

Generate HTML Report:

    ./dal_recon_pro.sh --target scanme.nmap.org --html

Help Menu:

    ./dal_recon_pro.sh --help

---

## 📁 Output Structure

The results are saved in a structured folder system:

    results/
    ├── txt/
    │   └── scanme.nmap.org_20250517_140532_scan.txt
    └── html/
        └── scanme.nmap.org_20250517_140532_report.html

Plain text logs contain full scan data. HTML reports (optional) provide a clean browser-based summary.

---

## ⚠️ Disclaimer

> This tool is intended for **educational and authorized security testing only**.  
> Never scan systems you do not own or have explicit permission to assess.

---

## 📜 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Nanak Rajppot**  
Made with ❤️ for learning, exploration, and ethical hacking.

---

## 🙌 Acknowledgments

- Inspired by open-source security tools like Nmap  
- Thanks to the original AdvancedNetScan project  
- Shout-out to the infosec community for continual learning
