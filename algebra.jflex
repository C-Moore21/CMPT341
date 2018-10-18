// We are going to be returning java_cup.runtime.Symbol objects from
// yylex() (these are the tokens)
import java_cup.runtime.Symbol;

%%

%class AlgebraScanner  // name of class to generate
%unicode  // Support Unicode characters
%type Symbol // The return type of yylex(), the method that returns the next token

// Tells JFlex to generate an end-of-file token
// when the end of input is reached (needed by
// JCup)
%eofval{
    return new Symbol(AlgebraParserSym.EOF);
%eofval}
%eofclose

%%

// What to do when the scanner is in the YYINITIAL state
<YYINITIAL> {
    \+ {
        // What to do when we see a "+" token
        System.out.println("+");
        // Return this token to the parser
        return new Symbol(AlgebraParserSym.PLUS);
    }

    - {
        System.out.println("-");
        return new Symbol(AlgebraParserSym.MINUS);
    }

    \* {
        System.out.println("*");
        return new Symbol(AlgebraParserSym.TIMES);
    }

    \/ {
        System.out.println("/");
        return new Symbol(AlgebraParserSym.DIVIDE);
    }

    \^ {
        System.out.println("^");
        return new Symbol(AlgebraParserSym.POWER);

    }

    \( {
        System.out.println("(");
        return new Symbol(AlgebraParserSym.LPAREN);
    }

    \) {
        System.out.println(")");
        return new Symbol(AlgebraParserSym.RPAREN);
    }

    [0-9]+(\.[0-9]+)? {
        System.out.println("Number: " + yytext());
        return new Symbol(AlgebraParserSym.NUMBER,
            Double.parseDouble(yytext()));
    }

    [a-zA-Z_][0-9a-zA-Z_]* {
        System.out.println("Identifier: " + yytext());
        return new Symbol(AlgebraParserSym.IDENTIFIER, yytext());
    }

    // Matches any whitespace
    \s+ {
        // Skip over whitespace
        return yylex();
    }

    . {
        // Lexer error! Invalid character
        System.out.println("Invalid character: " + yytext());
    }
}
