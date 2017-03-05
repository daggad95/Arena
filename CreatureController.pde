public interface CreatureController {
  public Command getCommand();
  public void update(PVector pos, Direction dir);
  public String getName();
  public color getColor();
}