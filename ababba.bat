@echo off
setlocal EnableExtensions

title Gerador de Arquivos Aleatorios

echo ================================
echo    GERADOR DE ARQUIVOS
echo ================================
echo.

set /p "PASTA=Nome da pasta: "
if not defined PASTA set "PASTA=ArquivosGerados"

set /p "QTD=Quantidade de arquivos: "
if not defined QTD exit /b 1

set /p "TAM=Tamanho de cada arquivo (ex: 1KB, 10KB, 1MB, 100MB, 1GB): "
if not defined TAM exit /b 1

if not exist "%PASTA%" mkdir "%PASTA%"

echo.
echo Pasta: %PASTA%
echo Arquivos: %QTD%
echo Tamanho: %TAM%
echo.

powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"$p = $env:PASTA; $q = [int]$env:QTD; $t = $env:TAM; ^
function Convert-ToBytes([string]$Texto) { ^
  if($Texto -match '^\s*(\d+)\s*KB\s*$'){ return [int64]$Matches[1] * 1024 } ^
  if($Texto -match '^\s*(\d+)\s*MB\s*$'){ return [int64]$Matches[1] * 1024 * 1024 } ^
  if($Texto -match '^\s*(\d+)\s*GB\s*$'){ return [int64]$Matches[1] * 1024 * 1024 * 1024 } ^
  if($Texto -match '^\s*(\d+)\s*B\s*$'){ return [int64]$Matches[1] } ^
  if($Texto -match '^\s*(\d+)\s*$'){ return [int64]$Texto } ^
  throw 'Tamanho invalido' ^
} ^
$bytes = Convert-ToBytes $t; ^
$chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'; ^
$rand = [System.Random]::new(); ^
for($i = 1; $i -le $q; $i++){ ^
  $path = Join-Path $p ('arquivo_{0}.txt' -f $i); ^
  $sw = [System.IO.StreamWriter]::new($path, $false, [System.Text.Encoding]::UTF8); ^
  try { ^
    $count = 0; ^
    while($count -lt $bytes){ ^
      $sb = [System.Text.StringBuilder]::new(); ^
      for($j = 0; $j -lt 64; $j++){ [void]$sb.Append($chars[$rand.Next(0, $chars.Length)]) } ^
      $line = $sb.ToString(); ^
      $sw.WriteLine($line); ^
      $count += [Text.Encoding]::UTF8.GetByteCount($line + [Environment]::NewLine); ^
    } ^
  } finally { ^
    $sw.Dispose() ^
  } ^
  Write-Host ('Criado {0}/{1}: {2}' -f $i, $q, $path) ^
}"

if errorlevel 1 (
    echo.
    echo Houve um erro na criacao dos arquivos.
    pause
    exit /b 1
)

echo.
echo Concluido!
pause
