Import-Module UniversalDashboard
Import-Module "C:\dev\ud-windowmodal\src\output\UniversalDashboard.UD-WindowModal\UniversalDashboard.UD-WindowModal.psm1"

$endpointinit = New-UDEndpointInitialization -Module @("C:\dev\ud-windowmodal\src\output\UniversalDashboard.UD-WindowModal\UniversalDashboard.UD-WindowModal.psm1")

Enable-UDLogging -Level debug -FilePath C:\dev\ud-windowmodal\Examples\udlog.txt

Get-UDDashboard | Stop-UDDashboard

$dashboard = New-UDDashboard -title "Non Global Hotkeys" -Content {
    #define where the hotkeys are active within

    #generic content
    New-UDInput -Endpoint {
        param($target)
        New-UDInputAction -ClearInput
        <#
        Show-UDWindowModal -parentId "Parent" -title "Ping - $target" -Content {
            New-UDCounter -Id "$($target)pinger" -AutoRefresh -RefreshInterval 1 -Endpoint {
                (Test-Connection $target -Count 1 ).ResponseTime
            } -ArgumentList $target
        }#>
        Show-UDToast $target
    }
    New-UDWindowModal -Title "HelloBruv" -content {
        New-UDElement -Endpoint {
            (Test-Connection "vg.no" -Count 1 ).ResponseTime
        } -AutoRefresh -RefreshInterval 1 -Tag div -Id "Pingbois"
        New-UDHtml -Markup "ASDF FOR THE WIN"
    } -id "stuffboisid"

    New-UDButton -Text "Show me some money" -OnClick {
        Show-UDModal -Content {
            New-UDElement -Id "Stuffme" -Content {"henlo"} -Tag span
        }
    }

    New-UDElement -Id "Parent" -Content {} -Tag span
    New-UDButton -Text "Add Modal" -OnClick {
        Show-UDWindowModal -parentId "Parent" -Title "HelloBruv" -content {
            New-UDParagraph -Content {
                New-UDHtml -Markup "hello bruv"
            }
            New-UDParagraph -Content {
                New-UDHtml -Markup "hello bruv v2"
            }
            New-UDParagraph -Content {
                New-UDElement -Endpoint {
                    (Test-Connection "vg.no" -Count 1 ).ResponseTime
                } -AutoRefresh -RefreshInterval 1 -Tag div
            }
            New-UDInput -Endpoint {
                param(
                    $string
                )
                Show-UDToast -Text "Stuff is triggered $string"
            }
        } -id (get-random)
    }

    
    New-UDCard -Title "This is card inside child"

} -theme $theme -EndpointInitialization $endpointinit

Start-UDDashboard -Dashboard $dashboard -Port 8083