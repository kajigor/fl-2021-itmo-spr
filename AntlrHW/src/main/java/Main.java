import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        String inputFile = args[0];
        try {
            CharStream stream = CharStreams.fromFileName(inputFile);
            LangLexer lexer = new LangLexer(stream);
            LangParser parser = new LangParser(new CommonTokenStream(lexer));
            LangParser.ProgramContext ctx = parser.program();
            ctx.accept(new LangVisitorImpl());

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
