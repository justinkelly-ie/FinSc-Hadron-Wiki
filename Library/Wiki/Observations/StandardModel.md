# Standard Model Particle Catalog & Discrete Interaction Vertices Observation

## Overview & Theoretical Foundation

The Standard Model of particle physics categorizes fundamental constituents into 12 Fermions (6 Quarks, 6 Leptons) and their antiparticles, alongside 13 Gauge Bosons and the Higgs scalar (37 discrete states total). Discrete metrology defines exact fractional electric charges in units of $e/3$, and vertex interaction operators govern QED pair annihilation ($e^+ e^- \to \gamma \gamma$), weak beta decay ($d \to u + e^- + \bar{\nu}_e$), and Higgs vector fusion ($H^0 \to W^+ W^-$).

---

## Executable Literate Idris2 Observation Code

```idris
module Wiki.Observations.StandardModel

import Language.Reflection
import Stage0.BoxInt
import Stage0.Multiset
import Stage1.UnixelFraction
import Data.List

%default total

------------------------------------------------------------------------
-- 1. FULL STANDARD MODEL PARTICLE ENUMERATIONS (37 STATES)
------------------------------------------------------------------------

||| Standard Model Fermions (12 Quarks/Leptons + 12 Anti-Fermions).
public export
data SMFermion =
    QuarkU | QuarkD | QuarkC | QuarkS | QuarkT | QuarkB
  | AntiQuarkU | AntiQuarkD | AntiQuarkC | AntiQuarkS | AntiQuarkT | AntiQuarkB
  | LepE | LepMu | LepTau | LepNuE | LepNuMu | LepNuTau
  | AntiLepE | AntiLepMu | AntiLepTau | AntiLepNuE | AntiLepNuMu | AntiLepNuTau

public export
Eq SMFermion where
  QuarkU == QuarkU = True
  QuarkD == QuarkD = True
  QuarkC == QuarkC = True
  QuarkS == QuarkS = True
  QuarkT == QuarkT = True
  QuarkB == QuarkB = True
  AntiQuarkU == AntiQuarkU = True
  AntiQuarkD == AntiQuarkD = True
  AntiQuarkC == AntiQuarkC = True
  AntiQuarkS == AntiQuarkS = True
  AntiQuarkT == AntiQuarkT = True
  AntiQuarkB == AntiQuarkB = True
  LepE == LepE = True
  LepMu == LepMu = True
  LepTau == LepTau = True
  LepNuE == LepNuE = True
  LepNuMu == LepNuMu = True
  LepNuTau == LepNuTau = True
  AntiLepE == AntiLepE = True
  AntiLepMu == AntiLepMu = True
  AntiLepTau == AntiLepTau = True
  AntiLepNuE == AntiLepNuE = True
  AntiLepNuMu == AntiLepNuMu = True
  AntiLepNuTau == AntiLepNuTau = True
  _ == _ = False

public export
Show SMFermion where
  show QuarkU = "u"
  show QuarkD = "d"
  show QuarkC = "c"
  show QuarkS = "s"
  show QuarkT = "t"
  show QuarkB = "b"
  show AntiQuarkU = "u_bar"
  show AntiQuarkD = "d_bar"
  show AntiQuarkC = "c_bar"
  show AntiQuarkS = "s_bar"
  show AntiQuarkT = "t_bar"
  show AntiQuarkB = "b_bar"
  show LepE = "e"
  show LepMu = "mu"
  show LepTau = "tau"
  show LepNuE = "nu_e"
  show LepNuMu = "nu_mu"
  show LepNuTau = "nu_tau"
  show AntiLepE = "e_bar"
  show AntiLepMu = "mu_bar"
  show AntiLepTau = "tau_bar"
  show AntiLepNuE = "nu_e_bar"
  show AntiLepNuMu = "nu_mu_bar"
  show AntiLepNuTau = "nu_tau_bar"

||| Standard Model Gauge Bosons & Higgs (13 Boson states).
public export
data SMBoson =
    GluonR | GluonG | GluonB | GluonBarR | GluonBarG | GluonBarB | GluonOctet
  | Photon | Z0 | WPlus | WMinus
  | Higgs0 | HiggsCharged

public export
Eq SMBoson where
  GluonR == GluonR = True
  GluonG == GluonG = True
  GluonB == GluonB = True
  GluonBarR == GluonBarR = True
  GluonBarG == GluonBarG = True
  GluonBarB == GluonBarB = True
  GluonOctet == GluonOctet = True
  Photon == Photon = True
  Z0 == Z0 = True
  WPlus == WPlus = True
  WMinus == WMinus = True
  Higgs0 == Higgs0 = True
  HiggsCharged == HiggsCharged = True
  _ == _ = False

public export
Show SMBoson where
  show GluonR = "g_R"
  show GluonG = "g_G"
  show GluonB = "g_B"
  show GluonBarR = "g_R_bar"
  show GluonBarG = "g_G_bar"
  show GluonBarB = "g_B_bar"
  show GluonOctet = "g_8"
  show Photon = "gamma"
  show Z0 = "Z0"
  show WPlus = "W+"
  show WMinus = "W-"
  show Higgs0 = "H0"
  show HiggsCharged = "H+"

||| Unified Standard Model State (37 States Total).
public export
data StandardModelParticle =
    SMPFermion SMFermion
  | SMPBoson   SMBoson

public export
Eq StandardModelParticle where
  (SMPFermion f1) == (SMPFermion f2) = f1 == f2
  (SMPBoson b1)   == (SMPBoson b2)   = b1 == b2
  _               == _               = False

public export
Show StandardModelParticle where
  show (SMPFermion f) = show f
  show (SMPBoson b)   = show b

------------------------------------------------------------------------
-- 2. DISCRETE CHARGE & SPIN METROLOGY
------------------------------------------------------------------------

||| Returns the exact electrical charge (in 1/3 e units) of any Standard Model particle.
public export
electricChargeThirds : StandardModelParticle -> BoxInt
electricChargeThirds (SMPFermion QuarkU) = intToBoxInt 2
electricChargeThirds (SMPFermion QuarkC) = intToBoxInt 2
electricChargeThirds (SMPFermion QuarkT) = intToBoxInt 2
electricChargeThirds (SMPFermion QuarkD) = intToBoxInt (-1)
electricChargeThirds (SMPFermion QuarkS) = intToBoxInt (-1)
electricChargeThirds (SMPFermion QuarkB) = intToBoxInt (-1)
electricChargeThirds (SMPFermion AntiQuarkU) = intToBoxInt (-2)
electricChargeThirds (SMPFermion AntiQuarkC) = intToBoxInt (-2)
electricChargeThirds (SMPFermion AntiQuarkT) = intToBoxInt (-2)
electricChargeThirds (SMPFermion AntiQuarkD) = intToBoxInt 1
electricChargeThirds (SMPFermion AntiQuarkS) = intToBoxInt 1
electricChargeThirds (SMPFermion AntiQuarkB) = intToBoxInt 1
electricChargeThirds (SMPFermion LepE)   = intToBoxInt (-3)
electricChargeThirds (SMPFermion LepMu)  = intToBoxInt (-3)
electricChargeThirds (SMPFermion LepTau) = intToBoxInt (-3)
electricChargeThirds (SMPFermion AntiLepE)   = intToBoxInt 3
electricChargeThirds (SMPFermion AntiLepMu)  = intToBoxInt 3
electricChargeThirds (SMPFermion AntiLepTau) = intToBoxInt 3
electricChargeThirds (SMPBoson WPlus)  = intToBoxInt 3
electricChargeThirds (SMPBoson WMinus) = intToBoxInt (-3)
electricChargeThirds _ = intToBoxInt 0

||| Identifies whether a particle is a Up-type Quark (+2/3 e).
public export
isUpQuark : StandardModelParticle -> Bool
isUpQuark (SMPFermion QuarkU) = True
isUpQuark (SMPFermion QuarkC) = True
isUpQuark (SMPFermion QuarkT) = True
isUpQuark _                   = False

||| Identifies whether a particle is a Lepton.
public export
isLepton : StandardModelParticle -> Bool
isLepton (SMPFermion LepE)      = True
isLepton (SMPFermion LepMu)     = True
isLepton (SMPFermion LepTau)    = True
isLepton (SMPFermion LepNuE)    = True
isLepton (SMPFermion LepNuMu)   = True
isLepton (SMPFermion LepNuTau)  = True
isLepton _                      = False

------------------------------------------------------------------------
-- 3. STANDARD MODEL GAUGE INTERACTION VERTICES
------------------------------------------------------------------------

||| QED Annihilation Vertex: e⁻ + e⁺ -> γ + γ
public export
qedAnnihilationVertex : StandardModelParticle -> StandardModelParticle -> List StandardModelParticle
qedAnnihilationVertex (SMPFermion LepE) (SMPFermion AntiLepE) = [SMPBoson Photon, SMPBoson Photon]
qedAnnihilationVertex _ _ = []

||| Weak Interaction Beta Decay Vertex: d -> u + e⁻ + ν̄_e
public export
weakBetaDecayVertex : StandardModelParticle -> List StandardModelParticle
weakBetaDecayVertex (SMPFermion QuarkD) = [SMPFermion QuarkU, SMPFermion LepE, SMPFermion AntiLepNuE]
weakBetaDecayVertex _ = []

||| Higgs Gauge Boson Decay Vertex: H -> W⁺ + W⁻
public export
higgsGaugeDecayVertex : StandardModelParticle -> List StandardModelParticle
higgsGaugeDecayVertex (SMPBoson Higgs0) = [SMPBoson WPlus, SMPBoson WMinus]
higgsGaugeDecayVertex _ = []

------------------------------------------------------------------------
-- 4. FORMAL INVARIANT AUDIT WITNESSES
------------------------------------------------------------------------

||| Audits the Standard Model Particle Catalog & Interaction Vertices.
public export
auditFullStandardModelCatalogProof : Bool
auditFullStandardModelCatalogProof =
  (isUpQuark (SMPFermion QuarkU) == True) &&
  (isLepton (SMPFermion LepE) == True) &&
  (qedAnnihilationVertex (SMPFermion LepE) (SMPFermion AntiLepE) == [SMPBoson Photon, SMPBoson Photon]) &&
  (weakBetaDecayVertex (SMPFermion QuarkD) == [SMPFermion QuarkU, SMPFermion LepE, SMPFermion AntiLepNuE]) &&
  (higgsGaugeDecayVertex (SMPBoson Higgs0) == [SMPBoson WPlus, SMPBoson WMinus])

export
%macro
auditStandardModelCatalog : Elab (Wiki.Observations.StandardModel.auditFullStandardModelCatalogProof = True)
auditStandardModelCatalog = pure Refl
```
