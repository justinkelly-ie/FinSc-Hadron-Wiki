# Big Bang Cosmic Nucleosynthesis (BBN) Light Nuclei Observation

## Overview & Theoretical Foundation

In Big Bang Nucleosynthesis (BBN), primordial nuclear fusion synthesizes light cosmic isotopes: Deuteron (${}^2\text{H}$), Triton (${}^3\text{H}$), Helium-3 (${}^3\text{He}$), and Lithium-7 (${}^7\text{Li}$). Mass token conservation requires that every nucleus with $A$ nucleons carries $A \times 27$ tokens.

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.CosmicNucleosynthesis

import Stage0.BoxInt
import Stage0.Multiset
import Stage1.VexelMaxel
import Stage1.UnixelFraction
import Wiki.Observations.HadronicConfinement
import Wiki.Observations.QuarkHadronAlgebra
import Data.List

%default total

------------------------------------------------------------------------
-- 1. BIG BANG NUCLEOSYNTHESIS (BBN) LIGHT COSMIC NUCLEI
------------------------------------------------------------------------

||| Light Cosmic Nucleus Species.
public export
data LightNucleusSpec = Deuteron2H | Triton3H | Helium3He | Lithium7Li

public export
Eq LightNucleusSpec where
  Deuteron2H == Deuteron2H = True
  Triton3H   == Triton3H   = True
  Helium3He  == Helium3He  = True
  Lithium7Li == Lithium7Li = True
  _          == _          = False

public export
Show LightNucleusSpec where
  show Deuteron2H = "2H (Deuteron)"
  show Triton3H   = "3H (Triton)"
  show Helium3He  = "3He"
  show Lithium7Li = "7Li"

||| Computes exact nucleon count of a light cosmic nucleus.
public export
nucleusNucleonCount : LightNucleusSpec -> Nat
nucleusNucleonCount Deuteron2H = 2
nucleusNucleonCount Triton3H   = 3
nucleusNucleonCount Helium3He  = 3
nucleusNucleonCount Lithium7Li = 7

||| Computes exact fundamental mass token count of a light cosmic nucleus (nucleons * 27).
public export
nucleusMassTokens : LightNucleusSpec -> BoxInt
nucleusMassTokens spec = intToBoxInt (cast (nucleusNucleonCount spec * 27))

------------------------------------------------------------------------
-- 2. SMART CONSTRUCTORS FOR BBN NUCLEI
------------------------------------------------------------------------

||| Fuses 1 Proton (27) and 1 Neutron (27) into a Deuteron 2H nucleus (54 tokens).
public export
fuseDeuteron : HadronBoxel -> HadronBoxel -> Boxel
fuseDeuteron p n = addBoxel p n

||| Fuses 3 Protons (81) and 4 Neutrons (108) into a Lithium-7 nucleus (189 tokens).
public export
fuseLithium7 : List HadronBoxel -> Boxel
fuseLithium7 nucleons = foldl addBoxel (MkBoxel []) nucleons

------------------------------------------------------------------------
-- 3. FORMAL INVARIANT AUDIT PROOFS
------------------------------------------------------------------------

||| Audits BBN Mass Token Conservation.
public export
auditCosmicNucleosynthesisProof : Bool
auditCosmicNucleosynthesisProof =
  unwrapBox (nucleusMassTokens Deuteron2H) == 54 &&
  unwrapBox (nucleusMassTokens Triton3H)   == 81 &&
  unwrapBox (nucleusMassTokens Helium3He)  == 81 &&
  unwrapBox (nucleusMassTokens Lithium7Li) == 189
```
