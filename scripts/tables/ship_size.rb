module ShipSize
  TABLE = [
    %w[SIZE CATEGORY LENGTH HULL CREW EXAMPLE],
    ["Tiny", "5 m", "1", "1 (2)", "Breaching pod"],
    ["Small", "10 m", "1d3", "1 (2)", "Shuttle or skiff"],
    ["Medium", "25 m", "1d6", "2 (4)", "Ship’s boat, drop ship"],
    ["Large", "50 m", "2d6", "4 (16)", "Frigate"],
    ["Huge", "100 m", "3d6", "16 (64)", "Destroyer"],
    ["Gigantic", "250 m", "4d6", "64 (512)", "Cruiser"],
    ["Colossal", "500 m", "5d6", "256 (2,048)", "Battleship"],
    ["Titanic", "1 km+", "6d6", "1024 (8,192)", "Colony generation-ship"],
  TAB
end
