#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if whois is installed
if ! command_exists whois; then
  echo "The 'whois' tool is not installed. Installing it..."
  # You can modify this line to use the package manager of your choice (e.g., apt-get for Debian/Ubuntu)
  sudo apt-get install whois
fi

# Prompt for input
read -p "Enter IP address(es) separated by spaces or the path to a file: " ip_input

# Check if the input is a file
if [[ -f $ip_input ]]; then
    # Read IP addresses from the file
    ip_file=$ip_input
else
    # Use the input as space-separated IP addresses
    ip_list=$ip_input
fi

# Specify the output file to store the results
output_file="asn_info.txt"
csv_file="asn_info.csv"

# Function to retrieve ASN information from APNIC
get_asn_info() {
    ip=$1
    domain=$(dig +short -x "$ip" 2>/dev/null)
    as_number=$(whois -h whois.apnic.net "$ip" | awk -F':' '/^origin:/ {print $2}' | awk '{$1=$1};1')
    as_org=$(whois -h whois.apnic.net "$ip" | awk -F':' '/^descr:/ {print $2}' | awk '{$1=$1};1')
    domain_resolved="No"

    if [[ -n $domain ]]; then
        domain_resolved="Yes"
    fi

    echo -e "IP Address: $ip"
    echo "Domain Resolved: $domain_resolved"
    echo "AS Number: $as_number"
    echo "AS Organization: $as_org"
    echo ""

    echo -e "IP Address: $ip\nDomain Resolved: $domain_resolved\nAS Number: $as_number\nAS Organization: $as_org\n" >> "$output_file"
}

# Clear the output files if they already exist
> "$output_file"

# Process IP addresses
if [[ -n $ip_file ]]; then
    # Read IP addresses from the file
    while IFS= read -r ip; do
        get_asn_info "$ip"
    done < "$ip_file"
else
    # Use space-separated IP addresses
    for ip in $ip_list; do
        get_asn_info "$ip"
    done
fi

# Count resolved and unresolved IP addresses
resolved_count=$(grep -c "Domain Resolved: Yes" "$output_file")
unresolved_count=$(grep -c "Domain Resolved: No" "$output_file")
total_count=$((resolved_count + unresolved_count))

# Input text file
input_file="test_data.txt"

# Output CSV file
output_file="test_data.csv"

# Initialize variables to store data
ip_address=""
domain_resolved=""
as_number=""
as_organization=""

# Function to write data to CSV
write_to_csv() {
    echo "$ip_address,$domain_resolved,$as_number,\"$as_organization\"" >> "$output_file"
}

# Clear the output file and add header
echo "IP Address,Domain Resolved,AS Number,AS Organization" > "$output_file"

# Read the input file line by line
while IFS= read -r line; do
    if [[ $line == "IP Address: "* ]]; then
        ip_address="${line#IP Address: }"
    elif [[ $line == "Domain Resolved: "* ]]; then
        domain_resolved="${line#Domain Resolved: }"
    elif [[ $line == "AS Number: "* ]]; then
        as_number="${line#AS Number: }"
    elif [[ $line == "AS Organization: "* ]]; then
        as_organization="${line#AS Organization: }"
        write_to_csv
        # Reset variables for the next entry
        ip_address=""
        domain_resolved=""
        as_number=""
        as_organization=""
    fi
done < "$input_file"

# Display summary
echo ""
echo "Summary:"
echo "Total IP Addresses Checked: $total_count"
echo "Resolved IP Addresses: $resolved_count"
echo "Unresolved IP Addresses: $unresolved_count"
echo ""

echo "ASN information retrieval completed. Results stored in $output_file and $csv_file."
