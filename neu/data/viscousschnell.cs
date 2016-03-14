using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using BoSSS.Foundation.Grid;
using BoSSS.Foundation.XDG;
using BoSSS.Platform;
using BoSSS.Platform.LinAlg;
using BoSSS.Solution.GridImport;
using BoSSS.Solution.Queries;
using CNS;
using CNS.Convection;
using CNS.Diffusion;
using CNS.EquationSystem;
using CNS.Exception;
using CNS.IBM;
using CNS.MaterialProperty;
using CNS.Residual;
using CNS.Solution;
using CNS.Source;

string dbPath = @"/work/scratch/ws35kire/dg1/";
// string dbPath = @"\\fdyprime\userspace\stange\bosss_db";
// c.AddBoundaryCondition("adiabaticWall"); 
// c.LevelSetBoundaryTag = "adiabaticWall"; 
double Mach = 0.2;
int dgDegree = 1;
double agglomerationThreshold = 0.1; 
int levelSetQuadratureOrder = 10;
int parmetiesRefinements = 10;
double[] reynolds = new double[] {136.3756299, 272.7512599, 681.8781497, 1363.756299};
int[] cells = new int[] {32, 64, 128};
double penalty = 5.0;

List<IBMControl> controls = new List<IBMControl>();
int i = 1;
// Iterate over Reynold 20, 40, 100, 200 (outer loop) and over numberOfCells (inner loop)

