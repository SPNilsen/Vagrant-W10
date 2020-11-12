
$testchoco = $ChocoInstalled = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $ChocoInstalled = $true
}

if($testchoco){
    $chocover = powershell choco -v
    Write-Output "Seems Chocolatey is installed : $chocover"
    } else {
    Write-Output "Seems Chocolatey is not installed, installing now"
    #install chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

#install sublime text 3
choco install sublimetext3 -y

#install java - START

 # Download and silent install JDK Environement

# working directory path
$workd = "c:\temp"

# Check if work directory exists if not create it
If (!(Test-Path -Path $workd -PathType Container))
{ 
New-Item -Path $workd  -ItemType directory 
}

#create config file for silent install
$text = '
INSTALL_SILENT=Enable
AUTO_UPDATE=Enable
SPONSORS=Disable
REMOVEOUTOFDATEJRES=1
'
$text | Set-Content "$workd\jdkinstall.cfg"
    
#install java

    #download executable, this is 64-Bit Windows Java 8
    $source = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=240728_5b13a193868b4bf28bcb45c792fce896"
    $destination = "$workd\jdkInstall.exe"
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($source, $destination)

    #install silently
    Start-Process -FilePath "$workd\jdkInstall.exe" -ArgumentList INSTALLCFG="$workd\jdkinstall.cfg"

    echo 'Waiting for install to finish...'

    # Wait 120 Seconds for the installation to finish
    Start-Sleep -s 180

    echo 'Timer done...'

    # Remove the installer
    rm -Force $workd\jdk* 

#install java - END


#install git
choco install git -y

#rest of dev environment
choco install mysql -y
choco install mysql-connector -y
choco install mysql.workbench -y
choco install apache-netbeans.portable -y
choco install openconnect-gui -y
choco install python3 -y
choco install nodejs -y
choco install firefox -y
choco install postman -y
choco install ngrok -y

# changed base image to one that has Docker and Visual Studio installed
#enable linux subsystems and virtualization before installing WSL and Docker
# dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

#choco install docker-cli -y
# choco install wsl2 -y
# choco install docker-desktop -y


#init database
[void][system.reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.22\Assemblies\v4.5.2\MySQL.Data.dll")
#Create a variable to hold the connection:
$myconnection = New-Object MySql.Data.MySqlClient.MySqlConnection
#Set the connection string:
$myconnection.ConnectionString = "server=localhost;Persist Security Info=false;user id=root;pwd="
#Call the Connection object�s Open() method:
$myconnection.Open()

#uncomment this to print connection properties to the console
#echo $myconnection

$dbname = "test2"

#create the database
$createcmd = New-Object MySql.Data.MySqlClient.MySqlCommand
$createcmd.Connection  = $myconnection

#drop if exists
$createcmd.CommandText = "DROP DATABASE IF EXISTS " + $dbname
$createcmd.ExecuteNonQuery()

#create schema
$createcmd.CommandText = 'CREATE SCHEMA `' + $dbname + '`'
$createcmd.ExecuteNonQuery()
#close the connection
$myconnection.Close()

#populate data using SQL file
#cmd.exe /c "mysql -u root -p test2 < /vagrant/setup-db.sql" 