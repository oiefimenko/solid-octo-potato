
defmodule Conn.SerializerPipe do
      
  def run do
    receive do
      {from, type, data} -> send(from, serialize(type, data))
    end
    run()
  end

  # Connection message
  def serialize(:conn) do
    "10" <> ";"
  end

  # Ping message
  def serialize(:ping) do
    "11" <> ";"
  end

  # Init message
  def serialize(:init, {id_0, id_1, squads}) do
    s_squads = squads 
      |> Enum.map(fn(e) -> Game.Squad.serialize(e) end) 
      |> Enum.join(";")
      
    "12;#{id_0};0;#{id_1};1;#{s_squads}"
  end

  # Squad State message
  def serialize(:squad_state, squad) do
    "21" <> ";" <> Game.Squad.serialize(squad)
  end

  # Path provided
  def serialize(:new_path, squad) do
    "22" <> ";" <> Game.Squad.serialize(squad)
  end  

  # Formation message
  def serialize(:new_formation, squad) do
    "23" <> ";" <> Game.Squad.serialize(squad)
  end

  # Skill message
  def serialize(:skill_used, squad) do
    "24" <> ";" <> Game.Squad.serialize(squad)
  end

end