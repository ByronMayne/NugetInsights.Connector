# NugetInsights.Collector 

Have you ever wanted to get more information about your NuGet packages? As a package developer myself I often wondered if my packages were even being used. In part to help motivate me and in another just for the curiosity I wanted to add telemetry to all my packages.  That is exactly what this library does. This is exactly what NugetInsights.Collector does!


# How it works

This project injects a `init.ps1` powershell script into the `tools` folder of the generated NuGet package. This script will be called by the NuGet package manager whenever your package is added. This will publish the event to my private Azure Application Insight instance which I will expose publicly on Grafana. 

All the data I collect has no way of being mapped back to a specific user. Don't trust me? [Read the code yourself](./Content/tools/init.ps1), it's very bare bones as the telemetry is posted using a simple REST request. 


# Notes
* Right nos this is very much a work in progress 
* At some point I will require packages to register before hand, right now it's open.
* All the costs are being paid for me personally. 



## Accreditation 
<a href="https://www.flaticon.com/free-icons/network" title="network icons">Network icons created by Freepik - Flaticon</a>