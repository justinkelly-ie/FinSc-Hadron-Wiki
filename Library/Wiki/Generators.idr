module Wiki.Generators

import public QuickCheck
import Core
import Wiki.Observations.HadronicConfinement
import Wiki.Observations.StandardModel

%default total

public export
natToColorCharge : Nat -> Wiki.Observations.HadronicConfinement.ColorCharge
natToColorCharge Z = RedColor
natToColorCharge (S Z) = GreenColor
natToColorCharge (S (S _)) = BlueColor

public export
Arbitrary Wiki.Observations.HadronicConfinement.ColorCharge where
  arbitrary = map natToColorCharge arbitrary

  coarbitrary RedColor gen   = coarbitrary (the Nat 0) gen
  coarbitrary GreenColor gen = coarbitrary (the Nat 1) gen
  coarbitrary BlueColor gen  = coarbitrary (the Nat 2) gen

public export
natToFermion : Nat -> Wiki.Observations.StandardModel.SMFermion
natToFermion Z = QuarkU
natToFermion (S Z) = QuarkD
natToFermion (S (S Z)) = QuarkC
natToFermion (S (S (S Z))) = QuarkS
natToFermion (S (S (S (S Z)))) = QuarkT
natToFermion (S (S (S (S (S Z))))) = QuarkB
natToFermion (S (S (S (S (S (S Z)))))) = AntiQuarkU
natToFermion (S (S (S (S (S (S (S Z))))))) = AntiQuarkD
natToFermion (S (S (S (S (S (S (S (S Z)))))))) = LepE
natToFermion (S (S (S (S (S (S (S (S (S Z))))))))) = LepNuE
natToFermion (S (S (S (S (S (S (S (S (S (S _)))))))))) = AntiLepE

public export
Arbitrary Wiki.Observations.StandardModel.SMFermion where
  arbitrary = map natToFermion arbitrary

  coarbitrary f gen = coarbitrary (the Nat 0) gen

public export
natToBoson : Nat -> Wiki.Observations.StandardModel.SMBoson
natToBoson Z = Photon
natToBoson (S Z) = WPlus
natToBoson (S (S Z)) = WMinus
natToBoson (S (S (S Z))) = Z0
natToBoson (S (S (S (S _)))) = Higgs0

public export
Arbitrary Wiki.Observations.StandardModel.SMBoson where
  arbitrary = map natToBoson arbitrary

  coarbitrary b gen = coarbitrary (the Nat 0) gen

public export
Arbitrary Wiki.Observations.StandardModel.StandardModelParticle where
  arbitrary = do
    b <- arbitrary {a = Bool}
    if b then map SMPFermion arbitrary else map SMPBoson arbitrary

  coarbitrary (SMPFermion f) gen = coarbitrary f gen
  coarbitrary (SMPBoson b) gen   = coarbitrary b gen
