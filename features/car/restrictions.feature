@routing @car @restrictions
Feature: Car - Turn restrictions
	Handle turn restrictions as defined by http://wiki.openstreetmap.org/wiki/Relation:restriction
	Note that if u-turns are allowed, turn restrictions can lead to suprising, but correct, routes.
	
	Background: Use car routing
		Given the profile "car"
	
	@no_turning
	Scenario: Car - No left turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction  |
		 | restriction | sj       | wj     | j        | no_left_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  | sj,ej |

	@no_turning
	Scenario: Car - No right turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction   |
		 | restriction | sj       | ej     | j        | no_right_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  | sj,wj |
		 | s    | n  | sj,nj |
		 | s    | e  |       |

	@no_turning
	Scenario: Car - No u-turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction |
		 | restriction | sj       | wj     | j        | no_u_turn   |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  | sj,ej |

	@no_turning
	Scenario: Car - Handle any no_* relation
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction      |
		 | restriction | sj       | wj     | j        | no_weird_zigzags |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  | sj,ej |

	@only_turning
	Scenario: Car - Only left turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction    |
		 | restriction | sj       | wj     | j        | only_left_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  | sj,wj |
		 | s    | n  |       |
		 | s    | e  |       |

	@only_turning
	Scenario: Car - Only right turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction     |
		 | restriction | sj       | ej     | j        | only_right_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  |       |
		 | s    | e  | sj,ej |
	
	@only_turning
	Scenario: Car - Only straight on
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction      |
		 | restriction | sj       | nj     | j        | only_straight_on |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  |       |

	@no_turning
	Scenario: Car - Handle any only_* restriction
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction        |
		 | restriction | sj       | nj     | j        | only_weird_zigzags |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  |       |

  	@except @todo
  	Scenario: Bike - Except tag and on no_ restrictions
  		Given the node map
  		 | b | x | c |
  		 | a | j | d |
  		 |   | s |   |

  		And the ways
  		 | nodes | oneway |
  		 | sj    | yes    |
  		 | xj    | -1     |
  		 | aj    | -1     |
  		 | bj    | -1     |
  		 | cj    | -1     |
  		 | dj    | -1     |

  		And the relations
  		 | type        | way:from | way:to | node:via | restriction   | except   |
  		 | restriction | sj       | aj     | j        | no_left_turn  | motorcar |
  		 | restriction | sj       | bj     | j        | no_left_turn  |          |
  		 | restriction | sj       | cj     | j        | no_right_turn | motorcar |
  		 | restriction | sj       | dj     | j        | no_right_turn |          |

  		When I route I should get
  		 | from | to | route |
  		 | s    | a  | sj,aj |
  		 | s    | b  |       |
  		 | s    | c  |       |
  		 | s    | d  | sj,dj |

   	@except @todo
   	Scenario: Bike - Except tag and on only_ restrictions
   		Given the node map
   		 | a |   | b |
   		 |   | j |   |
   		 |   | s |   |

   		And the ways
   		 | nodes | oneway |
   		 | sj    | yes    |
   		 | aj    | -1     |
   		 | bj    | -1     |

   		And the relations
   		 | type        | way:from | way:to | node:via | restriction      | except   |
   		 | restriction | sj       | aj     | j        | only_straight_on | motorcar |

   		When I route I should get
   		 | from | to | route |
   		 | s    | a  | sj,aj |
   		 | s    | b  | sj,bj |
