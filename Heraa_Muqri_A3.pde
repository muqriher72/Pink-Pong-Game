/**************************
 * Heraa Muqri             *
 *                         *
 * Heraa_Muqri_A3.pde      *
 *                         *
 *                         *
 *     Pong Assignment     *
 * A program that runs a   *
 * pong game using various *
 * methods, loops, and if  *
 * statements.             *
 *                         *
 * December 8, 2020        *
 **************************/
// global variables used throughout code are initialized.
int ballX = 350, ballY = 300; // store the starting values of the balls x and y position.
int paddleX = 350, paddleY = 100, paddle2X = 350, paddle2Y = 500; // store the starting values of both paddles x and y positions.
int xSpeed = 5, ySpeed = -5; // store the x and y speed of the ball.
int ballSize = 16; // stores the value of the size of the ball 16.
int scoreP1 = 0, scoreP2 = 0; // store the scores for player 1 and 2, starting at 0.
int xP1Speed = 10, xP2Speed = 10;// stores the x speed for paddle 1 and 2. 
PFont font, font2, font3, font4, font5; // variables used to store 5 different fonts used for text in the game.
boolean paddle1Right = false, paddle1Left = false, paddle2Right = false, paddle2Left = false; // boolean expressions set to false to be used in if statements in the game to control the paddles.
int gameState = 1; // stores the value 1 in gameState variable, 1 = welcome, 2 = game mode, 3 = level mode, 4 = instructions, 5 = Pong game.
int gameMode = 0; // stores the value 0 in the gameMode variable, 1 = 2 Player Mode, 2 = Computer Player Mode.
int gameLevel= 0; // stores the value 0 in the gameLevel variable, 1 = Easy Mode, 2 = Hard Mode.
color lightPink = #f998a7, darkPink = #f30071, white = #ffffff, black = #000000, darkBlue = #00a8f3, yellow = #fff200; // 6 different color variables to store 6 different colours to use in the program.
int textSize90 = 90, textSize50 = 50, textSize30 = 30, textSize25 = 25, textSize65 = 65; // 5 different variables to store 5 different text sizes to use in the program.

void setup () {
  size (700, 600); // sets the canvas size to 700 width and 600 height.
  surface.setResizable (true); // allows the canvas window to be resized.
  // the following code in this setup method loads 5 different text fonts stored in the sketch folder to be used in the program.
  font = loadFont ("Constantia-BoldItalic-48.vlw"); 
  font2 = loadFont ("Arial-Black-48.vlw"); 
  font3 = loadFont ("Arial-BoldItalicMT-48.vlw"); 
  font4 = loadFont ("ArialMT-48.vlw");
  font5 = loadFont ("Monospaced.bold-48.vlw");
}

void draw () {
  if (gameState == 1) { // runs the code inside only if the value in gameState variable is 1.
    welcomeScreen (); // method call to draw the welcome screen.
  } else if (gameState == 2) { // runs the code inside only if the value in gameState variable is 2.
    gameMode (); // method call to draw the game mode selection screen.
  } else if (gameState == 3) { // runs the code inside only if the value in gameState variable is 3.
    level (); // method call to draw the game level selection screen.
  } else if (gameState == 4) { // runs the code inside only if the value in the gameState variable is 4.
    instruction (); // method call to draw the instruction screen.
  } else if (gameState == 5 && gameMode == 1 && gameLevel == 1 || gameLevel == 2) { // runs code for 2 PLAYER EASY OR HARD MODE.
    background (darkPink); 
    drawBall (ballX, ballY); // method call to draw the white ball.
    moveBall (); // method call to move the white ball.
    checkBallHitEdge (); // method call to bounce the white ball of the edge of the window.
    drawPaddles (paddleX, paddleY, yellow); // method call to draw the yellow paddle for player 1.
    drawPaddles (paddle2X, paddle2Y, darkBlue); // method call to draw the blue paddle for player 2.
    movePaddles (); // method call to move both paddles.
    checkPaddlesHitEdge (paddleX); // method call to make the yellow paddles bounce off the edge of the window.
    checkPaddlesHitEdge (paddle2X); // method call to make the blue paddles bounce off the edge of the window.
    checkBallHitPaddle (paddleX, paddleY); // method call to make the ball bounce off the edge of the yellow paddle.
    checkBallHitPaddle (paddle2X, paddle2Y); // method call to make the ball bounce off the edge of the blue paddle.
    scoreDisplay (); // method call to display the scores for player 1/yellow paddle and 2/blue paddle.
    winnerScreen (); // method call to display the winner of the game and end the game.
  } else if (gameState == 5 && gameMode == 2 && gameLevel == 1 || gameLevel == 2) { // runs code for COMPUTER PLAYER EASY OR HARD MODE.
    background (darkPink);
    drawBall (ballX, ballY); // method call to draw the white ball.
    moveBall (); // method call to move the white ball.
    checkBallHitEdge (); // method call to bounce the white ball of the edge of the window.
    drawPaddles (paddleX, paddleY, yellow); // method call to draw the yellow paddle for player 1.
    drawPaddles (paddle2X, paddle2Y, darkBlue); // method call to draw the blue paddle for player 2.
    movePaddles (); // method call to move the blue paddle for player 2 with user input.
    computerPlayer (); // method call to move the yellow paddle for the Computer player/player 1.
    checkPaddlesHitEdge (paddleX); // method call to make the yellow paddles bounce off the edge of the window.
    checkPaddlesHitEdge (paddle2X); // method call to make the blue paddles bounce off the edge of the window.
    checkBallHitPaddle (paddleX, paddleY); // method call to make the ball bounce off the edge of the yellow paddle.
    checkBallHitPaddle (paddle2X, paddle2Y); // method call to make the ball bounce off the edge of the blue paddle.
    scoreDisplay (); // method call to display the scores for player 1/yellow paddle and 2/blue paddle.
    winnerScreen (); // method call to display the winner of the game and end the game.
  }
}

