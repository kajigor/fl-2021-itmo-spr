// Generated from /Users/klochkovanton/Desktop/Study/JB/Sem2/forml/fl-2021-itmo-spr/02/antlrExample/src/Expr.g4 by ANTLR 4.9.1
package parser;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link ExprParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface ExprVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link ExprParser#language}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLanguage(ExprParser.LanguageContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#sequence}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSequence(ExprParser.SequenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStatement(ExprParser.StatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#compound_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCompound_statement(ExprParser.Compound_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#n_if}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitN_if(ExprParser.N_ifContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#n_while}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitN_while(ExprParser.N_whileContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#n_assign}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitN_assign(ExprParser.N_assignContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#n_read}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitN_read(ExprParser.N_readContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#n_write}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitN_write(ExprParser.N_writeContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(ExprParser.ExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#condition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCondition(ExprParser.ConditionContext ctx);
	/**
	 * Visit a parse tree produced by {@link ExprParser#binary_operation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinary_operation(ExprParser.Binary_operationContext ctx);
}