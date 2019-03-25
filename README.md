#**Algorithm Design for a Lexical Analyzer**

##**1. Understanding The Problem**

Lexical analysis is the first phase of a compiler. It takes the modified source code from language preprocessors that are written in the form of sentences. The lexical analyzer breaks these syntaxes into a series of tokens, by removing any whitespace or comments in the source code.

If the lexical analyzer finds a token invalid, it generates an error. The lexical analyzer works closely with the syntax analyzer. It reads character streams from the source code, checks for legal tokens, and passes the data to the syntax analyzer when it demands.

##**2. Plan and Preliminaries**

**a) Specifications of Tokens**

Language theory undertakes the following terms:

**Alphabets**

Any finite set of symbols {0,1} is a set of binary alphabets, {0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F} is a set of Hexadecimal alphabets, {a-z, A-Z} is a set of English language alphabets.

**Strings**

Any finite sequence of alphabets is called a string. Length of the string is the total number of occurrence of alphabets, e.g., the length of the string tutorialspoint is 14 and is denoted by |tutorialspoint| = 14. A string having no alphabets, i.e. a string of zero length is known as an empty string and is denoted by ε (epsilon).

**Special Symbols**

A typical high-level language contains the following symbols:-

Arithmetic Symbols:	Addition(+), Subtraction(-), Modulo(%), Multiplication(*), Division(/)
Punctuation:	Comma(,), Semicolon(;), Dot(.), Arrow(->)
Assignment:	=
Augmented Assignment:	+=, /=, *=, -=
Comparison:	==, !=, <, <=, >, >=
Preprocessor:	#
Location Specifier:	&
Logical operators:	&, &&, |, ||, !
Shift Operators:	>>, >>>, <<, <<<
e.t.c

**b)Longest Match Rule**

When the lexical analyzer reads the source-code, it scans the code letter by letter; and when it encounters a whitespace, operator symbol, or special symbols, it decides that a word is completed.

For example: int intvalue;

While scanning both lexemes till ‘int’, the lexical analyzer cannot determine whether it is a keyword int or the initials of identifier int value.

The Longest Match Rule states that the lexeme scanned should be determined based on the longest match among all the tokens available.

The lexical analyzer also follows rule priority where a reserved word, e.g., a keyword, of a language is given priority over user input. That is, if the lexical analyzer finds a lexeme that matches with any existing reserved word, it should generate an error.

The lexical analyzer needs to scan and identify only a finite set of valid string/token/lexeme that belong to the language in hand. It searches for the pattern defined by the language rules.

###c) Regular Expressions
These are useful notation for describing the token classes.
ACTION tables can be generated from them directly, although the construction is somewhat complicated.

**Operands**

1. Single characters, e.g, + , A .
2. Character classes, e.g.,
letter = [A-Za-z]
digit = [0-9]
addop = [+-]

Expressions built from operands and operators denote sets of strings.

**Operators**

1. Concatenation. ( R )( S ) denotes the set of all strings formed by taking a string in the set denoted by
R and following it by a string in the set denoted by S . For example, the keyword "then" can be expressed as a
regular expression by then.

2. The operator + stands for union or \or." ( R ) + ( S ) denotes the set of strings that are in the set de-
noted by S union those in the set denoted by R . For example, letter + digit denotes any character that
is either a letter or a digit.

3. The post x unary operator *, the Kleene closure, indicates \any number of," including zero. Thus,
( letter )* denotes the set of strings consisting of zero or more letters.

The usual order of precedence is * highest, then concatenation, then +. Thus, a + bc* is
a + (b (c*))

**Shorthands**

a) R + stands for "one or more occurrences of," i.e., R+ = RR* . Do not confuse infix +, meaning "or,"
with the superscript +.

b) R ? stands for "an optional R ," i.e., R? = R + {}.
Note {} stands for the empty string, which is the string of length 0.

Some Examples
identifier = letter(letter + digit )*
float = digit+.digit* +.digit+

###**d) Finite Automata**

A collection of states and rules for transferring among states in response to inputs. They look like state diagrams, and they can be represented by ACTION tables. We can convert any collection of regular expressions to a FA; the details are in the text. Intuitively, we begin by writing the "or" of the regular expressions for each of our tokens.

In our simple example of plus signs, identi ers, and "if," we would write:

+ + i f + letter(letter + digit)*

States correspond to sets of positions in this expression. For example,
i) The "initial state" corresponds to the positions where we are ready to begin recognizing any token,
i.e., just before the + , just before the i , and just before the first letter .