void welcomeScreen () { // method for displaying welcome screen text.
  background (lightPink); 
  scaledText ("P I N K", 190, 175, textSize90, darkPink, font);
  scaledText ("P O N G", 155, 335, textSize90, white, font2);
  scaledText ("To continue, PRESS the spacebar.", 148, 500, textSize25, black, font3);
}

void gameMode () { // method for displaying game mode selection screen text.
  background (darkPink);
  color textColour = white; // variable to control the colour of all text on game mode screen except title.
  scaledText ("SELECT A GAME MODE", 35, 90, textSize50, lightPink, font2);
  scaledText ("2 Player Mode", 240, 170, textSize30, textColour, font2);
  scaledText ("To play 2 Player Mode, PRESS 1", 185, 270, textSize25, textColour, font4);
  scaledText ("Computer Player Mode", 170, 370, textSize30, textColour, font2);
  scaledText ("To play Computer Player Mode, PRESS 2", 120, 470, textSize25, textColour, font4);
}

void level () { // method for displaying game level selection screen text.
  background (darkPink);
  color textColour = white; // variable to control the colour of all text on game mode screen except title.
  scaledText ("SELECT A LEVEL", 120, 90, textSize50, lightPink, font2);
  scaledText ("Easy Mode", 260, 170, textSize30, textColour, font2);
  scaledText ("To play Easy Mode, PRESS 3", 185, 270, textSize25, textColour, font4);
  scaledText ("Hard Mode", 260, 370, textSize30, textColour, font2);
  scaledText ("To play Hard Mode, PRESS 4", 185, 470, textSize25, textColour, font4);
}

void instruction () { // method for displaying instruction screen text.
  PFont textFont = font4; // variable to control the font of all text under the two subtitles except the last sentence.
  color textColour = white; // variable to control the colour of all text except the title and last sentence.
  background (lightPink); // sets the background colour to light pink.
  scaledText ("HOW TO PLAY", 155, 90, textSize50, darkPink, font2);
  scaledText ("FOR 2 PLAYER MODE:", 170, 140, textSize30, textColour, font2);
  scaledText ("Use the right and left arrow key for the blue paddle for player 2.", 10, 180, textSize25, textColour, textFont); 
  scaledText ("Use the A/left and D/right keys for the yellow paddle for player 1.", 10, 230, textSize25, textColour, textFont); 
  scaledText ("If one player fails to return the ball using the paddle to the", 50, 275, textSize25, textColour, textFont); 
  scaledText ("other player, the second player will be awarded a point.", 60, 305, textSize25, textColour, textFont); 
  scaledText ("FOR COMPUTER PLAYER MODE:", 90, 370, textSize30, textColour, font2);
  scaledText ("Use the right and left arrow keys to control the blue paddle", 45, 410, textSize25, textColour, textFont); 
  scaledText ("for player 2. The computer is the yellow paddle or player 1.", 45, 440, textSize25, textColour, textFont); 
  scaledText ("First player to 10 points wins!", 190, 495, textSize25, textColour, textFont); 
  scaledText ("PRESS the enter key to begin the game!", 105, 565, textSize25, black, font3);
}

