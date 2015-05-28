-- | Actor (or rather actor body trunk) definitions.
module Content.ItemKindActor ( actors ) where

import qualified Data.EnumMap.Strict as EM

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.Flavour
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.ItemKind

actors :: [ItemKind]
actors = privateers ++ merchants ++ forcesOfChaos ++ spawns ++ techCultists ++ animals

privateers, merchants, forcesOfChaos, spawns, techCultists, animals :: [ItemKind]

privateers    = [ warrior
                , scout ]
merchants     = [ merchant
                , merchantSgt
                , merchantLibrarian
                , guardianSpider ]
forcesOfChaos = [ chaosWarrior
                , chaosLord ]
techCultists  = [ priest
                , cultist]
spawns        = [ warpBeast ]
animals       = [ ventLizard ]

warrior, scout :: ItemKind
merchant, merchantSgt, merchantLibrarian, guardianSpider :: ItemKind
chaosWarrior, chaosLord :: ItemKind
priest, cultist :: ItemKind
warpBeast :: ItemKind
ventLizard :: ItemKind

-- * Heroes (hero)

warrior = ItemKind
  { isymbol  = '@'
  , iname    = "warrior"
  , ifreq    = [("hero", 100)]
  , iflavour = zipPlain [BrBlack]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 50, AddMaxCalm 60, AddSpeed 20
               , AddSight 3
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "PBI, ready to take the next city vessel."
  , ikit     = [  ("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan), ("sapient brain", COrgan)
                , ("starting weapon", CEqp), ("starting weapon", CEqp)]
  }

scout = warrior
  { iname    = "scout"
  , iaspects = [ AddMaxHP 40, AddMaxCalm 60, AddSpeed 25
               , AddSight 4
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , idesc    = "Fast and keen scouts are essential any fighting force."
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 5", COrgan), ("sapient brain", COrgan),
                ("any arrow", CInv), ("any vial", CInv), ("any vial", CInv)]
  }

-- * Merchant Mariners (merchant)

merchant = ItemKind
  { isymbol  = '@'
  , iname    = "merchant mariner"
  , ifreq    = [("merchant", 100)]
  , iflavour = zipPlain [Blue]
  , icount   = 1
  , irarity  = [(1, 10)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 30, AddMaxCalm 40, AddSpeed 20
               , AddSight 3
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Merchant mariners are operating city vessels on their endless journey to stars."
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan), ("sapient brain", COrgan)]
  }

merchantSgt = merchant
  { iname    = "merchant mariner sgt"
  , ifreq    = [("merchant", 100)]
  , iflavour = zipPlain [Cyan]
  , icount   = 1
  , irarity  = [(1, 1), (10, 3)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 40, AddMaxCalm 60, AddSpeed 20
               , AddSight 3
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Squad leader for merchant mariners"
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan), ("sapient brain", COrgan),
                ("starting weapon", CEqp)]
  }

merchantLibrarian = merchant
  { iname    = "librarian"
  , ifreq    = [("merchant", 25)]
  , iflavour = zipPlain [BrBlue]
  , icount   = 1
  , irarity  = [(1, 1), (10, 3)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 35, AddMaxCalm 80, AddSpeed 25
               , AddSight 2
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Librarian of merchant mariners"
  , ikit     = [ ("fist", COrgan)
               , ("foot", COrgan)
               , ("eye 4", COrgan)
               , ("sapient brain", COrgan)
               , ("starting weapon", CEqp)
               , ("book", CInv)
               , ("book", CInv) ]
  }

guardianSpider = ItemKind
  { isymbol  = 's'
  , iname    = "guardian spider"
  , ifreq    = [("merchant", 100)]
  , iflavour = zipPlain [Blue]
  , icount   = 3
  , irarity  = [(1, 10)]
  , iverbHit = "thud"
  , iweight  = 20000
  , iaspects = [ AddMaxHP 5, AddMaxCalm 20, AddSpeed 25
               , AddSight 5 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Guardian spiders patrol corridors of city vessel and protect merchant mariners"
  , ikit     = [("small claw", COrgan), ("eye 5", COrgan), ("animal brain", COrgan)]
  }

-- * Forces of Chaos (chaos)

chaosWarrior = ItemKind
  { isymbol  = 'c'
  , iname    = "chaos warrior"
  , ifreq    = [("chaos", 100)]
  , iflavour = zipPlain [Red]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 100000
  , iaspects = [ AddMaxHP 40, AddMaxCalm 70, AddSpeed 20
               , AddSight 3
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Warrior of Chaos, ready to wreck havoc."
  , ikit     = [  ("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan), ("sapient brain", COrgan)
                , ("starting weapon", CEqp)]
  }

chaosLord    = chaosWarrior
  { isymbol  = 'c'
  , iname    = "chaos lord"
  , ifreq    = [("chaos", 100)]
  , irarity  = [(5, 1), (10, 3)]
  , iflavour = zipPlain [BrRed]
  , iaspects = [ AddMaxHP 60, AddMaxCalm 70, AddSpeed 20
               , AddSight 3
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , idesc    = "Lord of Chaos, leader of warriors"
  }

-- * Tech Cult (tech)

cultist = ItemKind
  { isymbol  = 't'
  , iname    = "tech cultist"
  , ifreq    = [("tech", 100)]
  , iflavour = zipPlain [Green]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 100000
  , iaspects = [ AddMaxHP 10, AddMaxCalm 50, AddSpeed 20
               , AddSight 2
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Tech cultist, follower of the great Machinae"
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 3", COrgan), ("sapient brain", COrgan)]
  }

priest = cultist
  { iname    = "cult priest"
  , iflavour = zipPlain [BrGreen]
  , irarity  = [(1, 1)]
  , iaspects = [ AddMaxHP 20, AddMaxCalm 70, AddSpeed 20
               , AddSight 3
               , AddSkills $ EM.fromList [(AbProject, 2), (AbApply, 1)]]
  , idesc    = "Cultist priest, voice of the great Machinae"
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan), ("sapient brain", COrgan)]
  }

-- * Spawn

warpBeast    = ItemKind
  { isymbol  = 'w'
  , iname    = "warp beast"
  , ifreq    = [("spawn", 100), ("horror", 100)]
  , iflavour = zipPlain [White]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 40000
  , iaspects = [ AddMaxHP 20, AddMaxCalm 30, AddSpeed 20
               , AddSight 1 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Shambling beast of warp has phased into this corporeal realm."
  , ikit     = [("small claw", COrgan), ("foot", COrgan), ("eye 2", COrgan),
                ("nostril", COrgan), ("sapient brain", COrgan)]
  }

-- * Animals

ventLizard = ItemKind
  { isymbol  = ':'
  , iname    = "vent lizard"
  , ifreq    = [ ("summonable animal", 100)  -- can be summoned
               , ("spawn", 1)  -- almost never spawned
               , ("horror", 100)]  -- if no Spawn faction, belongs to horrors
  , iflavour = zipPlain [White]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 25000
  , iaspects = [ AddMaxHP 15, AddMaxCalm 30, AddSpeed 18
               , AddSkills $ EM.singleton AbAlter (-1)
               , AddSight 3 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = ""
  , ikit     = [ ("claw", COrgan), ("snout", COrgan), ("armored skin", COrgan)
               , ("nostril", COrgan), ("sapient brain", COrgan) ]
  }
