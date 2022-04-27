function Get-Summary ($issue) {
    return New-Object psobject -Property @{
        Number = $issue.number;
        Title = $issue.title;
        Labels = $issue.labels | ForEach-Object { $_.name };
        State = $issue.state;
        Created = $issue.created_at;
        Updated = $issue.updated_at;
        Closed = $issue.closed_at;
    }
}

function Get-Issues {
    [CmdletBinding()]
    param (
        [int] $MaxPages = 3
    )

    $allIssues = @()
    $page = 1

    while ($page -le $MaxPages) {
        $uri = "https://api.github.com/repos/OctopusDeploy/Issues/issues?state=all&page=$page"
        $headers = @{ "Accept" = "application/vnd.github.v3+json" }
        try {
            $issues = (Invoke-WebRequest -Uri $uri -Headers $headers).Content | ConvertFrom-Json
            if ($null -eq $issues) {
                break
            }
            $allIssues += $issues
        } catch {
            break
        }
        $page++
    }

    return $allIssues | ForEach-Object { Get-Summary $_ }
}

Get-Issues

# $issues = Get-Issues

# # 1.
# $issues | Format-Table -Property Number, Title

# # 2.
# $issues | Where-Object { $_.State -eq 'open' } | Sort-Object -Property Number | Format-Table -Property Number, Title 

# # 3.
# $issues | Where-Object { $_.State -eq 'closed' } | Sort-Object -Property Closed -Descending | Format-Table -Property Number, Closed, Title

# # 4.
# $TimeToClose = @{ label = "Time to Close"; expression = { $_.Closed - $_.Created } }
# $issues | Where-Object { $_.State -eq 'closed' } | Select-Object -Property *, $TimeToClose | Sort-Object -Property "Time to Close" -Descending | Format-Table -Property Number, "Time to Close", Title

# # 5.
# $Team = @{ label = "Team"; expression = { @($_.Labels) -Like "team/*" | ForEach-Object { $_.SubString(5) } } }
# $issues | Select-Object -Property *, $Team | Where-Object -Property Team | Format-Table -Property Number, Team, Title