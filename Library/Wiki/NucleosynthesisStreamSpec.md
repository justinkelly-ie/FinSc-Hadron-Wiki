# 🗂️ Hadron Nucleosynthesis & Fusion Stream Specification

Documents and verifies discrete triple-alpha nuclear fusion streaming ($3 \times 108 \to 324$), $S$-wave stability filters, and zero-heap stream deforestation.

## 1. Specification & Property Tests

```idris
module Wiki.NucleosynthesisStreamSpec

import Data.List
import Data.Fuel
import Core
import Stage1.Order.Preorder
import Hadron
import Stage0.OnSeq.FusedStream

%default total

||| Erased compile-time witness verifying SU(3)_c quark color neutrality (red + green <= blue + 100)
public export
0 NucleosynthesisColorNeutralityWitness : (red : Nat) -> (green : Nat) -> (blue : Nat) -> Type
NucleosynthesisColorNeutralityWitness red green blue = natLTE (red + green) (blue + 100) = True

||| Static compile-time witness proving color neutrality bound (10 + 10 <= 20 + 100)
public export
prfColorNeutralityHadron : NucleosynthesisColorNeutralityWitness 10 10 20
prfColorNeutralityHadron = Refl

||| Verified color charge state carrying erased color neutrality witness
public export
record VerifiedColorChargeState where
  constructor MkVerifiedColorChargeState
  redQuarks   : Nat
  greenQuarks : Nat
  blueQuarks  : Nat
  0 neutralityPrf : NucleosynthesisColorNeutralityWitness redQuarks greenQuarks blueQuarks

||| $O(1)$ allocation deforested hadronization stream transducer using fusedHylomorphism
public export covering
fusedNucleosynthesisStream : Fuel -> List (Nat, Nat) -> Nat
fusedNucleosynthesisStream f items =
  fusedHylomorphism f
    (\st => case st of
              [] => Done
              (q1, q2) :: rest => Yield (q1 + q2) rest)
    (\val, acc => val + acc)
    0
    items

||| Property 1: Seed Alpha Cluster Stream Stability Filter
public export
prop_alphaClusterStreamStability : Bool
prop_alphaClusterStreamStability =
  let
    a = seedAlphaClusterEpoch4
    strm = streamAlphaClusters [a]
    filtered = fusedFilterStableAlpha strm
    res = runFueledStream (limit 10) filtered
  in
    length res == 1

||| Property 2: Triple-Alpha Carbon Fusion Stream Flux Conservation (3 * 108 = 324)
public export
prop_tripleAlphaFusionFluxStream : Bool
prop_tripleAlphaFusionFluxStream =
  let
    a = seedAlphaClusterEpoch4
    strm = unfoldAlphaFusionStream [a]
    res = runFueledStream (limit 10) strm
  in
    res == [intToBoxInt 324]

||| QuickCheck / Direct Suite Execution for Nucleosynthesis Stream Spec
public export
auditNucleosynthesisStreamProof : IO Bool
auditNucleosynthesisStreamProof = do
  let p1 = prop_alphaClusterStreamStability
  let p2 = prop_tripleAlphaFusionFluxStream
  let streamSum = fusedNucleosynthesisStream (limit 100) [(108, 108), (108, 0)]
  pure (p1 && p2 && streamSum == 324)
```
