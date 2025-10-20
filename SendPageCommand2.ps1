$pipeName = "MyWpfAppPipe"

# Connect to the named pipe (client side)
$pipeClient = new-object System.IO.Pipes.NamedPipeClientStream(".", $pipeName, [System.IO.Pipes.PipeDirection]::Out)
$pipeClient.Connect()

# Create a StreamWriter to send the command
$writer = new-object System.IO.StreamWriter($pipeClient)
$writer.AutoFlush = $true

# Send the command to the WPF app
$writer.WriteLine("OpenPage2")   # Or "OpenPage2" depending on what you want

# Close resources
$writer.Close()
$pipeClient.Close()
