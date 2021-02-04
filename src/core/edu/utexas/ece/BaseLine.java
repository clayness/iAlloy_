/*
 * This file is part of iAlloy. iAlloy is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * iAlloy is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with iAlloy.
 * If not, see <https://www.gnu.org/licenses/>.
 */

package edu.utexas.ece;

import java.io.File;
import java.nio.file.Paths;
import java.util.Arrays;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.ast.Command;
import edu.mit.csail.sdg.ast.Module;
import edu.mit.csail.sdg.parser.CompUtil;
import edu.mit.csail.sdg.translator.A4Options;
import edu.mit.csail.sdg.translator.A4Solution;
import edu.utexas.ece.feature.TimeoutThread;

/**
 * Baseline: normal evolving alloy analysis
 *
 * @author Wenxi Wang
 * @version 1.0
 */
public class BaseLine {

    public static final String SEP = File.separator;

    public static void main(String[] args) throws Err, InterruptedException {
        int cmdNum = 0;
        int totalTime = 0;

        String modelRootPath = args[0];
        File modelRoot = new File(modelRootPath);

        String[] elementList = modelRootPath.split(SEP);
        String modelName = elementList[elementList.length - 1];

        File[] modelDirs = modelRoot.listFiles();
        Arrays.sort(modelDirs);
        for (File modelDir : modelDirs) {
            String modelFilePath = modelDir.getAbsolutePath() + SEP + modelName + ".als";

            // Run a4reporter and count time consumption
            long startTime = System.currentTimeMillis();
            Module world = CompUtil.parseEverything_fromFile(A4Reporter.NOP, null, modelFilePath);
            A4Options options = new A4Options();
            options.solver = A4Options.SatSolver.SAT4J;

            for (Command command : world.getAllCommands()) {

                TimeoutThread hyt = new TimeoutThread(world, command, Paths.get(modelFilePath));
                hyt.start();
                hyt.join(30 * 1000);
                A4Solution ans = hyt.sol;
                if (ans != null && ans.satisfiable()) {
                    ans.writeXML("alloy_example_output.xml");
                }
            }
            long stopTime = System.currentTimeMillis();
            long executeTime = stopTime - startTime;

            String[] tmpElementList = modelFilePath.split(SEP);
            String version = tmpElementList[tmpElementList.length - 2];
            cmdNum = world.getAllCommands().size(); // get the total number of the commands in the Alloy model
            totalTime += executeTime;

            System.out.printf("%s,%s,%d,%d,%d,0,%d%n", modelName, version, cmdNum, cmdNum, cmdNum, 0, executeTime);
        }

        System.out.printf("%s,v1_v2,%d,%d,%d,0,%d%n", modelName, cmdNum * 2, cmdNum * 2, cmdNum * 2, totalTime);
    }
}
