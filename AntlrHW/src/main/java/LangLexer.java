// Generated from Lang.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class LangLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, NOT=2, LPAR=3, RPAR=4, LBR=5, RBR=6, TRUE=7, FALSE=8, READ=9, 
		WRITE=10, NUMBER=11, MINUS=12, ASSIGN=13, IF=14, ELSE=15, IDENT=16, STAR=17, 
		SLASH=18, PERCENT=19, PLUS=20, LT=21, LE=22, GE=23, GT=24, EQ=25, NEQ=26, 
		AND=27, OR=28, WS=29;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "DIGIT", "LETTER", "NOT", "LPAR", "RPAR", "LBR", "RBR", "TRUE", 
			"FALSE", "READ", "WRITE", "NUMBER", "MINUS", "ASSIGN", "IF", "ELSE", 
			"IDENT", "STAR", "SLASH", "PERCENT", "PLUS", "LT", "LE", "GE", "GT", 
			"EQ", "NEQ", "AND", "OR", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "';'", "'!'", "'('", "')'", "'{'", "'}'", "'true'", "'false'", 
			"'read'", "'write'", null, "'-'", "'='", "'if'", "'else'", null, "'*'", 
			"'/'", "'%'", "'+'", "'<'", "'<='", "'>='", "'>'", "'=='", "'!='", "'&&'", 
			"'||'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, "NOT", "LPAR", "RPAR", "LBR", "RBR", "TRUE", "FALSE", "READ", 
			"WRITE", "NUMBER", "MINUS", "ASSIGN", "IF", "ELSE", "IDENT", "STAR", 
			"SLASH", "PERCENT", "PLUS", "LT", "LE", "GE", "GT", "EQ", "NEQ", "AND", 
			"OR", "WS"
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


	public LangLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Lang.g4"; }

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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\37\u00ac\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t"+
		" \3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\n"+
		"\3\n\3\n\3\n\3\n\3\13\3\13\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\f\3\f\3\r"+
		"\3\r\3\r\3\r\3\r\3\r\3\16\5\16i\n\16\3\16\6\16l\n\16\r\16\16\16m\3\17"+
		"\3\17\3\20\3\20\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\23\3\23\5\23"+
		"~\n\23\3\23\3\23\3\23\7\23\u0083\n\23\f\23\16\23\u0086\13\23\3\24\3\24"+
		"\3\25\3\25\3\26\3\26\3\27\3\27\3\30\3\30\3\31\3\31\3\31\3\32\3\32\3\32"+
		"\3\33\3\33\3\34\3\34\3\34\3\35\3\35\3\35\3\36\3\36\3\36\3\37\3\37\3\37"+
		"\3 \6 \u00a7\n \r \16 \u00a8\3 \3 \2\2!\3\3\5\2\7\2\t\4\13\5\r\6\17\7"+
		"\21\b\23\t\25\n\27\13\31\f\33\r\35\16\37\17!\20#\21%\22\'\23)\24+\25-"+
		"\26/\27\61\30\63\31\65\32\67\339\34;\35=\36?\37\3\2\5\3\2\62;\4\2C\\c"+
		"|\5\2\13\f\17\17\"\"\2\u00b0\2\3\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r"+
		"\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2"+
		"\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2"+
		"#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3"+
		"\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67\3\2\2\2\29\3\2\2\2"+
		"\2;\3\2\2\2\2=\3\2\2\2\2?\3\2\2\2\3A\3\2\2\2\5C\3\2\2\2\7E\3\2\2\2\tG"+
		"\3\2\2\2\13I\3\2\2\2\rK\3\2\2\2\17M\3\2\2\2\21O\3\2\2\2\23Q\3\2\2\2\25"+
		"V\3\2\2\2\27\\\3\2\2\2\31a\3\2\2\2\33h\3\2\2\2\35o\3\2\2\2\37q\3\2\2\2"+
		"!s\3\2\2\2#v\3\2\2\2%}\3\2\2\2\'\u0087\3\2\2\2)\u0089\3\2\2\2+\u008b\3"+
		"\2\2\2-\u008d\3\2\2\2/\u008f\3\2\2\2\61\u0091\3\2\2\2\63\u0094\3\2\2\2"+
		"\65\u0097\3\2\2\2\67\u0099\3\2\2\29\u009c\3\2\2\2;\u009f\3\2\2\2=\u00a2"+
		"\3\2\2\2?\u00a6\3\2\2\2AB\7=\2\2B\4\3\2\2\2CD\t\2\2\2D\6\3\2\2\2EF\t\3"+
		"\2\2F\b\3\2\2\2GH\7#\2\2H\n\3\2\2\2IJ\7*\2\2J\f\3\2\2\2KL\7+\2\2L\16\3"+
		"\2\2\2MN\7}\2\2N\20\3\2\2\2OP\7\177\2\2P\22\3\2\2\2QR\7v\2\2RS\7t\2\2"+
		"ST\7w\2\2TU\7g\2\2U\24\3\2\2\2VW\7h\2\2WX\7c\2\2XY\7n\2\2YZ\7u\2\2Z[\7"+
		"g\2\2[\26\3\2\2\2\\]\7t\2\2]^\7g\2\2^_\7c\2\2_`\7f\2\2`\30\3\2\2\2ab\7"+
		"y\2\2bc\7t\2\2cd\7k\2\2de\7v\2\2ef\7g\2\2f\32\3\2\2\2gi\5\35\17\2hg\3"+
		"\2\2\2hi\3\2\2\2ik\3\2\2\2jl\5\5\3\2kj\3\2\2\2lm\3\2\2\2mk\3\2\2\2mn\3"+
		"\2\2\2n\34\3\2\2\2op\7/\2\2p\36\3\2\2\2qr\7?\2\2r \3\2\2\2st\7k\2\2tu"+
		"\7h\2\2u\"\3\2\2\2vw\7g\2\2wx\7n\2\2xy\7u\2\2yz\7g\2\2z$\3\2\2\2{~\5\7"+
		"\4\2|~\7a\2\2}{\3\2\2\2}|\3\2\2\2~\u0084\3\2\2\2\177\u0083\5\7\4\2\u0080"+
		"\u0083\5\5\3\2\u0081\u0083\7a\2\2\u0082\177\3\2\2\2\u0082\u0080\3\2\2"+
		"\2\u0082\u0081\3\2\2\2\u0083\u0086\3\2\2\2\u0084\u0082\3\2\2\2\u0084\u0085"+
		"\3\2\2\2\u0085&\3\2\2\2\u0086\u0084\3\2\2\2\u0087\u0088\7,\2\2\u0088("+
		"\3\2\2\2\u0089\u008a\7\61\2\2\u008a*\3\2\2\2\u008b\u008c\7\'\2\2\u008c"+
		",\3\2\2\2\u008d\u008e\7-\2\2\u008e.\3\2\2\2\u008f\u0090\7>\2\2\u0090\60"+
		"\3\2\2\2\u0091\u0092\7>\2\2\u0092\u0093\7?\2\2\u0093\62\3\2\2\2\u0094"+
		"\u0095\7@\2\2\u0095\u0096\7?\2\2\u0096\64\3\2\2\2\u0097\u0098\7@\2\2\u0098"+
		"\66\3\2\2\2\u0099\u009a\7?\2\2\u009a\u009b\7?\2\2\u009b8\3\2\2\2\u009c"+
		"\u009d\7#\2\2\u009d\u009e\7?\2\2\u009e:\3\2\2\2\u009f\u00a0\7(\2\2\u00a0"+
		"\u00a1\7(\2\2\u00a1<\3\2\2\2\u00a2\u00a3\7~\2\2\u00a3\u00a4\7~\2\2\u00a4"+
		">\3\2\2\2\u00a5\u00a7\t\4\2\2\u00a6\u00a5\3\2\2\2\u00a7\u00a8\3\2\2\2"+
		"\u00a8\u00a6\3\2\2\2\u00a8\u00a9\3\2\2\2\u00a9\u00aa\3\2\2\2\u00aa\u00ab"+
		"\b \2\2\u00ab@\3\2\2\2\t\2hm}\u0082\u0084\u00a8\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}