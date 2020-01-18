function Add-UDWindowModal {
    [CmdletBinding(DefaultParameterSetName = "Global")]
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()),
        [Parameter(
            ParameterSetName = "Content")]
        [scriptblock]$Content,
        [Parameter(
            Mandatory = $true
        )]
        [string]$ParentId,
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
        $out
        $paramSplat = @{
            Id = $Id
            Content = $Content
            Title = $Title
            onClose = $onClose
            onReSize = $onReSize
        }
    }

    Process {
        $out = New-UDWindowModal @paramSplat
    }

    End {
        Add-UDElement -ParentId $ParentId -Content {
            $out
        }
    }
}

