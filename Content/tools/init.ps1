# Used to send a telemetry event whenever a package is installed. It does not
# post any information that can be traced back to a user. It's used just so
# I can see which projects are being used the most.
param($installPath, $toolsPath, $package, $project)

# Import other scripts 
. $PSScriptRoot\..\ps\Hashing.ps1
. $PSScriptRoot\..\ps\BuildAgent.ps1
. $PSScriptRoot\..\ps\Variables.ps1

$packageName = $package.Id;
$packageVersion = $package.Version;
$applicationInsightsUrl = "https://dc.services.visualstudio.com/v2/track"
$operationId = 
$buildAgent = Get-BuildAgent
$machineHash =  Get-MachineHash

$tracePayload = @{
    name = "Microsoft.ApplicationInsights.Event"
    time = (Get-Date).ToString("o") 
    iKey = "43813c6c-bcf0-4610-bd97-9f6933a02b44"
    tags = @{
        "ai.operation.id" = $operationId
        "ai.cloud.role" = "NuGetScript"
    }
    data = @{
        baseType = "EventData"
        baseData = @{
            name = "package_init"
            properties = @{
                "PackageName" = "$packageName"
                "PackageVersion" = "$packageVersion"
                "BuildAgent" = $buildAgent
                "MachineId" = $machineHash
                "ConnectorVersion" = $insightsConnectorVersion
            }
        }
    }
}
$traceJson = $tracePayload | ConvertTo-Json -Depth 10 
try {
    Invoke-WebRequest -Uri $applicationInsightsUrl -Method Post -Body $traceJson -ContentType "application/json" | Out-NullInvoke-WebRequest 
} catch {}