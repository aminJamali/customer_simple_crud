Feature: Add Customer
  The customer must be added when the user submits a valid customer

  Scenario: User observes an error when submits a customer with invalid mobile number
    Given User observes "Nothing to show!" text in Customer List
    And Navigates to the Add Customer Screen by tapping "addCustomer" button
    When User create the customer with invalid mobile number
    And  fill the "firstName" field with "John"
    And  fill the "lastName" field with "Doe"
    And  fill the "email" field with "amin@gmail.com"
    And  fill the "mobileNumber" field with "5550112366"
    And  fill the "bankAccountNumber" field with "123456789"
    And  tap on the "dateOfBirth" button
    And  tap on the "Submit Date" date button
    And  tap on the "submit" button
    Then user observes the error that "mobile number is not valid"
    When user corrects the mobile number into a valid mobile number
    And  fill the "mobileNumber" field with "2125556789"
    And  tap on the "submit" button
    Then user observes the "Successfully Submitted!" message
    And  user observes "John Doe" customer in the records list
    When user edits the customer to a new valid customer
    And  tap on the "more" button
    And  tap on the "edit" button
    And  fill the "firstName" field with "Amin"
    And  fill the "lastName" field with "Jamali"
    And  fill the "email" field with "aminNew@gmail.com"
    And  fill the "mobileNumber" field with "2125556778"
    And  fill the "bankAccountNumber" field with "123456788"
    And  tap on the "dateOfBirth" button
    And  tap on the "Submit Date" date button
    And  tap on the "submit" button
    Then user observes the "Successfully Submitted!" message
    And  user observes "Amin Jamali" customer in the records list


         
