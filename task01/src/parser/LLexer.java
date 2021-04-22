// Generated from /home/max/Projects/fl-2021-itmo-spr/task01/src/L.g4 by ANTLR 4.9.1
package parser;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class LLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, POW=12, MULT=13, DIV=14, PLUS=15, MINUS=16, EQ=17, 
		IDENT=18, NUM=19, WS=20;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
			"T__9", "T__10", "POW", "MULT", "DIV", "PLUS", "MINUS", "EQ", "IDENT", 
			"NUM", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "';'", "'if'", "'('", "')'", "'{'", "'}'", "'while'", "'read'", 
			"'print'", "'='", "'var'", "'^'", "'*'", "'/'", "'+'", "'-'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			"POW", "MULT", "DIV", "PLUS", "MINUS", "EQ", "IDENT", "NUM", "WS"
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


	public LLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "L.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\26|\b\1\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\3\2\3\2\3\3\3\3\3\3\3\4\3\4\3\5\3\5\3\6"+
		"\3\6\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3"+
		"\n\3\n\3\n\3\13\3\13\3\f\3\f\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3\20"+
		"\3\20\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\5\22c\n\22"+
		"\3\23\3\23\7\23g\n\23\f\23\16\23j\13\23\3\24\3\24\3\24\7\24o\n\24\f\24"+
		"\16\24r\13\24\5\24t\n\24\3\25\6\25w\n\25\r\25\16\25x\3\25\3\25\2\2\26"+
		"\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20"+
		"\37\21!\22#\23%\24\'\25)\26\3\2\b\4\2>>@@\4\2C\\c|\6\2\62;C\\aac|\3\2"+
		"\63;\3\2\62;\5\2\13\f\17\17\"\"\2\u0083\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3"+
		"\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2"+
		"\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35"+
		"\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)"+
		"\3\2\2\2\3+\3\2\2\2\5-\3\2\2\2\7\60\3\2\2\2\t\62\3\2\2\2\13\64\3\2\2\2"+
		"\r\66\3\2\2\2\178\3\2\2\2\21>\3\2\2\2\23C\3\2\2\2\25I\3\2\2\2\27K\3\2"+
		"\2\2\31O\3\2\2\2\33Q\3\2\2\2\35S\3\2\2\2\37U\3\2\2\2!W\3\2\2\2#b\3\2\2"+
		"\2%d\3\2\2\2\'s\3\2\2\2)v\3\2\2\2+,\7=\2\2,\4\3\2\2\2-.\7k\2\2./\7h\2"+
		"\2/\6\3\2\2\2\60\61\7*\2\2\61\b\3\2\2\2\62\63\7+\2\2\63\n\3\2\2\2\64\65"+
		"\7}\2\2\65\f\3\2\2\2\66\67\7\177\2\2\67\16\3\2\2\289\7y\2\29:\7j\2\2:"+
		";\7k\2\2;<\7n\2\2<=\7g\2\2=\20\3\2\2\2>?\7t\2\2?@\7g\2\2@A\7c\2\2AB\7"+
		"f\2\2B\22\3\2\2\2CD\7r\2\2DE\7t\2\2EF\7k\2\2FG\7p\2\2GH\7v\2\2H\24\3\2"+
		"\2\2IJ\7?\2\2J\26\3\2\2\2KL\7x\2\2LM\7c\2\2MN\7t\2\2N\30\3\2\2\2OP\7`"+
		"\2\2P\32\3\2\2\2QR\7,\2\2R\34\3\2\2\2ST\7\61\2\2T\36\3\2\2\2UV\7-\2\2"+
		"V \3\2\2\2WX\7/\2\2X\"\3\2\2\2YZ\7?\2\2Zc\7?\2\2[\\\7#\2\2\\c\7?\2\2]"+
		"^\7>\2\2^c\7?\2\2_`\7@\2\2`c\7?\2\2ac\t\2\2\2bY\3\2\2\2b[\3\2\2\2b]\3"+
		"\2\2\2b_\3\2\2\2ba\3\2\2\2c$\3\2\2\2dh\t\3\2\2eg\t\4\2\2fe\3\2\2\2gj\3"+
		"\2\2\2hf\3\2\2\2hi\3\2\2\2i&\3\2\2\2jh\3\2\2\2kt\7\62\2\2lp\t\5\2\2mo"+
		"\t\6\2\2nm\3\2\2\2or\3\2\2\2pn\3\2\2\2pq\3\2\2\2qt\3\2\2\2rp\3\2\2\2s"+
		"k\3\2\2\2sl\3\2\2\2t(\3\2\2\2uw\t\7\2\2vu\3\2\2\2wx\3\2\2\2xv\3\2\2\2"+
		"xy\3\2\2\2yz\3\2\2\2z{\b\25\2\2{*\3\2\2\2\b\2bhpsx\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}