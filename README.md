# PowerShell Backup Script

## Description  
PowerShell script that automates backing up all files from a source folder to a timestamped destination folder. The script preserves the original folder and subfolder structure, handles duplicate filenames safely, logs all successes and errors, and performs basic verification by comparing file sizes.

---

## Features   
- Source Validation: Checks if the source folder exists before starting and exits gracefully if it doesn’t.  <img width="483" height="37" alt="Screenshot 2025-09-23 201324" src="https://github.com/user-attachments/assets/86cc8aea-d482-4f99-a200-a00aeac07316" />

- Disk Space Check: Ensures there is sufficient free space on the destination drive.  <img width="633" height="42" alt="Screenshot 2025-09-23 203044" src="https://github.com/user-attachments/assets/6bfad8fc-514f-43f7-b66f-db067da08704" />

- Timestamped Destination Folders: Creates backup folders with the current date and time
  <img width="388" height="141" alt="Screenshot 2025-09-23 201634" src="https://github.com/user-attachments/assets/b72e7692-6638-44ab-8a2a-abac285d11a3" />


- Folder Structure Preservation: Copies files while maintaining the original folder hierarchy.  
  <img width="318" height="110" alt="Screenshot 2025-09-23 203310" src="https://github.com/user-attachments/assets/e49f059c-eb51-4dad-a520-ac35ef8bc01f" />

- Duplicate Filename Handling: Adds numeric suffixes (1), (2) to avoid overwriting files in the same folder.  
- Basic Verification: Confirms the backup by comparing source and destination file sizes.  
<img width="981" height="110" alt="Screenshot 2025-09-23 204342" src="https://github.com/user-attachments/assets/42114171-63aa-46fd-bf6d-e10c2e3a91f7" />

- Logging: Records each success and error in a timestamped log file.
 <img width="1156" height="207" alt="Screenshot 2025-09-23 201813" src="https://github.com/user-attachments/assets/2076261b-f9b3-4a05-b5c3-94cacd888307" />

- Error Handling: If a file fails to copy or verification fails, the error is logged, and the script continues processing the remaining files.  

- Summary Report: Outputs total files backed up and number of errors encountered.
 <img width="447" height="59" alt="Screenshot 2025-09-23 201606" src="https://github.com/user-attachments/assets/61c637f4-00fc-4e5a-93b9-1131c068e4e3" />

## Setup & Usage  
1. Download backup_script.ps1 from this repository.
2. Set the $Source variable in the script to the folder you want to back up.  
    <img width="463" height="133" alt="Screenshot 2025-09-23 210003" src="https://github.com/user-attachments/assets/c08a369a-333c-43f6-a597-0ae6d6a19c18" />  
3. Optionally, set the $Destination variable for your preferred backup location. By default, it uses C:\TestBackup\ with a timestamp.
4. Open PowerShell and navigate to the folder containing the script.
5. (Optional) Ensure the execution policy allows running scripts:  
    - Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
6. Run the script:
    - .\backup_script.ps1
7. Monitor the terminal for output and check the log file inside the backup folder for detailed information.

## Output  

- Timestamped log file recording all operations.
- Backup Folder: Preserves original folder structure with timestamped destination folder.

## Notes

- Verification: The script only checks file sizes to verify a copy; it does not verify full file content.  
- Execution Policy: Must be set to allow running scripts (RemoteSigned recommended).  
- Duplicate Handling: Adds numeric suffixes to avoid overwriting files with the same name in the same folder.

## License 
This project is licensed under the MIT License.
