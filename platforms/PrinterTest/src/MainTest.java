import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

/**
 * Created by twer on 4/18/14.
 */
public class MainTest {

    public static void main(String args[]) throws IOException {
        String sentence;
        String modifiedSentence;
        BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));

        Socket clientSocket = new Socket("192.168.1.114", 9100);
        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
        BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

        while (true) {
            sentence = inFromUser.readLine();
            outToServer.writeBytes(sentence + '\n');
        }
//        sentence = inFromUser.readLine();
//        outToServer.writeBytes(sentence + '\n');
//        modifiedSentence = inFromServer.readLine();
//        System.out.println("..hello world");
//        clientSocket.close();

    }
}
