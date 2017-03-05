public class TestController implements CreatureController {
  private Command command;
  private String name;
  color c;
  
  public TestController() {
    name = "TEST";
    command = Command.MOVE;
    c = color(0, 34, 122);
  }
  
  public Command getCommand() {
    return command;
  }
  
  public void update(PVector pos, Direction dir) {
    int choice;
    if (facingEnemy(pos, dir, name)) {
      choice = (int) random(4);
      if (choice < 2) {
        command = Command.ATTACK;
      } else if (choice == 2) {
        command = Command.BLOCK;
      } else {
        choice = (int) random(2);
        if (choice == 0) {
          command = Command.TURN_RIGHT;
        } else {
          command = Command.TURN_LEFT;
        }
      }
    } else {
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