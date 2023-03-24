package Eliminatorias;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;

public class GenerateDev {
    public static void main(String[] args) throws FileNotFoundException {

        PrintStream out = new PrintStream(new FileOutputStream("output.csv"));
        System.setOut(out);

        String []name={"Zalo", "Trotuman", "Peter Parker", "xd", "Tazon de cereales", "Tardes Buenas", "Siete Developer", "Bycicle", "Kuku", "Calcetin Sucio", "DAM no mola", ":)","Bernat te echare de menos", "Bicho Studios","Piensalo","Goyo no responde al Teams"};
        String []url={"looting", "quest", "climb", "touch", "broccoli", "meet", "carriage", "convert", "balance", "shift", "aware", "restaurant", "moving", "area", "gesture", " node"};
        for (int i = 0; i < 1000; i++) {
            System.out.println(","+name[generarAleatorio(0,name.length-1)]+" "+url[generarAleatorio(0, url.length-1)]);
        }
    }
    public static int generarAleatorio(int empiezo, int acabo){
        return (int)Math.floor(empiezo+Math.random()*(acabo-empiezo+1));
    }
}