ii) If we see i , we go to a state consisting of the positions where we are ready to see the f or the second
letter , or the digit , or we have completed the token. Positions following the expression for one of the tokens are special; they indicate that the token has been seen.

However, just because a token has been seen does not mean that the lexical analyzer is done. We could
see a longer instance of the same token (e.g., identifier) or we could see a longer string that is an instance
of another token.

**Using the Finite Automaton**

To disambiguate situations where more than one candidate token exists:
i) Prefer longer strings to shorter. Thus, we do not take a or ab to be the token when confronted with identifier abc.
ii) Let the designer of the lexical analyzer pick an order for the tokens. If the longest possible string matches two or more tokens, pick the first in the order. Thus, we might list keyword tokens before the token "identifier," and confronted with string
if +... would determine that we had the keyword "if," not an identifier if.

##**3. Execution**

Two kinds of execution of partially specified algorithms were observed — one on concrete data (test-case execution, for example, sample_input.c file) and the other on symbolic exemplars (symbolic execution, for example, raw input strings). Both forms of trial execution helped elaborate the algorithm description by exposing difficulties and opportunities.

We found it useful to view execution as a technique for selectively propagating constraints (assertions.) by moving
them around in the order in which the steps of the algorithm are executed. This limits the reasoning that might otherwise be necessary to find contradictions and make inferences.

##**4. Difficulties and Opportunities**

Difficulties were encountered while deriving some regular expressions to identify the patterns of some lexemes. In particular, the regular expression for non-tokens such as comments was troublesome. Another major difficulty was that of generating the symbol table since at the Lexical analysis stage of compilation, a symbol table isn't generated and therefore specifying the exact fields and records was a major challenge.

The major opportunity brought forth with the completion of the Lexical Analyzer is buiding a parser to complement the Analysis phase of a compiler.

##**5. Verifying Correctness**

We determined whether the algorithms were correct primarily by testing them on specific examples and observing whether there were any errors generated. Test case execution in fact was made to do the job of full formal verification. To do this, the algorithm was executed on a test case file (sample_input.c) and all assertions were propagated to determine whether the results of the algorithm (and its subparts) match the specifications.

If a specification included performance constraints, then verification must also include an evaluation (see Section 6) to determine whether the solution is efficient enough (in time or space complexity) according to the expectations.

During the initial algorithm design, we ignored "details" such as comments, preprocessor directives, whitespace, among others. The heuristic was to get an algorithm for the general case first, then worry about modifying it later to take the exceptions into account.

##**6. Evaluating Plans, Refinements, and Solutions**

The descriptions of the processes used in design did not detail how plans, refinement steps, and overall solutions are evaluated. Evaluation can be based on specific knowledge about the algorithm design principles being applied or/on an analysis of the cost of the algorithm and its subparts.

With the appropriate rules about the algorithm design principle and the domain, then the refinement process can be smooth and top down.'Generate and test' is usually the fall back idea, which is sometimes very efficient (linear in the input size) and sometimes not.

The final algorithm design is composed of two cascading processes connected by a buffer as described below:

**a) Scanning**

The sample input file (eg. sample_input.c) is processed character by character in ways such as:
i) Remove comments
ii) Replace strings of whitespace(tabs, blanks, and newlines) by single blanks

**b) Lexical Analysis**

Group the stream of refined input characters(lexemes) into tokens i.e.

Raw input --> SCANNER --> Refined input --> LEXICAL ANALYZER --> Token stream

The Token Output Stream

Before passing the tokens further on in the compiler, it is useful to represent tokens as pairs, consisting of a
token-class(simply, token) and token-value. The reason is because the parser will normally only use the token class, while later phases of the compiler, such as the code generator will need more information which is found in the token value. For example;

Group all identifiers into one token-class, <identifier>, and let the value associated with the identifier be a pointer to the symbol table entry for that identifier. (<identifier>,<ptr to symbol table>)

Likewise, constants can be grouped into token class < constant > :( < constant > , < ptr to value > )

Keywords should form token classes by themselves, since each plays a unique syntactic role. Value can be
null, since keywords play no role beyond the syntax analysis phase, e.g.  ( < then > , { )

Operators may form classes by themselves. Or, group operators with the same syntactic role and use the
token value to distinguish among them. For example, + and (binary) , are usually operators with the same precedence, so we might have a token class < additive operator > , and use value = 0 for + and value = 1 for -