void drawBall (int xPosition, int yPosition) { // method for drawing a scaled white ball.
  fill (white); // fills any following shapes drawn with white colour.
  scaledBall (xPosition, yPosition, ballSize, ballSize); // scaled ellipse method to draw a scaled white ball.
}

void moveBall () { // method for moving the white ball.
  ballX = ballX + xSpeed; // adds value stored in xSpeed variable to x position of the ball to move it horizontally.
  ballY = ballY + ySpeed; // adds value stored in ySpeed variable to y position of the ball to move it vertically.
}

void checkBallHitEdge () { // method to bounce the white ball of the edge of the window by changing speeds under speific conditions.
  int windowWidth = width - ballSize; // variables store the parameters of the window width and height in relation to the size of the ball.
  int windowHeight = height - ballSize; // variables store the parameters of the window width and height in relation to the size of the ball.
  if (ballX <= ballSize || ballX >= windowWidth) { // runs the code inside only if the x position of the ball is between 16 and 684.
    xSpeed = -xSpeed; // changes the value stored in the xSpeed variable for the ball to negative to change ball's x direction.
  }
  if (ballY <= ballSize) { // runs the code inside only if the y position of the ball is less than or equal to 16.
    ySpeed = -ySpeed; // changes the value stored in the ySpeed variable for the ball to negative to change ball's y direction.
    xSpeed = 5; // resets the x speed of the ball to their original values for hard mode.
    ySpeed = -5; // resets the y speed of the ball to their original values for hard mode.
    ballX = width/2; // resets the x position of the ball to the middle of the screen.
    ballY = height/2; // resets the y position of the ball to the middle of the screen.
    scoreP2++ ; // player 2 with the blue paddle gets 1 point.
  } else if (ballY >= windowHeight) { // runs the code inside only if the y position of the ball is greater than or equal to 584.
    ySpeed = -ySpeed; // changes the value stored in the ySpeed variable for the ball to negative to change ball's y direction.
    xSpeed = 5; // resets the x speed of the ball to their original values for hard mode.
    ySpeed = -5; // resets the y speed of the ball to their original values for hard mode.
    ballX = width/2; // resets the x position of the ball to the middle of the screen.
    ballY = height/2; // resets the y position of the ball to the middle of the screen.
    scoreP1++ ; // player 1 with the yellow paddle gets 1 point.
  }
}

void drawPaddles (int xPaddle, int yPaddle, color paddleColour) { // method to draw the 2 paddles for 2 players.
  rectMode (CENTER); // draws the rectangle from its center using the x and y values.
  fill (paddleColour); // fills any following shapes drawn with the colour stored in the paddleColour variable.
  scaledPaddles (xPaddle, yPaddle, 100, 46); // draws a scaled rectangle for paddles 1 and 2 using the parameters.
}

void movePaddles () { // method for moving the 2 paddles right and left using boolean expressions.
  if (paddle1Right && gameMode == 1) { // runs if boolean expression condition is true when a key is pressed.
    paddleX += xP1Speed; // adds value stored in xP1Speed variable to paddleX position to move it right.
  }
  if (paddle1Left && gameMode == 1) { // runs if boolean expression condition is true when d key is pressed.
    paddleX -= xP1Speed; // subtracts value stored in xP1Speed variable from paddleX position to move it left.
  }
  if (paddle2Right) { // runs if boolean expression condition is true when left arrow key is pressed.
    paddle2X += xP2Speed; // adds value stored in xP2Speed variable to paddle2X position to move it right.
  }
  if (paddle2Left) { // runs if boolean expression condition is true when right arrow key is pressed. 
    paddle2X -= xP2Speed; // subtracts value stored in xP2Speed variable from paddle2X position to move it left.
  }
}

void computerPlayer () { // method for moving the yellow paddle for the computer player right and left using boolean expressions.
  paddleX = ballX + xP1Speed; // moves the yellow paddle horizontally with the ball's x position and its horizontal speed.
}

