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

package edu.utexas.ece.feature;

import java.io.BufferedWriter;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import edu.mit.csail.sdg.ast.Command;
import edu.mit.csail.sdg.ast.Module;
import edu.mit.csail.sdg.translator.A4Solution;
import edu.utexas.ece.feature.GetDepInCmd.SingleDepOutput;

/**
 * Solution Reuse in iAlloy
 *
 * @author Wenxi Wang
 * @version 1.0
 */
public abstract class ReuseSol {

    public static final String SEP = File.separator;

    public List<SingleDepOutput> output4Dep;
    public Path xmlRoot;
    public Path paramRoot;
    public String modelName;
    public Module module;
    public Path modelPath;
    public int rerun;
    public int reuse;

    public ReuseSol(List<SingleDepOutput> output4Dep, Path modelXmlRoot, Path paramRoot, String modelName,
            Module module, Path modelPath) {
        this.output4Dep = output4Dep;
        this.xmlRoot = modelXmlRoot;
        this.paramRoot = paramRoot;
        this.modelName = modelName;
        this.module = module;
        this.modelPath = modelPath;
        rerun = 0;
        reuse = 0;
    }

    public abstract boolean checkReuse(Module world, String cmdName, List<String> predFacts,
            Map<Set<String>, Set<String>> type2Sol, Set<String> paramSet) throws Exception;

    public void RunAgain(Module world, Path modelPath, String cmdName, Command cmd,
            Map<Set<String>, Set<String>> type2Sol, Set<String> paramSet) throws Exception {

        TimeoutThread thd = new TimeoutThread(world, cmd, modelPath);
        thd.start();
        thd.join(30 * 1000);

        Path modelParamPath = paramRoot.resolve(cmdName);
        Path modelXmlPath = xmlRoot.resolve(cmdName + ".xml");
        A4Solution solution = thd.sol;

        if (solution != null && solution.satisfiable()) {
            try (BufferedWriter out = Files.newBufferedWriter(modelParamPath)) {
                for (String p : paramSet) {
                    out.write(p + "\n");
                }
            }
            solution.writeXML(modelXmlPath.toString());
        }
        thd.interrupt();
    }

    public void execute() throws Exception {
        Map<Set<String>, Set<String>> type2Sol = new HashMap<Set<String>, Set<String>>();

        for (SingleDepOutput sdo : output4Dep) {
            String cmdName = sdo.cmdName;
            List<String> predFacts = sdo.predFacts;
            Set<String> paramSet = sdo.paramSet;
            Command cmd = sdo.cmd;

            if (!predFacts.isEmpty()) {
                if (!checkReuse(module, cmdName, predFacts, type2Sol, paramSet)) {
                    rerun++;
                    RunAgain(module, modelPath, cmdName, cmd, type2Sol, paramSet);
                } else {
                    reuse++;
                }
            } else {
                rerun++;
                RunAgain(module, modelPath, cmdName, cmd, type2Sol, paramSet);
            }
        }
    }
}
