# PowerShell Backup Script

## Description  
PowerShell script that automates backing up all files from a source folder to a timestamped destination folder. The script preserves the original folder and subfolder structure, handles duplicate filenames safely, logs all successes and errors, and performs basic verification by comparing file sizes.

---

## Features   
- Source Validation: Checks if the source folder exists before starting and exits gracefully if it doesn’t.  <img width="483" height="37" alt="492969865-86cc8aea-d482-4f99-a200-a00aeac07316" src="https://github.com/user-attachments/assets/66959e22-4592-42d5-9420-c981063dad47" />  
- Disk Space Check: Ensures there is sufficient free space on the destination drive.  <img width="633" height="42" alt="492971017-6bfad8fc-514f-43f7-b66f-db067da08704" src="https://github.com/user-attachments/assets/2a7c1a74-b757-4378-a1a6-721ccbbf86d1" />  

- Timestamped Destination Folders: Creates backup folders with the current date and time
  <img width="388" height="141" alt="492978211-b72e7692-6638-44ab-8a2a-abac285d11a3" src="https://github.com/user-attachments/assets/54ad4cff-b0e6-4175-9d71-9848da1ab1ec" />  


- Folder Structure Preservation: Copies files while maintaining the original folder hierarchy.  
  <img width="318" height="110" alt="492971660-e49f059c-eb51-4dad-a520-ac35ef8bc01f" src="https://github.com/user-attachments/assets/9f7492cc-5676-4558-8b62-ec5281313aeb" />  

- Duplicate Filename Handling: Adds numeric suffixes (1), (2) to avoid overwriting files in the same folder.  
- Basic Verification: Confirms the backup by comparing source and destination file sizes.  
  <img width="981" height="110" alt="492977154-42114171-63aa-46fd-bf6d-e10c2e3a91f7" src="https://github.com/user-attachments/assets/b2377ee5-7c30-4113-a4a8-8a939a7096c6" />  

- Logging: Records each success and error in a timestamped log file.
   <img width="1156" height="207" alt="492977365-2076261b-f9b3-4a05-b5c3-94cacd888307" src="https://github.com/user-attachments/assets/5a751d23-06d1-4a16-af17-4e1058303d8e" />

- Error Handling: If a file fails to copy or verification fails, the error is logged, and the script continues processing the remaining files.  

- Summary Report: Outputs total files backed up and number of errors encountered.
   <img width="447" height="59" alt="492978490-61c637f4-00fc-4e5a-93b9-1131c068e4e3" src="https://github.com/user-attachments/assets/143b7e70-b230-4caf-9278-95659d3a4056" />  

## Setup & Usage  
1. Download backup_script.ps1 from this repository.
2. Set the $Source variable in the script to the folder you want to back up.  
      <img width="463" height="133" alt="492981848-c08a369a-333c-43f6-a597-0ae6d6a19c18" src="https://github.com/user-attachments/assets/3ba9bdea-8736-4f14-9aef-a8699143186b" />  
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
