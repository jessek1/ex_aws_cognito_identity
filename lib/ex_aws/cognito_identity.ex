defmodule ExAws.CognitoIdentity do
  @moduledoc """
  Operations on AWS Cognito Identity
  """
  @namespace "com.amazonaws.cognito.identity.model.AWSCognitoIdentityService"

  @identity_ids_to_delete_req_key "IdentityIdsToDelete"
  @identity_pool_id_req_key "IdentityPoolId"
  @identity_pool_name_req_key "IdentityPoolName"
  @identity_id_req_key "IdentityId"
  @logins_req_key "Logins"
  @max_results_req_key "MaxResults"
  @resource_arn_req_key "ResourceArn"
  @dest_user_identifier_req_key "DestinationUserIdentifier"
  @dev_provider_name_req_key "DeveloperProviderName"
  @source_user_identifier_req_key "SourceUserIdentifier"
  @roles_req_key "Roles"
  @tags_req_key "Tags"
  @logins_to_remove_req_key "LoginsToRemove"
  @tag_keys_req_key "TagKeys"
  @dev_user_identifier_req_key "DeveloperUserIdentifier"
  @allow_unauthenticated_identities_req_key "AllowUnauthenticatedIdentities"


  @doc """
  Creates a new identity pool. The identity pool is a store of user identity information that is specific to your AWS account. The keys for SupportedLoginProviders are as follows:

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_CreateIdentityPool.html)

  Facebook: graph.facebook.com

  Google: accounts.google.com

  Amazon: www.amazon.com

  Twitter: api.twitter.com

  Digits: www.digits.com

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:allow_classic_flow` - Enables or disables the Basic (Classic) authentication flow. For more information, see Identity Pools (Federated Identities) Authentication Flow in the Amazon Cognito Developer Guide. Valid values: true, false.

  *`:cognito_identity_providers` - An array of Amazon Cognito user pools and their client IDs. Valid values: array of [CognitoIdentityProvider](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_CognitoIdentityProvider.html) objects.

  *`:developer_provider_name` - The "domain" by which Cognito will refer to your users. This name acts as a placeholder that allows your backend and the Cognito service to communicate about the developer provider. For the DeveloperProviderName, you can use letters as well as period (.), underscore (_), and dash (-). Valid values: string betwee

  Once you have set a developer provider name, you cannot change it. Please take care in setting this parameter.

  *`:identity_pool_tags` - Tags to assign to the identity pool. A tag is a label that you can apply to identity pools to categorize and manage them in different ways, such as by purpose, owner, environment, or other criteria. Valid values: String to string map, key length max of 128 and value length max of 256.

  *`:open_id_connect_provider_arns` - The Amazon Resource Names (ARN) of the OpenID Connect providers. Valid values: array of strings, string min length of 20 and max length of 2048.

  *`:saml_provider_arns` - An array of Amazon Resource Names (ARNs) of the SAML provider for your identity pool. Valid values: array of string, string min length of 20 and max length of 2048.

  *`:supported_login_providers` - Optional key:value pairs mapping provider names to provider app IDs.  Valid values: string to string map, key min length of 1 and max of 128, value min length of 1 and max of 128.
  """
  def create_identity_pool(identity_pool_name, allow_unauthenticated_identities, opts \\ []) do
    data =
      %{
        @identity_pool_name_req_key => identity_pool_name,
        @allow_unauthenticated_identities_req_key => allow_unauthenticated_identities,
      }
      |> Map.merge(format_opts(opts))

    request(:create_identity_pool, data)
  end


  @doc """
  Deletes identities from an identity pool. You can specify a list of 1-60 identities that you want to delete.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_DeleteIdentities.html)

  Valid values: array of string, max 60 items, string min length of 1 and max length of 55.

  You must use AWS Developer credentials to call this API.
  """
  def delete_identities(identity_ids) do
    request(:delete_identities, %{
      @identity_ids_to_delete_req_key => identity_ids
    })
  end


  @doc """
  Deletes an identity pool. Once a pool is deleted, users will not be able to authenticate with the pool.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_DeleteIdentityPool.html)

  You must use AWS Developer credentials to call this API.
  """
  def delete_identity_pool(pool_id) do
    request(:delete_identity_pool, %{
      @identity_pool_id_req_key => pool_id
    })
  end


  @doc """
  Returns metadata related to the given identity, including when the identity was created and any associated linked logins.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_DescribeIdentity.html)

  You must use AWS Developer credentials to call this API.
  """
  def describe_identity(identity_id) do
    request(:describe_identity, %{
      @identity_id_req_key => identity_id
    })
  end


  @doc """
  Gets details about a particular identity pool, including the pool name, ID description, creation date, and current number of users.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_DescribeIdentityPool.html)

  You must use AWS Developer credentials to call this API.
  """
  def describe_identity_pool(pool_id) do
    request(:describe_idetity_pool, %{
      @identity_pool_id_req_key => pool_id
    })
  end


  @doc """
  Returns credentials for the provided identity ID. Any provided logins will be validated against supported login providers. If the token is for cognito-identity.amazonaws.com, it will be passed through to AWS Security Token Service with the appropriate role for the token.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetCredentialsForIdentity.html)

  This is a public API. You do not need any credentials to call this API.

  ## Options

  *`:custom_role_arn` - The Amazon Resource Name (ARN) of the role to be assumed when multiple roles were received in the token from the identity provider. For example, a SAML-based identity provider. This parameter is optional for identity providers that do not support role customization. Valid values: string with min length 20 and max length 2048.

  *`:logins` - A set of optional name-value pairs that map provider names to provider tokens. The name-value pair will follow the syntax "provider_name": "provider_user_identifier".

  Logins should not be specified when trying to get credentials for an unauthenticated identity.

  The Logins parameter is required when using identities associated with external identity providers such as Facebook. For examples of Logins maps, see the code examples in the [External Identity Providers](https://docs.aws.amazon.com/cognito/latest/developerguide/external-identity-providers.html) section of the Amazon Cognito Developer Guide. Valid values: string to string map, key min length of 1 and max length of 128, value min length of 1 and max length of 50000.
  """
  def get_credentials_for_identity(identity_id, opts \\ []) do
    data =
      %{
        @identity_id_req_key => identity_id
      }
      |> Map.merge(format_opts(opts))
    request(:get_credentials_for_identity, data)
  end


  @doc """
  Generates (or retrieves) a Cognito ID. Supplying multiple logins will create an implicit linked account.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetId.html)

  This is a public API. You do not need any credentials to call this API.

  ## Options

  *`:account_id` - A standard AWS account ID (9+ digits). Valid values: string with min length of 1 and max length of 15.

  *`:logins` - A set of optional name-value pairs that map provider names to provider tokens. The available provider names for Logins are as follows:

  Facebook: graph.facebook.com

  Amazon Cognito user pool: cognito-idp.<region>.amazonaws.com/<YOUR_USER_POOL_ID>, for example, cognito-idp.us-east-1.amazonaws.com/us-east-1_123456789.

  Google: accounts.google.com

  Amazon: www.amazon.com

  Twitter: api.twitter.com

  Digits: www.digits.com

  Valid values: string to string map, key min length of 1 and max length of 128, value min length of 1 and max length of 50000.
  """
  def get_id(pool_id, opts \\ []) do
    data =
      %{
        @identity_pool_id_req_key => pool_id
      }
      |> Map.merge(format_opts(opts))
    request(:get_id, data)
  end


  @doc """
  Gets the roles for an identity pool.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetIdentityPoolRoles.html)

  You must use AWS Developer credentials to call this API.
  """
  def get_identity_pool_roles(pool_id) do
    request(:get_identity_pool_roles, %{
      @identity_pool_id_req_key => pool_id
    })
  end


  @doc """
  Gets an OpenID token, using a known Cognito ID. This known Cognito ID is returned by GetId. You can optionally add additional logins for the identity. Supplying multiple logins creates an implicit link.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetOpenIdToken.html)

  The OpenID token is valid for 10 minutes.

  This is a public API. You do not need any credentials to call this API.

  ## Options

    *`:logins` - A set of optional name-value pairs that map provider names to provider tokens. When using graph.facebook.com and www.amazon.com, supply the access_token returned from the provider's authflow. For accounts.google.com, an Amazon Cognito user pool provider, or any other OpenID Connect provider, always include the `id_token`.  Valid values: string to string map, key min length of 1 and max length of 128, value min length of 1 and max length of 50000.
  """
  def get_open_id_token(identity_id, opts \\ []) do
    data =
      %{
        @identity_id_req_key => identity_id
      }
      |> Map.merge(format_opts(opts))
    request(:get_open_id_token, data)
  end


  @doc """
  Registers (or retrieves) a Cognito IdentityId and an OpenID Connect token for a user authenticated by your backend authentication process. Supplying multiple logins will create an implicit linked account. You can only specify one developer provider as part of the Logins map, which is linked to the identity pool. The developer provider is the "domain" by which Cognito will refer to your users.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetOpenIdTokenForDeveloperIdentity.html)

  You can use GetOpenIdTokenForDeveloperIdentity to create a new identity and to link new logins (that is, user credentials issued by a public provider or developer provider) to an existing identity. When you want to create a new identity, the IdentityId should be null. When you want to associate a new login with an existing authenticated/unauthenticated identity, you can do so by providing the existing IdentityId. This API will create the identity in the specified IdentityPoolId.

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:identity_id` - A unique identifier in the format REGION:GUID. Valid values: string with min length of 1 and max length of 55.

  *`:token_duration` - The expiration time of the token, in seconds. You can specify a custom expiration time for the token so that you can cache it. If you don't provide an expiration time, the token is valid for 15 minutes. You can exchange the token with Amazon STS for temporary AWS credentials, which are valid for a maximum of one hour. The maximum token duration you can set is 24 hours. You should take care in setting the expiration time for a token, as there are significant security implications: an attacker could use a leaked token to access your AWS resources for the token's duration.

  Note
  Please provide for a small grace period, usually no more than 5 minutes, to account for clock skew. Valid values: long between 1 and 86400.
  """
  def get_open_id_token_for_developer_identity(pool_id, logins, opts \\ []) do
    data =
      %{
        @identity_pool_id_req_key => pool_id,
        @logins_req_key => logins,
      }
      |> Map.merge(format_opts(opts))

    request(:get_open_id_token_for_developer_identity, data)
  end


  @doc """
  Lists the identities in an identity pool.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_ListIdentities.html)

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:hide_disabled` - An optional boolean parameter that allows you to hide disabled identities. If omitted, the ListIdentities API will include disabled identities in the response. Valid values: true/false.

  *`:next_token` - A pagination token. Valid values: string with min length of 1.
  """
  def list_identities(pool_id, max_results, opts \\ []) do
    data =
      %{
        @identity_pool_id_req_key => pool_id,
        @max_results_req_key => max_results
      }
      |> Map.merge(format_opts(opts))
    request(:list_identities, data)
  end


  @doc """
  Lists all of the Cognito identity pools registered for your account.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_ListIdentityPools.html)

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:next_token` - A pagination token. Valid values: string with min length of 1.
  """
  def list_identity_pools(max_results, opts \\ []) do
    data =
      %{
        @max_results_req_key => max_results
      }
      |> Map.merge(format_opts(opts))
    request(:list_identity_pools, data)
  end


  @doc """
  Lists the tags that are assigned to an Amazon Cognito identity pool.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_ListTagsForResource.html)

  A tag is a label that you can apply to identity pools to categorize and manage them in different ways, such as by purpose, owner, environment, or other criteria.

  You can use this action up to 10 times per second, per account.
  """
  def list_tags_for_resource(resource_arn) do
    request(:list_tags_for_resource, %{
      @resource_arn_req_key => resource_arn
    })
  end


  @doc """
  Retrieves the IdentityID associated with a DeveloperUserIdentifier or the list of DeveloperUserIdentifier values associated with an IdentityId for an existing identity. Either IdentityID or DeveloperUserIdentifier must not be null. If you supply only one of these values, the other value will be searched in the database and returned as a part of the response. If you supply both, DeveloperUserIdentifier will be matched against IdentityID. If the values are verified against the database, the response returns both values and is the same as the request. Otherwise a ResourceConflictException is thrown.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_LookupDeveloperIdentity.html)

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:developer_user_identifier` - A unique ID used by your backend authentication process to identify a user. Typically, a developer identity provider would issue many developer user identifiers, in keeping with the number of users. Valid values: string with min length 1 and max length of 1024.

  *`:identity_id` - A unique identifier in the format REGION:GUID. Valid values: string with min length of 1 and max length of 55.

  *`:max_results` - The maximum number of identities to return. Valid values: integer between 1 and 60.

  *`:next_token` - A pagination token. The first call you make will have NextToken set to null. After that the service will return NextToken values as needed. For example, let's say you make a request with MaxResults set to 10, and there are 20 matches in the database. The service will return a pagination token as a part of the response. This token can be used to call the API again and get results starting from the 11th match. Valid values: string with min length of 1
  """
  def lookup_developer_identity(pool_id, opts \\ []) do
    data =
      %{
        @identity_pool_id_req_key => pool_id,
      }
      |> Map.merge(format_opts(opts))
    request(:lookup_developer_identity, data)
  end


  @doc """
  Merges two users having different IdentityIds, existing in the same identity pool, and identified by the same developer provider. You can use this action to request that discrete users be merged and identified as a single user in the Cognito environment. Cognito associates the given source user (SourceUserIdentifier) with the IdentityId of the DestinationUserIdentifier. Only developer-authenticated users can be merged. If the users to be merged are associated with the same public provider, but as two different users, an exception will be thrown.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_MergeDeveloperIdentities.html)

  The number of linked logins is limited to 20. So, the number of linked logins for the source user, SourceUserIdentifier, and the destination user, DestinationUserIdentifier, together should not be larger than 20. Otherwise, an exception will be thrown.

  You must use AWS Developer credentials to call this API.
  """
  def merge_developer_identities(pool_id, dest_user_identifier, dev_provider_name, source_user_identifier) do
    request(:merge_developer_identities, %{
        @identity_pool_id_req_key => pool_id,
        @dest_user_identifier_req_key => dest_user_identifier,
        @dev_provider_name_req_key => dev_provider_name,
        @source_user_identifier_req_key => source_user_identifier
      })
  end


  @doc """
  Sets the roles for an identity pool. These roles are used when making calls to [GetCredentialsForIdentity](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetCredentialsForIdentity.html) action.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_SetIdentityPoolRoles.html)

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:role_mappings` - How users for a specific identity provider are to mapped to roles. This is a string to [RoleMapping](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_RoleMapping.html) object map. The string identifies the identity provider, for example, "graph.facebook.com" or "cognito-idp.us-east-1.amazonaws.com/us-east-1_abcdefghi:app_client_id".

  Up to 25 rules can be specified per identity provider. Valid values: string to [RoleMapping](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_RoleMapping.html) object map, key min length of 1 and max length of 128.
  """
  def set_identity_pool_roles(pool_id, roles, opts \\ []) do
    data =
      %{
        @identity_pool_id_req_key => pool_id,
        @roles_req_key => roles,
      }
      |> Map.merge(format_opts(opts))
    request(:set_identity_pool_roles, data)
  end


  @doc """
  Assigns a set of tags to the specified Amazon Cognito identity pool. A tag is a label that you can use to categorize and manage identity pools in different ways, such as by purpose, owner, environment, or other criteria.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_TagResource.html)

  Each tag consists of a key and value, both of which you define. A key is a general category for more specific values. For example, if you have two versions of an identity pool, one for testing and another for production, you might assign an Environment tag key to both identity pools. The value of this key might be Test for one identity pool and Production for the other.

  Tags are useful for cost tracking and access control. You can activate your tags so that they appear on the Billing and Cost Management console, where you can track the costs associated with your identity pools. In an IAM policy, you can constrain permissions for identity pools based on specific tags or tag values.

  You can use this action up to 5 times per second, per account. An identity pool can have as many as 50 tags.
  """
  def tag_resource(resource_arn, tags) do
    request(:tag_resource, %{
      @resource_arn_req_key => resource_arn,
      @tags_req_key => tags
    })
  end


  @doc """
  Unlinks a DeveloperUserIdentifier from an existing identity. Unlinked developer users will be considered new identities next time they are seen. If, for a given Cognito identity, you remove all federated identities as well as the developer user identifier, the Cognito identity becomes inaccessible.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_UnlinkDeveloperIdentity.html)

  You must use AWS Developer credentials to call this API.
  """
  def unlink_developer_identity(identity_id, pool_id, dev_provider_name, dev_user_identifier) do
    request(:unlink_developer_identity, %{
      @identity_id_req_key => identity_id,
      @identity_pool_id_req_key => pool_id,
      @dev_provider_name_req_key => dev_provider_name,
      @dev_user_identifier_req_key => dev_user_identifier
    })
  end


  @doc """
  Unlinks a federated identity from an existing account. Unlinked logins will be considered new identities next time they are seen. Removing the last linked login will make this identity inaccessible.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_UnlinkIdentity.html)

  This is a public API. You do not need any credentials to call this API.
  """
 def unlink_identity(identity_id, logins, logins_to_remove) do
  request(:unlink_identity, %{
    @identity_id_req_key => identity_id,
    @logins_req_key => logins,
    @logins_to_remove_req_key => logins_to_remove
  })
 end


  @doc """
  Removes the specified tags from the specified Amazon Cognito identity pool. You can use this action up to 5 times per second, per account

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_UntagResource.html)
  """
  def untag_resource(resource_arn, tag_keys) do
    request(:untag_resource, %{
      @resource_arn_req_key => resource_arn,
      @tag_keys_req_key => tag_keys
    })
  end


  @doc """
  Updates an identity pool.

  [AWS API Docs](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_UpdateIdentityPool.html)

  You must use AWS Developer credentials to call this API.

  ## Options

  *`:allow_classic_flow` - Enables or disables the Basic (Classic) authentication flow. For more information, see [Identity Pools (Federated Identities) Authentication Flow](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flow.html) in the Amazon Cognito Developer Guide. Valid values: true/false.

  *`:cognito_identity_providers` - A list representing an Amazon Cognito user pool and its client ID. Valid values: array of [CognitoIdentityProvider](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_CognitoIdentityProvider.html) objects.

  *`:developer_provider_name` - The "domain" by which Cognito will refer to your users. Valid values: string with min length of 1 and max length of 128.

  *`:identity_pool_tags` - The tags that are assigned to the identity pool. A tag is a label that you can apply to identity pools to categorize and manage them in different ways, such as by purpose, owner, environment, or other criteria. Valid values: string to string map, key min length of 1 and max length of 128, value min length of 0 and max length of 256.

  *`:open_id_connect_provider_arns` - The ARNs of the OpenID Connect providers. Valid values: array of strings, string min length of 20 and max length of 2048.

  *`:saml_provider_arns` - An array of Amazon Resource Names (ARNs) of the SAML provider for your identity pool. Valid values: array of strings, string min length of 20 and max length of 2048.

  *`:supported_login_providers` - Optional key:value pairs mapping provider names to provider app IDs. Valid values: string to string map, key min length of 1 and max length of 128, value min length of 1 and max length of 128.
  """
  def update_identity_pool(pool_id, pool_name, allow_unauthenticated_identities, opts \\ []) do
    data =
      %{
        @identity_pool_id_req_key => pool_id,
        @identity_pool_name_req_key => pool_name,
        @allow_unauthenticated_identities_req_key => allow_unauthenticated_identities
      }
      |> Map.merge(format_opts(opts))
    request(:update_identity_pool, data)
  end



  defp format_opts(opts) do
    opts
    |> Enum.reduce(%{}, fn({k, v}, acc) ->
      key =
        k
        |> Atom.to_string()
        |> Macro.camelize()
      Map.put(acc, key, v)
    end)
  end

  defp request(op, data, opts \\ %{}) do
    operation  = op |> Atom.to_string() |> Macro.camelize()

    ExAws.Operation.JSON.new(:cognito_identity,
      %{
        data: data,
        headers: [
          {"content-type", "application/x-amz-json-1.1"},
          {"x-amz-target", "#{@namespace}.#{operation}"}
        ],
        service: :"cognito-identity"
      }
      |> Map.merge(opts)
    )
  end
end
