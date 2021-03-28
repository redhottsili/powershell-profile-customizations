function myls($args){
    $mySize = @{
        Name       = "Size"
        Expression = {
            if ($_.Mode.ToString()[0] -eq 'd') { $null }
            else {
                foreach ($i in "a") {
                    if ([math]::Round($_.Length / 1PB, 2) -ge 1) {
                        "$([math]::Round($_.Length / 1PB,2)) PB"
                        break
                    }
                    
                    if ([math]::Round($_.Length / 1GB, 2) -ge 1) {
                        "$([math]::Round($_.Length / 1GB,2)) GB"
                        break
                    }
                    
                    if ([math]::Round($_.Length / 1MB, 2) -ge 1) {
                        "$([math]::Round($_.Length / 1MB,2)) MB"
                        break
                    }
    
                    if ([math]::Round($_.Length / 1KB, 2) -ge 1) {
                        "$([math]::Round($_.Length / 1KB,2)) KB"
                        break
                    }
    
                    "$([math]::Round($_.Length,2)) B"
                }
            }
        }
        Alignment = "Right"
    }
    
    $myLSFormat = @{
        Name = "Directory"
        Expression = {
            if ($_.Mode.ToString()[0] -eq 'd') {
                $_.Parent.FullName
            }
            else {
                $_.Directory.FullName    
            }
        }
    }
    
    ls @args | Format-Table Mode, LastWriteTime, $mySize, Name -GroupBy $myLSFormat
}
