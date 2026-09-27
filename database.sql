CREATE TABLE IF NOT EXISTS rc7_owners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    vehicle_plate VARCHAR(10) NOT NULL,
    UNIQUE KEY unique_vehicle_plate (vehicle_plate)
);