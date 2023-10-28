extends TileMap

@onready var tilemap_rect = self.get_used_rect()
@onready var cell_size = self.cell_quadrant_size
@onready var color = Color(0.5, 0.5, 0.5)

func _ready():
	set_process(true)


func _draw():
	for y in range(0, cell_size):
		draw_line(Vector2(0, y * cell_size), 
		Vector2(tilemap_rect.size.x * cell_size, y * cell_size), 
		color)

	for x in range(0, cell_size):
		draw_line(Vector2(x * cell_size, 0), 
		Vector2(x * cell_size, tilemap_rect.size.y * cell_size),
		color)
