param(
    [string]$first_name,
    [string]$last_name
)
function display {
    $full_name = $first_name + " " + $last_name
    Write-Output "My full name is $full_name"
}
display