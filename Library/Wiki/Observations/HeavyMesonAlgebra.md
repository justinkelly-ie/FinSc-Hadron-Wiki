# Heavy Meson & Quarkonium Algebra Observation

## Overview & Theoretical Foundation

Heavy Mesons and Quarkonium states ($c\bar{c}$ Charmonium and $b\bar{b}$ Upsilon Bottomonium) represent heavy-flavor 2-quark bound states. Each heavy meson multiset carries 18 mass tokens ($9 + 9 = 18$) across color and anti-color sectors.

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.HeavyMesonAlgebra

import Stage0.BoxInt
import Stage0.Multiset
import Stage1.VexelMaxel
import Stage1.UnixelFraction
import Core
import Stage1.ExclusionPrinciple
import Wiki.Observations.TypeIndexedMultiset
import Wiki.Observations.MesonAlgebra
import Data.List

%default total

------------------------------------------------------------------------
-- 1. HEAVY MESON SPECIES SPECIFICATION
------------------------------------------------------------------------

||| Heavy Meson & Quarkonium Species Specification.
public export
data HeavyMesonSpec = JPsiCharmonium | UpsilonBottomonium 
                     | DPlus | DZero | DsPlus 
                     | BPlus | BZero | BsZero

public export
Eq HeavyMesonSpec where
  JPsiCharmonium     == JPsiCharmonium     = True
  UpsilonBottomonium == UpsilonBottomonium = True
  DPlus              == DPlus              = True
  DZero              == DZero              = True
  DsPlus             == DsPlus             = True
  BPlus              == BPlus              = True
  BZero              == BZero              = True
  BsZero             == BsZero             = True
  _                  == _                  = False

public export
Show HeavyMesonSpec where
  show JPsiCharmonium     = "J/psi (c c_bar)"
  show UpsilonBottomonium = "Upsilon (b b_bar)"
  show DPlus              = "D+ (c d_bar)"
  show DZero              = "D0 (c u_bar)"
  show DsPlus             = "Ds+ (c s_bar)"
  show BPlus              = "B+ (u b_bar)"
  show BZero              = "B0 (d b_bar)"
  show BsZero             = "Bs0 (s b_bar)"

------------------------------------------------------------------------
-- 2. SMART CONSTRUCTORS FOR HEAVY MESONS
------------------------------------------------------------------------

||| Constructs a J/psi Charmonium (c c_bar) 18-token Meson Vexel.
%inline
public export
makeJPsiCharmoniumVexel : MesonVexel
makeJPsiCharmoniumVexel =
  MkVexel [ (MkUnixel 4, MkBoxInt 9)   -- Charm Quark
          , (MkUnixel 4, MkBoxInt 9)   -- Anti-Charm Quark
          ]

||| Constructs a Upsilon Bottomonium (b b_bar) 18-token Meson Vexel.
%inline
public export
makeUpsilonBottomoniumVexel : MesonVexel
makeUpsilonBottomoniumVexel =
  MkVexel [ (MkUnixel 5, MkBoxInt 9)   -- Bottom Quark
          , (MkUnixel 5, MkBoxInt 9)   -- Anti-Bottom Quark
          ]

------------------------------------------------------------------------
-- 3. OBSERVATIONS & AUDIT
------------------------------------------------------------------------

||| Evaluates mass tokens of a Heavy Meson Vexel.
%inline
public export
observeHeavyMesonMassTokens : MesonVexel -> Stage0.BoxInt.BoxInt
observeHeavyMesonMassTokens (MkVexel [(u1, MkBoxInt w1), (u2, MkBoxInt w2)]) = MkBoxInt (w1 + w2)
observeHeavyMesonMassTokens m = totalVexelMass m

||| Audits Heavy Meson Mass Token Conservation.
%inline
public export
auditHeavyMesonAlgebraProof : Bool
auditHeavyMesonAlgebraProof =
  (unwrapBox (observeHeavyMesonMassTokens makeJPsiCharmoniumVexel) == 18) &&
  (unwrapBox (observeHeavyMesonMassTokens makeUpsilonBottomoniumVexel) == 18)
```
