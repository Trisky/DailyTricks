#open a new powershell window with admin rights in this directory. (Triggers UAT)
function sudo(){
    Start-Process powershell -Verb runas -ArgumentList "-NoExit -c cd `"$pwd`""
}

#converts all office files in subfolders to PDF and moves the original files to a /docx folder inside its original folder
function office2folder($ext){
    if($ext -eq ""){
     write-host "Please specify an extension" -BackgroundColor Red -ForegroundColor White
    }
    $expression ="*.$ext"    

    $thisFolder = Get-ChildItem(get-location) -Filter  $expression -Recurse
    foreach ($file in $thisFolder) {
        $dir = $file.Directory.fullname
        $name = $file.name
        $old =  $file.fullname;
        $TargetFilePath = "$dir\vsd_$ext\$name"
        New-Item -ItemType File -Path $TargetFilePath -Force
        Move-Item -Path $old -Destination $TargetFilePath -Force
        Write-Output $TargetFilePath
    }
}

# Recursively transforms MOV files into mp4 files giving the mp4 files the mov file modification and creation dates.
# Deletes the MOV files


function videoTomp4{

    function scapePath($path){
        return "`"$path`""
    }
    function writeError($msg){
        write-host $msg -BackgroundColor Red -ForegroundColor White
        Add-Content $errorFile $msg
    }
    $StartTime = $(get-date)
    $errorFile = "ffmpeg_error.log"
    if (Test-Path $errorFile) {
        Remove-Item $errorFile
    }
    New-Item $errorFile

    #$codec = "libx264" #via CPU
    $codec = "h264_nvenc" #GPU

    $oldExtension = "*.mov"
    $files = Get-ChildItem(get-location) -Filter $oldExtension -Recurse 
    $originalSize = $actual =$newSize=$amoutOfErrors= 0
    $total = $files.count
    if($total -eq 0){
     Write-Host "no $oldExtension files found"
     return
    }
    foreach($file in $files){
        try{
            $name = $file.BaseName
            $movFile = $file.Name
            $actual++
            $size = ($file.length)/(1024*1024)
            $originalSize = $originalSize+ $size
            write-host "======================================" -BackgroundColor Green -ForegroundColor black
            Write-Host  "$actual/$total - Converting $movFile of size $size MB"  -BackgroundColor Green -ForegroundColor black

            $directory = $file.Directory.FullName
            $movFileName = "$directory\$movFile"        
            $movFileScaped = scapePath($movFileName)
            $mp4Name =  $name +".mp4" 
            $mp4OutputPath = "$directory\$mp4Name"
            #$mp4OutputPath = "C:\Users\Trisky\Desktop\out\$mp4Name" para testear
            $mp4NameScaped = scapePath($mp4OutputPath)

            $arg = " -y  -i  $movFileScaped -f mp4 -vcodec $codec -preset fast -profile:v main -acodec aac $mp4NameScaped -hide_banner"
            #write-host $arg
            # starts ffmpeg in the same window, returns the return code of the process and waits for it to finish before continuing.
            $process = Start-Process -FilePath ".\ffmpeg.exe" -ArgumentList $arg  -PassThru -NoNewWindow  -Wait
            if($process.ExitCode  -ne "#0"){
                writeError("ffmpeg FAILED  with $movFileName!")
                $amoutOfErrors = $amoutOfErrors + 1
                Continue 
            }  

            
            if (-Not (Test-Path $mp4OutputPath)) {
                writeError("ffmpeg FAILED to create the file $mp4OutputPath!")
                $amoutOfErrors = $amoutOfErrors + 1
                Continue 
            }
            $mp4File = (Get-Item $mp4OutputPath)
            #////////////// sets the new file dates to the old file ones.
            $mp4File.CreationTime =   $file.CreationTime
            $mp4File.LastWriteTime =    $file.LastWriteTime
            #//////////////// size calc
            $mp4Size = ($mp4File).length/(1024*1024)
            $newSize = $mp4Size + $newSize
            Remove-Item "$directory\$movFile" # deletes the MOV file!
        }
        catch{
            $ErrorMessage = $_.Exception.Message
            writeError("something FAILED with $movFileName! - $ErrorMessage")
            $amoutOfErrors = $amoutOfErrors + 1
            Continue 
        }
        
    }
    write-host "======================================"
    $finishedMsg = "finished processing $total videos"

    if($amoutOfErrors -gt 0){
        writeError("$finishedMsg but $amoutOfErrors of those failed!!!!!!!!!!!!!!!!!!!!!!")
    }else{
        write-host $finishedMsg -BackgroundColor Green
    }
    write-host "original videos size: $originalSize MB"
    write-host "new videos size: $newSize MB"
    $rate = $newSize/$originalSize
    write-host "compression rate: $rate %"
    $saved = $originalSize - $newSize
    write-host "saved space : $saved MB"

    $elapsedTime = $(get-date) - $StartTime
    $totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
    write-host "took $totalTime"

}

#Recursively sums the size of all the files with certain extension.
function calcSize($ext){
    if($ext -eq ""){
     write-host "Please specify an extension" -BackgroundColor Red -ForegroundColor White
    }
    $ext ="*.$ext"
    
    $files = Get-ChildItem(get-location) -Filter $ext -Recurse 
    $size = 0;
    foreach($file in $files){
        $size = ($file.length)/(1024*1024) + $size
    }
    if($size -gt 1024){
        $size = $size/1024
        $size = "$size GB"

    }else{
        $size = "$size MB"
    }
    $total = $files.count
    Write-Output "Total size = $size in $total files for extension $ext"

}