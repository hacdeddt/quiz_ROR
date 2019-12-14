# Multiple choice test website:
## Due to almost all subjects currently, the exams are multiple-choice. So I made this test website to meet the users' study needs, to reinforce my knowledge and to store all the multiple-choice questions.

## The website has 2 rights as a normal user and an administrator (admin).
- Users usually have the rights to:
+ Create an account or log in with facebook.
+ Edit personal information, change passwords.
+ View personal pages of others
+ Add, edit, delete their questions, view all the approved questions in the question bank.
+ Add questions by importing excel file
+ Add exam questions, add questions in the question bank to the exam questions, edit, delete exam questions.
+ Print the exam into pdf file
+ Take the test, see the detailed answer after taking the test.
+ Review or delete results after taking the test.

## Admin has rights:
+ Has all the rights of normal users.
+ Can manage users, ban users.
+ Review questions before adding questions to the questions bank. Questions after being added or modified must be approved by admin. If the question is not appropriate, the question can be deleted, if the question has been approved but then modified to bad content (possibly modified or deliberately by bad guys), it can be restored as last approved.
+ Add to delete a subject, add to delete a class.
+ Exam management
+ After deleting the question, the user will send an email notification.

## Some other characteristics
Validated to avoid xss and csrf attacks
Validated password more secure, the password must be at least 8 characters including uppercase, lowercase and numbers.
Use md5 to check if the question or exam already exists.

## Link video demo: https://www.youtube.com/watch?v=kmpb87UWw2E

