class MarriageDetails {
  String? partner1Name;
  String? partner2Name;
  DateTime? marriageDate;
  String? venue;

  MarriageDetails({
    this.partner1Name,
    this.partner2Name,
    this.marriageDate,
    this.venue,
  });

  // Optional: Add methods for serialization/deserialization if you plan to save/load data
  // For example, toMap() and fromMap() for JSON or database operations.

  @override
  String toString() {
    return 'MarriageDetails(\n'
        '  partner1Name: $partner1Name,\n'
        '  partner2Name: $partner2Name,\n'
        '  marriageDate: $marriageDate,\n'
        '  venue: $venue\n'
        ')';
  }
}