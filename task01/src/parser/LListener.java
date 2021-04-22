// Generated from /home/max/Projects/fl-2021-itmo-spr/task01/src/L.g4 by ANTLR 4.9.1
package parser;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link LParser}.
 */
public interface LListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link LParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(LParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(LParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#sequence}.
	 * @param ctx the parse tree
	 */
	void enterSequence(LParser.SequenceContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#sequence}.
	 * @param ctx the parse tree
	 */
	void exitSequence(LParser.SequenceContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(LParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(LParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#ignore}.
	 * @param ctx the parse tree
	 */
	void enterIgnore(LParser.IgnoreContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#ignore}.
	 * @param ctx the parse tree
	 */
	void exitIgnore(LParser.IgnoreContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#if_statement}.
	 * @param ctx the parse tree
	 */
	void enterIf_statement(LParser.If_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#if_statement}.
	 * @param ctx the parse tree
	 */
	void exitIf_statement(LParser.If_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#while_statement}.
	 * @param ctx the parse tree
	 */
	void enterWhile_statement(LParser.While_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#while_statement}.
	 * @param ctx the parse tree
	 */
	void exitWhile_statement(LParser.While_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#read}.
	 * @param ctx the parse tree
	 */
	void enterRead(LParser.ReadContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#read}.
	 * @param ctx the parse tree
	 */
	void exitRead(LParser.ReadContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#write}.
	 * @param ctx the parse tree
	 */
	void enterWrite(LParser.WriteContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#write}.
	 * @param ctx the parse tree
	 */
	void exitWrite(LParser.WriteContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#assign}.
	 * @param ctx the parse tree
	 */
	void enterAssign(LParser.AssignContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#assign}.
	 * @param ctx the parse tree
	 */
	void exitAssign(LParser.AssignContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#decl}.
	 * @param ctx the parse tree
	 */
	void enterDecl(LParser.DeclContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#decl}.
	 * @param ctx the parse tree
	 */
	void exitDecl(LParser.DeclContext ctx);
	/**
	 * Enter a parse tree produced by {@link LParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(LParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link LParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(LParser.ExprContext ctx);
}