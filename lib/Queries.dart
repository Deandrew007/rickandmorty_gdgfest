class Queries {
  String fetchAllProfile() {
    return '''
      query{
        characters() {
            results{
              name
              status
              image
              species
              origin{
                name
              }
              
            }
        }
      }
    ''';
  }

  String fetchProfileById(String id) {
    return '''
      query{
        character(id:"$id") {
          name
          image
          species
          origin{
            dimension
          }
            
        }
      }

    ''';
  }
}
