class ConstantsData {
  static const appName = 'chatty';
  static const noInternet = 'No Internet';
  static const noInternetDescription =
      'Please check your internet connection and try again';
  static const ok = 'OK';
  static const emailValidation = 'Please enter Email';
  static const verifyEmailValidation = 'Please enter valid Email';
  static const passwordValidation = 'Please enter Password';
  static const nameValidation = 'Please enter Name';
  static const imageValidation = 'Please upload Photo';
  static const confirmPasswordValidation = 'Please confirm Password';
  static const verifyPasswordValidation = 'Password mismatched';
  static const registeredSuccesfully = 'Registration Successful';
  static const loggedSuccesfully = 'Login Successful';
  static const somethingWentWrong = 'Something went wrong';
  static const invalidCredentials = 'Invalid Credentials';
  static const notRegistered = 'User not registered';
  static const loggedOutSuccesfully = 'Logout Successful';
  static const logoutAlert = 'Logging out?';
  static const logoutAlertDescription = 'Are you sure you want to log out?';
  static const cancel = 'Cancel';
  static const profile = 'Profile';
  static const addImage = 'Upload Photo';
  static const addName = 'Add Name';
  static const addEmail = 'Add Email';
  static const edit = 'Save Changes';
  static const savedSuccessfully = 'Saved Successfully';
  static const addFriends = 'Add Friends';
  static const emptyMessage = 'No Chatters found !!!';
    static const emptyDescription = 'New chatters will be joining soon. Hang in there';





  // Collection Names
  static const users = 'Users';
  static const chats = 'Chats';



  // Document Names
  // User
  static const id = 'user_id';
  static const name = 'name';
  static const email = 'email';
  static const imageUrl = 'image_url';
  static const contactId = 'contact_id';
  static const createdTime = 'created_time';

  // Chat
  static const senderId = 'sender_id';
  static const senderName = 'sender_name';
  static const receivingId = 'receiving_id';
  static const receivingName = 'receiving_name';
  static const chatId = 'chat_id';
  static const message = 'message';
  static const date = 'date';

  
  




}
class Collections{
  static const users = 'Users';
  static const chats = 'Chats';
    
  }

class UserCollection{
  static const userId = 'user_id';
  static const name = 'name';
  static const email = 'email';
  static const imageUrl = 'image_url';
  static const createdTime = 'created_date';

}

class ChatCollection{
   static const senderId = 'sender_id';
  static const senderName = 'sender_name';
  static const receivingId = 'receiving_id';
  static const receivingName = 'receiving_name';
  static const chatId = 'chat_id';
  static const message = 'message';
  static const date = 'date';
  static const receiverImageUrl = 'receiver_image_url';
  static const senderImageUrl = 'sender_image_url';


}
