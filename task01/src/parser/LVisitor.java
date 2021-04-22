// Generated from /home/max/Projects/fl-2021-itmo-spr/task01/src/L.g4 by ANTLR 4.9.1
package parser;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link LParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface LVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link LParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(LParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#sequence}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSequence(LParser.SequenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStatement(LParser.StatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#ignore}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIgnore(LParser.IgnoreContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#if_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIf_statement(LParser.If_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#while_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhile_statement(LParser.While_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#read}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRead(LParser.ReadContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#write}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWrite(LParser.WriteContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#assign}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssign(LParser.AssignContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#decl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDecl(LParser.DeclContext ctx);
	/**
	 * Visit a parse tree produced by {@link LParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpr(LParser.ExprContext ctx);
}