module Game where

import Structure.Object
import Type
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Render
import Settings
import Utils
import Update
import Handle

-- | Function to render universe
drawUniverse :: Universe -> Picture
drawUniverse u = field
              <> drawObject drawPlant  ps
              <> drawProjectiles Sun (prs ++ ss)
              <> drawProjectiles Pea prs
              <> drawObject drawZombie zs
              <> drawObject (drawCard m) cs
              <> drawMoney m 
              <> uScreen u
  where
    prs      = concat (map pBullet ps)
    zs       = uEnemies u
    ps       = uDefense u  
    cs       = uCards u
    m        = uMoney u
    (ss, _)  = uSuns u

-- | Function to change universe according
--   to its rules by the interaction with the player
handleUniverse :: Event -> Universe -> Universe
handleUniverse (EventKey (MouseButton LeftButton)
               Down _ mouseCoords) u = handleCoords mouseCoords u
handleUniverse _  u = u

-- | Function to change universe according
--   to its rules by the time passed
--   detect if the game is over
updateUniverse :: Float -> Universe -> Universe
updateUniverse dt u
  | isWon u = u
         { uScreen = win }
  | isLost u = u
         { uScreen = lost }
  | otherwise = u
        { uEnemies = newEnemies
        , uDefense = newDefense
        , uCards   = newCards
        , uSuns    = newSuns
        , uTime    = newTime
        }
  where
    newEnemies = updateZombies dt u 
    newDefense = updatePlants dt u
    newSuns    = updateSuns dt u
    newCards   = updateCards dt u
    newTime    = (uTime u) + dt

perform :: IO()
perform = play
          screen
          white
          60
          initUniverse
          drawUniverse
          handleUniverse
          updateUniverse
