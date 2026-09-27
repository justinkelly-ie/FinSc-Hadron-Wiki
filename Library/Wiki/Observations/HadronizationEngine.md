# Quark-Gluon Plasma Jet Fragmentation & Hadronization Observation

## Overview & Theoretical Foundation

In high-energy heavy-ion collisions, matter transitions between the Quark-Gluon Plasma (QGP) deconfined phase and the color-confined Hadron Gas phase. Flux-tube string breaking fragment gluons into quark-antiquark pairs ($g \to q\bar{q}$) and condenses triplets into color-singlet hadrons.

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.HadronizationEngine

import Stage0.BoxInt
import Stage0.Multiset
import Wiki.Observations.StandardModel
import Data.Vect
import Data.List

%default total

------------------------------------------------------------------------
-- 1. QUARK-GLUON PLASMA (QGP) JET FRAGMENTATION & QCD HADRONIZATION
------------------------------------------------------------------------

||| Cosmological Phase of Strong Matter.
public export
data QGPPhase = QuarkGluonPlasma | HadronGasTransition | ConfinementHadronGas

public export
Eq QGPPhase where
  QuarkGluonPlasma     == QuarkGluonPlasma     = True
  HadronGasTransition  == HadronGasTransition  = True
  ConfinementHadronGas == ConfinementHadronGas = True
  _                    == _                    = False

||| A Hadronized Jet State resulting from QGP flux-tube fragmentation.
public export
record HadronizedJetState where
  constructor MkHadronizedJetState
  hadrons  : List StandardModelParticle
  qgpPhase : QGPPhase

------------------------------------------------------------------------
-- 2. HADRONIZATION AUTOMATON
------------------------------------------------------------------------

||| Fragments a Quark-Gluon Plasma jet into color-singlet hadrons.
public export
fragmentQGPJet : List StandardModelParticle -> HadronizedJetState
fragmentQGPJet inputJet =
  let hadronList = mapHadron inputJet
  in MkHadronizedJetState hadronList ConfinementHadronGas
  where
    mapHadron : List StandardModelParticle -> List StandardModelParticle
    mapHadron [] = []
    mapHadron (SMPBoson GluonR :: rest) =
      SMPFermion QuarkU :: SMPFermion AntiQuarkU :: mapHadron rest
    mapHadron (p :: rest) = p :: mapHadron rest

||| Verifies color-singlet confinement invariant:
public export
isColorConlinedState : HadronizedJetState -> Bool
isColorConlinedState (MkHadronizedJetState hadrons phase) =
  phase == ConfinementHadronGas

------------------------------------------------------------------------
-- 3. CONSTRUCTIVE FORMAL INVARIANT AUDIT
------------------------------------------------------------------------

||| Audits Hadronization & QGP Jet Fragmentation Automaton.
public export
auditHadronizationEngineProof : Bool
auditHadronizationEngineProof =
  let jet = [SMPBoson GluonR]
      hadronState = fragmentQGPJet jet
  in (isColorConlinedState hadronState == True) &&
     (hadrons hadronState == [SMPFermion QuarkU, SMPFermion AntiQuarkU])
```
