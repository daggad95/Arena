public class Creature {
  private PVector pos;
  private Direction dir;
  private CreatureController controller;
  
  public Creature(PVector startPos, Direction startDir, CreatureController startController) {
    pos = startPos;
    dir = startDir;
    controller = startController;
  }
  
  public void move() {
    switch(dir) {
      case RIGHT:
        if (validPosition(new PVector(pos.x + 1, pos.y))) {
          pos.x++;
        }
        break;
      case LEFT:
        if (validPosition(new PVector(pos.x - 1, pos.y))) {
          pos.x--;
        }
        break;
      case UP:
        if (validPosition(new PVector(pos.x, pos.y - 1))) {
          pos.y--;
        }
        break;
      case DOWN:
        if (validPosition(new PVector(pos.x, pos.y + 1))) {
          pos.y++;
        }
        break;
    }
  }
  
  public final void turn(Direction turnDir) {
    if (turnDir == Direction.LEFT) {
      switch(dir) {
        case RIGHT:
          dir = Direction.UP;
          break;
        case LEFT:
          dir = Direction.DOWN;
          break;
        case UP:
          dir = Direction.LEFT;
          break;
        case DOWN:
          dir = Direction.RIGHT;
          break;
      }
    } else if (turnDir == Direction.RIGHT) {
      switch(dir) {
        case RIGHT:
          dir = Direction.DOWN;
          break;
        case LEFT:
          dir = Direction.UP;
          break;
        case UP:
          dir = Direction.RIGHT;
          break;
        case DOWN:
          dir = Direction.LEFT;
          break;
      }
    }
  }
  
  public void setController(CreatureController controller) {
    this.controller = controller;
  }
  
  public PVector getPos() {
    return new PVector(pos.x, pos.y);
  }
  
  public Direction getDir() {
    return dir;
  }
  
  public CreatureController getController() {
    return controller;
  }
}