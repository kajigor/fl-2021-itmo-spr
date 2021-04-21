import org.antlr.v4.runtime.*;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        if (args.length != 1)
            throw new IllegalArgumentException("A single filename is required");

        GrammarLexer lexer = new GrammarLexer(CharStreams.fromFileName(args[0]));
        GrammarParser parser = new GrammarParser(new CommonTokenStream(lexer));
        System.out.println(parser.program().toStringTree());
    }
}
