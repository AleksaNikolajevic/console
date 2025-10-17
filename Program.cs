using System.IO.Pipes;

class Program
{
    static void Main()
    {
        using (NamedPipeClientStream client = new NamedPipeClientStream(".", "MyWpfAppPipe", PipeDirection.Out))
        {
            client.Connect();

            using (StreamWriter writer = new StreamWriter(client))
            {
                writer.AutoFlush = true;
                writer.WriteLine("OpenPage2"); // Or OpenPage1
            }
        }

        Console.WriteLine("Command sent.");
    }
}