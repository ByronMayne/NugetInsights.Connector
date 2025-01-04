function Get-BuildAgent {

    $agentKind = "None";

    if(Test-Path env:APPVEYOR_API_URL) {
        $agentKind = "AppVeyor";
    }

    if(Test-Path env:TF_BUILD) {
        $agentKind = "AzurePipelines";
    }

    if(Test-Path env:BITBUCKET_WORKSPACE) {
        $agentKind = "BitBucket";
    }

    if(Test-Path env:BUILDKITE) {
        $agentKind = "BuildKite";
    }

    if(Test-Path env:CODEBUILD_WEBHOOK_HEAD_REF) {
        $agentKind = "CodeBuild";
    }

    if(Test-Path env:ContinuaCI.Versin) {
        $agentKind = "ContinuaCi";
    }

    if(Test-Path env:DRONE) {
        $agentKind = "Drone";
    }

    if(Test-Path env:ENVRUN_DATABASE) {
        $agentKind = "EnvRun";
    }

    if(Test-Path env:GITHUB_ACTIONS) {
        $agentKind = "GitHubActions";
    }

    if(Test-Path env:GITLAB_CI) {
        $agentKind = "GitLabCi";
    }

    if(Test-Path env:JENKINS_URL) {
        $agentKind = "Jenkins";
    }

    if(Test-Path env:BuildRunner) {
        $agentKind = "MyGet";
    }

    if(Test-Path env:SpaceAutomation) {
        $agentKind = "MyGet";
    }

    if(Test-Path env:TEAMCITY_VERSION) {
        $agentKind = "TeamCity";
    }

    if(Test-Path env:TRAVIS) {
        $agentKind = "TravisCi";
    }
    return $agentKind;
}