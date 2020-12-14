# I will _always_ survive.

___

## General to-do list:

 * More interesting wandering
 	+ Return to its home
	+ Navigate between rooms
 * Lenny dies if you place him down facing a wall
 * Prints negative health when he dies
 
## Pathfinding

Maybe this will be finished?

### To-do list:

 * Make it navigate the final path
	+ Have to refine the code that records/updates it's "facing" value. What if it has to zig-zag? Can't depend on moving forward a block to figure out which way it's facing.
 * Make it map the room
 	+ Circle, starting at the outside and spiraling inwards?
	+ Store the map in an empty file stored on a disk connected to the server, then send it to clients through Rednet (you shouldn't have to serialize). They'll store it in an empty file as well.
		- This is assuming that Rednet can send data this large. If not, the file will have to be copied manually onto clients.

### Mapping

#### Basic concept:
1. Go in straight lines.
	
   a. Choose +X. Go in that direction. While doing this, note nodes you've been to. Note nodes that you pass that are open. When you hit a wall, reverse (-X) until you hit a wall. TODO: Update steps for the flipped direction.
   
   b. Once you can't go any further, choose +Z.
   
   c. Go that direction until a node in the +X direction is open.
   
   d. Go back to Step A.

2. Once you're trapped on all sides by impassable nodes or nodes you've been to, go back to the first open node you recorded. Do Step 1, but go whichever way is open when you hit a wall.
 
Depth-first search:

 - Start node
 
#### Data Storage
Store the map in an empty file stored on a disk connected to the server, then send it to clients through Rednet (you shouldn't have to serialize the table). The clients will store it in an empty file as well. This is assuming that Rednet can send data this large. If not, the file will have to be copied manually onto clients.


https://www.codementor.io/blog/basic-pathfinding-explained-with-python-5pil8767c1