package edu.utexas.ece.feature;

import java.nio.file.Path;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.ast.Command;
import edu.mit.csail.sdg.ast.Module;
import edu.mit.csail.sdg.translator.A4Options;
import edu.mit.csail.sdg.translator.A4Solution;
import edu.mit.csail.sdg.translator.TranslateAlloyToKodkod;

/**
 * thread for time out
 *
 * @author Wenxi Wang
 * @version 1.0
 */
public class TimeoutThread extends Thread {
    public A4Solution sol;
    public Path modelPath;
    public Module world;
    public Command cmd;

    public TimeoutThread(Module world, Command cmd, Path modelPath) {
        this.world = world;
        this.cmd = cmd;
        this.modelPath = modelPath;
    }

    public void run() {
        A4Options opt = new A4Options();
        opt.originalFilename = modelPath.toString();
        opt.solver = A4Options.SatSolver.SAT4J;
        sol = TranslateAlloyToKodkod.execute_commandFromBook(
                A4Reporter.NOP, world.getAllReachableSigs(), cmd, opt);
    }
}