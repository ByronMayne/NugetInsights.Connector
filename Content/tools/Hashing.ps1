function Get-StringHash {
    param (
        [Parameter(Mandatory=$true)]
        [string] $InputString
    )
    $hashLength = 64;
    $sha512 = [System.Security.Cryptography.SHA512]::Create()
    $inputBytes = [System.Text.Encoding]::UTF8.GetBytes($InputString)
    $hashBytes = $sha512.ComputeHash($inputBytes)
    $hashString = -join ($hashBytes | ForEach-Object { $_.ToString("x2") })

    if ($hashString.Length -gt $hashLength) {
        return $hashString.Substring(0, $hashLength) # Truncate if too long
    } elseif ($hashString.Length -lt $hashLength) {
        return $hashString.PadRight($hashLength, '0') # Pad with zeros if too short
    }

    return $hashString
}

function Get-MachineHash {
    try {
        $machineName = [Environment]::MachineName
        $userName = [Environment]::UserName
        $processorCount = [Environment]::ProcessorCount
        $osVersion = [System.Environment]::OSVersion;
        $data = "$machineName|$userName|$processorCount|$osVersion|"
        return Get-StringHash -Input $data
    }
    catch 
    {
        return 0;
    }
}