import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.lang.reflect.Array;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

public class App {
    public static void main(String[] args) throws FileNotFoundException{

        //Pasa todo lo que se imprime por consola a un .csv. Lo usamos para crear .csv

        //Para poder usarlo descomenta el metodo de la tabla que quieras crear y ejecuta el programa. Ejecuta los metodos de uno en uno si quieras varios csvs

        PrintStream out = new PrintStream(new FileOutputStream("output.csv"));
        System.setOut(out);
        //Script para generar los datos de la tabla JuegosDesarrolladores


        //Script para generar los datos de la tabla GruposUsuarios

        //tablaGruposUsuarios(1000, 10000, LocalDate.of(2003, 9, 1), LocalDate.of(2023, 3, 20), 40, 200);

        //Script para generar los datos de la tabla Amigos
        
        //tablaAmigos(1000,3,100, LocalDate.of(2003, 9, 1), LocalDate.of(2023, 3, 20) );

        //Script para generar los datos de la tabla Grupos

        //tablaGrupos(1000);

        //Script para generar los datos de la tabla ComentariosPerfil

        //tablaComentariosPerfil(LocalDate.of(2003, 9, 1), LocalDate.of(2023, 3, 20), 1000, 10);

        //Script para generar los datos de la tabla Mensajes
        
        //tablaMensajes(LocalDate.of(2003, 9, 1), LocalDate.of(2023, 3, 20), 10000, 20);

        //Script para la creación de la tabla Reseñas

        //tablaResenas(100, 10000, 5, 20);

        //Script para la creación de la tabla JuegosGenerados

        //tablaJuegosGeneros(100, 21, 2, 5);

        //Script para la creación de la tabla JuegosDesarrolladores

        tablaJuegosDesarrolladores(13600, 1000, 1, 4);

        //Script para la creación de la tabla PedidosJuegos
        //Falta rellenar el campo PrecioHistorico

        //tablaPedidosJuegos(50000, 100, 1, 7);

        //Script para la creación de la tabla Pedidos

        //tablaPedidos(100000, 10000, 0.7, LocalDate.of(2003, 9, 1), LocalDate.of(2023, 3, 20));

        

    }

    private static void tablaPedidos(int pedidos, int usuarios, double probabilidadcomprapropia, LocalDate inicio,
            LocalDate fin) {
        String [] mensajes={"If you are a beautiful strong black woman someone will put this in your comments", "Vete a recoger patatas",
        "GG", "Camper tunneler -rep", "Que perfil mas chulo", "Agregame para jugar juntos :)", "Hola te acuerdas de mi? besis <oo>", "Gracias por el carreo",
        "No jugueis con el le faltan manos", "No me puedo creer que tengas tan pocas horas", "Muy cringe tu foto de perfil", "+rep divertido jugar con el :D",
        "No me carga tu descripcion :(", "Como es posible que tengas tantas horas O:", "Si no soportas la presión no jueges! Fastidias la experiencia de los demás",
        "Echemonos algunas partidas al CSGO", "Me intercambias cromos?", "Algun dia me tienes que enseñar a jugar al Stardew valley", "No te rindas tienes potencial"};

        for (int i=0; i<pedidos; i++){

            int usuariorandom=(int) (1+Math.random()*usuarios);
            double probabilidadcompra=Math.random();
            System.out.print(",");
            System.out.print(usuariorandom);
            System.out.print(",");
            System.out.print((probabilidadcompra<=probabilidadcomprapropia)?usuariorandom:(int) (1+Math.random()*usuarios));
            System.out.print(",");
            System.out.print(inicio.plusDays((int) (Math.random()*ChronoUnit.DAYS.between(inicio, fin))));
            System.out.print(",");
            System.out.println((probabilidadcompra<=probabilidadcomprapropia)?"Nan":mensajes[(int) (Math.random()*mensajes.length)]);

        }
    }

    private static void tablaPedidosJuegos(int numeropedidos, int numerojuegos, int juegosminimos, int juegosmaximos) {
        ArrayList <Integer> juegos= new ArrayList<Integer>();

        for (int i=1; i<=numeropedidos; i++){

            for (int j=1; j<numerojuegos; j++){

                juegos.add(j);

            }

            int random=(int) (juegosminimos+Math.random()*(juegosmaximos-juegosminimos+1));
            for (int j=0; j<random; j++){

                System.out.print(",");
                System.out.print(i);
                System.out.print(",");
                System.out.print(juegos.remove((int) (Math.random()*juegos.size())));
                System.out.print(",");
                //Falta poner el precio historico
                System.out.println();

            }

            juegos.clear();

        }
    }

