import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/preference_manager.dart';
import '../utils/utils.dart';

class GraphQLClientService {
  static final HttpLink _httpLink = HttpLink(
      // 'https://server.casashop.in/graphql', // PROD
      'https://staging.casashop.in/graphql' // STAGING - DEV
      );

  static final AuthLink _authLink = AuthLink(
    getToken: () async {
      final token = PreferenceManager.getString(PreferenceManager.token);
      if (token == null || token.isEmpty) {
        logg.e('No token found com PreferenceManager!');
      }
      logg.d('Bearer $token');
      return 'Bearer $token';
    },
  );

  static final Link _link = _authLink.concat(_httpLink);

  static final GraphQLClient _client = GraphQLClient(
    link: _link,
    cache: GraphQLCache(
      store: InMemoryStore(),
    ), // Caching for better performance
  );

  /// **Perform a GraphQL Query**
  Future<QueryResult> performQuery(
      {required String document, Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(document),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly, // Always fetch fresh data
    );

    _prettyPrintRequest(document, variables);

    final result = await _client.query(options);

    _handleErrors(result);
    _prettyPrintResponse(result);
    return result;
  }

  /// **Perform a GraphQL Mutation**
  Future<QueryResult> performMutation(
      {required String document, Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(document),
      variables: variables ?? {},
    );

    _prettyPrintRequest(document, variables);

    final result = await _client.mutate(options);

    _handleErrors(result);
    _prettyPrintResponse(result);
    return result;
  }

  /// **Perform a GraphQL Mutation without Token**
  Future<QueryResult> performMutationWithoutToken(
      {required String document, Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(document),
      variables: variables ?? {},
    );

    _prettyPrintRequest(document, variables);

    final tokenLessClient = GraphQLClient(
      link: _httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ), // Caching for better performance
    );

    final result = await tokenLessClient.mutate(options);

    _handleErrors(result);
    _prettyPrintResponse(result);
    return result;
  }

  /// **Perform a GraphQL Query without Token**
  Future<QueryResult> performQueryWithoutToken(
      {required String document, Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(document),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly, // Always fetch fresh data
    );

    _prettyPrintRequest(document, variables);

    final tokenLessClient = GraphQLClient(
      link: _httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ), // Caching for better performance
    );
    final result = await tokenLessClient.query(options);

    _handleErrors(result);
    _prettyPrintResponse(result);
    return result;
  }

  /// **Handle GraphQL Errors**
  void _handleErrors(QueryResult result) {
    if (result.hasException) {
      final responseContext = result.context.entry<HttpLinkResponseContext>();

      if (responseContext != null) {
        logg.e('HTTP Headers Sent: ${responseContext.headers}');
      } else {
        logg.e('No headers found com response context');
      }

      logg.e('GraphQL Error: ${result.exception.toString()}');
      throw Exception(result.exception.toString());
    }
  }
}

/// **Pretty Print JSON Request**
void _prettyPrintRequest(String operation, Map<String, dynamic>? variables) {
  final encoder = const JsonEncoder.withIndent('  ');
  final formattedVariables =
      variables != null ? encoder.convert(variables) : 'No variables';

  logg.w('''
-------------------- GraphQL Request --------------------
Operation: 
$operation
Variables:
$formattedVariables
--------------------------------------------------------
''');
}

/// **Pretty Print JSON Response**
void _prettyPrintResponse(QueryResult result) {
  final encoder = const JsonEncoder.withIndent('  ');
  final formattedResponse = result.data != null
      ? encoder.convert(result.data)
      : 'No Data (Error or Empty Response)';

  logg.w('''
-------------------- GraphQL Response -------------------
$formattedResponse
--------------------------------------------------------
''');
}
