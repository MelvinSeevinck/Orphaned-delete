# Orphaned-delete
This script permanently deletes orphaned resources. Ensure that the instances are no longer needed before confirming deletion.

Delete Orphaned Azure Arc SQL Managed Instances
This PowerShell script identifies and removes orphaned Azure Arc SQL Managed Instances from an Azure subscription.

Features
Uses Azure Resource Graph to find orphaned SQL Managed Instances.
Lists orphaned instances before deletion.
Asks for user confirmation before proceeding.
Deletes the orphaned instances securely using Remove-AzResource.
Prerequisites
Azure PowerShell module (Az module) installed.
Permissions to manage Azure Arc SQL Managed Instances in the target subscription.
Usage
Set your Azure subscription ID in the script.
Run the script in PowerShell.
Review the list of orphaned instances.
Confirm deletion (Y to proceed, any other key to cancel).
Customizing for Other Resource Types
This script can be modified to detect and delete other types of orphaned Azure resources by updating the Azure Resource Graph query.
For example, to find orphaned virtual machines or storage accounts, replace:

PowerShell

| where type =~ 'microsoft.azurearcdata/sqlmanagedinstances'
With:

PowerShell

| where type =~ 'microsoft.compute/virtualmachines'
Or:

PowerShell

| where type =~ 'microsoft.storage/storageaccounts'
Ensure you validate the query results before deletion to prevent accidental removal of active resources.

Warning
This script permanently deletes orphaned resources. Ensure that the instances are no longer needed before confirming deletion.
