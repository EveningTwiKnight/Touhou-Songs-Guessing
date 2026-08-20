# server.ps1 —— 东方Project 原曲听力测试 本地服务器
# 无需安装任何东西：Windows 自带 PowerShell。请通过「启动游戏.bat」运行本脚本。

$ErrorActionPreference = 'Stop'

# 1) 找一个可用端口（从 8000 开始，被占用则往后找）
$listener = $null
$port = 0
for ($p = 8000; $p -le 8099; $p++) {
    try {
        $l = New-Object System.Net.HttpListener
        $l.Prefixes.Add("http://localhost:$p/")
        $l.Start()
        $listener = $l
        $port = $p
        break
    } catch {
        # 端口被占用，继续尝试下一个
    }
}

if ($null -eq $listener) {
    Write-Host "启动失败：8000-8099 端口都被占用。" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

# 项目根目录 = 本脚本所在目录
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$url  = "http://localhost:$port/index.html"

Write-Host ""
Write-Host "  =============================================" -ForegroundColor Green
Write-Host "   东方Project 原曲听力测试 已启动！" -ForegroundColor Green
Write-Host "   请保持本窗口开启（关闭窗口即停止游戏）" -ForegroundColor Yellow
Write-Host "   地址：$url" -ForegroundColor Cyan
Write-Host "  =============================================" -ForegroundColor Green
Write-Host ""

# 2) 自动打开浏览器
try { Start-Process $url } catch {}

# 3) MIME 类型
$mime = @{
    '.html' = 'text/html; charset=utf-8'
    '.htm'  = 'text/html; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.mjs'  = 'application/javascript; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.mid'  = 'audio/midi'
    '.midi' = 'audio/midi'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.gif'  = 'image/gif'
    '.svg'  = 'image/svg+xml'
    '.ico'  = 'image/x-icon'
    '.woff' = 'font/woff'
    '.woff2'= 'font/woff2'
    '.ttf'  = 'font/ttf'
}

# 4) 处理请求（单线程足够本地单人使用）
$rootFull = [System.IO.Path]::GetFullPath($root).TrimEnd('\') + '\'

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
    } catch {
        break
    }

    $request  = $context.Request
    $response = $context.Response
    $out      = $response.OutputStream

    $raw  = $request.Url.AbsolutePath
    $path = [System.Uri]::UnescapeDataString($raw)
    if ($path -eq '/' -or $path -eq '') { $path = '/index.html' }

    $file = Join-Path $root ($path.TrimStart('/') -replace '/', '\')
    $full = [System.IO.Path]::GetFullPath($file)

    if (-not $full.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase) -or
        -not (Test-Path -LiteralPath $full -PathType Leaf)) {
        $response.StatusCode = 404
        $bytes = [System.Text.Encoding]::UTF8.GetBytes('404 Not Found')
    } else {
        $response.StatusCode = 200
        $ext = [System.IO.Path]::GetExtension($full).ToLower()
        if ($mime.ContainsKey($ext)) { $response.ContentType = $mime[$ext] }
        else { $response.ContentType = 'application/octet-stream' }
        $bytes = [System.IO.File]::ReadAllBytes($full)
    }

    $response.ContentLength64 = $bytes.Length
    $out.Write($bytes, 0, $bytes.Length)
    $out.Close()
}

Write-Host "服务器已停止。" -ForegroundColor Yellow
