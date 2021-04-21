// Generated from /Users/klochkovanton/Desktop/Study/JB/Sem2/forml/fl-2021-itmo-spr/02/antlrExample/src/Expr.g4 by ANTLR 4.9.1
package parser;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class ExprParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		IDENT=25, NUM=26, NAT=27, SPACES=28, WS=29;
	public static final int
		RULE_language = 0, RULE_sequence = 1, RULE_statement = 2, RULE_compound_statement = 3, 
		RULE_n_if = 4, RULE_n_while = 5, RULE_n_assign = 6, RULE_n_read = 7, RULE_n_write = 8, 
		RULE_expr = 9, RULE_condition = 10, RULE_binary_operation = 11;
	private static String[] makeRuleNames() {
		return new String[] {
			"language", "sequence", "statement", "compound_statement", "n_if", "n_while", 
			"n_assign", "n_read", "n_write", "expr", "condition", "binary_operation"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'{'", "'}'", "'if'", "'else'", "'loop'", "':='", "';'", "'in'", 
			"'out'", "'('", "')'", "'^'", "'*'", "'/'", "'+'", "'-'", "'<'", "'>'", 
			"'=='", "'!='", "'<='", "'>='", "'&&'", "'||'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, "IDENT", "NUM", "NAT", "SPACES", "WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Expr.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public ExprParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class LanguageContext extends ParserRuleContext {
		public SequenceContext sequence() {
			return getRuleContext(SequenceContext.class,0);
		}
		public TerminalNode EOF() { return getToken(ExprParser.EOF, 0); }
		public LanguageContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_language; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterLanguage(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitLanguage(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitLanguage(this);
			else return visitor.visitChildren(this);
		}
	}

	public final LanguageContext language() throws RecognitionException {
		LanguageContext _localctx = new LanguageContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_language);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(24);
			sequence();
			setState(25);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SequenceContext extends ParserRuleContext {
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public SequenceContext sequence() {
			return getRuleContext(SequenceContext.class,0);
		}
		public List<TerminalNode> WS() { return getTokens(ExprParser.WS); }
		public TerminalNode WS(int i) {
			return getToken(ExprParser.WS, i);
		}
		public SequenceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sequence; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterSequence(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitSequence(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitSequence(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SequenceContext sequence() throws RecognitionException {
		SequenceContext _localctx = new SequenceContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_sequence);
		int _la;
		try {
			setState(37);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(27);
				statement();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(28);
				statement();
				setState(32);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==WS) {
					{
					{
					setState(29);
					match(WS);
					}
					}
					setState(34);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(35);
				sequence();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementContext extends ParserRuleContext {
		public N_ifContext n_if() {
			return getRuleContext(N_ifContext.class,0);
		}
		public N_whileContext n_while() {
			return getRuleContext(N_whileContext.class,0);
		}
		public N_readContext n_read() {
			return getRuleContext(N_readContext.class,0);
		}
		public N_writeContext n_write() {
			return getRuleContext(N_writeContext.class,0);
		}
		public N_assignContext n_assign() {
			return getRuleContext(N_assignContext.class,0);
		}
		public StatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterStatement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitStatement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitStatement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StatementContext statement() throws RecognitionException {
		StatementContext _localctx = new StatementContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_statement);
		try {
			setState(44);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__2:
				enterOuterAlt(_localctx, 1);
				{
				setState(39);
				n_if();
				}
				break;
			case T__4:
				enterOuterAlt(_localctx, 2);
				{
				setState(40);
				n_while();
				}
				break;
			case T__7:
				enterOuterAlt(_localctx, 3);
				{
				setState(41);
				n_read();
				}
				break;
			case T__8:
				enterOuterAlt(_localctx, 4);
				{
				setState(42);
				n_write();
				}
				break;
			case IDENT:
				enterOuterAlt(_localctx, 5);
				{
				setState(43);
				n_assign();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Compound_statementContext extends ParserRuleContext {
		public SequenceContext sequence() {
			return getRuleContext(SequenceContext.class,0);
		}
		public List<TerminalNode> WS() { return getTokens(ExprParser.WS); }
		public TerminalNode WS(int i) {
			return getToken(ExprParser.WS, i);
		}
		public Compound_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_compound_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterCompound_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitCompound_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitCompound_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Compound_statementContext compound_statement() throws RecognitionException {
		Compound_statementContext _localctx = new Compound_statementContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_compound_statement);
		int _la;
		try {
			setState(70);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,6,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(46);
				match(T__0);
				setState(50);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==WS) {
					{
					{
					setState(47);
					match(WS);
					}
					}
					setState(52);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(53);
				sequence();
				setState(57);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==WS) {
					{
					{
					setState(54);
					match(WS);
					}
					}
					setState(59);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(60);
				match(T__1);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(62);
				match(T__0);
				setState(66);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==WS) {
					{
					{
					setState(63);
					match(WS);
					}
					}
					setState(68);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(69);
				match(T__1);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class N_ifContext extends ParserRuleContext {
		public ConditionContext condition() {
			return getRuleContext(ConditionContext.class,0);
		}
		public List<Compound_statementContext> compound_statement() {
			return getRuleContexts(Compound_statementContext.class);
		}
		public Compound_statementContext compound_statement(int i) {
			return getRuleContext(Compound_statementContext.class,i);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public List<TerminalNode> WS() { return getTokens(ExprParser.WS); }
		public TerminalNode WS(int i) {
			return getToken(ExprParser.WS, i);
		}
		public N_ifContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_n_if; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterN_if(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitN_if(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitN_if(this);
			else return visitor.visitChildren(this);
		}
	}

	public final N_ifContext n_if() throws RecognitionException {
		N_ifContext _localctx = new N_ifContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_n_if);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(72);
			match(T__2);
			setState(76);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(73);
				match(SPACES);
				}
				}
				setState(78);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(79);
			condition();
			setState(83);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==WS) {
				{
				{
				setState(80);
				match(WS);
				}
				}
				setState(85);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(86);
			compound_statement();
			setState(90);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==WS) {
				{
				{
				setState(87);
				match(WS);
				}
				}
				setState(92);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(93);
			match(T__3);
			setState(97);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==WS) {
				{
				{
				setState(94);
				match(WS);
				}
				}
				setState(99);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(100);
			compound_statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class N_whileContext extends ParserRuleContext {
		public ConditionContext condition() {
			return getRuleContext(ConditionContext.class,0);
		}
		public Compound_statementContext compound_statement() {
			return getRuleContext(Compound_statementContext.class,0);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public List<TerminalNode> WS() { return getTokens(ExprParser.WS); }
		public TerminalNode WS(int i) {
			return getToken(ExprParser.WS, i);
		}
		public N_whileContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_n_while; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterN_while(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitN_while(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitN_while(this);
			else return visitor.visitChildren(this);
		}
	}

	public final N_whileContext n_while() throws RecognitionException {
		N_whileContext _localctx = new N_whileContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_n_while);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(102);
			match(T__4);
			setState(106);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(103);
				match(SPACES);
				}
				}
				setState(108);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(109);
			condition();
			setState(113);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==WS) {
				{
				{
				setState(110);
				match(WS);
				}
				}
				setState(115);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(116);
			compound_statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class N_assignContext extends ParserRuleContext {
		public TerminalNode IDENT() { return getToken(ExprParser.IDENT, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public N_assignContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_n_assign; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterN_assign(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitN_assign(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitN_assign(this);
			else return visitor.visitChildren(this);
		}
	}

	public final N_assignContext n_assign() throws RecognitionException {
		N_assignContext _localctx = new N_assignContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_n_assign);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(118);
			match(IDENT);
			setState(122);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(119);
				match(SPACES);
				}
				}
				setState(124);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(125);
			match(T__5);
			setState(129);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(126);
				match(SPACES);
				}
				}
				setState(131);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(132);
			expr();
			setState(136);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(133);
				match(SPACES);
				}
				}
				setState(138);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(139);
			match(T__6);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class N_readContext extends ParserRuleContext {
		public TerminalNode IDENT() { return getToken(ExprParser.IDENT, 0); }
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public N_readContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_n_read; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterN_read(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitN_read(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitN_read(this);
			else return visitor.visitChildren(this);
		}
	}

	public final N_readContext n_read() throws RecognitionException {
		N_readContext _localctx = new N_readContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_n_read);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(141);
			match(T__7);
			setState(145);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(142);
				match(SPACES);
				}
				}
				setState(147);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(148);
			match(IDENT);
			setState(152);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(149);
				match(SPACES);
				}
				}
				setState(154);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(155);
			match(T__6);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class N_writeContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public N_writeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_n_write; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterN_write(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitN_write(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitN_write(this);
			else return visitor.visitChildren(this);
		}
	}

	public final N_writeContext n_write() throws RecognitionException {
		N_writeContext _localctx = new N_writeContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_n_write);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(157);
			match(T__8);
			setState(161);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(158);
				match(SPACES);
				}
				}
				setState(163);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(164);
			expr();
			setState(168);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(165);
				match(SPACES);
				}
				}
				setState(170);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(171);
			match(T__6);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprContext extends ParserRuleContext {
		public TerminalNode IDENT() { return getToken(ExprParser.IDENT, 0); }
		public TerminalNode NUM() { return getToken(ExprParser.NUM, 0); }
		public Binary_operationContext binary_operation() {
			return getRuleContext(Binary_operationContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_expr);
		int _la;
		try {
			setState(192);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,22,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(173);
				match(IDENT);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(174);
				match(NUM);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(175);
				binary_operation(0);
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(176);
				match(T__9);
				setState(180);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==SPACES) {
					{
					{
					setState(177);
					match(SPACES);
					}
					}
					setState(182);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(183);
				expr();
				setState(187);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==SPACES) {
					{
					{
					setState(184);
					match(SPACES);
					}
					}
					setState(189);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(190);
				match(T__10);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ConditionContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public ConditionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_condition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterCondition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitCondition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitCondition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ConditionContext condition() throws RecognitionException {
		ConditionContext _localctx = new ConditionContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_condition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(194);
			match(T__9);
			setState(198);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(195);
				match(SPACES);
				}
				}
				setState(200);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(201);
			expr();
			setState(205);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SPACES) {
				{
				{
				setState(202);
				match(SPACES);
				}
				}
				setState(207);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(208);
			match(T__10);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Binary_operationContext extends ParserRuleContext {
		public Token op;
		public List<Binary_operationContext> binary_operation() {
			return getRuleContexts(Binary_operationContext.class);
		}
		public Binary_operationContext binary_operation(int i) {
			return getRuleContext(Binary_operationContext.class,i);
		}
		public List<TerminalNode> SPACES() { return getTokens(ExprParser.SPACES); }
		public TerminalNode SPACES(int i) {
			return getToken(ExprParser.SPACES, i);
		}
		public TerminalNode NUM() { return getToken(ExprParser.NUM, 0); }
		public TerminalNode IDENT() { return getToken(ExprParser.IDENT, 0); }
		public Binary_operationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_binary_operation; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).enterBinary_operation(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ExprListener ) ((ExprListener)listener).exitBinary_operation(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof ExprVisitor ) return ((ExprVisitor<? extends T>)visitor).visitBinary_operation(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Binary_operationContext binary_operation() throws RecognitionException {
		return binary_operation(0);
	}

	private Binary_operationContext binary_operation(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Binary_operationContext _localctx = new Binary_operationContext(_ctx, _parentState);
		Binary_operationContext _prevctx = _localctx;
		int _startState = 22;
		enterRecursionRule(_localctx, 22, RULE_binary_operation, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(229);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__9:
				{
				setState(211);
				match(T__9);
				setState(215);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==SPACES) {
					{
					{
					setState(212);
					match(SPACES);
					}
					}
					setState(217);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(218);
				binary_operation(0);
				setState(222);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==SPACES) {
					{
					{
					setState(219);
					match(SPACES);
					}
					}
					setState(224);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(225);
				match(T__10);
				}
				break;
			case NUM:
				{
				setState(227);
				match(NUM);
				}
				break;
			case IDENT:
				{
				setState(228);
				match(IDENT);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(251);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,29,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(249);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,28,_ctx) ) {
					case 1:
						{
						_localctx = new Binary_operationContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_binary_operation);
						setState(231);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(232);
						((Binary_operationContext)_localctx).op = match(T__11);
						setState(233);
						binary_operation(9);
						}
						break;
					case 2:
						{
						_localctx = new Binary_operationContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_binary_operation);
						setState(234);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(235);
						((Binary_operationContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==T__12 || _la==T__13) ) {
							((Binary_operationContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(236);
						binary_operation(9);
						}
						break;
					case 3:
						{
						_localctx = new Binary_operationContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_binary_operation);
						setState(237);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(238);
						((Binary_operationContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==T__14 || _la==T__15) ) {
							((Binary_operationContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(239);
						binary_operation(8);
						}
						break;
					case 4:
						{
						_localctx = new Binary_operationContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_binary_operation);
						setState(240);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(241);
						((Binary_operationContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__16) | (1L << T__17) | (1L << T__18) | (1L << T__19) | (1L << T__20) | (1L << T__21))) != 0)) ) {
							((Binary_operationContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(242);
						binary_operation(7);
						}
						break;
					case 5:
						{
						_localctx = new Binary_operationContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_binary_operation);
						setState(243);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(244);
						((Binary_operationContext)_localctx).op = match(T__22);
						setState(245);
						binary_operation(5);
						}
						break;
					case 6:
						{
						_localctx = new Binary_operationContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_binary_operation);
						setState(246);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(247);
						((Binary_operationContext)_localctx).op = match(T__23);
						setState(248);
						binary_operation(4);
						}
						break;
					}
					} 
				}
				setState(253);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,29,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 11:
			return binary_operation_sempred((Binary_operationContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean binary_operation_sempred(Binary_operationContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 9);
		case 1:
			return precpred(_ctx, 8);
		case 2:
			return precpred(_ctx, 7);
		case 3:
			return precpred(_ctx, 6);
		case 4:
			return precpred(_ctx, 5);
		case 5:
			return precpred(_ctx, 4);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\37\u0101\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\3\2\3\2\3\2\3\3\3\3\3\3\7\3!\n\3\f\3\16\3$\13\3"+
		"\3\3\3\3\5\3(\n\3\3\4\3\4\3\4\3\4\3\4\5\4/\n\4\3\5\3\5\7\5\63\n\5\f\5"+
		"\16\5\66\13\5\3\5\3\5\7\5:\n\5\f\5\16\5=\13\5\3\5\3\5\3\5\3\5\7\5C\n\5"+
		"\f\5\16\5F\13\5\3\5\5\5I\n\5\3\6\3\6\7\6M\n\6\f\6\16\6P\13\6\3\6\3\6\7"+
		"\6T\n\6\f\6\16\6W\13\6\3\6\3\6\7\6[\n\6\f\6\16\6^\13\6\3\6\3\6\7\6b\n"+
		"\6\f\6\16\6e\13\6\3\6\3\6\3\7\3\7\7\7k\n\7\f\7\16\7n\13\7\3\7\3\7\7\7"+
		"r\n\7\f\7\16\7u\13\7\3\7\3\7\3\b\3\b\7\b{\n\b\f\b\16\b~\13\b\3\b\3\b\7"+
		"\b\u0082\n\b\f\b\16\b\u0085\13\b\3\b\3\b\7\b\u0089\n\b\f\b\16\b\u008c"+
		"\13\b\3\b\3\b\3\t\3\t\7\t\u0092\n\t\f\t\16\t\u0095\13\t\3\t\3\t\7\t\u0099"+
		"\n\t\f\t\16\t\u009c\13\t\3\t\3\t\3\n\3\n\7\n\u00a2\n\n\f\n\16\n\u00a5"+
		"\13\n\3\n\3\n\7\n\u00a9\n\n\f\n\16\n\u00ac\13\n\3\n\3\n\3\13\3\13\3\13"+
		"\3\13\3\13\7\13\u00b5\n\13\f\13\16\13\u00b8\13\13\3\13\3\13\7\13\u00bc"+
		"\n\13\f\13\16\13\u00bf\13\13\3\13\3\13\5\13\u00c3\n\13\3\f\3\f\7\f\u00c7"+
		"\n\f\f\f\16\f\u00ca\13\f\3\f\3\f\7\f\u00ce\n\f\f\f\16\f\u00d1\13\f\3\f"+
		"\3\f\3\r\3\r\3\r\7\r\u00d8\n\r\f\r\16\r\u00db\13\r\3\r\3\r\7\r\u00df\n"+
		"\r\f\r\16\r\u00e2\13\r\3\r\3\r\3\r\3\r\5\r\u00e8\n\r\3\r\3\r\3\r\3\r\3"+
		"\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\7\r\u00fc\n\r\f"+
		"\r\16\r\u00ff\13\r\3\r\2\3\30\16\2\4\6\b\n\f\16\20\22\24\26\30\2\5\3\2"+
		"\17\20\3\2\21\22\3\2\23\30\2\u011c\2\32\3\2\2\2\4\'\3\2\2\2\6.\3\2\2\2"+
		"\bH\3\2\2\2\nJ\3\2\2\2\fh\3\2\2\2\16x\3\2\2\2\20\u008f\3\2\2\2\22\u009f"+
		"\3\2\2\2\24\u00c2\3\2\2\2\26\u00c4\3\2\2\2\30\u00e7\3\2\2\2\32\33\5\4"+
		"\3\2\33\34\7\2\2\3\34\3\3\2\2\2\35(\5\6\4\2\36\"\5\6\4\2\37!\7\37\2\2"+
		" \37\3\2\2\2!$\3\2\2\2\" \3\2\2\2\"#\3\2\2\2#%\3\2\2\2$\"\3\2\2\2%&\5"+
		"\4\3\2&(\3\2\2\2\'\35\3\2\2\2\'\36\3\2\2\2(\5\3\2\2\2)/\5\n\6\2*/\5\f"+
		"\7\2+/\5\20\t\2,/\5\22\n\2-/\5\16\b\2.)\3\2\2\2.*\3\2\2\2.+\3\2\2\2.,"+
		"\3\2\2\2.-\3\2\2\2/\7\3\2\2\2\60\64\7\3\2\2\61\63\7\37\2\2\62\61\3\2\2"+
		"\2\63\66\3\2\2\2\64\62\3\2\2\2\64\65\3\2\2\2\65\67\3\2\2\2\66\64\3\2\2"+
		"\2\67;\5\4\3\28:\7\37\2\298\3\2\2\2:=\3\2\2\2;9\3\2\2\2;<\3\2\2\2<>\3"+
		"\2\2\2=;\3\2\2\2>?\7\4\2\2?I\3\2\2\2@D\7\3\2\2AC\7\37\2\2BA\3\2\2\2CF"+
		"\3\2\2\2DB\3\2\2\2DE\3\2\2\2EG\3\2\2\2FD\3\2\2\2GI\7\4\2\2H\60\3\2\2\2"+
		"H@\3\2\2\2I\t\3\2\2\2JN\7\5\2\2KM\7\36\2\2LK\3\2\2\2MP\3\2\2\2NL\3\2\2"+
		"\2NO\3\2\2\2OQ\3\2\2\2PN\3\2\2\2QU\5\26\f\2RT\7\37\2\2SR\3\2\2\2TW\3\2"+
		"\2\2US\3\2\2\2UV\3\2\2\2VX\3\2\2\2WU\3\2\2\2X\\\5\b\5\2Y[\7\37\2\2ZY\3"+
		"\2\2\2[^\3\2\2\2\\Z\3\2\2\2\\]\3\2\2\2]_\3\2\2\2^\\\3\2\2\2_c\7\6\2\2"+
		"`b\7\37\2\2a`\3\2\2\2be\3\2\2\2ca\3\2\2\2cd\3\2\2\2df\3\2\2\2ec\3\2\2"+
		"\2fg\5\b\5\2g\13\3\2\2\2hl\7\7\2\2ik\7\36\2\2ji\3\2\2\2kn\3\2\2\2lj\3"+
		"\2\2\2lm\3\2\2\2mo\3\2\2\2nl\3\2\2\2os\5\26\f\2pr\7\37\2\2qp\3\2\2\2r"+
		"u\3\2\2\2sq\3\2\2\2st\3\2\2\2tv\3\2\2\2us\3\2\2\2vw\5\b\5\2w\r\3\2\2\2"+
		"x|\7\33\2\2y{\7\36\2\2zy\3\2\2\2{~\3\2\2\2|z\3\2\2\2|}\3\2\2\2}\177\3"+
		"\2\2\2~|\3\2\2\2\177\u0083\7\b\2\2\u0080\u0082\7\36\2\2\u0081\u0080\3"+
		"\2\2\2\u0082\u0085\3\2\2\2\u0083\u0081\3\2\2\2\u0083\u0084\3\2\2\2\u0084"+
		"\u0086\3\2\2\2\u0085\u0083\3\2\2\2\u0086\u008a\5\24\13\2\u0087\u0089\7"+
		"\36\2\2\u0088\u0087\3\2\2\2\u0089\u008c\3\2\2\2\u008a\u0088\3\2\2\2\u008a"+
		"\u008b\3\2\2\2\u008b\u008d\3\2\2\2\u008c\u008a\3\2\2\2\u008d\u008e\7\t"+
		"\2\2\u008e\17\3\2\2\2\u008f\u0093\7\n\2\2\u0090\u0092\7\36\2\2\u0091\u0090"+
		"\3\2\2\2\u0092\u0095\3\2\2\2\u0093\u0091\3\2\2\2\u0093\u0094\3\2\2\2\u0094"+
		"\u0096\3\2\2\2\u0095\u0093\3\2\2\2\u0096\u009a\7\33\2\2\u0097\u0099\7"+
		"\36\2\2\u0098\u0097\3\2\2\2\u0099\u009c\3\2\2\2\u009a\u0098\3\2\2\2\u009a"+
		"\u009b\3\2\2\2\u009b\u009d\3\2\2\2\u009c\u009a\3\2\2\2\u009d\u009e\7\t"+
		"\2\2\u009e\21\3\2\2\2\u009f\u00a3\7\13\2\2\u00a0\u00a2\7\36\2\2\u00a1"+
		"\u00a0\3\2\2\2\u00a2\u00a5\3\2\2\2\u00a3\u00a1\3\2\2\2\u00a3\u00a4\3\2"+
		"\2\2\u00a4\u00a6\3\2\2\2\u00a5\u00a3\3\2\2\2\u00a6\u00aa\5\24\13\2\u00a7"+
		"\u00a9\7\36\2\2\u00a8\u00a7\3\2\2\2\u00a9\u00ac\3\2\2\2\u00aa\u00a8\3"+
		"\2\2\2\u00aa\u00ab\3\2\2\2\u00ab\u00ad\3\2\2\2\u00ac\u00aa\3\2\2\2\u00ad"+
		"\u00ae\7\t\2\2\u00ae\23\3\2\2\2\u00af\u00c3\7\33\2\2\u00b0\u00c3\7\34"+
		"\2\2\u00b1\u00c3\5\30\r\2\u00b2\u00b6\7\f\2\2\u00b3\u00b5\7\36\2\2\u00b4"+
		"\u00b3\3\2\2\2\u00b5\u00b8\3\2\2\2\u00b6\u00b4\3\2\2\2\u00b6\u00b7\3\2"+
		"\2\2\u00b7\u00b9\3\2\2\2\u00b8\u00b6\3\2\2\2\u00b9\u00bd\5\24\13\2\u00ba"+
		"\u00bc\7\36\2\2\u00bb\u00ba\3\2\2\2\u00bc\u00bf\3\2\2\2\u00bd\u00bb\3"+
		"\2\2\2\u00bd\u00be\3\2\2\2\u00be\u00c0\3\2\2\2\u00bf\u00bd\3\2\2\2\u00c0"+
		"\u00c1\7\r\2\2\u00c1\u00c3\3\2\2\2\u00c2\u00af\3\2\2\2\u00c2\u00b0\3\2"+
		"\2\2\u00c2\u00b1\3\2\2\2\u00c2\u00b2\3\2\2\2\u00c3\25\3\2\2\2\u00c4\u00c8"+
		"\7\f\2\2\u00c5\u00c7\7\36\2\2\u00c6\u00c5\3\2\2\2\u00c7\u00ca\3\2\2\2"+
		"\u00c8\u00c6\3\2\2\2\u00c8\u00c9\3\2\2\2\u00c9\u00cb\3\2\2\2\u00ca\u00c8"+
		"\3\2\2\2\u00cb\u00cf\5\24\13\2\u00cc\u00ce\7\36\2\2\u00cd\u00cc\3\2\2"+
		"\2\u00ce\u00d1\3\2\2\2\u00cf\u00cd\3\2\2\2\u00cf\u00d0\3\2\2\2\u00d0\u00d2"+
		"\3\2\2\2\u00d1\u00cf\3\2\2\2\u00d2\u00d3\7\r\2\2\u00d3\27\3\2\2\2\u00d4"+
		"\u00d5\b\r\1\2\u00d5\u00d9\7\f\2\2\u00d6\u00d8\7\36\2\2\u00d7\u00d6\3"+
		"\2\2\2\u00d8\u00db\3\2\2\2\u00d9\u00d7\3\2\2\2\u00d9\u00da\3\2\2\2\u00da"+
		"\u00dc\3\2\2\2\u00db\u00d9\3\2\2\2\u00dc\u00e0\5\30\r\2\u00dd\u00df\7"+
		"\36\2\2\u00de\u00dd\3\2\2\2\u00df\u00e2\3\2\2\2\u00e0\u00de\3\2\2\2\u00e0"+
		"\u00e1\3\2\2\2\u00e1\u00e3\3\2\2\2\u00e2\u00e0\3\2\2\2\u00e3\u00e4\7\r"+
		"\2\2\u00e4\u00e8\3\2\2\2\u00e5\u00e8\7\34\2\2\u00e6\u00e8\7\33\2\2\u00e7"+
		"\u00d4\3\2\2\2\u00e7\u00e5\3\2\2\2\u00e7\u00e6\3\2\2\2\u00e8\u00fd\3\2"+
		"\2\2\u00e9\u00ea\f\13\2\2\u00ea\u00eb\7\16\2\2\u00eb\u00fc\5\30\r\13\u00ec"+
		"\u00ed\f\n\2\2\u00ed\u00ee\t\2\2\2\u00ee\u00fc\5\30\r\13\u00ef\u00f0\f"+
		"\t\2\2\u00f0\u00f1\t\3\2\2\u00f1\u00fc\5\30\r\n\u00f2\u00f3\f\b\2\2\u00f3"+
		"\u00f4\t\4\2\2\u00f4\u00fc\5\30\r\t\u00f5\u00f6\f\7\2\2\u00f6\u00f7\7"+
		"\31\2\2\u00f7\u00fc\5\30\r\7\u00f8\u00f9\f\6\2\2\u00f9\u00fa\7\32\2\2"+
		"\u00fa\u00fc\5\30\r\6\u00fb\u00e9\3\2\2\2\u00fb\u00ec\3\2\2\2\u00fb\u00ef"+
		"\3\2\2\2\u00fb\u00f2\3\2\2\2\u00fb\u00f5\3\2\2\2\u00fb\u00f8\3\2\2\2\u00fc"+
		"\u00ff\3\2\2\2\u00fd\u00fb\3\2\2\2\u00fd\u00fe\3\2\2\2\u00fe\31\3\2\2"+
		"\2\u00ff\u00fd\3\2\2\2 \"\'.\64;DHNU\\cls|\u0083\u008a\u0093\u009a\u00a3"+
		"\u00aa\u00b6\u00bd\u00c2\u00c8\u00cf\u00d9\u00e0\u00e7\u00fb\u00fd";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}