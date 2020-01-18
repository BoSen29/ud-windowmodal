function New-UDWindowModal {
    [CmdletBinding(DefaultParameterSetName = "Global")]
    param(
        [Parameter(
            Mandatory = $true
        )]
        [string]$Id = ([Guid]::NewGuid()),
        [Parameter(
            ParameterSetName = "Content")]
        [scriptblock]$Content,
        [Parameter(
            Mandatory = $true
        )]
        [string]$Title,
        [Parameter(
            Mandatory = $false
        )]
        [scriptblock]$onClose,
        [Parameter(
            Mandatory = $false
        )]
        [scriptblock]$onReSize
    )
    Begin {
        if ($onClose) {
            if ($onClose -is [scriptblock]) {
                $onClose = New-UDEndpoint -Endpoint $onClose -Id "$($Id)onClose"
            }
            elseif ($onClose -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "Action must be a script block or UDEndpoint."
            }
        }
        if ($onReSize) {
            if ($onReSize -is [scriptblock]) {
                $onReSize = New-UDEndpoint -Endpoint $onReSize -Id "$($Id)onReSize"
            }
            elseif ($onReSize -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "Action must be a script block or UDEndpoint."
            }
        }
    }

    Process {
    }

    End {
        @{
            # The AssetID of the main JS File
            assetId = $AssetId 
            # Tell UD this is a plugin
            isPlugin = $true 
            # This ID must be the same as the one used in the JavaScript to register the control with UD
            type = "ud-windowmodal"
            # An ID is mandatory 
            id = $Id
            content = $Content.Invoke()
            title = $title
            onClose = $onClose.Id
            onReSize = $onReSize.Id
        }
    }
}

