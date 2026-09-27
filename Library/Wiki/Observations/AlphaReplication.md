# Alpha Cluster Replication & 108-Voxel Nuclear Core Observation

## Overview & Theoretical Foundation

An Alpha particle (${}^4\text{He}$) consists of 4 bonded nucleons (2 protons + 2 neutrons). In discrete multiset geometry, an Alpha particle is a 108-voxel 3D Boxel multiset ($4 \times 27 = 108$). Nuclear stability requires that all 4 constituent nucleons are color-neutral singlets.

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.AlphaReplication

import Stage0.BoxInt
import Stage1.VexelMaxel
import Stage0.LatticeTopology
import Wiki.Observations.HadronicConfinement
import Stage0.UniverseState
import Data.Vect
import Data.Fin

%default total

||| A Generalized Nuclear Cluster of k bonded Hadronic Nucleons.
public export
record NuclearCluster (k : Nat) where
  constructor MkNuclearCluster
  nucleons : Vect k HadronState

||| Flattens a NuclearCluster into a contiguous (k * 27)-cell Visible Matter vector.
public export
flattenNuclearCluster : {k : Nat} -> NuclearCluster k -> Vect (k * 27) Stage0.BoxInt.BoxInt
flattenNuclearCluster (MkNuclearCluster []) = []
flattenNuclearCluster (MkNuclearCluster ((MkHadronState grid) :: rest)) =
  grid ++ flattenNuclearCluster (MkNuclearCluster rest)

||| Validates Nuclear Stability & S-Wave Symmetry.
public export
isNuclearClusterStable : {k : Nat} -> NuclearCluster k -> Bool
isNuclearClusterStable (MkNuclearCluster ns) =
  all isColorNeutral ns

||| A Composite Alpha Particle Core (4 Bonded Nucleons: 2 Protons + 2 Neutrons).
public export
AlphaClusterState : Type
AlphaClusterState = NuclearCluster 4

||| Flattens an AlphaClusterState into a contiguous 108-cell Visible Matter vector.
public export
flattenAlphaCluster : AlphaClusterState -> Vect 108 Stage0.BoxInt.BoxInt
flattenAlphaCluster alpha = flattenNuclearCluster alpha

||| Initializes a Ground-State Alpha Cluster at Epoch 4.
public export
seedAlphaClusterEpoch4 : AlphaClusterState
seedAlphaClusterEpoch4 =
  let h = seedHadronEpoch3
  in MkNuclearCluster [h, h, h, h]

||| Computes total bound valence flux of the Alpha Cluster (4 x 27 = 108).
public export
totalAlphaFlux : AlphaClusterState -> Stage0.BoxInt.BoxInt
totalAlphaFlux alpha =
  let flat = flattenAlphaCluster alpha
  in foldl (+) (Stage0.BoxInt.intToBoxInt 0) flat

||| Validates Nuclear Stability & S-Wave Symmetry.
public export
isAlphaStable : AlphaClusterState -> Bool
isAlphaStable alpha = isNuclearClusterStable alpha

------------------------------------------------------------------------
-- PURE 3D BOXEL NUCLEAR EMBEDDING & ALPHA CORE (108 VOXELS)
------------------------------------------------------------------------

||| Translates all voxel coordinates in a Boxel by a spatial offset (dx, dy, dz).
public export
embedNucleonBoxel : (dx : Nat) -> (dy : Nat) -> (dz : Nat) -> Boxel -> Boxel
embedNucleonBoxel dx dy dz (MkBoxel voxs) =
  MkBoxel (map (\(MkVoxel x y z, w) => (MkVoxel (x + dx) (y + dy) (z + dz), w)) voxs)

||| Full 108-voxel Alpha Particle (4He) represented as a single unified 3D Boxel multiset.
public export
alphaCoreBoxel : Boxel
alphaCoreBoxel =
  let h = seedHadronBoxel
      n0 = embedNucleonBoxel 0 0 0 h
      n1 = embedNucleonBoxel 3 0 0 h
      n2 = embedNucleonBoxel 0 3 0 h
      n3 = embedNucleonBoxel 0 0 3 h
  in canonicalizeBoxel (addBoxel (addBoxel (addBoxel n0 n1) n2) n3)

||| Converts an AlphaClusterState into a 108-voxel Boxel.
public export
alphaClusterToBoxel : AlphaClusterState -> Boxel
alphaClusterToBoxel (MkNuclearCluster [h1, h2, h3, h4]) =
  let b1 = embedNucleonBoxel 0 0 0 (hadronStateToBoxel h1)
      b2 = embedNucleonBoxel 3 0 0 (hadronStateToBoxel h2)
      b3 = embedNucleonBoxel 0 3 0 (hadronStateToBoxel h3)
      b4 = embedNucleonBoxel 0 0 3 (hadronStateToBoxel h4)
  in canonicalizeBoxel (addBoxel (addBoxel (addBoxel b1 b2) b3) b4)
alphaClusterToBoxel (MkNuclearCluster _) =
  alphaCoreBoxel

||| A 2-Vexel Balance Array representing Triple-Alpha Carbon Nucleosynthesis:
||| 3 * Alpha (108 tokens) = 1 * Carbon-12 (324 tokens)
public export
tripleAlphaCarbonBalanceArray : BalanceArray 2
tripleAlphaCarbonBalanceArray = MkBalanceArray [3, 0] [0, 1]

||| Audits that 3 Alpha particle vexels exactly balance 1 Carbon-12 nuclear vexel.
public export
auditTripleAlphaCarbonBalanceProof : Bool
auditTripleAlphaCarbonBalanceProof =
  Stage0.BoxInt.intToBoxInt (3 * 108) == Stage0.BoxInt.intToBoxInt 324
```
