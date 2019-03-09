{-# OPTIONS_GHC -Wall -fdefer-typed-holes #-}

module Type where

-- | Type for coordinates on the field
type Coords = (Float, Float)

-- | Data type to store different types of zombie
data ZombieType = ZombieOne | ZombieTwo | ZombieThree

-- | Data type to store different types of plant
data PlantType = PlantOne | PlantTwo

-- | Data type for Zombie
data Zombie = Zombie
  { zType     :: ZombieType
  , zCoords   :: Coords    -- ^ coordinates of zombie
  }

-- | Data type for Plants
data Plant = Plant
  { pType     ::  PlantType
  , pCoords   ::     Coords -- ^ coordinates of plants
  , pDamage   ::        Int -- ^ health of the plant
--  , pStrength ::        Int -- ^ strength of the plant
  , pBullet   :: Projectile -- ^ projectile of the plant
  }

data Projectile = Projectile
  { prX :: Float            -- ^ coordinates of projectile
  }

-- | Data type for whole Universe
data Universe = Universe
  { uEnemies :: [Zombie]   -- ^ list of enemies
  , uDefense ::  [Plant]   -- ^ list of plants
  , uTime    ::    Float   -- ^ amount of time passed since start
  }
