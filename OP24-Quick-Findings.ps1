$op24user = ""
$op24pw = ""
$uri = "https://outscan.outpost24.com"

# Interact with OP24 API
$creds = 'username=' + 
         ([System.Web.HttpUtility]::UrlEncode([System.Web.HttpUtility]::UrlDecode($op24user))) + 
         '&password=' + 
         ([System.Web.HttpUtility]::UrlEncode([System.Web.HttpUtility]::UrlDecode($op24pw)))

# Function to obtain all of the regular findings from Outpost24 to create issues from
function Get-OP24Findings ([string]$creds, [string]$uri) {
    # Start off by logging in (this should be handled separately)
    $response = curl -uri ($uri+'/opi/rest/auth/login') -Method post -Body $creds
    $token = $response.Content
    $data = curl -uri ($uri + '/opi/rest/findings') -Header @{Authorization = "Bearer "+ $token }
    
    # Convert the data from JSON into powershell object and return it
    $findings = convertfrom-json $data.content
    return  $findings
}

$findings = Get-OP24Findings -creds $creds -uri $uri
$findings
