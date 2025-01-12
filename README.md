# bash-security-scripts
A collection of Bash scripts for log analysis and security operations

Script Name: HTTP_Status_TopIP.sh
Description: Analyze web server access logs to find top IPs and HTTP status codes.
Usage: bash HTTP_Status_TopIP.sh
Requirements: Log file location in the LOG_FILE variable.

Script Name: SSH_Fail_Login.sh
Description: Identify failed SSH login attempts from log files.
Usage: bash SSH_Fail_Login.sh
Requirements: Access to /var/log/auth.log.

## Sample Output
Script Name: HTTP_Status_TopIP.sh
HTTP Status Code Analysis:
  18295 404
   3913 200
    528 301
Rest omitted for brevity.

Top 10 IPs Accessing the Server:
  14215 xxx.xxx.xxx.152
    475 yyy.yyy.yy.28
    446 zzz.zzz.zzz.233
Rest omitted for brevity.