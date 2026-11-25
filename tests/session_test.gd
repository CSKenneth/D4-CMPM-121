extends "res://tests/test_case.gd"


func test_a_tick_moves_the_dragon_head() -> void:
	var session := Session.new(Vector2i(10, 10))
	session.start()
	session.tick()
	assert_eq(session.dragon.body[0], Vector2i(6, 5))


func test_the_dragon_starts_on_open_floor_inside_a_wall() -> void:
	var session := Session.new(Vector2i(10, 10))
	assert_true(session.board.is_solid(Vector2i(0, 0)))
	assert_true(not session.board.is_solid(session.dragon.body[0]))


func test_eating_grows_the_body_by_the_growth_amount() -> void:
	var session := Session.new(Vector2i(20, 20))
	session.start()
	var before := session.dragon.body.size()
	session.food = session.dragon.body[0] + Vector2i.RIGHT
	session.tick()
	session.food = Vector2i(1, 1)
	for i in Session.GROWTH:
		session.tick()
	assert_eq(session.dragon.body.size(), before + Session.GROWTH)


func test_new_food_never_appears_on_the_body() -> void:
	var session := Session.new(Vector2i(20, 20))
	session.start()
	for i in 5:
		session.food = session.dragon.body[0] + Vector2i.RIGHT
		session.tick()
		assert_true(not session.dragon.body.has(session.food))
		assert_true(not session.board.is_solid(session.food))


func test_the_score_counts_what_was_eaten() -> void:
	var session := Session.new(Vector2i(20, 20))
	session.start()
	assert_eq(session.score, 0)
	for i in 2:
		session.food = session.dragon.body[0] + Vector2i.RIGHT
		session.tick()
	assert_eq(session.score, 2)


func test_nothing_moves_until_the_first_arrow_key() -> void:
	var session := Session.new(Vector2i(10, 10))
	var start := session.dragon.body[0]
	session.tick()
	session.tick()
	assert_eq(session.dragon.body[0], start)
	session.steer(Vector2i.UP)
	session.tick()
	assert_eq(session.dragon.body[0], start + Vector2i.UP)


func test_hitting_a_wall_ends_the_run() -> void:
	var session := Session.new(Vector2i(10, 10))
	session.start()
	for i in 3:
		session.tick()
	assert_true(not session.over)
	session.tick()  # the head enters (9, 5), which is wall
	assert_true(session.over)


func test_biting_the_body_ends_the_run() -> void:
	var session := Session.new(Vector2i(10, 10))
	session.start()
	session.dragon.body.assign(
		[Vector2i(5, 5), Vector2i(5, 6), Vector2i(6, 6), Vector2i(6, 5), Vector2i(6, 4)]
	)
	session.tick()  # the head moves into (6, 5), which the body still holds
	assert_true(session.over)


func test_chasing_the_tail_into_the_cell_it_is_leaving_is_safe() -> void:
	var session := Session.new(Vector2i(10, 10))
	session.start()
	session.dragon.body.assign([Vector2i(5, 5), Vector2i(5, 6), Vector2i(6, 6), Vector2i(6, 5)])
	session.tick()  # the head enters (6, 5) just as the tail leaves it
	assert_true(not session.over)
