import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.RuleNode;
import org.antlr.v4.runtime.tree.TerminalNode;

public class LangVisitorImpl implements LangVisitor<Void> {

    private int indent = 0;

    private void printIndented(String str) {
        for (int i = 0; i < indent; ++i) {
            System.out.print(" ");
        }
        System.out.println(str);
    }

    @Override
    public Void visitProgram(LangParser.ProgramContext ctx) {
        printIndented("PROGRAM");
        indent += 2;
        ctx.blockExpr().accept(this);
        indent -= 2;
        return null;
    }

    @Override
    public Void visitBlockExpr(LangParser.BlockExprContext ctx) {
        printIndented("BLOCKEXPR");
        indent += 2;
        for (LangParser.ExprContext child : ctx.expr()) {
            child.accept(this);
        }
        indent -= 2;
        return null;
    }

    @Override
    public Void visitExpr(LangParser.ExprContext ctx) {
        printIndented("EXPR");
        indent += 2;
        if (ctx.op != null) {
            printIndented(ctx.op.getText());
            indent += 2;
            ctx.expr(0).accept(this);
            ctx.expr(1).accept(this);
            indent -= 2;
        } else {
            for (ParseTree child : ctx.children) {
                child.accept(this);
            }
        }
        indent -= 2;
        return null;
    }

    @Override
    public Void visitNonBinExpr(LangParser.NonBinExprContext ctx) {
        printIndented("NONBINEXPR");
        indent += 2;
        if (ctx.basicExpr() != null) {
            if (ctx.NOT() != null) {
                printIndented("NOT");
                indent += 2;
            }
            ctx.basicExpr().accept(this);
            if (ctx.NOT() != null) {
                indent -= 2;
            }
        } else {
            for (ParseTree child : ctx.children) {
                child.accept(this);
            }
        }
        indent -= 2;
        return null;
    }

    @Override
    public Void visitReadExpr(LangParser.ReadExprContext ctx) {
        printIndented("READ");
        indent += 2;
        printIndented(ctx.IDENT().getText());
        indent -= 2;
        return null;
    }

    @Override
    public Void visitWriteExpr(LangParser.WriteExprContext ctx) {
        printIndented("WRITE");
        indent += 2;
        ctx.expr().accept(this);
        indent -= 2;
        return null;
    }

    @Override
    public Void visitBasicExpr(LangParser.BasicExprContext ctx) {
        printIndented("BASICEXPR");
        indent += 2;
        for (ParseTree child : ctx.children) {
            child.accept(this);
        }
        indent -= 2;
        return null;
    }

    @Override
    public Void visitAssignExpr(LangParser.AssignExprContext ctx) {
        printIndented("ASSIGNEXPR");
        indent += 2;
        printIndented(ctx.IDENT().getText());
        ctx.blockExpr().accept(this);
        indent -= 2;
        return null;
    }

    @Override
    public Void visitIfExpr(LangParser.IfExprContext ctx) {
        printIndented("IFEXPR");
        indent += 2;
        printIndented("CONDITION");
        indent += 2;
        ctx.expr().accept(this);
        indent -= 2;
        printIndented("TRUEBRANCH");
        indent += 2;
        ctx.blockExpr(0).accept(this);
        indent -= 2;
        if (ctx.blockExpr().size() > 1) {
            printIndented("FALSEBRANCH");
            indent += 2;
            ctx.blockExpr(1).accept(this);
            indent -= 2;
        }
        indent -= 2;
        return null;
    }

    @Override
    public Void visit(ParseTree tree) {
        return null;
    }

    @Override
    public Void visitChildren(RuleNode node) {
        return null;
    }

    @Override
    public Void visitTerminal(TerminalNode node) {
        printIndented(node.getText());
        return null;
    }

    @Override
    public Void visitErrorNode(ErrorNode node) {
        return null;
    }
}