for(int k = 0; k <= 3; k++) { \
	for(int j = 0; j <= 2; j++) { \
		int numberOfCells = cells[j]; \
		IBMControl c = new IBMControl(); \
		c.DbPath = dbPath; \
		c.savetodb = dbPath != null; \
 \
		c.ProjectName = "Viscous"; \
		c.ProjectDescription = String.Format( \
			"Viscous flow around cylinder represented by a level set at Mach {0}" + \
				" with cell agglomeration threshold {1} and {2}th order" + \
				" HMF quadrature (classic variant)", \
			Mach, \
			agglomerationThreshold, \
			levelSetQuadratureOrder); \
 \
		c.Tags.Add("Cylinder"); \
		c.Tags.Add("IBM"); \
		c.Tags.Add("Agglomeration " + agglomerationThreshold); \
		c.Tags.Add("Case " + i); \
		c.Tags.Add("Re " + reynolds[k]); \
		c.Tags.Add("NoCells " + numberOfCells); \
		c.Tags.Add("DgDegree " + dgDegree); \
		c.Tags.Add("final"); \
		\
		c.DomainType = DomainTypes.ImmersedBoundary; \
		c.ActiveOperators = Operators.Convection | Operators.Diffusion; \
		c.ConvectiveFluxType = ConvectiveFluxTypes.OptimizedHLLC; \
		c.DiffusiveFluxType = DiffusiveFluxTypes.OptimizedSIPG; \
		c.TimeSteppingScheme = TimeSteppingSchemes.Explicit; \
		c.ExplicitScheme = ExplicitSchemes.RungeKutta; \
		c.ExplicitOrder = 1; \
 \
		c.EquationOfState = IdealGas.Air; \
		c.ReynoldsNumber = reynolds[k]; \
		c.PrandtlNumber = 0.72; \
		c.ViscosityLaw = new PowerLaw(); \
		c.SIPGPenaltyConstant = penalty; \
 \
		c.AddVariable(Variable.Density, dgDegree); \
		c.AddVariable(Variable.Momentum.xComponent, dgDegree); \
		c.AddVariable(Variable.Momentum.yComponent, dgDegree); \
		c.AddVariable(Variable.Energy, dgDegree); \
		c.AddVariable(Variable.LevelSet, 2); \
		c.AddVariable(Variable.Velocity.xComponent, dgDegree); \
		c.AddVariable(Variable.Velocity.yComponent, dgDegree); \
		c.AddVariable(Variable.Vorticity.xComponent, dgDegree); \
		c.AddVariable(Variable.Vorticity.yComponent, dgDegree); \
 \
		c.GridFunc = delegate () { \
			double stretching1 = 2.4; \
			double stretching2 = 2.0; \
			double D = 40.0; \
		 \
			double[] nodesA = Grid1D.TanhSpacing(-D, -1.05, numberOfCells / 2 + 1, stretching1, false); \
			double[] nodesB = Grid1D.TanhSpacing(-1.05, 0, numberOfCells / 8 + 1, stretching2, true); \
			double[] nodesC = Grid1D.TanhSpacing(0, 1.05, numberOfCells / 8 + 1, stretching2, false); \
			double[] nodesD = Grid1D.TanhSpacing(1.05, D, numberOfCells / 2 + 1, stretching1, true); \
			double[] nodes = nodesA.Take(nodesA.Length - 1).Concat(nodesB.Take(nodesB.Length - 1)).Concat(nodesC.Take(nodesC.Length - 1)).Concat(nodesD).ToArray(); \
			GridCommons grid = Grid2D.Cartesian2DGrid(nodes, nodes); \
		 \
			grid.EdgeTagNames.Add(1, "supersonicInlet"); \
			grid.EdgeTagNames.Add(2, "isothermalWall"); \
			Func<double[], byte> func = delegate (double[] x) { \
				return 1; \
			}; \
			grid.DefineEdgeTags(func); \
		 \
			return grid; \
		}; \
 \
		c.GridPartType = GridPartType.ParMETIS; \
		c.GridPartOptions = "5"; \
		c.CutCellWeightingFactor = 10; \
\
		c.InitialValues.Add(Variable.Density, X => 1.0); \
		c.InitialValues.Add(Variable.Momentum[0], X => 1.0); \
		c.InitialValues.Add(Variable.Momentum[1], X => 0.0); \
		c.InitialValues.Add(Variable.Energy, X => 45.14285714); \
		c.InitialValues.Add(Variable.LevelSet, X => X[0] * X[0] + X[1] * X[1] - 1.0 * 1.0); \
 \
		c.AddBoundaryCondition("supersonicInlet", Variable.Density, (X, t) => 1.0); \
		c.AddBoundaryCondition("supersonicInlet", Variable.Velocity[0], (X, t) => 1.0); \
		c.AddBoundaryCondition("supersonicInlet", Variable.Velocity[1], (X, t) => 0.0); \
		c.AddBoundaryCondition("supersonicInlet", Variable.Pressure, (X, t) => 17.85714286); \
 \
		c.AddBoundaryCondition("isothermalWall", Variable.Temperature, (X, t) => 17.85714286); \
		c.AddBoundaryCondition("isothermalWall"); \
		c.LevelSetBoundaryTag = "isothermalWall"; \
 \
		c.Queries.Add("L2ErrorEntropy", IBMQueries.L2Error(state => state.Entropy, (X, t) => 1.0));  \
		c.Queries.Add("LiftForce", IBMQueries.IBMLiftForce());  \
		c.Queries.Add("DragForce", IBMQueries.IBMDragForce());  \
 \
		c.MomentFittingVariant = XQuadFactoryHelper.MomentFittingVariants.Classic; \
 \
		c.SurfaceHMF_ProjectNodesToLevelSet = false; \
		c.SurfaceHMF_RestrictNodes = true; \
		c.SurfaceHMF_UseGaussNodes = false; \
		c.VolumeHMF_NodeCountSafetyFactor = 2.0; \
		c.VolumeHMF_RestrictNodes = true; \
		c.VolumeHMF_UseGaussNodes = false; \
		c.LevelSetQuadratureOrder = levelSetQuadratureOrder; \
		c.AgglomerationThreshold = agglomerationThreshold; \
 \
		c.dtMin = 0.0; \
		c.dtMax = 1.0; \
		c.CFLFraction = 0.01; \
		c.Endtime = double.MaxValue; \
		c.NoOfTimesteps = int.MaxValue; \
 \
		c.saveperiod = 1000; \
		c.PrintInterval = 1000; \
 \
		c.ResidualInterval = 1000; \
		c.ResidualLoggerType = ResidualLoggerTypes.ChangeRate | ResidualLoggerTypes.Query; \
		c.ResidualBasedTerminationCriteria.Add("query_L2ErrorEntropy_change", 1e-12); \
		c.ProjectName += String.Format(" case {0}, Degree {1}, NoCells {2}, Re {3}", i, dgDegree, numberOfCells, reynolds[k]); \
		\
		c.Paramstudy_ContinueOnError = true; \
		c.Paramstudy_CaseIdentification = new Tuple<string, object>[] { \
			new Tuple<string, object>("Reynolds", reynolds[k]), \
			new Tuple<string, object>("numberOfCellsPerDirection", numberOfCells) \
		}; \
		controls.Add(c); \
		i++; \
	} \
}

controls.ToArray();