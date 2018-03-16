# OnedriveRoamingProfile
This tool will run on login. Detect whether OneDrive Sync has been setup and folders have been redirected.
If not it will set it up and redirect them.

INSTRUCTIONS:

For an existing user:
1. Login
2. Run powershell as administrator.
3. Run SyncandRedirect.ps1
4. It will prompt you to log into OneDrive, login.

To setup brand new users:
To more accurately simulate Romaing Profiles, this OneDrive syncing and folder redirection should automatically be triggered for users that have never logged onto the system and are logging on for the first time.
Microsoft has a feature called RunOnce. Which let's you specify a batch file to run the first time a user logs in.

1. Download SyncandRedirect.ps1 and copy it to C:\Scripts (You can save it somewhere else, but you'll have to update the path in    the FirstLogon.bat)
2. Download the FirstLogon.bat and save it somewhere(Ex. C:\Scripts\FirstLogon.bat)
3. Configure RunOnce to run this script(If you need help see https://github.com/ChristSent/FirstLogonScript