void checkPaddlesHitEdge (int pX) { // method to make the 2 paddles bounce off the edge of the window and stay in the window frame.
  int paddleRight = pX + 50; // dummy variable to represent the right side for paddle 1 and 2.
  int paddleLeft = pX - 50; // dummy variable to represent the left side for paddle 1 and 2.
  if (paddleRight >= 700 && pX == paddleX) { 
    paddleX = abs (paddleLeft); // ensures the yellow paddle's x position is an absolute value to make it bounce left.
  } else if (paddleRight >= 700 && pX == paddle2X) { 
    paddle2X = abs (paddleLeft); // ensures the blue paddle's x position is an absolute value to make it bounce left.
  } else if (paddleLeft <= 0 && pX == paddleX) { 
    paddleX = abs (paddleRight); // ensures the yellow paddle's x position is an absolute value to make it bounce right.
  } else if (paddleLeft <= 0 && pX == paddle2X) { 
    paddle2X = abs (paddleRight); // ensures the yellow paddle's x position is an absolute value to make it bounce right.
  }
}

void checkBallHitPaddle (int pX, int pY) { // method to make the ball bounce off the edge of both paddles.
  int paddleRight = pX + 50; // variable stores the measurement of the right side of the 2 paddles.
  int paddleLeft = pX - 50; // variable stores the measurement of the left side of the 2 paddles.
  int paddleTop = pY - 23; // variable stores the measurement of the top side of the 2 paddles.
  int paddleBottom = pY + 23; // variable stores the measurement of the bottom side of the 2 paddles.
  int ballRight = ballX + 8; // variable stores the measurement of the right side of the ball.
  int ballLeft = ballX - 8; // variable stores the measurement of the left side of the ball.
  int ballTop = ballY - 8; // variable stores the measurement of the top side of the ball.
  int ballBottom = ballY + 8; // variable stores the measurement of the bottom side of the ball.
  if (ballTop < paddleBottom && ballLeft < paddleRight &&
    ballRight > paddleLeft &&
    ballBottom > paddleTop) { // runs the code inside it if the ball and paddle are at certain positions in relation with one another.
    if (ballY > height/2) { // runs the code inside it if the ball's y position is in the first half of the canvas.
      ySpeed = -abs (ySpeed); // changes the balls y speed to a negative absolute value to make it bounce downward.
    } else {
      ySpeed = abs (ySpeed); // changes the balls y speed to an absolute value to make it bounce upward.
    }
    if (gameLevel == 2) { // runs the code inside it ONLY IN HARD MODE.
      xSpeed += 2; // increases the x/horizontal speed of the ball every time it hits the paddle.
      ySpeed += 2; // increases the y/vertical speed of the ball every time it hits the paddle.
    }
  }
}

void scoreDisplay () { // method to display the scores for player 1/yellow paddle and 2/blue paddle.
  int x = 650; // variable x stores a value of 650.
  int textSize = 25; // initializes the variable textSize and stores a value of 25 in it.
  scaledScoreDisplay (scoreP1, x, 200, textSize, yellow); // method call for scaled player 1 score displayed using provided values.
  scaledScoreDisplay (scoreP2, x, 400, textSize, darkBlue); // method call for scaled player 2 score displayed using provided values.
}

void winnerScreen () { // method to display the winner of the game and end the game.
  PFont fontType = font5; // variable stores the font of all text in the method.
  if (scoreP1 == 10) { 
    background (lightPink);
    scaledText ("GAME OVER", 110, 190, textSize90, darkPink, fontType); // method call for scaled game over text displayed using provided values.
    scaledText ("PLAYER 1 IS THE WINNER!", 10, 350, textSize50, darkPink, fontType); // method call for scaled text displayed using provided values.
    noLoop (); // stops the program from executing code in draw loop to end the game.
  } else if (scoreP2 == 10) {
    background (lightPink);
    scaledText ("GAME OVER", 110, 190, textSize90, darkPink, fontType); // method call for scaled game over text displayed using provided values.
    scaledText ("PLAYER 2 IS THE WINNER!", 10, 350, textSize50, darkPink, fontType); // method call for scaled text displayed using provided values.
    noLoop (); // stops the program from executing code in draw loop to end the game.
  }
}

