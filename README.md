# I will _always_ survive.

___

## General to-do list:

 * More interesting wandering
 	+ Return to its home
	+ Navigate between rooms
 
## Pathfinding to-do list:

 * Make it navigate the final path
	+ Have to refine the code that records/updates it's "facing" value. What if it has to zig-zag? Can't depend on moving forward a block to figure out which way it's facing.
 * Make it map the room
 	+ Circle, starting at the outside and spiraling inwards?
	+ Store the map in an empty file stored on a disk connected to the server, then send it to clients through Rednet (you shouldn't have to serialize). They'll store it in an empty file as well.
		- This is assuming that Rednet can send data this large. If not, the file will have to be copied manually onto clients.