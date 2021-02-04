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
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;

import edu.mit.csail.sdg.parser.CompModule;
import edu.utexas.ece.feature.GetDepInCmd;
import edu.utexas.ece.feature.GetDepInCmd.SingleDepOutput;
import edu.utexas.ece.feature.ReuseGroupSol;
import parser.util.AlloyUtil;

/**
 * iAlloy entry
 *
 * @author Wenxi Wang
 * @version 1.0
 */
public class AlloyMain {

    /** Main method */
    public static void main(String[] args) throws Exception {
        // Analyze file path
        Path modelRootPath = Paths.get(args[0]);
        String modelName = modelRootPath.getFileName().toString();
        Path csRootPath = modelRootPath.getParent().getParent();
        Path dependRootPath = csRootPath.resolve("dependency").resolve(modelName);
        Path paramRootPath = csRootPath.resolve("param").resolve(modelName);
        Path xmlRootPath = csRootPath.resolve("xml").resolve(modelName);

        for (Path p : new Path[] { dependRootPath, paramRootPath, xmlRootPath }) {
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
        long totalTime = 0, totalRerun = 0, totalReuse = 0, totalCmd = 0, totalRerunCmd = 0;

        Iterator<Path> modelDirs = Files.list(modelRootPath).sorted().iterator();
        while (modelDirs.hasNext()) {
            Path modelPath = modelDirs.next().resolve(modelName + ".als");

            // Run alloy and count time consumption
            long startTime = System.currentTimeMillis();
            CompModule module = AlloyUtil.compileAlloyModule(modelPath.toString());
            GetDepInCmd depCmd = new GetDepInCmd();
            List<SingleDepOutput> output4Dep = depCmd.collectDep(module, dependRootPath, modelName);
            ReuseGroupSol reuseGroup = new ReuseGroupSol(output4Dep, xmlRootPath, paramRootPath, modelName, module,
                    modelPath);
            reuseGroup.execute();
            long stopTime = System.currentTimeMillis();
            long executeTime = stopTime - startTime;

            String version = modelPath.getParent().getFileName().toString();
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
