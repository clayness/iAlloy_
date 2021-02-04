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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;

import edu.mit.csail.sdg.parser.CompModule;
import edu.utexas.ece.feature.GetDepInCmd;
import edu.utexas.ece.feature.GetDepInCmd.SingleDepOutput;
import edu.utexas.ece.feature.ReuseGroupSol;
import parser.util.AlloyUtil;
import parser.util.StringUtil;

/**
 * iAlloy entry
 *
 * @author Wenxi Wang
 * @version 1.0
 */
public class AlloyMain {

    public static final String SEP = File.separator;
    public static final String DEPEND_FOLD = "dependency";
    public static final String PARAM_FOLD = "param";
    public static final String MODELS_FOLD = "models";
    public static final String XML_FOLD = "xml";

    /** Main method */
    public static void main(String[] args) throws Exception {
        // Analyze file path
        String modelRootPath = args[0];
        String[] elementList = modelRootPath.split(SEP);
        String modelName = elementList[elementList.length - 1];
        String csRootPath = StringUtil.beforeSubstring(modelRootPath, SEP + MODELS_FOLD, true);
        String dependRootPath = csRootPath + SEP + DEPEND_FOLD + SEP + modelName;
        String paramRootPath = csRootPath + SEP + PARAM_FOLD + SEP + modelName;
        String xmlRootPath = csRootPath + SEP + XML_FOLD + SEP + modelName;

        for (String dir : new String[] { dependRootPath, paramRootPath, xmlRootPath }) {
            Path p = Paths.get(dir);
            if (Files.exists(p)) {
                try (Stream<Path> walk = Files.walk(p)) {
                    walk.sorted(Comparator.reverseOrder())
                        .map(Path::toFile)
                        .forEach(File::delete);
                }
            }
            Files.createDirectories(p);
        }

        // Apply regression command selection and solution reuse, and collect the
        // results
        long totalTime = 0;
        int totalRerun = 0, totalReuse = 0;
        int totalCmd = 0, totalRerunCmd = 0;

        File[] modelDirs = new File(modelRootPath).listFiles();
        Arrays.sort(modelDirs);
        for (File modelDir : modelDirs) {
            String modelPath = modelDir.getAbsolutePath() + SEP + modelName + ".als";

            // Run alloy and count time consumption
            long startTime = System.currentTimeMillis();
            CompModule module = AlloyUtil.compileAlloyModule(modelPath);
            GetDepInCmd depCmd = new GetDepInCmd();
            List<SingleDepOutput> output4Dep = depCmd.collectDep(module, dependRootPath, modelName);
            ReuseGroupSol reuseGroup = new ReuseGroupSol(output4Dep, xmlRootPath, paramRootPath, modelName, module,
                    modelPath);
            reuseGroup.execute();
            long stopTime = System.currentTimeMillis();
            long executeTime = stopTime - startTime;

            String[] tmpElementList = modelPath.split(SEP);
            String version = tmpElementList[tmpElementList.length - 2];

            totalCmd += module.getAllCommands().size();
            totalRerunCmd += output4Dep.size();
            totalRerun += reuseGroup.rerun;
            totalReuse += reuseGroup.reuse;
            totalTime += executeTime;

            System.out.printf("%s,%s,%d,%d,%d,%d,%d%n", modelName, version, module.getAllCommands().size(),
                    output4Dep.size(), reuseGroup.rerun, reuseGroup.reuse, executeTime);
        }

        System.out.printf("%s,v1_v2,%d,%d,%d,%d,%d%n", modelName, totalCmd, totalRerunCmd, totalRerun, totalReuse,
                totalTime);
    }
}
