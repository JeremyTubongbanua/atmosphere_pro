class TextStrings {
  TextStrings._();
  static TextStrings _instance = TextStrings._();
  factory TextStrings() => _instance;

  // home screen texts
  String homeFileTransferItsSafe = 'File transfer.\nIt’s safe!';
  String homeHassleFree = 'Hassle free.\n';
  String homeWeWillSetupAccount = 'We will set up your account right away.';

  // welcome screen texts
  String welcomeUser(String userName) => 'Welcome\n $userName!';
  String welcomeRecipient = 'Select a recipient and start sending them files.';
  String welcomeSendFilesTo = 'Send file to';
  String welcomeContactPlaceholder = '@sign';
  String welcomeFilePlaceholder = 'Select file to transfer';
  String welcomeAddFilePlaceholder = 'Add file to transfer';

  //sidebar menu texts
  String sidebarContact = 'Contact';
  String sidebarTransferHistory = 'Transfer History';
  String sidebarBlockedUser = 'Blocked User';
  String sidebarTermsAndConditions = 'Terms and Conditions';
  String sidebarFaqs = 'FAQ';
  String sidebarAutoAcceptFile = 'Auto Accept Files';
  String sidebarEnablingMessage =
      'Enabling this will auto accept all the files sent by your contacts.';
  String sidebarSwitchOut = 'Switch @sign';

  //FAQs texts
  String faqs = 'FAQ';

  //Contact texts
  String searchContact = 'Search Contact';
  String addContactSearch = 'Search @sign';
  String contactSearchResults = 'Search Results';
  String addContact = 'Add Contact';

  // buttons text
  String buttonStart = 'Start';
  String buttonSend = 'Send';
  String buttonClose = 'Close';
  String accept = 'Accept';
  String reject = 'Reject';

  //history screen texts
  String sent = 'Sent';
  String received = 'Received';
  String moreDetails = 'More Details';
  String lesserDetails = 'Lesser Details';

  //receive files texts
  String blockUser = 'Block User';

  //add contact texts
  String addContactHeading =
      'Are you sure you want to add the user to your contact list?';
  String yes = 'Yes';
  String no = 'No';

  // terms and conditions texts
  String termsAppBar = 'Terms and Conditions';
  String termsAndConditions =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\n Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\n Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  // scan qr texts
  String scanQrTitle = 'Scan QR Code';
  String scanQrMessage = 'Just scan the QR code displayed at\nwww.atsign.com';
  String scanQrFooter = 'Don’t have an @sign? Get now.';
}