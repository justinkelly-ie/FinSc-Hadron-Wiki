# Big Bang Cosmic Nucleosynthesis (BBN) Light Nuclei Observation

## Overview & Theoretical Foundation

In Big Bang Nucleosynthesis (BBN), primordial nuclear fusion synthesizes light cosmic isotopes: Deuteron (${}^2\text{H}$), Triton (${}^3\text{H}$), Helium-3 (${}^3\text{He}$), and Lithium-7 (${}^7\text{Li}$). Rather than using hardcoded constants or heuristic ratios, constructivist physics grounds all light nuclei into certified dependent `Nuclide z n` records (Rule 03 §8).

Furthermore, the cosmic reactor is modeled as a **deforested single-pass stream transducer** (`streamBBNReactor`):
1. **Freeze-out Feed**: Primordial nucleons enter with the thermal freeze-out ratio $n/p = 1/7$, represented by 2 neutrons and 14 protons (total 16 nucleons).
2. **Deuteron Bottleneck**: Neutrons and protons bind into deuterons ($p + n \to d$).
3. **Helium-4 Synthesis**: Pairs of deuterons fuse into alpha particles ($2d \to {}^4\text{He}$).
4. **Observable Reduction**: From the initial 16 nucleons, $2n + 2p$ fuse into 1 ${}^4\text{He}$ core (4 nucleons), while $14 - 2 = 12$ protons remain unreacted. The primordial Helium-4 mass fraction $Y_p$ is observed directly as an exact multiset reduction:
   $$Y_p = \frac{\text{Nucleons in } {}^4\text{He}}{\text{Total Streamed Nucleons}} = \frac{4}{16} = \frac{1}{4} = 0.25$$
   which falls strictly within the PDG / Planck 2018 empirical bounds $[0.24, 0.26]$.

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.CosmicNucleosynthesis

import Stage0.BoxInt
import Stage0.Multiset
import Stage0.OnSeq.FusedStream
import Stage1.Basis.Coordinate
import Stage1.UnixelFraction
import public Stage0.Hadron.CosmicNucleosynthesis
import Stage0.Hadron.StellarNucleosynthesis
import Wiki.Observations.HadronicConfinement
import Wiki.Observations.QuarkHadronAlgebra
import Data.List

%default total

------------------------------------------------------------------------
-- 1. OBSERVABLE REDUCTION OVER DEFORESTED BBN REACTOR STREAM
------------------------------------------------------------------------

||| Evaluates the BBN reactor trajectory across all 16 freeze-out feed steps.
public export
bbnReactorTrajectory : List BBNReactionStep
bbnReactorTrajectory = runFueledStreamNat 32 (streamBBNReactor (stream primordialFreezeOutFeed))

||| Audits that all 16 reaction steps preserve strict nucleon conservation:
||| freeProtons + freeNeutrons + 2*deuterons + 4*he4 == totalNucleons.
public export
auditBBNStreamNucleonConservationProofWiki : Bool
auditBBNStreamNucleonConservationProofWiki =
  all stepNucleonConservation bbnReactorTrajectory && (length bbnReactorTrajectory == 16)

||| Audits that the observed primordial Helium-4 mass fraction Y_p = 4/16 = 25%
||| matches the PDG Planck empirical confidence interval [0.24, 0.26].
public export
auditBBNStreamHeliumFractionProofWiki : Bool
auditBBNStreamHeliumFractionProofWiki =
  case lastBBNStep bbnReactorTrajectory of
    Just finalStep =>
      let yp = finalStep.observedHeliumYp
      in rationalEquiv yp (mkUnixelFraction (intToBoxInt 1) 4) &&
         rationalGTE yp pdgHelium4LowerBound &&
         rationalLTE yp pdgHelium4UpperBound &&
         (finalStep.freeProtons == 12) &&
         (finalStep.freeNeutrons == 0) &&
         (finalStep.helium4Count == 1) &&
         (finalStep.totalNucleons == 16)
    Nothing => False

------------------------------------------------------------------------
-- 2. FORMAL INVARIANT AUDIT PROOFS (LIGHT NUCLIDE CARRIERS)
------------------------------------------------------------------------

||| Audits BBN Mass Token Conservation observed from constituent hadrons:
||| 1. Deuteron 2H = 2 * 27 = 54 tokens.
||| 2. Triton 3H = 3 * 27 = 81 tokens.
||| 3. Helium-3 = 3 * 27 = 81 tokens.
||| 4. Lithium-7 = 7 * 27 = 189 tokens.
public export
auditCosmicNucleosynthesisProof : Bool
auditCosmicNucleosynthesisProof =
  (unwrapBox (nucleusMassTokens Deuteron2H) == 54) &&
  (unwrapBox (nucleusMassTokens Triton3H)   == 81) &&
  (unwrapBox (nucleusMassTokens Helium3He)  == 81) &&
  (unwrapBox (nucleusMassTokens Lithium7Li) == 189) &&
  auditBBNStreamNucleonConservationProofWiki &&
  auditBBNStreamHeliumFractionProofWiki
```
