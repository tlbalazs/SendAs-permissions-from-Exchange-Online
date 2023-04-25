$mailboxes = @()
$mailboxes = Get-ExoMailbox -ResultSize Unlimited | select Userprincipalname

foreach ($mailbox in $mailboxes)
{
    Get-EXORecipientPermission -UserPrincipalName $mailbox.UserPrincipalName | Select Identity, @{N='UPN';E={$mailbox.UserPrincipalName}}, Trustee, AccessControlType, AccessRights, IsInherited | Where {($_.Trustee -ne "NT AUTHORITY\SELF")} | Export-Csv C:\temp\sendas_upn.csv -Append
}