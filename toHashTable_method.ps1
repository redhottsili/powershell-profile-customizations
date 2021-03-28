try {
    class MyCustomObject {
        [PSCustomObject]$PSCustomObject
        
        MyCustomObject([PSCustomObject]$p) {
            $this.PSCustomObject = $p
        }
            
        [hashtable] ToHashTable () {
            $properties = $this.PSCustomObject | Get-Member | Where-Object MemberType -eq "NoteProperty" | Select-Object -ExpandProperty name
        
            $HashTable = @{}
            foreach ($property in $properties) {
                $HashTable[$property] = $this.PSCustomObject.$property
            }
            Return $HashTable
        }
    }
        
    Update-TypeData -TypeName System.Object -MemberType ScriptMethod -ErrorAction Stop -MemberName ToHashTable -Value {
        $hash = @{}
        foreach ($m in $this.PSObject.Properties.Where{ $_.MemberType -like '*Property' }) {
            $hash[$m.Name] = $m.Value
        }
          
        $hash
    }
}
catch [System.Management.Automation.RuntimeException] {
    if (-not ($_.Exception.Message -eq 'Error in TypeData "System.Object": The member ToHashTable is already present.')) {
        $_
    }
}