    private static void tablaJuegosDesarrolladores(int numerojuegos, int numerodesarrolladores, int minimodesarrollador,
            int maximodesarrollador) {
        ArrayList <Integer> devs = new ArrayList<Integer>();
        for (int i=1; i<=numerojuegos; i++){

            for (int j=1; j<=numerodesarrolladores; j++){

                devs.add(j);

            }

            int random=(int) (minimodesarrollador+Math.random()*(maximodesarrollador-minimodesarrollador+1));
            for (int j=0; j<random; j++){

                System.out.print(i);
                System.out.print(",");
                System.out.println(devs.remove((int) (Math.random()*devs.size())));

            }

            devs.clear();

            
        }
    }

    private static void tablaJuegosGeneros(int numerojuegos, int numerogeneros, int numerominimogeneros, int numeromaximogeneros) {
        ArrayList <Integer> generos= new ArrayList<Integer>();
        int numerorandom;
        for (int j=1; j<=numerojuegos; j++){

            for (int i=1; i<=numerogeneros; i++){

                generos.add(i);
    
            }

            numerorandom=(int) (numerominimogeneros+Math.random()*(numeromaximogeneros-numerominimogeneros+1));
            for (int i=0; i<numerorandom; i++){

                System.out.print(j);
                System.out.println(",");
                System.out.println(generos.remove((int) (Math.random()*generos.size())));

            }

            generos.clear();

        }
    }

    private static void tablaResenas(int numerojuegos, int numerousuarios, int reseñasminimas, int reseñasmaximas) {
        String [] contenidopositivo= {"Me gusta mucho", "Es muy interesante", "Creo que le echaré bastante horas", "Concepto entrentenido"};
        String [] contenidonegativo= {"Es aburrido", "Me estoy planteando devolverlo", "Su gameplay es demasiado complejo", "La idea es buena pero esta muy mal ejecutado"};
        ArrayList <Integer> usuarios= new ArrayList<Integer>();
        for (int i=1; i<=numerojuegos; i++){

            
            for (int j=1; j<=numerousuarios; j++){

                usuarios.add(j);
    
            }

            int numerorandom=(int) (reseñasminimas+Math.random()*(reseñasmaximas-reseñasminimas+1));
            for (int j=1; j<numerorandom; j++){

                int opinion=(int) (Math.random()*2);
                System.out.print(usuarios.remove((int) (Math.random()*usuarios.size())));
                System.out.print(",");
                System.out.print(i);
                System.out.print(",");
                System.out.print((opinion==0)?true:false);
                System.out.print(",");
                System.out.println((opinion==0)?contenidopositivo[(int) (Math.random()*contenidopositivo.length)]:contenidonegativo[(int) (Math.random()*contenidonegativo.length)]);

            }

            usuarios.clear();

        }
    }

    private static void tablaMensajes(LocalDate inicio, LocalDate fin, int numerousuarios, int numeromensajesporusuario) {

        String [] posiblesmensajes= {"If you are a beautiful strong black woman someone will put this in your comments", "Vete a recoger patatas",
        "GG", "Camper tunneler -rep", "Que perfil mas chulo", "Agregame para jugar juntos :)", "Hola te acuerdas de mi? besis <oo>", "Gracias por el carreo",
        "No jugueis con el le faltan manos", "No me puedo creer que tengas tan pocas horas", "Muy cringe tu foto de perfil", "+rep divertido jugar con el :D",
        "No me carga tu descripcion :(", "Como es posible que tengas tantas horas O:", "Si no soportas la presión no jueges! Fastidias la experiencia de los demás",
        "Echemonos algunas partidas al CSGO", "Me intercambias cromos?", "Algun dia me tienes que enseñar a jugar al Stardew valley", "No te rindas tienes potencial"};

        for (int i=0; i<numerousuarios*numeromensajesporusuario; i++){

            System.out.print(",");
            System.out.print((int) (1+Math.random()*numerousuarios));
            System.out.print(",");
            System.out.print((int) (1+Math.random()*numerousuarios));
            System.out.print(",");
            System.out.print(inicio.plusDays((int) (Math.random()*ChronoUnit.DAYS.between(inicio, fin))));
            System.out.print(",");
            System.out.println(posiblesmensajes[(int) (Math.random()*posiblesmensajes.length)]);


        }
    }

    private static void tablaComentariosPerfil(LocalDate inicio, LocalDate fin, int numerousuarios, int numeromensajesporusuario) {

        String [] posiblesmensajes= {"If you are a beautiful strong black woman someone will put this in your comments", "Vete a recoger patatas",
        "GG", "Camper tunneler -rep", "Que perfil mas chulo", "Agregame para jugar juntos :)", "Hola te acuerdas de mi? besis <oo>", "Gracias por el carreo",
        "No jugueis con el le faltan manos", "No me puedo creer que tengas tan pocas horas", "Muy cringe tu foto de perfil", "+rep divertido jugar con el :D",
        "No me carga tu descripcion :(", "Como es posible que tengas tantas horas O:", "Si no soportas la presión no jueges! Fastidias la experiencia de los demás",
        "Echemonos algunas partidas al CSGO", "Me intercambias cromos?", "Algun dia me tienes que enseñar a jugar al Stardew valley", "No te rindas tienes potencial"};

        for (int i=0; i<numerousuarios*numeromensajesporusuario; i++){

            System.out.print(",");
            System.out.print((int) (1+Math.random()*numerousuarios));
            System.out.print(",");
            System.out.print((int) (1+Math.random()*numerousuarios));
            System.out.print(",");
            System.out.print(posiblesmensajes[(int) (Math.random()*posiblesmensajes.length)]);
            System.out.print(",");
            System.out.println(inicio.plusDays((int) (Math.random()*ChronoUnit.DAYS.between(inicio, fin))));


        }
    }

