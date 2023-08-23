
# Creating a Pizza Ordering Chatbot in R

# The code initiates by introducing users to the chatbot's purpose. It prints a welcoming message, inviting users to interact with the "Local Pizza" chatbot. Users are informed that they can exit the conversation by typing "Exit."

# Loop Function: while(TRUE)

# Users Input:
# - user_select: Users respond "Yes" to place an order or "Exit" to end the conversation.
# - order_pizza: The user specifies the type of pizza they desire.
# - order_size: The user indicates the desired size of the pizza.
# - order_topping: The user is prompted to decide whether they want to add more toppings.
# - order_drink: The user selects their preferred beverage.
# - order_more: The user is asked whether they want to add more items.

#=====================================================================================================================================

chatbot <- function(){

  print("Welcome to Local Pizza!")
  print("You can type 'Exit' if you want to end the conversation.")
  print("------------------------------------")
  
  while(TRUE){
    user_select = readline("May I take your order? (Yes/Exit): ")
    if (user_select == "Exit"){
        print("Thank you for using our service")
      break 
    } else if (user_select == "Yes"){
        order_pizza = readline("What kind of pizza would you like??: ")
        order_size = readline("What size please?:")
        order_topping = readline("Do you want to add more topping?: ")
        order_drink = readline("What would you like to drinks?: ")
        order_more = readline("Anything else?(Yes/No): ")
    if (order_more == "No") {
      print("Here is your order summary")
      print(c(order_pizza, order_size, order_topping, order_drink))
      print("The food you ready in 25 minute, Thank you for using our service.")
      break
    }
        
}
}
} 
