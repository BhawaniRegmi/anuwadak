class AbroadStudyScreen extends StatefulWidget {
  const AbroadStudyScreen({super.key});

  @override
  State<AbroadStudyScreen> createState() => _AbroadStudyScreenState();
}

class _AbroadStudyScreenState extends State<AbroadStudyScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedProgram = 'All Programs';
  String _selectedLocation = 'All Locations';
  double _minRating = 0.0;

  // Dummy data for demonstration
  List<University> _allUniversities = [
    University(
      name: 'University of Toronto',
      location: 'Canada',
      program: 'Computer Science',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/8/87/University_of_Toronto_crest.svg/1200px-University_of_Toronto_crest.svg.png',
      rating: 4.8,
    ),
    University(
      name: 'University College London (UCL)',
      location: 'UK',
      program: 'Law',
      imageUrl:
          'https://www.ucl.ac.uk/sites/ucl-news/files/styles/full_width_image/public/ucl-portico-flag-desktop_1.jpg?itok=xU-h3L-g',
      rating: 4.5,
    ),
    University(
      name: 'Stanford University',
      location: 'USA',
      program: 'Engineering',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Stanford_University_Seal.svg/1200px-Stanford_University_Seal.svg.png',
      rating: 4.9,
    ),
    University(
      name: 'Technische Universität München (TUM)',
      location: 'Germany',
      program: 'Architecture',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Wappen_der_Technischen_Universit%C3%A4t_M%C3%BCnchen.svg/1200px-Wappen_der_Technischen_Universit%C3%A4t_M%C3%BCnchen.svg.png',
      rating: 4.6,
    ),
    University(
      name: 'University of Melbourne',
      location: 'Australia',
      program: 'Medicine',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/9/90/University_of_Melbourne_seal.svg/1200px-University_of_Melbourne_seal.svg.png',
      rating: 4.7,
    ),
    University(
      name: 'University of British Columbia (UBC)',
      location: 'Canada',
      program: 'Environmental Studies',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/8/80/UBC_crest_transparent.svg/1200px-UBC_crest_transparent.svg.png',
      rating: 4.4,
    ),
  ];

  List<University> _filteredUniversities = [];

  @override
  void initState() {
    super.initState();
    _filteredUniversities = _allUniversities;
    _searchController.addListener(_filterUniversities);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUniversities);
    _searchController.dispose();
    super.dispose();
  }

  void _filterUniversities() {
    setState(() {
      _filteredUniversities = _allUniversities.where((university) {
        final searchText = _searchController.text.toLowerCase();
        final matchesSearch = university.name.toLowerCase().contains(searchText) ||
            university.location.toLowerCase().contains(searchText) ||
            university.program.toLowerCase().contains(searchText);

        final matchesProgram = _selectedProgram == 'All Programs' ||
            university.program == _selectedProgram;

        final matchesLocation = _selectedLocation == 'All Locations' ||
            university.location == _selectedLocation;

        final matchesRating = university.rating >= _minRating;

        return matchesSearch && matchesProgram && matchesLocation && matchesRating;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abroad Study'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search universities, programs, locations...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDropdownFilter(
                    label: 'Program',
                    value: _selectedProgram,
                    items: [
                      'All Programs',
                      'Computer Science',
                      'Law',
                      'Engineering',
                      'Architecture',
                      'Medicine',
                      'Environmental Studies'
                    ],
                    onChanged: (newValue) {
                      setState(() {
                        _selectedProgram = newValue!;
                        _filterUniversities();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildDropdownFilter(
                    label: 'Location',
                    value: _selectedLocation,
                    items: ['All Locations', 'Canada', 'UK', 'USA', 'Germany', 'Australia'],
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue!;
                        _filterUniversities();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildRatingFilter(),
                ],
              ),
            ),
          ),
          const Divider(height: 20, thickness: 1),
          Expanded(
            child: _filteredUniversities.isEmpty
                ? Center(
                    child: Text(
                      'No universities found for your criteria.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredUniversities.length,
                    itemBuilder: (context, index) {
                      final university = _filteredUniversities[index];
                      return UniversityCard(university: university);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          hint: Text(label),
          style: const TextStyle(color: Colors.black),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
        ),
      ),
    );
  }

  Widget _buildRatingFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Text('Min Rating:', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<double>(
              value: _minRating,
              onChanged: (newValue) {
                setState(() {
                  _minRating = newValue!;
                  _filterUniversities();
                });
              },
              items: List.generate(6, (index) => index.toDouble()) // 0.0, 1.0, ..., 5.0
                  .map<DropdownMenuItem<double>>((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: Text('$value ⭐', style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              style: const TextStyle(color: Colors.black),
              icon: const Icon(Icons.star, color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
