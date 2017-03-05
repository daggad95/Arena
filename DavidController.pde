public class DavidController implements CreatureController {
  private Command command;
  private String name;
  color c;
  
  public DavidController() {
    name = "David";
    command = Command.MOVE;
    c = color(122, 34, 12);
  }
  
  public Command getCommand() {
    return command;
  }
  
  public void update(PVector pos, Direction dir) {
      if (facingEnemy(pos, dir, name)) {
        command = Command.ATTACK;
      } else {
        int choice;
        
        if (canMove(pos, dir)) {
          command = Command.MOVE;
        } else {
          choice = (int) random(2);
          if (choice == 0) {
            command = Command.TURN_RIGHT;
          } else {
            command = Command.TURN_LEFT;
          }
        }
      }
    }
  
  public String getName() {
    return name;
  }
  
  public color getColor() {
    return c;
  }
}