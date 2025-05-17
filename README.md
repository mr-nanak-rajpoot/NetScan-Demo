# NetScan-Demo
A Bash-powered Nmap automation tool for fast and advanced network reconnaissance with optional HTML reports.


# Installation
git clone https://github.com/yourusername/netscan-demo.git
cd netscan-demo
chmod +x dal_recon_pro.sh

# Basic Scan
./dal_recon_pro.sh --target scanme.nmap.org

# Generate HTML Report
./dal_recon_pro.sh --target scanme.nmap.org --html


# Full Scan (includes full port range)
./dal_recon_pro.sh --target scanme.nmap.org --full

# Help
./dal_recon_pro.sh --help


# Output
Scan results are saved to the results/ folder with a timestamp.
If --html is enabled, an HTML report is generated for easy viewing in browsers.

# Disclaimer
This tool is intended for educational and ethical testing purposes only.
Do not scan targets you do not own or have explicit permission to test.


# Author
Nanak Rajppot
Made with ❤️ for learning and cybersecurity exploration.
















