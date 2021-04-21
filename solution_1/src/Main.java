import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import parser.ExprLexer;
import parser.ExprParser;

import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {
        ExprLexer lexer = new ExprLexer ( CharStreams.fromString ("if (10 + (10 ^ 10) + (a && 10)) {} else {}"));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tokens.fill();
        System.out.println(tokens.getTokens().stream().map(Token::getText).collect(Collectors.joining(" /\\ ")));
        ExprParser parser = new ExprParser(tokens);
        ParseTree tree = parser.language();
        System.out.println(tree.toStringTree(parser));

    }
}
