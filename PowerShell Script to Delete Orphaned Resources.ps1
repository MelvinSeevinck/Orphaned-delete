# PowerShell Script to Delete Orphaned Azure Arc SQL Managed Instances

# Set the subscription context
$subscriptionId = "<subscription-id>"
Set-AzContext -SubscriptionId $subscriptionId

# Azure Resource Graph query to find orphaned Azure Arc SQL Managed Instances
$query = @"
Resources
| where type =~ 'microsoft.azurearcdata/sqlmanagedinstances'
| project id, name, resourceGroup
| join kind=leftouter (
    ResourceContainers
    | where type =~ 'microsoft.resources/subscriptions/resourcegroups'
    | project resourceGroup
) on resourceGroup
| where isnull(resourceGroup1)
| project id, name
"@

# Execute the query
$orphanedDatabases = Search-AzGraph -Query $query

# Check if there are any orphaned databases
if (-not $orphanedDatabases) {
    Write-Host "No orphaned Azure Arc SQL databases found."
    exit
}

# Display the list of orphaned databases
Write-Host "`nFound orphaned Azure Arc SQL databases:"
$orphanedDatabases | ForEach-Object { Write-Host " - $($_.name) (ID: $($_.id))" }

# Ask for confirmation before deletion
$confirmation = Read-Host "`nDo you want to delete these databases? (Y/N)"
if ($confirmation -ne 'Y') {
    Write-Host "Operation canceled."
    exit
}

# Delete the orphaned databases
foreach ($database in $orphanedDatabases) {
    Write-Host "Deleting: $($database.name)..."
    Remove-AzResource -ResourceId $database.id -Force
    Write-Host "Deleted: $($database.name)."
}

Write-Host "`nAll orphaned Azure Arc SQL databases have been deleted."