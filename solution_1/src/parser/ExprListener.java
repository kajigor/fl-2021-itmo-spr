// Generated from /Users/klochkovanton/Desktop/Study/JB/Sem2/forml/fl-2021-itmo-spr/02/antlrExample/src/Expr.g4 by ANTLR 4.9.1
package parser;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ExprParser}.
 */
public interface ExprListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ExprParser#language}.
	 * @param ctx the parse tree
	 */
	void enterLanguage(ExprParser.LanguageContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#language}.
	 * @param ctx the parse tree
	 */
	void exitLanguage(ExprParser.LanguageContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#sequence}.
	 * @param ctx the parse tree
	 */
	void enterSequence(ExprParser.SequenceContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#sequence}.
	 * @param ctx the parse tree
	 */
	void exitSequence(ExprParser.SequenceContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(ExprParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(ExprParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#compound_statement}.
	 * @param ctx the parse tree
	 */
	void enterCompound_statement(ExprParser.Compound_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#compound_statement}.
	 * @param ctx the parse tree
	 */
	void exitCompound_statement(ExprParser.Compound_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#n_if}.
	 * @param ctx the parse tree
	 */
	void enterN_if(ExprParser.N_ifContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#n_if}.
	 * @param ctx the parse tree
	 */
	void exitN_if(ExprParser.N_ifContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#n_while}.
	 * @param ctx the parse tree
	 */
	void enterN_while(ExprParser.N_whileContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#n_while}.
	 * @param ctx the parse tree
	 */
	void exitN_while(ExprParser.N_whileContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#n_assign}.
	 * @param ctx the parse tree
	 */
	void enterN_assign(ExprParser.N_assignContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#n_assign}.
	 * @param ctx the parse tree
	 */
	void exitN_assign(ExprParser.N_assignContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#n_read}.
	 * @param ctx the parse tree
	 */
	void enterN_read(ExprParser.N_readContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#n_read}.
	 * @param ctx the parse tree
	 */
	void exitN_read(ExprParser.N_readContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#n_write}.
	 * @param ctx the parse tree
	 */
	void enterN_write(ExprParser.N_writeContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#n_write}.
	 * @param ctx the parse tree
	 */
	void exitN_write(ExprParser.N_writeContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(ExprParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(ExprParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#condition}.
	 * @param ctx the parse tree
	 */
	void enterCondition(ExprParser.ConditionContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#condition}.
	 * @param ctx the parse tree
	 */
	void exitCondition(ExprParser.ConditionContext ctx);
	/**
	 * Enter a parse tree produced by {@link ExprParser#binary_operation}.
	 * @param ctx the parse tree
	 */
	void enterBinary_operation(ExprParser.Binary_operationContext ctx);
	/**
	 * Exit a parse tree produced by {@link ExprParser#binary_operation}.
	 * @param ctx the parse tree
	 */
	void exitBinary_operation(ExprParser.Binary_operationContext ctx);
}