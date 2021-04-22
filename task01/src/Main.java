import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import parser.*;

import java.io.IOException;
import java.nio.file.NoSuchFileException;

public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Source file required");
            return;
        }
        try {
            LLexer lexer = new LLexer(CharStreams.fromFileName(args[0]));
            LParser parser = new LParser(new CommonTokenStream(lexer));
            System.out.println(parser.program().toStringTree());
        } catch (NoSuchFileException e) {
            System.out.println("File not found: " + e.getFile());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
