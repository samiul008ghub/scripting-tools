


# ASN Information Retrieval Script

asn_info.sh script is a handy tool to check if IP addresses are resolvable to domain names and retrieve ASN (Autonomous System Number) information using the APNIC (Asia-Pacific Network Information Centre) database. 🌐

✨ The script prompts you to enter an IP address or a set of IP addresses separated by spaces. It also accepts a file containing a list of IP addresses. 📝

⚡️ Once you provide the IP addresses, the script performs a DNS lookup to determine if each IP address is resolvable to a domain name. If a domain is found, it fetches the corresponding ASN information, including the ASN number and organization. 🌍

📊 The script generates a text file with the IP address, resolved domain name (if available), ASN number, and organization. It also creates a CSV file with headers for easy analysis and data manipulation. 📁

🔍 The script provides a summary at the end, displaying the total number of IP addresses checked, the count of IP addresses with resolved domains, and the count of IP addresses without resolved domains.

🚀 This script is a helpful tool for network administrators, cybersecurity professionals, or anyone interested in investigating IP address connectivity and ownership information. 💡This script retrieves ASN (Autonomous System Number) information for a list of IP addresses using APNIC (Asia-Pacific Network Information Centre) database.

## Usage

1. Clone the repository:

```shell
git clone <repository-url>

2. Navigate to the cloned repository:
cd asn-info-script

3. Make the script executable (if needed):
chmod +x asn_info.sh

4. Run the script and follow the prompts:
./asn_info.sh

Provide IP address(es) when prompted. You can enter a single IP address, multiple IP addresses separated by spaces, or specify a file containing a list of IP addresses.

The script will retrieve the ASN information for each IP address, including the resolved domain (if any), AS number, and AS organization. The results will be stored in the asn_info.txt file and a CSV file named asn_info.csv.

After execution, a summary will be displayed, showing the total number of IP addresses checked, the number of resolved IP addresses, and the number of unresolved IP addresses.

# Requirements
Bash (Unix Shell)
dig command-line tool
whois command-line tool
License
This script is released under the MIT License.

Feel free to use and modify this script according to your needs.
