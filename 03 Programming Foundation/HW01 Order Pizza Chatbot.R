
# Create a pizza-ordering chatbot using R programming
# - The chatbot engages users in a conversation, welcoming them to 'Local Pizza.' 
# - Users can place an order by responding with 'Yes' or end the conversation with 'Exit.'
# - Upon choosing to order, users specify the type and size of the pizza, additional toppings, preferred drinks, and whether they want to add more items.
# - Once the order is complete, the chatbot provides an order summary and informs users that the food will be ready in 25 minutes.

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
