extends "res://tests/test_case.gd"


func test_a_tick_moves_the_dragon_head() -> void:
	var session := Session.new(Vector2i(10, 10))
	session.tick()
	assert_eq(session.dragon.body[0], Vector2i(6, 5))


func test_the_dragon_starts_on_open_floor_inside_a_wall() -> void:
	var session := Session.new(Vector2i(10, 10))
	assert_true(session.board.is_solid(Vector2i(0, 0)))
	assert_true(not session.board.is_solid(session.dragon.body[0]))


func test_eating_grows_the_body_by_the_growth_amount() -> void:
	var session := Session.new(Vector2i(20, 20))
	var before := session.dragon.body.size()
	session.food = session.dragon.body[0] + Vector2i.RIGHT
	session.tick()
	session.food = Vector2i(1, 1)
	for i in Session.GROWTH:
		session.tick()
	assert_eq(session.dragon.body.size(), before + Session.GROWTH)


func test_new_food_never_appears_on_the_body() -> void:
	var session := Session.new(Vector2i(20, 20))
	for i in 5:
		session.food = session.dragon.body[0] + Vector2i.RIGHT
		session.tick()
		assert_true(not session.dragon.body.has(session.food))
		assert_true(not session.board.is_solid(session.food))


func test_the_score_counts_what_was_eaten() -> void:
	var session := Session.new(Vector2i(20, 20))
	assert_eq(session.score, 0)
	for i in 2:
		session.food = session.dragon.body[0] + Vector2i.RIGHT
		session.tick()
	assert_eq(session.score, 2)
