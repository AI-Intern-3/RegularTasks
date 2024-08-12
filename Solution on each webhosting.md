```
import openpyxl
import requests
import socket
import ssl
import os
from datetime import datetime
from openpyxl.styles import PatternFill

# File paths
input_file_path = r"/mnt/c/Users/smit/Desktop/Trillixent Technologies/excel/new.xlsx"
output_file_path = r"/mnt/c/Users/smit/Desktop/Trillixent Technologies/excel/output_{}.xlsx".format(datetime.now().strftime("%Y%m%d_%H%M%S"))

# Check if the input file exists
if not os.path.isfile(input_file_path):
    print(f"Error: The file {input_file_path} does not exist.")
    exit(1)

try:
    # Load the workbook and select the active worksheet
    wb = openpyxl.load_workbook(input_file_path)
    ws = wb.active

    # Add headers to the output columns
    ws['C1'] = 'Status'
    ws['D1'] = 'IP Address'
    ws['E1'] = 'SSL Certificate'
    ws['F1'] = 'HTTP Reachable'
    ws['G1'] = 'HTTP Error Code'
    ws['H1'] = 'HTTP Error Message'
    ws['I1'] = 'HTTPS Reachable'
    ws['J1'] = 'HTTPS Error Code'
    ws['K1'] = 'HTTPS Error Message'
    ws['L1'] = 'Solution'

    # Function to determine the solution based on the error code and message
    def get_solution(error_code, error_message):
        if error_code == 200:
            return "No issue."
        elif error_code == 403:
            return "Check file permissions and IP restrictions."
        elif error_code == 500:
            return "Check server logs for detailed error messages and ensure server resources are adequate."
        elif "Connection aborted" in error_message:
            return "Check server stability and network connectivity."
        else:
            return "Refer to server logs and documentation for detailed troubleshooting."

    # Iterate through the domain names in the second column
    for row in range(2, ws.max_row + 1):
        domain = ws.cell(row=row, column=2).value

        if not domain:
            continue

        # Initialize results
        status = 'Not Working'
        ip_address = 'N/A'
        ssl_certificate = 'No'
        http_reachable = 'No'
        http_error_code = 'N/A'
        http_error_message = 'N/A'
        https_reachable = 'No'
        https_error_code = 'N/A'
        https_error_message = 'N/A'
        solution = 'N/A'

        try:
            # Check if the domain is working
            response = requests.get(f'http://{domain}', timeout=10)
            if response.status_code == 200:
                status = 'Working'
            http_error_code = response.status_code
            http_error_message = response.reason

            # Get IP address
            ip_address = socket.gethostbyname(domain)

            # Check SSL certificate
            context = ssl.create_default_context()
            with socket.create_connection((domain, 443)) as sock:
                with context.wrap_socket(sock, server_hostname=domain) as ssock:
                    ssl_certificate = 'Yes'

            # Check HTTP reachability
            try:
                http_response = requests.get(f'http://{domain}', timeout=10)
                if http_response.status_code == 200:
                    http_reachable = 'Yes'
                else:
                    http_error_code = http_response.status_code
                    http_error_message = http_response.reason
            except requests.RequestException as e:
                http_error_message = str(e)

            # Check HTTPS reachability
            try:
                https_response = requests.get(f'https://{domain}', timeout=10)
                if https_response.status_code == 200:
                    https_reachable = 'Yes'
                else:
                    https_error_code = https_response.status_code
                    https_error_message = https_response.reason
            except requests.RequestException as e:
                https_error_message = str(e)

        except Exception as e:
            pass

        # Determine the solution
        solution = get_solution(http_error_code if http_error_code != 'N/A' else https_error_code, http_error_message if http_error_message != 'N/A' else https_error_message)

        # Write results to the output columns
        ws.cell(row=row, column=3).value = status
        ws.cell(row=row, column=4).value = ip_address
        ws.cell(row=row, column=5).value = ssl_certificate
        ws.cell(row=row, column=6).value = http_reachable
        ws.cell(row=row, column=7).value = http_error_code
        ws.cell(row=row, column=8).value = http_error_message
        ws.cell(row=row, column=9).value = https_reachable
        ws.cell(row=row, column=10).value = https_error_code
        ws.cell(row=row, column=11).value = https_error_message
        ws.cell(row=row, column=12).value = solution

        # Set cell color based on status
        if status == 'Working':
            ws.cell(row=row, column=3).fill = PatternFill(start_color="00FF00", end_color="00FF00", fill_type="solid")
        else:
            ws.cell(row=row, column=3).fill = PatternFill(start_color="FF0000", end_color="FF0000", fill_type="solid")

        # Set cell color based on HTTP status code
        if http_error_code == 200:
            ws.cell(row=row, column=7).fill = PatternFill(start_color="00FF00", end_color="00FF00", fill_type="solid")
        else:
            ws.cell(row=row, column=7).fill = PatternFill(start_color="FF0000", end_color="FF0000", fill_type="solid")

        # Set cell color based on HTTPS status code
        if https_error_code == 200:
            ws.cell(row=row, column=10).fill = PatternFill(start_color="00FF00", end_color="00FF00", fill_type="solid")
        else:
            ws.cell(row=row, column=10).fill = PatternFill(start_color="FF0000", end_color="FF0000", fill_type="solid")

    # Save the results to a new Excel file
    wb.save(output_file_path)
    print(f'Results saved to {output_file_path}')

except Exception as e:
    print(f"An error occurred: {e}")

```
