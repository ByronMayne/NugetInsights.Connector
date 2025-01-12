param($installPath, $toolsPath, $package, $project)
# Used to send a telemetry event whenever a package is installed. It does not
# post any information that can be traced back to a user. It's used just so
# I can see which projects are being used the most.


# Import other scripts 
. $PSScriptRoot\Variables.ps1
. $PSScriptRoot\BuildAgent.ps1
. $PSScriptRoot\Location.ps1
. $PSScriptRoot\Hashing.ps1

$projectName = "Unset"
if($null -ne $project || $null -ne $project.FileName){
    $projectName = $project.name;
}

$buildAgent = Get-BuildAgent
$machineHash =  Get-MachineHash
$projectPathHash = Get-StringHash -InputString $projectName 

$tracePayload = @{
    name = "Microsoft.ApplicationInsights.Event"
    time = (Get-Date).ToString("o") 
    iKey = $instrumentationKey
    tags = @{
        "ai.operation.id" = $operationId
        "ai.cloud.role" = "NuGetScript"
    }
    data = @{
        baseType = "EventData"
        baseData = @{
            name = "package_init"
            properties = @{
                "PackageId" = $packageId
                "PackageVersion" = $packageVersion
                "BuildAgent" = $buildAgent
                "MachineId" = $machineHash
                "ProjectPathHash" = $projectPathHash
                "NugetInsights.Connector.Version" = $insightsConnectorVersion
                "Latitude" = $latitude
                "Longitude" = $longitude
            }
        }
    }
}
try {
    $traceJson = $tracePayload | ConvertTo-Json -Depth 10 
    Invoke-WebRequest -Uri $insightsIngestionUrl -Method Post -Body $traceJson -ContentType "application/json" | Out-Null
} catch {}