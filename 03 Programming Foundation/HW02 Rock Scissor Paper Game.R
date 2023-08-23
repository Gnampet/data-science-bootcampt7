
# Creating a Rock-Scissors-Paper Game in R
# The game sets up the initial scores for the user and the computer as well as a counter for the rounds played. 
# It defines the available options: "rock," "scissors," and "paper."
# After each round, the code prints the computer's choice and the outcome of the round (win, tie, or loss).
# If the user types "exit," the game concludes. The total rounds played, the user's score, and the computer's score are displayed

# Loop Function: while(TRUE) 

# Useer and Computer Input:
# - user: The user is the option to input their choice among "rock," "scissor," or "paper" using the readline function.
# - computer: The computer randomly selects an option from the available choices.

#==================================================================================================================================

roshambo <- function(){
  user_score <-  0
  computer_score <- 0
  round <- 0
  
  
  options <- c("rock", "scissor", "paper")
  print("Let's play game YEAHHH!!")
  print("Type'exit' if you want to end the game.")
  print(options)
  print("-------------------------------")
  
  while(TRUE){
    user <- readline("Your turn! choose one: ")
    round <- round + 1 
    if (user == "exit"){
      cat("Total round: ",round - 1,
          "\n Your score: ",user_score, 
          "\n My score: ", computer_score,
          "\n Thank you for playing with me!, See you next time Bye!")
      
      break
    } else {
      computer <- sample(options, 1)
      print(computer)
    } 
    if ((user == "rock" && computer == "scissor") ||
        (user == "scissor" && computer == "paper") ||
        (user == "paper" && computer == "rock")){
      user_score <-  user_score + 1

      print("You Win!")
    } else if (user == computer){
      print("Tie")
    } else  {
      computer_score <- computer_score + 1
      print("I'm Win!")
    }
  }
}
