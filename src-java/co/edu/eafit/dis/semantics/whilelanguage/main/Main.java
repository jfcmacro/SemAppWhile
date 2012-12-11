package co.edu.eafit.dis.semantics.whilelanguage.main;

import co.edu.eafit.dis.semantics.whilelanguage.parser.WhileLanguageLexer;
import co.edu.eafit.dis.semantics.whilelanguage.parser.WhileLanguageParser;
import co.edu.eafit.dis.semantics.whilelanguage.walker.FreeVars;
import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.tree.CommonTree;
import org.antlr.runtime.tree.CommonTreeNodeStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.HashSet;

public class Main {

    public static void usage() {

	System.err.println("Usage: java " +
			   "co.edu.eafit.dis.semantics.whilelanguaje.main " +
			   "<filename>");
	System.exit(1);
    }

    public static void main(String args[]) {

	if (args.length != 1) {
	    usage();
	}

	try {

	    WhileLanguageLexer wll = new
		WhileLanguageLexer(new ANTLRFileStream(args[0]));
	    CommonTokenStream tokens = new CommonTokenStream(wll);
	    WhileLanguageParser parser = new WhileLanguageParser(tokens);
	    WhileLanguageParser.whilelanguage_return r =
		parser.whilelanguage();
	    CommonTree t = (CommonTree) r.getTree() ;
	    System.out.println(t.toStringTree());
	    CommonTreeNodeStream nodes = new CommonTreeNodeStream(t);
	    FreeVars walker = new FreeVars(nodes);
	    HashSet<String> hs = walker.whilelanguage();
	    System.out.println(hs.toString());

	} catch (RecognitionException re ) {
	    System.err.println("Recognition exception in file: "
			       + args[0]
			       + "line: " + re.line
			       + " column: " + re.charPositionInLine
			       + " token: " + re.token);
	    System.exit(1);
	} catch (FileNotFoundException fnfe) {
	    usage();
	} catch (IOException ioe) {
	    System.err.println("Exception: " + ioe);
	    System.exit(1);
	}
    }
}