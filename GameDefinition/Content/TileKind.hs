-- | Terrain tile definitions.
module Content.TileKind ( cdefs ) where

import Prelude ()

import Game.LambdaHack.Common.Prelude

import qualified Data.Text as T

import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.TileKind

cdefs :: ContentDef TileKind
cdefs = ContentDef
  { getSymbol = tsymbol
  , getName = tname
  , getFreq = tfreq
  , validateSingle = validateSingleTileKind
  , validateAll = validateAllTileKind
  , content =
      [wall, hardRock, pillar, pillarCache, lampPost, burningBush, bush, tree, wallV, wallSuspectV, doorClosedV, doorOpenV, wallH, wallSuspectH, doorClosedH, doorOpenH, stairsUpLit, stairsLit, stairsDownLit, escapeUpLit, escapeDownLit, unknown, floorCorridorLit, floorArenaLit, floorArenaShade, floorActorLit, floorItemLit, floorActorItemLit, floorRedLit, floorBlueLit, floorGreenLit, floorBrownLit]
      ++ map makeDark [wallV, wallSuspectV, doorClosedV, doorOpenV, wallH, wallSuspectH, doorClosedH, doorOpenH, stairsLit, escapeUpLit, escapeDownLit, floorCorridorLit]
      ++ map makeDarkColor [stairsUpLit, stairsDownLit, floorArenaLit, floorActorLit, floorItemLit, floorActorItemLit]
  }
wall,        hardRock, pillar, pillarCache, lampPost, burningBush, bush, tree, wallV, wallSuspectV, doorClosedV, doorOpenV, wallH, wallSuspectH, doorClosedH, doorOpenH, stairsUpLit, stairsLit, stairsDownLit, escapeUpLit, escapeDownLit, unknown, floorCorridorLit, floorArenaLit, floorArenaShade, floorActorLit, floorItemLit, floorActorItemLit, floorRedLit, floorBlueLit, floorGreenLit, floorBrownLit :: TileKind

wall = TileKind
  { tsymbol  = ' '
  , tname    = "bedrock"
  , tfreq    = [("fillerWall", 1), ("legendLit", 100), ("legendDark", 100)]
  , tcolor   = defBG
  , tcolor2  = defBG
  , tfeature = [Dark]
      -- Bedrock being dark is bad for AI (forces it to backtrack to explore
      -- bedrock at corridor turns) and induces human micromanagement
      -- if there can be corridors joined diagonally (humans have to check
      -- with the cursor if the dark space is bedrock or unexplored).
      -- Lit bedrock would be even worse for humans, because it's harder
      -- to guess which tiles are unknown and which can be explored bedrock.
      -- The setup of Allure is ideal, with lit bedrock that is easily
      -- distinguished from an unknown tile. However, LH follows the NetHack,
      -- not the Angband, visual tradition, so we can't improve the situation,
      -- unless we turn to subtle shades of black or non-ASCII glyphs,
      -- but that is yet different aesthetics and it's inconsistent
      -- with console frontends.
  }
  
unknown = TileKind  -- needs to have index 0 and alter 1
  { tsymbol  = ' '
  , tname    = "unknown space"
  , tfreq    = [("unknown space", 1)]
  , tcolor   = defFG
  , tcolor2  = defFG
  , talter   = 1
  , tfeature = [Dark, Indistinct]
  }
  
hardRock = TileKind
  { tsymbol  = ' '
  , tname    = "impenetrable bedrock"
  , tfreq    = [("basic outer fence", 1)]
  , tcolor   = defFG
  , tcolor2  = defFG
  , talter   = maxBound  -- impenetrable
  , tfeature = [Dark, Indistinct]
  }
 
pillar = TileKind
  { tsymbol  = 'O'
  , tname    = "rock"
  , tfreq    = [ ("cachable", 70)
               , ("legendLit", 100), ("legendDark", 100)
               , ("noiseSet", 100), ("skirmishSet", 5)
               , ("battleSet", 250) ]
  , tcolor   = BrCyan  -- not BrWhite, to tell from heroes
  , tcolor2  = Cyan
  , talter   = 100
  , tfeature = [Indistinct]
  }

