package parser;

import gen.SuperLanguageLexer;
import gen.SuperLanguageParser;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class Main {
    interface ParseTreeElement {
        String multiLineString(String ident);
    }

    static class ParseTreeLeaf implements ParseTreeElement {
        private final String text;

        public ParseTreeLeaf(String text) {
            this.text = text;
        }

        @Override
        public String toString() {
            return "T" + "[" + text + "]";
        }

        @Override
        public String multiLineString(String ident) {
            return ident + this + "\n";
        }
    }

    static class ParseTreeNode implements ParseTreeElement {
        private final String name;
        private final List<ParseTreeElement> children = new LinkedList<>();

        public ParseTreeNode(String name) {
            this.name = name;
        }

        public void addChild(ParseTreeElement child) {
            this.children.add(child);
        }

        @Override
        public String toString() {
            return "Node(" + name + ") " + children;
        }

        @Override
        public String multiLineString(String ident) {
            var sb = new StringBuilder();
            sb.append(ident).append(name).append("\n");
            children.forEach(c -> sb.append(c.multiLineString(ident + "  ")));
            return sb.toString();
        }
    }

    private static ParseTreeNode toParseTree(ParserRuleContext ctx) {
        var res = new ParseTreeNode(removeSuffix(ctx.getClass().getSimpleName(), 7));
        ctx.children.forEach(c -> {
            if (c instanceof ParserRuleContext) {
                res.addChild(toParseTree((ParserRuleContext) c));
            }
            if (c instanceof TerminalNode) {
                res.addChild(new ParseTreeLeaf(c.getText()));
            }
        });
        return res;
    }

    private static String removeSuffix(String s, int c) {
        return s.substring(0, s.length() - c);
    }

    private static Lexer getLexerForInputFrom(File file) throws IOException {
        return new SuperLanguageLexer(new ANTLRInputStream(new FileReader(file)));
    }

    private static SuperLanguageParser getParserForInputFrom(File file) throws IOException {
        var lexer = getLexerForInputFrom(file);
        return new SuperLanguageParser(new CommonTokenStream(lexer));
    }

    private static File getFileFrom(String fileName) {
        return new File(fileName);
    }

    public static void main(String[] args) {
        var scanner = new Scanner(System.in);
        while (!scanner.hasNext())
            System.out.println("Enter a filename:");
        try {
            var fileName = scanner.nextLine();
            SuperLanguageParser parser = getParserForInputFrom(getFileFrom(fileName));
            SuperLanguageParser.ProgramContext programContext = parser.program();
            System.out.println("AST:\n");
            System.out.println(toParseTree(programContext).multiLineString(" "));
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
}
