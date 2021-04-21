// Generated from Lang.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link LangParser}.
 */
public interface LangListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link LangParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(LangParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(LangParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#blockExpr}.
	 * @param ctx the parse tree
	 */
	void enterBlockExpr(LangParser.BlockExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#blockExpr}.
	 * @param ctx the parse tree
	 */
	void exitBlockExpr(LangParser.BlockExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(LangParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(LangParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#nonBinExpr}.
	 * @param ctx the parse tree
	 */
	void enterNonBinExpr(LangParser.NonBinExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#nonBinExpr}.
	 * @param ctx the parse tree
	 */
	void exitNonBinExpr(LangParser.NonBinExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#readExpr}.
	 * @param ctx the parse tree
	 */
	void enterReadExpr(LangParser.ReadExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#readExpr}.
	 * @param ctx the parse tree
	 */
	void exitReadExpr(LangParser.ReadExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#writeExpr}.
	 * @param ctx the parse tree
	 */
	void enterWriteExpr(LangParser.WriteExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#writeExpr}.
	 * @param ctx the parse tree
	 */
	void exitWriteExpr(LangParser.WriteExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#basicExpr}.
	 * @param ctx the parse tree
	 */
	void enterBasicExpr(LangParser.BasicExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#basicExpr}.
	 * @param ctx the parse tree
	 */
	void exitBasicExpr(LangParser.BasicExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#assignExpr}.
	 * @param ctx the parse tree
	 */
	void enterAssignExpr(LangParser.AssignExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#assignExpr}.
	 * @param ctx the parse tree
	 */
	void exitAssignExpr(LangParser.AssignExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link LangParser#ifExpr}.
	 * @param ctx the parse tree
	 */
	void enterIfExpr(LangParser.IfExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LangParser#ifExpr}.
	 * @param ctx the parse tree
	 */
	void exitIfExpr(LangParser.IfExprContext ctx);
}