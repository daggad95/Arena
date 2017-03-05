private int MAPSIZE = 20;
private int NUM_CREATURES = 10;
private int tileSize;
private HashMap<PVector, Creature> creatureMap;
private ArrayList<Creature> creatures;

void setup() {
  size(800, 800);
  tileSize = width / MAPSIZE;
  
  creatureMap = new HashMap<PVector, Creature>();
  creatures = new ArrayList<Creature>();
  
  for (int i = 0; i < NUM_CREATURES; i++) {
    Creature david = new Creature(new PVector(19, 0), Direction.LEFT, new DavidController());
  
    creatureMap.put(new PVector(19, 0), david);
    creatures.add(david);
    
    Creature test= new Creature(new PVector(0, 0), Direction.LEFT, new TestController());
  
    creatureMap.put(new PVector(0, 0), test);
    creatures.add(test);
  }
}

void draw() {
  
  //update done first for fairness in battle;
  for (Creature creature : creatures) {
    PVector pos = creature.getPos();
    Direction dir = creature.getDir();
    CreatureController controller = creature.getController();
    controller.update(pos, dir);
  }
  
  
  background(255);
  for (Creature creature : creatures) {
    PVector pos = creature.getPos();
    Direction dir = creature.getDir();
    CreatureController controller = creature.getController();
    color c = controller.getColor();
    
    fill(c);
    ellipse(pos.x * tileSize + tileSize / 2, pos.y * tileSize + tileSize / 2, tileSize, tileSize);

    
    Command command = controller.getCommand();
    
    switch(command) {
      case MOVE:
        moveCreature(creature);
        break;
      case TURN_RIGHT:
        creature.turn(Direction.RIGHT);
        break;
      case TURN_LEFT:
        creature.turn(Direction.LEFT);
        break;
      case ATTACK:
        handleAttack(creature, getDefender(pos, dir));
        break;
    }
  }
  
  delay(10);
}

private Creature getDefender(PVector pos, Direction dir) {
  Creature enemy = null;
  switch(dir) {
    case RIGHT:
      enemy = creatureMap.get(new PVector(pos.x + 1, pos.y));
      break;
    case LEFT:
      enemy = creatureMap.get(new PVector(pos.x - 1, pos.y));
      break;
    case UP:
      enemy = creatureMap.get(new PVector(pos.x, pos.y - 1));
      break;
    case DOWN:
     enemy = creatureMap.get(new PVector(pos.x, pos.y + 1));
     break;
  }
  
  return enemy;
}

private void moveCreature(Creature creature) {
   creatureMap.put(creature.getPos(), null);
   creature.move();
   creatureMap.put(creature.getPos(), creature);
}

private void recoil(Creature creature, int distance) {
   creature.turn(Direction.RIGHT);
   creature.turn(Direction.RIGHT);
   for (int i = 0; i < distance; i++) {
     moveCreature(creature);
   }
   creature.turn(Direction.LEFT);
   creature.turn(Direction.LEFT);
   println("RECOIL");
}

private void handleAttack(Creature attacker, Creature defender) {
  if (attacker != null && defender != null) {
   Command defense = defender.getController().getCommand();
  
  //attacker pushed back on block;
  if (defense == Command.BLOCK) {
    recoil(attacker, 3);
  } else if (defense == Command.ATTACK) {
    recoil(attacker, 1);
    recoil(defender, 1);
  } else {
    defender.setController(attacker.getController());
  }
  }
}

boolean validPosition(PVector pos) {
  if (pos.x >= MAPSIZE || pos.y >= MAPSIZE || pos.x < 0 || pos.y < 0 || creatureMap.get(pos) != null) {
    return false;
  }
  
  return true;
}

boolean canMove(PVector pos, Direction dir) {
  switch(dir) {
    case RIGHT:
      return validPosition(new PVector(pos.x + 1, pos.y));
    case LEFT:
      return validPosition(new PVector(pos.x - 1, pos.y));
    case UP:
      return validPosition(new PVector(pos.x, pos.y - 1));
    case DOWN:
      return validPosition(new PVector(pos.x, pos.y + 1));
  }
  
  return false;
}

boolean facingEnemy(PVector pos, Direction dir, String name) {
  Creature enemy = null;
  switch(dir) {
    case RIGHT:
      enemy = creatureMap.get(new PVector(pos.x + 1, pos.y));
      break;
    case LEFT:
      enemy = creatureMap.get(new PVector(pos.x - 1, pos.y));
      break;
    case UP:
      enemy = creatureMap.get(new PVector(pos.x, pos.y - 1));
      break;
    case DOWN:
     enemy = creatureMap.get(new PVector(pos.x, pos.y + 1));
     break;
  }
  
  if (enemy != null) {
    if (!name.equals(enemy.getController().getName())) {
      return true;
    }
  }
  
  return false;
}