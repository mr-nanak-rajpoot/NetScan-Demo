#!/bin/bash

# Recon Pro - Advanced Network Reconnaissance Script
# Author: Nanak Rajpoot

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
print_banner() {
    echo -e "${BLUE}=================================================${NC}"
    echo -e "${GREEN}                RECON PRO                    ${NC}"
    echo -e "${GREEN}     Advanced Network Reconnaissance Toolkit     ${NC}"
    echo -e "${BLUE}=================================================${NC}"
}

# Spinner for long processes
spinner() {
    local pid=$!
    local delay=0.15
    local spinstr='|/-\'
    while ps -p $pid &>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Help section
print_help() {
    echo -e "${YELLOW}Usage: $0 --target <IP/DOMAIN> [--full] [--html]${NC}"
    echo -e "${GREEN}  --target <target>   ${NC}Set the target IP or domain"
    echo -e "${GREEN}  --full              ${NC}Enable comprehensive scans"
    echo -e "${GREEN}  --html              ${NC}Generate an HTML report (requires 'aha')"
    echo -e "${GREEN}  --help              ${NC}Display this help message"
    exit 0
}

# Validate IP or domain
validate_target() {
    if [[ ! $target =~ ^[a-zA-Z0-9.-]+$ ]]; then
        echo -e "${RED}Invalid target format.${NC}"
        exit 1
    fi
}

# Run and log scans
run_scan() {
    local type=$1
    local cmd=$2

    echo -e "\n${BLUE}Running $type...${NC}"
    echo -e "\n=== $type ===" >> "$filename"
    
    (eval "$cmd" >> "$filename" 2>&1) & spinner

    echo -e "${GREEN}✓ $type completed${NC}"
}

# Argument parsing
target=""
full_scan=false
generate_html=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --target)
            target="$2"
            shift 2
            ;;
        --full)
            full_scan=true
            shift
            ;;
        --html)
            generate_html=true
            shift
            ;;
        --help)
            print_help
            ;;
        *)
            echo -e "${RED}Unknown argument: $1${NC}"
            print_help
            ;;
    esac
done

# Main execution
print_banner

if [ -z "$target" ]; then
    echo -e "${RED}Error: No target specified. Use --target <IP/DOMAIN>${NC}"
    exit 1
fi

validate_target

# Check Nmap
if ! command -v nmap &>/dev/null; then
    echo -e "${RED}Error: Nmap not found. Install it with:${NC}"
    echo -e "${YELLOW}sudo apt install nmap${NC}"
    exit 1
fi

# Optional: Check if aha is available for HTML
if $generate_html && ! command -v aha &>/dev/null; then
    echo -e "${RED}Error: HTML generation requires 'aha'. Install with:${NC}"
    echo -e "${YELLOW}sudo apt install aha${NC}"
    exit 1
fi

# Setup
mkdir -p results
timestamp=$(date +"%Y%m%d_%H%M%S")
filename="results/${target}_${timestamp}_scan.txt"
htmlfile="${filename%.txt}.html"

# Log header
{
    echo "========================================="
    echo "  Network Reconnaissance Report"
    echo "  Target: $target"
    echo "  Date: $(date)"
    echo "========================================="
} > "$filename"

echo -e "${GREEN}Target: ${YELLOW}$target${NC}"
echo -e "${GREEN}Saving results to: ${YELLOW}$filename${NC}"

# Scanning phases
run_scan "Ping Scan" "nmap -sn $target"
run_scan "Basic Port Scan" "nmap -sS $target"
run_scan "Service Version & OS Detection" "nmap -sV -O $target"
run_scan "Script Scan (Common Vulns)" "nmap -sC -sS $target"

if $full_scan; then
    run_scan "Comprehensive Port Scan" "nmap -p- -T4 $target"
fi

# HTML report (optional)
if $generate_html; then
    aha < "$filename" > "$htmlfile"
    echo -e "${GREEN}✓ HTML Report created at: ${YELLOW}$htmlfile${NC}"
fi

# Summary
echo -e "\n${GREEN}Quick Summary:${NC}"
echo "=============="
echo -e "${YELLOW}Open Ports:${NC}"
grep "open" "$filename" | grep -v "filtered" | sort -u

echo -e "\n${YELLOW}Operating System Detection:${NC}"
grep -A 3 "OS details" "$filename" | head -n 5

echo -e "\n${YELLOW}Detected Services:${NC}"
grep "open" "$filename" | awk '{print $1, $3, $4}' | sort -u

# Footer
echo -e "\n${GREEN}Scan complete!${NC}"
echo -e "${GREEN}Check full results: ${YELLOW}$filename${NC}"
if $generate_html; then
    echo -e "${GREEN}Open HTML report in browser: ${YELLOW}xdg-open $htmlfile${NC}"
fi
echo -e "${BLUE}=================================================${NC}"
echo -e "${GREEN}       Made by HuzaifaDal - Happy Hacking!       ${NC}"
echo -e "${BLUE}=================================================${NC}"
