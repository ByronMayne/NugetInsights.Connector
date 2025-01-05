# NugetInsights.Collector 

Gain insights into how your NuGet packages are being used.

As a NuGet package developer, I often wondered whether my packages were being used and how they were performing. To address this curiosity and stay motivated, I decided to add lightweight telemetry to my packages. NugetInsights.Collector simplifies this process for package developers by providing an easy way to collect usage data.


# How it works

NugetInsights.Collector adds an `init.ps1` PowerShell script to the tools folder of the generated NuGet package. This script is automatically executed by the NuGet package manager whenever the package is installed. When executed, the script sends a telemetry event to an Azure Application Insights instance, which is publicly accessible through Grafana.
Key Features:

* **Transparency**: All collected data is anonymized and cannot be linked to specific users.
* **Open Source**: Don't just take my word for [it—review](./Content/tools/init.ps1) the script yourself. The telemetry process is minimal, using a simple REST request to send data.


## Customization  

Currently this posts the information to my Azure subscription however you can changing the following MSBuild property values.

`NugetInsightsInstrumentationKey`: The key to application insights instance 
`NugetInsightsIngestionUrl`: The url to the application insights. 

```xml
<PropertyGroup>
    <NugetInsightsIngestionUrl>{Application Insights Url}</NugetInsightsIngestionUrl>
    <NugetInsightsInstrumentationKey>{Your Key}</NugetInsightsInstrumentationKey>
</PropertyGroup>
```



## Accreditation 
<a href="https://www.flaticon.com/free-icons/network" title="network icons">Network icons created by Freepik - Flaticon</a>