void keyPressed () { // runs the code it contains when certain keys are pressed.
  if (gameState == 1) { // WELCOME SCREEN
    if (keyCode == 32) { // runs the code inside it only if the spacebar key is pressed.
      gameState = 2; // changes the value of the gameState variable to 2.
    }
  } else if (gameState == 2) { // GAME MODE SCREEN
    if (keyCode == 49) { // runs the code inside it only if the number 1 key is pressed.
      gameMode = 1; // 2 PLAYER MODE
      gameState = 3; // changes the value of the gameState variable to 3.
    } else if (keyCode == 50) { // runs the code inside it only if the number 2 key is pressed.
      gameMode = 2; // COMPUTER AI MODE
      gameState = 3; // changes the value of the gameState variable to 3.
    }
  } else if (gameState == 3) { // GAME LEVEL SCREEN
    if (keyCode == 51) { // runs the code inside it only if the number 3 key is pressed.
      gameLevel = 1; // EASY MODE
      gameState = 4; // changes the value of the gameState variable to 4.
    } else if (keyCode == 52) { // runs the code inside it only if the number 4 key is pressed.
      gameLevel = 2; // HARD MODE
      gameState = 4; // changes the value of the gameState variable to 4.
    }
  } else if (gameState == 4) { // INSTRUCTIONS SCREEN
    if (keyCode == 10) { // runs the code inside it only if the enter key is pressed.
      gameState = 5; // changes the value of the gameState variable to 5.
    }
  } else if (gameState == 5 && gameMode == 1 && gameLevel == 1 || gameLevel == 2) { // 2 PLAYER EASY OR HARD MODE.
    if (keyCode == 68) { // runs only if the 'd' key is pressed to move yellow paddle to the right.
      paddle1Right = true; // sets the boolean expression to true.
    }
    if (keyCode == 65) { // runs only if the 'a' key is pressed to move yellow paddle to the left.
      paddle1Left = true; // sets the boolean expression to true.
    }
    if (keyCode == 39) { // runs only if right arrow key is pressed to move blue paddle.
      paddle2Right = true; // sets the boolean expression to true.
    }
    if (keyCode == 37) { // runs only if left arrow key is pressed to move blue paddle.
      paddle2Left = true; // sets the boolean expression to true.
    }
  } else if (gameState == 5 && gameMode == 2 && gameLevel == 1 || gameLevel == 2) { // COMPUTER PLAYER EASY OR HARD MODE.
    if (keyCode == 39) { // runs only if right arrow key is pressed to move blue paddle.
      paddle2Right = true; // sets the boolean expression to true.
    }
    if (keyCode == 37) { // runs only if left arrow key is pressed to move blue paddle.
      paddle2Left = true; // sets the boolean expression to true.
    }
  }
}

void keyReleased () { // runs the code it contains when certain keys are released.
  if (keyCode == 65) { // runs only if the 'a' key is released to stop moving the yellow paddle to the left.
    paddle1Left = false; // sets the boolean expression to false.
  }
  if (keyCode == 68) { // runs only if the 'd' key is released to stop moving the yellow paddle to the right.
    paddle1Right = false; // sets the boolean expression to false.
  }
  if (keyCode == 37) { // runs only if left arrow key is released to stop moving the blue paddle.
    paddle2Left = false; // sets the boolean expression to false.
  }
  if (keyCode == 39) { // runs only if right arrow key is released to stop moving the blue paddle.
    paddle2Right = false; // sets the boolean expression to false.
  }
}

void scaledPaddles (int x, int y, int w, int h) { // a method for scaling the paddles in the program.
  rect (x*width/700, y*height/600, w*width/700, h*height/600, 10); // draws a scaled rectangle/paddles using appropriate parameters.
}

void scaledBall (int x, int y, int w, int h) { // a method for scaling the ball in the program.
  ellipse (x*width/700, y*height/600, w*width/700, h*height/600); // draws a scaled ball/ellipse using appropriate parameters.
}

void scaledText (String text, int x, int y, int size, color textColour, PFont textFont) { // a method for scaling text in the program.
  fill (textColour); // sets the colour of the text based on the colour set in the method call parameters.
  textFont (textFont, size); // sets the font and the size of the text based on method call parameters.
  textSize (size*width/700); // sets the size of the text based on method call parameters and makes it resizable.
  text (text, x*width/700, y*height/600); // displays the text stored in the variable on appropriate x and y position.
}

void scaledScoreDisplay (int score, int x, int y, int size, color textColour) { // a method for scaling the score of player 1 and 2 in the program.
  fill (textColour); // sets the colour of the text based on the colour set in the method call parameters.
  textSize (size*width/700); // sets the size of the text based on method call parameters and makes it resizable.
  text (score, x*width/700, y*height/600); // displays the values stored as the scores of players 1 and 2 on appropriate x and y position.
}
