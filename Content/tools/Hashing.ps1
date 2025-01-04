function Get-MachineHash {
    try {
        $machineName = [Environment]::MachineName
        $userName = [Environment]::UserName
        $processorCount = [Environment]::ProcessorCount
        $osVersion = [System.Environment]::OSVersion;
        $data = "$machineName|$userName|$processorCount|$osVersion"
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($data)
        $sha256 = [System.Security.Cryptography.SHA256]::Create()
        $hashBytes = $sha256.ComputeHash($bytes)
        $hashString = -join ($hashBytes | ForEach-Object { $_.ToString("x2") })
        return $hashString
    }
    catch 
    {
        return 0;
    }
}