# Mega Bunny
My progress following Godot platformer tutorial by ClearCode on Net Ninja. As of 11/20/2024 I am stuck on the third video. 18 minutes in: 
 
[https://youtu.be/7ijfcTN4g0Y?si=ZmK6rBFlKQP7Ist3&t=1080](Build a Platformer with Godot #3 - Adding Bullets)

I'm pretty sure I'm following the steps exactly, but my bullets don't move and I don't know why. If I continue with the video and add code to fix the direction of the bullet (even though mine isn't even moving yet anyway) I get the additional error "Invalid assignment property or key 'direction' with value of type 'int' on a base object of type 'Area2D' and then it crashes." This is caused by the line bullet.direction = direction in level.gd. If I comment that line out I no longer get that error and it no longer crashes, but the bullet still doesn't move
