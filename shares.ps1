$set = {
function setshare{
$pass = Read-Host -AsSecureString
$dp1base = "C:\DP1\"
$dp1public = "C:\DP1\Public\"
$char = "Charb"
$flamme = "Flamme"
$fraser = "Fraser"
$rimp = "Rimp"
$mach = "Jon"
$chop = "Choppy"
$userarr = @($char,$flamme,$fraser,$rimp,$mach,$chop)
foreach($user in $userarr){
    New-LocalUser -Name $user -AccountNeverExpires -Password $pass
}
New-Item -ItemType Directory -Path $dp1base
New-Item -ItemType Directory -Path $dp1public
New-SmbShare -Name "DP1PUBLIC" -path $dp1public -FullAccess $char,$flamme,$fraser,$mach,$rimp,$chop, "Administrator"
foreach($user in $userarr){
New-Item -ItemType Directory -Path $dp1base$user
New-SmbShare -Name $user -Path $dp1base$user -FullAccess $user
}
}
setshare
}

## ENabling WINRM winrm set winrm/config/client '@{TrustedHosts="192.168.152.1,192.168.152.134"}' (2 IPS SERVER AND CLIENT)
Invoke-Command -ComputerName "192.168.152.134" -Credential Administrator -ScriptBlock $set