// Generated from Lang.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link LangParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface LangVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link LangParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(LangParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#blockExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlockExpr(LangParser.BlockExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(LangParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#nonBinExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNonBinExpr(LangParser.NonBinExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#readExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReadExpr(LangParser.ReadExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#writeExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWriteExpr(LangParser.WriteExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#basicExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBasicExpr(LangParser.BasicExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#assignExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignExpr(LangParser.AssignExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link LangParser#ifExpr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIfExpr(LangParser.IfExprContext ctx);
}