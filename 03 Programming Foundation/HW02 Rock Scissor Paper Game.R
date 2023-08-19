# Create a Rock Scissor Paper game in R programming

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
