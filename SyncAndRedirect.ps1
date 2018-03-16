function Set-KnownFolderPath {
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('AddNewPrograms', 'AdminTools', 'AppData', 'AppUpdates', 'CDBurning', 'ChangeRemovePrograms', 
                         'CommonAdminTools', 'CommonOEMLinks', 'CommonPrograms', 'CommonStartMenu', 
                         'CommonStartup', 'CommonTemplates', 'ComputerFolder', 'ConflictFolder', 
                         'ConnectionsFolder', 'Contacts', 'ControlPanelFolder', 'Cookies', 'Desktop', 
                         'Documents', 'Downloads', 'Favorites', 'Fonts', 'Games', 'GameTasks', 'History', 
                         'InternetCache', 'InternetFolder', 'Links', 'LocalAppData', 'LocalAppDataLow', 
                         'LocalizedResourcesDir', 'Music', 'NetHood', 'NetworkFolder', 'OriginalImages', 
                         'PhotoAlbums', 'Pictures', 'Playlists', 'PrintersFolder', 'PrintHood', 'Profile', 
                         'ProgramData', 'ProgramFiles', 'ProgramFilesX64', 'ProgramFilesX86', 
                         'ProgramFilesCommon', 'ProgramFilesCommonX64', 'ProgramFilesCommonX86', 'Programs', 
                         'Public', 'PublicDesktop', 'PublicDocuments', 'PublicDownloads', 'PublicGameTasks', 
                         'PublicMusic', 'PublicPictures', 'PublicVideos', 'QuickLaunch', 'Recent', 
                         'RecycleBinFolder', 'ResourceDir', 'RoamingAppData', 'SampleMusic', 'SamplePictures', 
                         'SamplePlaylists', 'SampleVideos', 'SavedGames', 'SavedSearches', 'SEARCH_CSC', 
                         'SEARCH_MAPI', 'SearchHome', 'SendTo', 'SidebarDefaultParts', 'SidebarParts', 
                         'StartMenu', 'Startup', 'SyncManagerFolder', 'SyncResultsFolder', 'SyncSetupFolder', 
                         'System', 'SystemX86', 'Templates', 'TreeProperties', 'UserProfiles', 'UsersFiles', 
                         'Videos', 'Windows')]
        [string]$KnownFolder,

        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory=$true,
                    ParameterSetName='Parameter Set 1')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("yes","no")]
        [String]
        $moveContent
    )
    # Define known folder GUIDs
    $KnownFolders = @{
        'AddNewPrograms' = 'de61d971-5ebc-4f02-a3a9-6c82895e5c04';
        'AdminTools' = '724EF170-A42D-4FEF-9F26-B60E846FBA4F';
        'AppUpdates' = 'a305ce99-f527-492b-8b1a-7e76fa98d6e4';
        'CDBurning' = '9E52AB10-F80D-49DF-ACB8-4330F5687855';
        'ChangeRemovePrograms' = 'df7266ac-9274-4867-8d55-3bd661de872d';
        'CommonAdminTools' = 'D0384E7D-BAC3-4797-8F14-CBA229B392B5';
        'CommonOEMLinks' = 'C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D';
        'CommonPrograms' = '0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8';
        'CommonStartMenu' = 'A4115719-D62E-491D-AA7C-E74B8BE3B067';
        'CommonStartup' = '82A5EA35-D9CD-47C5-9629-E15D2F714E6E';
        'CommonTemplates' = 'B94237E7-57AC-4347-9151-B08C6C32D1F7';
        'ComputerFolder' = '0AC0837C-BBF8-452A-850D-79D08E667CA7';
        'ConflictFolder' = '4bfefb45-347d-4006-a5be-ac0cb0567192';
        'ConnectionsFolder' = '6F0CD92B-2E97-45D1-88FF-B0D186B8DEDD';
        'Contacts' = '56784854-C6CB-462b-8169-88E350ACB882';
        'ControlPanelFolder' = '82A74AEB-AEB4-465C-A014-D097EE346D63';
        'Cookies' = '2B0F765D-C0E9-4171-908E-08A611B84FF6';
        'Desktop' = 'B4BFCC3A-DB2C-424C-B029-7FE99A87C641';
        'Documents' = 'FDD39AD0-238F-46AF-ADB4-6C85480369C7';
        'Downloads' = '374DE290-123F-4565-9164-39C4925E467B';
        'Favorites' = '1777F761-68AD-4D8A-87BD-30B759FA33DD';
        'Fonts' = 'FD228CB7-AE11-4AE3-864C-16F3910AB8FE';
        'Games' = 'CAC52C1A-B53D-4edc-92D7-6B2E8AC19434';
        'GameTasks' = '054FAE61-4DD8-4787-80B6-090220C4B700';
        'History' = 'D9DC8A3B-B784-432E-A781-5A1130A75963';
        'InternetCache' = '352481E8-33BE-4251-BA85-6007CAEDCF9D';
        'InternetFolder' = '4D9F7874-4E0C-4904-967B-40B0D20C3E4B';
        'Links' = 'bfb9d5e0-c6a9-404c-b2b2-ae6db6af4968';
        'LocalAppData' = 'F1B32785-6FBA-4FCF-9D55-7B8E7F157091';
        'LocalAppDataLow' = 'A520A1A4-1780-4FF6-BD18-167343C5AF16';
        'LocalizedResourcesDir' = '2A00375E-224C-49DE-B8D1-440DF7EF3DDC';
        'Music' = '4BD8D571-6D19-48D3-BE97-422220080E43';
        'NetHood' = 'C5ABBF53-E17F-4121-8900-86626FC2C973';
        'NetworkFolder' = 'D20BEEC4-5CA8-4905-AE3B-BF251EA09B53';
        'OriginalImages' = '2C36C0AA-5812-4b87-BFD0-4CD0DFB19B39';
        'PhotoAlbums' = '69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C';
        'Pictures' = '33E28130-4E1E-4676-835A-98395C3BC3BB';
        'Playlists' = 'DE92C1C7-837F-4F69-A3BB-86E631204A23';
        'PrintersFolder' = '76FC4E2D-D6AD-4519-A663-37BD56068185';
        'PrintHood' = '9274BD8D-CFD1-41C3-B35E-B13F55A758F4';
        'Profile' = '5E6C858F-0E22-4760-9AFE-EA3317B67173';
        'ProgramData' = '62AB5D82-FDC1-4DC3-A9DD-070D1D495D97';
        'ProgramFiles' = '905e63b6-c1bf-494e-b29c-65b732d3d21a';
        'ProgramFilesX64' = '6D809377-6AF0-444b-8957-A3773F02200E';
        'ProgramFilesX86' = '7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E';
        'ProgramFilesCommon' = 'F7F1ED05-9F6D-47A2-AAAE-29D317C6F066';
        'ProgramFilesCommonX64' = '6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D';
        'ProgramFilesCommonX86' = 'DE974D24-D9C6-4D3E-BF91-F4455120B917';
        'Programs' = 'A77F5D77-2E2B-44C3-A6A2-ABA601054A51';
        'Public' = 'DFDF76A2-C82A-4D63-906A-5644AC457385';
        'PublicDesktop' = 'C4AA340D-F20F-4863-AFEF-F87EF2E6BA25';
        'PublicDocuments' = 'ED4824AF-DCE4-45A8-81E2-FC7965083634';
        'PublicDownloads' = '3D644C9B-1FB8-4f30-9B45-F670235F79C0';
        'PublicGameTasks' = 'DEBF2536-E1A8-4c59-B6A2-414586476AEA';
        'PublicMusic' = '3214FAB5-9757-4298-BB61-92A9DEAA44FF';
        'PublicPictures' = 'B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5';
        'PublicVideos' = '2400183A-6185-49FB-A2D8-4A392A602BA3';
        'QuickLaunch' = '52a4f021-7b75-48a9-9f6b-4b87a210bc8f';
        'Recent' = 'AE50C081-EBD2-438A-8655-8A092E34987A';
        'RecycleBinFolder' = 'B7534046-3ECB-4C18-BE4E-64CD4CB7D6AC';
        'ResourceDir' = '8AD10C31-2ADB-4296-A8F7-E4701232C972';
        'RoamingAppData' = '3EB685DB-65F9-4CF6-A03A-E3EF65729F3D';
        'SampleMusic' = 'B250C668-F57D-4EE1-A63C-290EE7D1AA1F';
        'SamplePictures' = 'C4900540-2379-4C75-844B-64E6FAF8716B';
        'SamplePlaylists' = '15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5';
        'SampleVideos' = '859EAD94-2E85-48AD-A71A-0969CB56A6CD';
        'SavedGames' = '4C5C32FF-BB9D-43b0-B5B4-2D72E54EAAA4';
        'SavedSearches' = '7d1d3a04-debb-4115-95cf-2f29da2920da';
        'SEARCH_CSC' = 'ee32e446-31ca-4aba-814f-a5ebd2fd6d5e';
        'SEARCH_MAPI' = '98ec0e18-2098-4d44-8644-66979315a281';
        'SearchHome' = '190337d1-b8ca-4121-a639-6d472d16972a';
        'SendTo' = '8983036C-27C0-404B-8F08-102D10DCFD74';
        'SidebarDefaultParts' = '7B396E54-9EC5-4300-BE0A-2482EBAE1A26';
        'SidebarParts' = 'A75D362E-50FC-4fb7-AC2C-A8BEAA314493';
        'StartMenu' = '625B53C3-AB48-4EC1-BA1F-A1EF4146FC19';
        'Startup' = 'B97D20BB-F46A-4C97-BA10-5E3608430854';
        'SyncManagerFolder' = '43668BF8-C14E-49B2-97C9-747784D784B7';
        'SyncResultsFolder' = '289a9a43-be44-4057-a41b-587a76d7e7f9';
        'SyncSetupFolder' = '0F214138-B1D3-4a90-BBA9-27CBC0C5389A';
        'System' = '1AC14E77-02E7-4E5D-B744-2EB1AE5198B7';
        'SystemX86' = 'D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27';
        'Templates' = 'A63293E8-664E-48DB-A079-DF759E0509F7';
        'TreeProperties' = '5b3749ad-b49f-49c1-83eb-15370fbd4882';
        'UserProfiles' = '0762D272-C50A-4BB0-A382-697DCD729B80';
        'UsersFiles' = 'f3ce0f7c-4901-4acc-8648-d5d44b04ef8f';
        'Videos' = '18989B1D-99B5-455B-841C-AB7C74E4DDFC';
        'Windows' = 'F38BF404-1D43-42F2-9305-67DE0B28FC23';
    }

    # Define SHSetKnownFolderPath if it hasn't been defined already
    $Type = ([System.Management.Automation.PSTypeName]'KnownFolders').Type
    if (-not $Type) {
        $Signature = @'
[DllImport("shell32.dll")]
public extern static int SHSetKnownFolderPath(ref Guid folderId, uint flags, IntPtr token, [MarshalAs(UnmanagedType.LPWStr)] string path);
'@
        $Type = Add-Type -MemberDefinition $Signature -Name 'KnownFolders' -Namespace 'SHSetKnownFolderPath' -PassThru
    }#/if

	# Make path, if doesn't exist
	if(!(Test-Path $Path -PathType Container)) {
		New-Item -Path $Path -ItemType Directory -Force
    }

    # Move existing content to the redirected file path, unless triggered not to move
    if ($moveContent -like "yes") {
        if (Test-Path $Path -PathType Container) {
            $Leaf = Split-Path -Path "$Path" -Leaf
            if ($Leaf -like "AppData") {
	            Copy-Item "$HOME\$Leaf\Roaming" $Path -Force
            } else {
	            Move-Item "$HOME\$Leaf\*" $Path -Force
                # Call SHSetKnownFolderPath
                return $Type::SHSetKnownFolderPath([ref]$KnownFolders[$KnownFolder], 0, 0, $Path)
            }#/
        } else {
            throw New-Object System.IO.DirectoryNotFoundException "Could not find part of the path $Path."
        }
	} else {
        Write-Output "Existing content will not be moved to the redirected file path"
    }
	# Fix up permissions, if we're still here
	attrib +r $Path

	$Leaf = Split-Path -Path "$Path" -Leaf
	Move-Item "$HOME\$Leaf\*" $Path
	# rd $HOME\$Leaf -recurse -Force

}#/function-set-knownfolderpath
function StartOneDrive-FolderRedirect {
<#
.Synopsis
   Sets a known folder's path using SHSetKnownFolderPath (shell function) and Add-Type cmdlet.
.DESCRIPTION
   This script enables folder redirection. The specified user environment profile folders will redirect to the user's OneDrive path.

   Credits:
   This project was edited and updated by ChrisM and ChrisW.

   This project was obtained from https://gist.github.com/semenko/49a28675e4aae5c8be49b83960877ac5

   That project was derived from http://stackoverflow.com/questions/25709398/set-location-of-special-folders-with-powershell
.EXAMPLE
   StartOneDrive-FolderRedirect -O365domain contoso.com -O365TennantName contoso.com -OneDriveAccountType Business

   This will execute the script based on an environment within the www.contoso.com domain. This is a Business account, therefore the
   $ONEDRIVESYNC variable will include the domain name, as opposed to the OneDrive personal account which does not use a domain name
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    #[Alias()]
    [OutputType([String])]
    Param (
        # Param1 help description
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNullOrEmpty()]
        $O365domain,

        # Param2 help description
        [Parameter(Mandatory=$true,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNullOrEmpty()]
        $O365TennantName,

        # Type of OneDrive account, Business or Personal
        [Parameter(Mandatory=$true,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Business","Personal")]
        [String]
        $OneDriveAccountType,

        [Parameter(Mandatory=$true,
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("yes","no")]
        [String]
        $moveContent
#>
    )
    Begin {
        # need script line to validate param's are not empty here

        # need script to validate OneDrive is logged in for user

        if ($OneDriveAccountType -like "Business") {
            $ONEDRIVESYNC = "$env:USERPROFILE\OneDrive - $O365TennantName"
        } else {
            $ONEDRIVESYNC = "$env:USERPROFILE\OneDrive"
        }            
        $ONEDRIVESYNC
    }
    Process {
        # Root Folders
        Set-KnownFolderPath -KnownFolder 'Desktop' -Path "$ONEDRIVESYNC\Desktop" -moveContent $moveContent
        #move $env:
        Set-KnownFolderPath -KnownFolder 'Documents' -Path "$ONEDRIVESYNC\Documents" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'Downloads' -Path "$ONEDRIVESYNC\Downloads" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'Pictures' -Path "$ONEDRIVESYNC\Pictures" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'Music' -Path "$ONEDRIVESYNC\Music" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'Videos' -Path "$ONEDRIVESYNC\Videos" -moveContent $moveContent

        # Annoying Other Folders
        Set-KnownFolderPath -KnownFolder 'Contacts' -Path "$ONEDRIVESYNC\Work Sync\Contacts" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'Favorites' -Path "$ONEDRIVESYNC\Work Sync\Favorites" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'Links' -Path "$ONEDRIVESYNC\Work Sync\Links" -moveContent $moveContent
        Set-KnownFolderPath -KnownFolder 'RoamingAppData' -Path "$ONEDRIVESYNC\Work Sync\AppData" -moveContent $moveContent
        #>

        #Uncomment this option if you use Azure AD. It can provide single-signon capability.
        #New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\OneDrive -Name EnableADAL -PropertyType DWORD -Value 1 
        <#Silent Sync Auto-Account Configuration for OneDrive with ADAL- Microsoft Azure Active Directory Authentication Library 
        will now support silent sync and account config for OneDrive. This will automatically configure OneDrive 
        during a new device provisioning and ensure a new users OneDrive is automatically set up without 
        any interaction required from the end user#>

        #New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\OneDrive -Name EnableAllOcsiClients -PropertyType DWORD -Value 1
        <#This setting enables live coauthoring and in-app sharing for Office files opened locally from your computer.
        Coauthoring and in-app sharing for Office files is allowed by default. (Coauthoring is available in Office 2013 and Office 2016.)
        If you enable this setting, coauthoring and in-app sharing for Office is enabled, but users can disable it on the Office tab in the sync client if they wish.
        If you disable this setting, coauthoring and in-app sharing for Office files is disabled, and the Office tab is hidden in the sync client. 
        If you disable this setting, then the "Users can choose how to handle Office files in conflict" setting will act as disabled and in case of file conflicts, 
        the file will be forked.#>

        New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\OneDrive -Name DisablePersonalSync -PropertyType DWORD -Value 1
        <#This setting allows you to block users from syncing files from consumer (Microsoft Account-based) OneDrive. By default, 
        users are allowed to synchronize personal OneDrive accounts.
        If you enable this setting, users will be prevented from setting up a sync relationship for their personal OneDrive account. 
        If they had previously been synchronizing a personal OneDrive account, 
        they are shown an error when they start the sync client, but their files remain on the disk.
        If you disable this setting, users are allowed to synchronize personal OneDrive accounts.#>

        New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\OneDrive -Name DefaultToBusinessFRE -PropertyType DWORD -Value 1

        <#This policy setting lets you configure OneDrive so that, when triggered, the first run experience is launched in a mode for users to configure their O365 account to sync with SPO.
        If you enable this policy setting:
        * If users unlink their account and the first run experience launches, it will upsell them to configure an organization account as opposed to a Microsoft account. 
        * If a user uninstalls OneDrive, this regkey will be removed. If they then later reinstall OneDrive, the first run will default to the experience for configuring a Microsoft account.
        If you disable or do not configure this policy setting, OneDrive will default to showing the first run experience for configuring a Microsoft account.#>

        #New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\OneDrive\Tenants\TENAND-ID-GOES-HERE -Name DisableCustomRoot -PropertyType DWORD -Value 1
        <#This setting allows you to prevent users from changing the location of their OneDrive sync folder.
        If you enable this setting, users cannot change the location of their OneDrive - {tenant name} folder during the Welcome to OneDrive wizard. 
        This forces users to use either the default location, or, if you've set the "Set the default location for the OneDrive folder" setting, 
        ensures all users have their local OneDrive folder in the location that you've specified.
        If you disable this setting, users can change the location of their sync folder during the Welcome to OneDrive wizard.#>

        start odopen://sync?useremail=$env:USERNAME@$O365domain
    }
    End {
    }
}#/function
#