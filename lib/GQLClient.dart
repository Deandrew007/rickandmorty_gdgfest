import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: "https://rickandmortyapi.com/graphql",
  );

  GraphQLClient myGQLClient() {
    return GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    );
  }
}
