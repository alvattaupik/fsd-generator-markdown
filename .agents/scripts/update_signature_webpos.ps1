$webPosFiles = @(
    "d:\FSD\Web POS\3. First time login user kasir.md",
    "d:\FSD\Web POS\4. Temporary password expired user kasir.md",
    "d:\FSD\Web POS\5. Update password expired user kasir.md",
    "d:\FSD\Web POS\6. Reset password user kasir.md",
    "d:\FSD\Web POS\7. Generate report.md",
    "d:\FSD\Web POS\8. Menampilkan riwayat transaksi.md",
    "d:\FSD\Web POS\9. Transaksi penjualan generate QRIS MPM.md",
    "d:\FSD\Web POS\10. Transaksi penjualan scan QRIS CPM On-Us.md",
    "d:\FSD\Web POS\11. Transaksi penjualan scan QRIS CPM Off-Us.md"
)

$sigRuleText = "<br>10. **Web POS Request Signature Verification Standard:** Selain permintaan Aktivasi (UC-WPOS-001), seluruh permintaan API yang dikirimkan oleh peramban Web POS WAJIB ditandatangani secara digital (*digital signature* - header `X-Signature`) menggunakan Private Key yang tersimpan pada *Local Device Storage* peramban (*IndexedDB / Hardware TPM*). API Gateway WAJIB memverifikasi signature tersebut menggunakan `web_pos_public_key` yang tersimpan pada tabel `mst_merchant_terminals` (atau Redis Cache). Apabila signature tidak valid, kedaluwarsa, atau missing, API Gateway WAJIB menolak request secara langsung (HTTP Status 401 `INVALID_DEVICE_SIGNATURE`)."

foreach ($filePath in $webPosFiles) {
    if (Test-Path $filePath) {
        $content = Get-Content -Path $filePath -Raw -Encoding UTF8

        # 1. Update Aturan Bisnis if signature rule not present
        if ($content -notlike "*Web POS Request Signature Verification Standard*") {
            $content = $content -replace "(\|\s*Aturan Bisnis/Sistem\s*\|[\s\S]*?)( \|)", "`$1$sigRuleText `$2"
        }

        # 2. Add AF for Invalid Device Signature if not present
        if ($content -notlike "*INVALID_DEVICE_SIGNATURE*" -and $content -like "*# 3 Alternative Flow*") {
            # Find last AF code number in table
            $afMatches = [regex]::Matches($content, "AF-(\d+)")
            $maxAfNum = 0
            foreach ($match in $afMatches) {
                $num = [int]$match.Groups[1].Value
                if ($num -gt $maxAfNum) { $maxAfNum = $num }
            }
            $nextAfNum = $maxAfNum + 1
            $afCodeStr = "AF-" + $nextAfNum.ToString("D2")

            $afLine = "| $afCodeStr | Signature Digital Perangkat Web POS Tidak Valid | Pada langkah request API Gateway, apabila header `X-Signature` tidak valid, kedaluwarsa, atau tidak cocok dengan `web_pos_public_key` pada `mst_merchant_terminals` / Redis Cache, API Gateway menolak request dan Front-End menampilkan `Signature digital perangkat Web POS tidak valid atau tidak terverifikasi.`. |"

            # Insert before # 4 Status Frontend
            $content = $content -replace "(# 4 Status Frontend)", "$afLine`n`n`$1"
        }

        # 3. Add Response Code 401XX01 if not present
        if ($content -notlike "*INVALID_DEVICE_SIGNATURE*" -or $content -notlike "*401XX01*") {
            # Find max row number in Table 5
            $rcLine = "| 99 | 401 | 401XX01 | INVALID_DEVICE_SIGNATURE | Signature digital request Web POS (header `X-Signature`) tidak valid atau tidak cocok dengan `web_pos_public_key` pada `mst_merchant_terminals`. | Menampilkan pesan kesalahan `Signature digital perangkat Web POS tidak valid atau tidak terverifikasi`. |"
            
            # Insert before # 8 Desain Antarmuka
            $content = $content -replace "(# 8 Desain Antarmuka)", "$rcLine`n`n`$1"
        }

        [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated:" $filePath
    }
}

Write-Host "Web POS Signature Updates Complete."
