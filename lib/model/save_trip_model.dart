List checkListItems = [
  {
    "id": 0,
    "value": false,
    "title": "Family",
  },
  {
    "id": 1,
    "value": false,
    "title": "Friends",
  },
  {
    "id": 2,
    "value": false,
    "title": "Couple",
  },
];

List checkListItems2 = [
  {
    "id": 0,
    "value": false,
    "title": "3 Star",
  },
  {
    "id": 1,
    "value": false,
    "title": "4 Star",
  },
  {
    "id": 2,
    "value": false,
    "title": "Budget Hotel",
  },
];

List improveListingCheckbox = [
  {
    "value": false,
    "title": "About place",
  },
  {
    "value": false,
    "title": "Spot photo",
  },
  {
    "value": false,
    "title": "Location",
  },
  {
    "value": false,
    "title": "Timing",
  },
  {
    "value": false,
    "title": "Experience",
  },
  {
    "value": false,
    "title": "Missing place",
  },
  {
    "value": false,
    "title": "Safety",
  },
  {
    "value": false,
    "title": "Others",
  },
];

class IncludesModel {
  String name;
  bool isSelected;
  IncludesModel({required this.name, required this.isSelected});
}

List<IncludesModel> includesList = [
  IncludesModel(name: 'Pickup and drop', isSelected: false),
  IncludesModel(name: 'Sightseeing Transport', isSelected: false),
  IncludesModel(name: 'Travel Guide', isSelected: false),
  IncludesModel(name: 'Infant assistance', isSelected: false),
];

class SaveWishItem {
  String userName;
  String item;
  List<String> dropDown;
  String selectedValaue;
  SaveWishItem(
      {required this.selectedValaue,
      required this.userName,
      required this.dropDown,
      required this.item});
}

List<SaveWishItem> saveWishList = [
  SaveWishItem(
      userName: 'Joesson',
      dropDown: ['Carry and take back', 'Take on Rent', 'Buy while trip'],
      item: 'DSLR         ',
      selectedValaue: 'Buy while trip'),
  SaveWishItem(
      userName: 'Sumit',
      dropDown: ['Carry and take back', 'Take on Rent', 'Buy while trip'],
      item: 'Guitar        ',
      selectedValaue: 'Buy while trip'),
  SaveWishItem(
      userName: 'Rajiv',
      dropDown: ['Carry and take back', 'Take on Rent', 'Buy while trip'],
      item: 'First Aid Box',
      selectedValaue: 'Buy while trip'),
  SaveWishItem(
      userName: 'varun',
      dropDown: ['Carry and take back', 'Take on Rent', 'Buy while trip'],
      item: 'Snacks       ',
      selectedValaue: 'Buy while trip'),
  SaveWishItem(
      userName: 'Mayur',
      dropDown: ['Carry and take back', 'Take on Rent', 'Buy while trip'],
      item: 'Energy Drink',
      selectedValaue: 'Buy while trip'),
];

class TripLibrary {
  String inviteAndRequest;
  String img;
  TripLibrary({required this.inviteAndRequest, required this.img});
}

List<TripLibrary> tripLibraryList = [
  TripLibrary(
      inviteAndRequest: 'Requested to join', img: 'assets/images/beach.png'),
  TripLibrary(
      inviteAndRequest: 'Invited to join', img: 'assets/images/mountain.png'),
  TripLibrary(
      inviteAndRequest: 'Requested to join', img: 'assets/images/mountain.png'),
];

class SelectDocument {
  String name;
  bool isSelected;
  SelectDocument({required this.name, required this.isSelected});
}

List<SelectDocument> selectDocumentList = [
  SelectDocument(name: 'Aadhar', isSelected: false),
  SelectDocument(name: 'Driving Licence', isSelected: false),
  SelectDocument(name: 'Passport', isSelected: false),
];

List<SelectDocument> incorrectCheckboxList = [
  SelectDocument(name: 'User in business', isSelected: false),
  SelectDocument(name: 'Wrong content', isSelected: false),
  SelectDocument(name: 'Copyright', isSelected: false),
  SelectDocument(name: 'Adult Content', isSelected: false),
  SelectDocument(name: 'Abusive', isSelected: false),
  SelectDocument(name: 'Other', isSelected: false),
];

List<SelectDocument> incorrectTripCheckboxList = [
  SelectDocument(name: 'Trip in business', isSelected: false),
  SelectDocument(name: 'Wrong content', isSelected: false),
  SelectDocument(name: 'Copyright', isSelected: false),
  SelectDocument(name: 'Adult Content', isSelected: false),
  SelectDocument(name: 'Abusive', isSelected: false),
  SelectDocument(name: 'Other', isSelected: false),
];

List<SelectDocument> feedBackCheckboxList = [
  SelectDocument(name: 'Save Trips', isSelected: false),
  SelectDocument(name: 'Trip friends', isSelected: false),
  SelectDocument(name: 'Prima \nSubscription', isSelected: false),
  SelectDocument(name: 'Event trip', isSelected: false),
  SelectDocument(name: 'Prima trips', isSelected: false),
  SelectDocument(name: 'Aspired trips', isSelected: false),
  SelectDocument(name: 'Trip Library', isSelected: false),
  SelectDocument(name: 'Travel Utility', isSelected: false),
  SelectDocument(name: 'Advertidement', isSelected: false),
  SelectDocument(name: 'Refund', isSelected: false),
  SelectDocument(name: 'Co-traveler', isSelected: false),
  SelectDocument(name: 'Friends in nVicinity', isSelected: false),
  SelectDocument(name: 'Save trips', isSelected: false),
  SelectDocument(name: 'Trip Interest', isSelected: false),
  SelectDocument(name: 'Tourist Spots', isSelected: false),
  SelectDocument(name: 'Quick Escape', isSelected: false),
  SelectDocument(name: 'Bookmarking', isSelected: false),
  SelectDocument(name: 'Others', isSelected: false),
];
