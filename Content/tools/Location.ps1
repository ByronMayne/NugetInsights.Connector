try {

    $ipResponse = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/2001:4958:234d:c01:991e:32a4:b4e3:adbf"
    $latitude = $ipResponse.lat;
    $longitude = $ipResponse.lon;
}
catch {
    # Does not matter
}