pillarCache = TileKind
  { tsymbol  = '&'
  , tname    = "cache"
  , tfreq    = [ ("cachable", 30)
               , ("legendLit", 100), ("legendDark", 100) ]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [ Cause $ IK.CreateItem CGround "useful" IK.TimerNone
               , ChangeTo "cachable"]
  }
lampPost = TileKind
  { tsymbol  = 'O'
  , tname    = "lamp post"
  , tfreq    = [("lampPostOver_O", 90)]
  , tcolor   = BrYellow
  , tcolor2  = Brown
  , tfeature = []
  }
burningBush = TileKind
  { tsymbol  = 'O'
  , tname    = "burning bush"
  , tfreq    = [("lampPostOver_O", 10), ("ambushSet", 3), ("battleSet", 2)]
  , tcolor   = BrRed
  , tcolor2  = Red
  , tfeature = []
  }
bush = TileKind
  { tsymbol  = 'O'
  , tname    = "bush"
  , tfreq    = [("ambushSet", 100) ]
  , tcolor   = Green
  , tcolor2  = BrBlack
  , tfeature = [Dark]
  }
tree = TileKind
  { tsymbol  = 'O'
  , tname    = "tree"
  , tfreq    = [("skirmishSet", 14), ("battleSet", 20), ("treeShadeOver_O", 1)]
  , tcolor   = BrGreen
  , tcolor2  = Green
  , tfeature = []
  }
wallV = TileKind
  { tsymbol  = '|'
  , tname    = "granite wall"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [HideAs "suspect vertical wall Lit"]
  }
