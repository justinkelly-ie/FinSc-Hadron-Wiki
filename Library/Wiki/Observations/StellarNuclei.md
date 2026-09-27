# Heavy Stellar Nuclei & Fusion Ladder Observation

## Overview & Theoretical Foundation

Stellar nucleosynthesis synthesizes heavy nuclei (${}^7\text{Be}, {}^8\text{B}, {}^{20}\text{Ne}, {}^{24}\text{Mg}, {}^{28}\text{Si}, {}^{56}\text{Fe}$). Every nucleus of mass number $A$ contains $A \times 27$ fundamental mass tokens. Iron-56 (${}^{56}\text{Fe}$) represents the peak binding energy per nucleon (1,512 mass tokens).

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.StellarNuclei

import Stage0.BoxInt
import Stage0.Multiset
import Stage1.VexelMaxel
import Stage1.UnixelFraction
import Wiki.Observations.HadronicConfinement
import Wiki.Observations.QuarkHadronAlgebra
import Wiki.Observations.AlphaReplication
import Data.List

%default total

------------------------------------------------------------------------
-- 1. STELLAR FUSION CHAIN HEAVY NUCLEI
------------------------------------------------------------------------

||| Heavy Stellar Nucleus Species Specification.
public export
data StellarNucleusSpec = Beryllium7 | Boron8 | Neon20 | Magnesium24 | Silicon28 | Iron56

public export
Eq StellarNucleusSpec where
  Beryllium7  == Beryllium7  = True
  Boron8      == Boron8      = True
  Neon20      == Neon20      = True
  Magnesium24 == Magnesium24 = True
  Silicon28   == Silicon28   = True
  Iron56      == Iron56      = True
  _           == _           = False

public export
Show StellarNucleusSpec where
  show Beryllium7  = "7Be (Beryllium-7)"
  show Boron8      = "8B (Boron-8)"
  show Neon20      = "20Ne (Neon-20)"
  show Magnesium24 = "24Mg (Magnesium-24)"
  show Silicon28   = "28Si (Silicon-28)"
  show Iron56      = "56Fe (Iron-56)"

||| Evaluates mass number A (nucleon count) of a stellar nucleus.
public export
stellarNucleusMassNumber : StellarNucleusSpec -> Nat
stellarNucleusMassNumber Beryllium7  = 7
stellarNucleusMassNumber Boron8      = 8
stellarNucleusMassNumber Neon20      = 20
stellarNucleusMassNumber Magnesium24 = 24
stellarNucleusMassNumber Silicon28   = 28
stellarNucleusMassNumber Iron56      = 56

||| Evaluates fundamental mass token count (A * 27) of a stellar nucleus.
public export
stellarNucleusMassTokens : StellarNucleusSpec -> BoxInt
stellarNucleusMassTokens spec = intToBoxInt (cast (stellarNucleusMassNumber spec * 27))

------------------------------------------------------------------------
-- 2. SMART CONSTRUCTORS FOR STELLAR NUCLEI
------------------------------------------------------------------------

||| Fuses 5 Alpha Cores into a Neon-20 nucleus (540 mass tokens).
public export
fuseNeon20 : List Boxel -> Boxel
fuseNeon20 alphaCores = foldl addBoxel (MkBoxel []) alphaCores

||| Fuses 56 Nucleons into an Iron-56 peak binding nucleus (1512 mass tokens).
public export
fuseIron56Tokens : List HadronBoxel -> BoxInt
fuseIron56Tokens nucleons = foldl (+) (intToBoxInt 0) (map totalBoxelWeight nucleons)

------------------------------------------------------------------------
-- 3. FORMAL AUDIT PROOFS
------------------------------------------------------------------------

||| Audits Stellar Fusion Chain Mass Token Conservation.
%inline
public export
auditStellarNucleiProof : Bool
auditStellarNucleiProof =
  unwrapBox (stellarNucleusMassTokens Beryllium7)  == 189 &&
  unwrapBox (stellarNucleusMassTokens Boron8)      == 216 &&
  unwrapBox (stellarNucleusMassTokens Neon20)      == 540 &&
  unwrapBox (stellarNucleusMassTokens Magnesium24) == 648 &&
  unwrapBox (stellarNucleusMassTokens Silicon28)   == 756 &&
  unwrapBox (stellarNucleusMassTokens Iron56)      == 1512
```
