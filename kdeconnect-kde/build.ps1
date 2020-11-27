choco pack;
[xml]$xmlObject = (New-Object System.Net.WebClient).DownloadString(".\kdeconnect-kde.nuspec")
$version = $xmlObject.package.metadata.version
$pkg = Get-ChildItem -filter "kdeconnect-kde.$version.nupkg" | Select -exp Name
Write-host "Tem certeza que quer enviar o pacote $pkg para o repositório da comunidade do Chocolatey? (Padrão: N)" -ForegroundColor Yellow 
    $Readhost = Read-Host "( Y / N )" 
    Switch ($ReadHost) 
     { 
       Y {Write-host "Sim, continuar com o envio.";$push="true"} 
       N {Write-Host "Não, abortar.";$push = "false"} 
       Default {Write-Host "Nenhuma opção escolhida, pulando...";$push="false"} 
     } 
if($push -eq "true"){
	choco push ".\$pkg" --source 'https://push.chocolatey.org/';	
	Write-Host "Concluído!"
}else{
	Write-Host "Operação cancelada!"
}

Start-Sleep -s 2
Stop-Process -Id $PID
