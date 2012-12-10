package co.edu.eafit.dis.semantics.whilelanguage.main;

import co.edu.eafit.dis.semantics.whilelanguage.parser.WhileLanguageLexer;
import co.edu.eafit.dis.semantics.whilelanguage.parser.WhileLanguageParser;
import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import java.io.IOException;
import java.io.FileNotFoundException;

public class Main {

    public static void usage() {

	System.err.println("Usage: java co.edu.eafit.dis.semantics.whilelanguaje.main <filename>");
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
	    parser.whilelanguage();

	} catch (RecognitionException re ) {
	    System.err.println("Recognition exception in file: " 
			       + args[0] + " " + re);
	    System.exit(1);
	} catch (FileNotFoundException fnfe) {
	    usage();
	} catch (IOException ioe) {
	    System.err.println("Exception: " + ioe);
	    System.exit(1);
	}
    }
}