wallSuspectV = TileKind
  { tsymbol  = '|'
  , tname    = "moldy wall"
  , tfreq    = [("suspect vertical wall Lit", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [Suspect, RevealAs "vertical closed door Lit"]
  }
doorClosedV = TileKind
  { tsymbol  = '+'
  , tname    = "closed door"
  , tfreq    = [("vertical closed door Lit", 1)]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , tfeature = [ OpenTo "vertical open door Lit"
               , HideAs "suspect vertical wall Lit"
               ]
  }
doorOpenV = TileKind
  { tsymbol  = '-'
  , tname    = "open door"
  , tfreq    = [("vertical open door Lit", 1)]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , tfeature = [ Walkable, Clear, NoItem, NoActor
               , CloseTo "vertical closed door Lit"
               ]
  }
wallH = TileKind
  { tsymbol  = '-'
  , tname    = "granite wall"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [HideAs "suspect horizontal wall Lit"]
  }
wallSuspectH = TileKind
  { tsymbol  = '-'
  , tname    = "scratched wall"
  , tfreq    = [("suspect horizontal wall Lit", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [Suspect, RevealAs "horizontal closed door Lit"]
  }
doorClosedH = TileKind
  { tsymbol  = '+'
  , tname    = "closed door"
  , tfreq    = [("horizontal closed door Lit", 1)]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , tfeature = [ OpenTo "horizontal open door Lit"
               , HideAs "suspect horizontal wall Lit"
               ]
  }
doorOpenH = TileKind
  { tsymbol  = '|'
  , tname    = "open door"
  , tfreq    = [("horizontal open door Lit", 1)]
  , tcolor   = Brown
  , tcolor2  = BrBlack
  , tfeature = [ Walkable, Clear, NoItem, NoActor
               , CloseTo "horizontal closed door Lit"
               ]
  }
stairsUpLit = TileKind
  { tsymbol  = '<'
  , tname    = "staircase up"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [Walkable, Clear, NoItem, NoActor, Cause $ IK.Ascend 1]
  }
stairsLit = TileKind
  { tsymbol  = '>'
  , tname    = "staircase"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrCyan
  , tcolor2  = Cyan  -- TODO
  , tfeature = [ Walkable, Clear, NoItem, NoActor
               , Cause $ IK.Ascend 1
               , Cause $ IK.Ascend (-1) ]
  }
stairsDownLit = TileKind
  { tsymbol  = '>'
  , tname    = "staircase down"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , talter   = 0
  , tfeature = [Embed "Escape", ConsideredByAI]
  }
escapeUpLit = TileKind
  { tsymbol  = '<'
  , tname    = "exit hatch up"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrYellow
  , tcolor2  = BrYellow
  , talter   = 0 -- anybody can escape
  , tfeature = [Embed "Escape", ConsideredByAI]
  }
escapeDownLit = TileKind
  { tsymbol  = '>'
  , tname    = "exit trapdoor down"
  , tfreq    = [("legendLit", 100)]
  , tcolor   = BrYellow
  , tcolor2  = BrYellow
  , tfeature = [Walkable, Clear, NoItem, NoActor, Cause $ IK.Escape (-1)]
  }

floorCorridorLit = TileKind
  { tsymbol  = '#'
  , tname    = "corridor"
  , tfreq    = [("floorCorridorLit", 1)]
  , tcolor   = BrWhite
  , tcolor2  = defFG
  , tfeature = [Walkable, Clear]
  }
floorArenaLit = floorCorridorLit
  { tsymbol  = '.'
  , tname    = "stone floor"
  , tfreq    = [ ("floorArenaLit", 1)
               , ("arenaSet", 1), ("emptySet", 1), ("noiseSet", 50)
               , ("battleSet", 1000), ("skirmishSet", 100)
               , ("ambushSet", 1000) ]
  }
floorActorLit = floorArenaLit
  { tfreq    = []
  , tfeature = OftenActor : tfeature floorArenaLit
  }
floorItemLit = floorArenaLit
  { tfreq    = []
  , tfeature = OftenItem : tfeature floorArenaLit
  }
floorActorItemLit = floorItemLit
  { tfreq    = [("legendLit", 100)]  -- no OftenItem in legendDark
  , tfeature = OftenActor : tfeature floorItemLit
  }
floorArenaShade = floorActorLit
  { tname    = "stone floor"  -- TODO: "shaded ground"
  , tfreq    = [("treeShadeOver_s", 1)]
  , tcolor2  = BrBlack
  , tfeature = Dark : tfeature floorActorLit  -- no OftenItem
  }
floorRedLit = floorArenaLit
  { tname    = "brick pavement"
  , tfreq    = [("trailLit", 30), ("trailChessLit", 30)]
  , tcolor   = BrRed
  , tcolor2  = Red
  , tfeature = Trail : tfeature floorArenaLit
  }
floorBlueLit = floorRedLit
  { tname    = "cobblestone path"
  , tfreq    = [("trailLit", 100), ("trailChessLit", 70)]
  , tcolor   = BrBlue
  , tcolor2  = Blue
  }
floorGreenLit = floorRedLit
  { tname    = "mossy stone path"
  , tfreq    = [("trailLit", 100)]
  , tcolor   = BrGreen
  , tcolor2  = Green
  }
floorBrownLit = floorRedLit
  { tname    = "rotting mahogany deck"
  , tfreq    = [("trailLit", 10)]
  , tcolor   = BrMagenta
  , tcolor2  = Magenta
  }

makeDark :: TileKind -> TileKind
makeDark k = let darkText :: GroupName TileKind -> GroupName TileKind
                 darkText t = maybe t (toGroupName . (<> "Dark"))
                              $ T.stripSuffix "Lit" $ tshow t
                 darkFrequency = map (first darkText) $ tfreq k
                 darkFeat (OpenTo t) = Just $ OpenTo $ darkText t
                 darkFeat (CloseTo t) = Just $ CloseTo $ darkText t
                 darkFeat (ChangeTo t) = Just $ ChangeTo $ darkText t
                 darkFeat (HideAs t) = Just $ HideAs $ darkText t
                 darkFeat (RevealAs t) = Just $ RevealAs $ darkText t
                 darkFeat OftenItem = Nothing -- items not common in the dark
                 darkFeat feat = Just feat
             in k { tfreq = darkFrequency
                  , tfeature = Dark : mapMaybe darkFeat (tfeature k)
                  }

makeDarkColor :: TileKind -> TileKind
makeDarkColor k = (makeDark k) {tcolor2 = BrBlack}
