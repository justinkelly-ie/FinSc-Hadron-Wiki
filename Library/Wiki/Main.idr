module Wiki.Main

import System
import Core
import NuclearMatter
import Language.Reflection
import Wiki.HadronScaleTransformSpec
import Wiki.NucleosynthesisStreamSpec
import Wiki.Observations.HadronicConfinement
import Wiki.Observations.StandardModel
import Wiki.Observations.QuarkHadronAlgebra
import Wiki.Observations.MesonAlgebra
import Wiki.Observations.HeavyMesonAlgebra
import Wiki.Observations.HyperonAlgebra
import Wiki.Observations.ExoticMultiquark
import Wiki.Observations.ParticleScattering
import Wiki.Observations.HadronizationEngine
import Wiki.Observations.TypeIndexedMultiset
import Wiki.Observations.GaugeBosons
import Wiki.Observations.StellarNuclei
import Wiki.Observations.StellarNucleosynthesis
import Wiki.Observations.CosmicNucleosynthesis
import Wiki.Observations.PlasmaRecombination
import Wiki.Observations.AlphaReplication
import Reflect.NuclearAuditor

%default total

||| Compile-time macro invariant witnesses (Rule 01)
0 prfAuditColorSingletNeutrality : Reflect.NuclearAuditor.auditColorSingletNeutralityProof = True
prfAuditColorSingletNeutrality = auditColorSingletNeutrality

0 prfAuditBaryonConfinementBound : Reflect.NuclearAuditor.auditBaryonConfinementBoundProof = True
prfAuditBaryonConfinementBound = auditBaryonConfinementBound

0 prfAuditTripleAlphaFusion : Reflect.NuclearAuditor.auditTripleAlphaFusionProof = True
prfAuditTripleAlphaFusion = auditTripleAlphaFusion

0 prfAuditNuclearReactionConservation : Reflect.NuclearAuditor.auditNuclearReactionConservationProofExport = True
prfAuditNuclearReactionConservation = auditNuclearReactionConservation

0 prfAuditNuclearBindingDepPoly : Reflect.NuclearAuditor.auditNuclearBindingDepPolyProofExport = True
prfAuditNuclearBindingDepPoly = auditNuclearBindingDepPoly

0 prfAuditGellMannOkuboDecuplet : Reflect.NuclearAuditor.auditGellMannOkuboDecupletProofExport = True
prfAuditGellMannOkuboDecuplet = auditGellMannOkuboDecuplet

0 prfHadron1 : (Wiki.Observations.StandardModel.auditFullStandardModelCatalogProof = True)
prfHadron1 = Refl

0 prfHadron2 : (Wiki.Observations.HadronicConfinement.auditHadronSingletBalanceProof = True)
prfHadron2 = Refl

0 prfHadron3 : (Wiki.Observations.TypeIndexedMultiset.auditTypeIndexedMultisetProof = True)
prfHadron3 = Refl

main : IO ()
main = do
  putStrLn "========================================================"
  putStrLn "  IDRIS 2 HARD HADRON ALGEBRA WIKI VERIFICATION SUITE"
  putStrLn "========================================================"
  putStrLn "0. Compile-Time Elaborator Reflection Audits (Rule 01):"
  putStrLn "   - Color-Singlet Neutrality (9+9+9 = 27): INJECTED & VALID (Refl) ✅"
  putStrLn "   - Baryon Confinement Bound (27 <= 54): INJECTED & VALID (Refl) ✅"
  putStrLn "   - Triple-Alpha Fusion (3*4 = 12): INJECTED & VALID (Refl) ✅"
  putStrLn "   - Universal Reaction Conservation (ΔB = 0, ΔQ = 0): INJECTED & VALID (Refl) ✅"
  putStrLn "   - Weizsäcker Liquid-Drop Coulomb & Asymmetry DepPoly: INJECTED & VALID (Refl) ✅"
  putStrLn "   - Gell-Mann–Okubo Hadron Mass Decuplet DepPoly: INJECTED & VALID (Refl) ✅"
  putStrLn ""
  putStrLn "1. Hadron Quark Multiset Confinement & Gauge Vertices:"
  if prop_standardModelCatalogValid && prop_hadronSingletBalanceValid &&
     Wiki.Observations.QuarkHadronAlgebra.auditQuarkHadronAlgebraProof &&
     Wiki.Observations.MesonAlgebra.auditMesonAlgebraProof &&
     Wiki.Observations.HeavyMesonAlgebra.auditHeavyMesonAlgebraProof &&
     Wiki.Observations.HyperonAlgebra.auditHyperonAlgebraProof &&
     Wiki.Observations.ExoticMultiquark.auditExoticMultiquarksProof &&
     Wiki.Observations.ParticleScattering.auditParticleScatteringProof &&
     Wiki.Observations.HadronizationEngine.auditHadronizationEngineProof &&
     Wiki.Observations.TypeIndexedMultiset.auditTypeIndexedMultisetProof &&
     Wiki.Observations.GaugeBosons.auditGaugeBosonProof &&
     Wiki.Observations.StellarNuclei.auditStellarNucleiProof &&
     Wiki.Observations.StellarNucleosynthesis.auditCompleteStellarFusionBalanceNetworkProof &&
     Wiki.Observations.CosmicNucleosynthesis.auditCosmicNucleosynthesisProof &&
     Wiki.Observations.PlasmaRecombination.auditPlasmaRecombinationDecouplingProof &&
     Wiki.Observations.AlphaReplication.auditTripleAlphaCarbonBalanceProof
     then putStrLn "   [PASSED] Hadron Confinement & All 16 Hadronic Suites Clean!"
     else do
       putStrLn "   [FAILED] Static Invariant Audits Failed!"
       exitWith (ExitFailure 1)
  putStrLn ""
  putStrLn "2. Hadron ScaleTransform (Coord2D -> BoxInt) QuickCheck Specs:"
  p <- auditHadronScaleTransformSpecProof
  if p
     then putStrLn "   [PASSED] Hadron ScaleTransform Verified!"
     else do
       putStrLn "   [FAILED] QuickCheck Specs Failed!"
       exitWith (ExitFailure 1)
  putStrLn "3. Deforested Triple-Alpha Fusion & Nucleosynthesis Stream Specs:"
  p3 <- auditNucleosynthesisStreamProof
  if p3
     then putStrLn "   [PASSED] Triple-Alpha Fusion Stream & Stability Verified!"
     else do
       putStrLn "   [FAILED] Nucleosynthesis Stream Specs Failed!"
       exitWith (ExitFailure 1)
  putStrLn "========================================================"
  putStrLn "  HADRON WIKI VERIFICATION COMPLETE: ALL PASSED!"
  putStrLn "========================================================"