    private static void tablaGrupos(int numerogrupos) {
        String [] nombres={"Hentai", "Universe", "Gaming", "Terminal", "Roleplay", "Server", "WhiteHouse", "Knight", "Ohio", "Ninja",
        "Based", "Shitpost", "complication", "jump", "area", "affair", "counter", "offensive", "touch", "requirement", "drift", "bake", "symbol", "van",
        "contrast", "cinema", "manager", "velvet", "service", "route", "satellite", "orientation", "theory", "hay", "dairy", "mass", "brand", "penalty",
        "extend", "ghost", "basic", "storage", "protection", "relieve", "hunting", "error", "worry", "tract", "attraction", "question", "emotion", "center",
        "embryo", "talkative", "overwhelm", "play", "tile", "outside", "conflict", "plastic", "shelf", "concept","Turtle", "Fanart", "GTA", "Clown", "Magic",
        "Zombies", "Strong", "Faction", "Sweat", "Park", "Prison", "Sock", "spell", "pleasure", "result", "designer", "unpleasant", "catalogue", "horoscope",
        "excavation", "straight", "beer", "lump", "efflux", "hip", "policy", "fleet", "war", "injury", "protest", "due", "misery", "context", "captivate",
        "multiply", "plaster", "conference", "direct", "variety", "extort", "temptation", "harvest", "rainbow", "twilight", "disco", "advance", "linger", "fat",
        "nuclear", "shallow", "force", "jaw", "chaos", "fish", "memory", "mole", "random", "valid", "headline", "objective", "develop", "pen"};

        for (int i=0; i<numerogrupos; i++){

            System.out.print(",");
            System.out.println(nombres[(int) (Math.random()*nombres.length)]+" "+nombres[(int) (Math.random()*nombres.length)]);

        }
    }

    private static void tablaAmigos(int numerousuarios, int amigosminimos, int amigosmaximos, LocalDate inicio, LocalDate fin) {

        ArrayList <ArrayList<Boolean>> usuarios= new ArrayList<ArrayList<Boolean>>();

        for (int i=0; i<numerousuarios; i++){

            usuarios.add(new ArrayList<Boolean>());

            //Cada usuario tendrá entre 3 y 100 amigos
            int random=(int) (amigosminimos+Math.random()*(amigosmaximos-amigosminimos+1));

            for (int j=0; j<random; j++){

                usuarios.get(i).add(true);
                
            }

        }

        int numerorandom;

        for (int i=1; i<=numerousuarios; i++){
        	
            int amigos=usuarios.get(i-1).size();
            ArrayList<Integer> yaamigados=new ArrayList<Integer>();
            for(int j=0; j<amigos; j++){

                System.out.print(i);
                usuarios.get(i-1).remove(0);
                int contador=0;
                do{

                    numerorandom=(int) (i+Math.random()*(numerousuarios-i+1));
                    contador++;
                    if (contador>100000){

                        break;

                    }

                }while (usuarios.get(numerorandom-1).size()==0 || numerorandom==i || yaamigados.contains(numerorandom));
                if (contador>100000){
                    
                    continue;

                }
                System.out.print(",");
                System.out.print(numerorandom);
                usuarios.get(numerorandom-1).remove(0);
                yaamigados.add(numerorandom);
                System.out.print(",");
                System.out.println(inicio.plusDays((int) (Math.random()*ChronoUnit.DAYS.between(inicio, fin))));

            }
            
        }
    }

    private static void tablaGruposUsuarios(int numerogrupos, int numerousuarios, LocalDate inicio, LocalDate fin, int numerominimogrupos, int numeromaximogrupos) {
        ArrayList <Integer> usuarios= new ArrayList<Integer>();

        for (int i=1; i<=numerogrupos; i++){

            //Cada grupo tendra entre 40 y 200 usuarios unidos
            int numerorandom = (int) (numerominimogrupos+Math.random()*(numeromaximogrupos-numerominimogrupos+1));
            for (int j=1; j<=numerousuarios; j++){

                usuarios.add(j);
    
            }
            for (int j=0; j<numerorandom; j++){

                System.out.print(i);
                System.out.print(",");
                System.out.print(usuarios.remove((int) (Math.random()*usuarios.size())));
                System.out.print(",");
                System.out.println(inicio.plusDays((int) (Math.random()*ChronoUnit.DAYS.between(inicio, fin))));

            }
            
            usuarios.clear();

        }
    }
}
