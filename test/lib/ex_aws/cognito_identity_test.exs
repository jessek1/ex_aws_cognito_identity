defmodule ExAws.CognitoIdentityTest do
  use ExUnit.Case, async: true
  alias ExAws.CognitoIdentity

  ## NOTE:
  # These tests are not intended to be operational examples, but intead to
  # ensure that the form of the data to be sent to AWS is correct.
  #

  test "#create_identity_pool with no opts" do
    expected = %{
      "IdentityPoolName" => "name",
      "AllowUnauthenticatedIdentities" => true,
    }

    assert CognitoIdentity.create_identity_pool("name", true)
      .data == expected
  end

  test "#create_identity_pool with opts" do
    expected = %{
      "AllowClassicFlow" => true,
      "AllowUnauthenticatedIdentities" => true,
      "CognitoIdentityProviders" => [
        %{ "ProviderName" => "provider name1" },
        %{ "ProviderName" => "provider name2" }
      ],
      "DeveloperProviderName" => "dev name",
      "IdentityPoolName" => "name",
      "IdentityPoolTags" => %{
        "tag1" => "1",
        "tag2" => "2"
      },
      "OpenIdConnectProviderArns" => [
        "open_id.test.arn.resource",
        "open_id.test.arn.resource"
      ],
      "SamlProviderArns" => [
        "saml.test.arn.resource",
        "saml.test.arn.resource"
      ],
      "SupportedLoginProviders" => %{
        "provider_name" => "app_id",
        "provider_name2" => "app_id2"
      }
    }

    assert CognitoIdentity.create_identity_pool("name", true, %{
      allow_classic_flow: true,
      cognito_identity_providers: [
        %{ "ProviderName" => "provider name1" },
        %{ "ProviderName" => "provider name2" }
      ],
      developer_provider_name: "dev name",
      identity_pool_tags: %{
        "tag1" => "1",
        "tag2" => "2"
      },
      open_id_connect_provider_arns: [
        "open_id.test.arn.resource",
        "open_id.test.arn.resource"
      ],
      saml_provider_arns: [
        "saml.test.arn.resource",
        "saml.test.arn.resource"
      ],
      supported_login_providers: %{
        "provider_name" => "app_id",
        "provider_name2" => "app_id2"
      }
    })
      .data == expected
  end


  test "#delete_identities" do
    expected = %{
      "IdentityIdsToDelete" => ["1", "2"]
    }

    assert CognitoIdentity.delete_identities(["1", "2"])
      .data == expected
  end

  test "#delete_identity_pool" do
    expected = %{
      "IdentityPoolId" => "123"
    }

    assert CognitoIdentity.delete_identity_pool("123")
      .data == expected
  end

  test "#describe_identity" do
    expected = %{
      "IdentityId" => "id"
    }

    assert CognitoIdentity.describe_identity("id")
      .data == expected
  end

  test "#describe_identity_pool" do
    expected = %{
      "IdentityPoolId" => "id"
    }

    assert CognitoIdentity.describe_identity_pool("id")
      .data == expected
  end

  test "#get_credentials_for_identity with no opts" do
    expected = %{
      "IdentityId" => "id"
    }

    assert CognitoIdentity.get_credentials_for_identity("id")
      .data == expected
  end

  test "#get_credentials_for_identity with opts" do
    expected = %{
      "IdentityId" => "id",
      "CustomRoleArn" => "custom.role.arn.resource",
      "Logins" => %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }

    assert CognitoIdentity.get_credentials_for_identity("id", %{
      custom_role_arn: "custom.role.arn.resource",
      logins: %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }).data == expected
  end

  test "#get_id with no opts" do
    expected = %{
      "IdentityPoolId" => "id"
    }

    assert CognitoIdentity.get_id("id")
      .data == expected
  end

  test "#get_id with opts" do
    expected = %{
      "IdentityPoolId" => "id",
      "AccountId" => "acct_id",
      "Logins" => %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }

    assert CognitoIdentity.get_id("id", %{
      account_id: "acct_id",
      logins: %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }).data == expected
  end

  test "#get_identity_pool_roles" do
    expected = %{
      "IdentityPoolId" => "id"
    }

    assert CognitoIdentity.get_identity_pool_roles("id")
      .data == expected
  end

  test "#get_open_id_token with no opts" do
    expected = %{
      "IdentityId" => "id"
    }

    assert CognitoIdentity.get_open_id_token("id")
      .data == expected
  end

  test "#get_open_id_token with opts" do
    expected = %{
      "IdentityId" => "id",
      "Logins" => %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }

    assert CognitoIdentity.get_open_id_token("id", %{
      logins: %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }).data == expected
  end


  test "#get_open_id_token_for_developer_identity with no opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "Logins" => %{
        "key1" => "value1",
        "key2" => "value2",
      }
    }

    logins = %{
      "key1" => "value1",
      "key2" => "value2",
    }
    assert CognitoIdentity.get_open_id_token_for_developer_identity("pool_id", logins)
      .data == expected
  end

  test "#get_open_id_token_for_developer_identity with opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "Logins" => %{
        "key1" => "value1",
        "key2" => "value2",
      },
      "IdentityId" => "id",
      "TokenDuration" => "10"
    }

    logins = %{
      "key1" => "value1",
      "key2" => "value2",
    }

    assert CognitoIdentity.get_open_id_token_for_developer_identity("pool_id", logins, %{
      identity_id: "id",
      token_duration: "10"
    }).data == expected
  end


  test "#list_identities with no opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "MaxResults" => 5
    }

    assert CognitoIdentity.list_identities("pool_id", 5)
      .data == expected
  end

  test "#list_identities with opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "MaxResults" => 5,
      "HideDisabled" => true,
      "NextToken" => "token"
    }

    assert CognitoIdentity.list_identities("pool_id", 5, %{
      hide_disabled: true,
      next_token: "token"
    }).data == expected
  end


  test "#list_identity_pools with no opts" do
    expected = %{
      "MaxResults" => 5
    }

    assert CognitoIdentity.list_identity_pools(5)
      .data == expected
  end

  test "#list_identity_pools with opts" do
    expected = %{
      "MaxResults" => 5,
      "NextToken" => "token"
    }

    assert CognitoIdentity.list_identity_pools(5, %{
      next_token: "token"
    }).data == expected
  end


  test "#list_tags_for_resource" do
    expected = %{
      "ResourceArn" => "list.tags.for.resource.arn"
    }

    assert CognitoIdentity.list_tags_for_resource("list.tags.for.resource.arn")
      .data == expected
  end


  test "#lookup_developer_identity with no opts" do
    expected = %{
      "IdentityPoolId" => "pool_id"
    }

    assert CognitoIdentity.lookup_developer_identity("pool_id")
      .data == expected
  end

  test "#lookup_developer_identity with opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "DeveloperUserIdentifier" => "dev user",
      "IdentityId" => "id",
      "MaxResults" => 5,
      "NextToken" => "token"
    }

    assert CognitoIdentity.lookup_developer_identity("pool_id", %{
      developer_user_identifier: "dev user",
      identity_id: "id",
      max_results: 5,
      next_token: "token"
    }).data == expected
  end

  test "#merge_developer_identities" do
    expected = %{
      "DestinationUserIdentifier" => "dest user id",
      "DeveloperProviderName" => "dev name",
      "IdentityPoolId" => "pool_id",
      "SourceUserIdentifier" => "source user"
    }

    assert CognitoIdentity.merge_developer_identities("pool_id", "dest user id", "dev name", "source user")
      .data == expected
  end

  test "#set_identity_pool_roles with no opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "Roles" => %{
        "rolekey1" => "val1",
        "rolekey2" => "val2"
      }
    }

    roles = %{
      "rolekey1" => "val1",
      "rolekey2" => "val2"
    }
    assert CognitoIdentity.set_identity_pool_roles("pool_id", roles)
      .data == expected
  end

  test "#set_identity_pool_roles with opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "Roles" => %{
        "rolekey1" => "val1",
        "rolekey2" => "val2"
      },
      "RoleMappings" => %{
        "rolemap1" => %{
          "AmbiguousRoleResolution" => "amb1"
        }
      }
    }

    roles = %{
      "rolekey1" => "val1",
      "rolekey2" => "val2"
    }
    assert CognitoIdentity.set_identity_pool_roles("pool_id", roles, %{
      role_mappings: %{
        "rolemap1" => %{
          "AmbiguousRoleResolution" => "amb1"
        }
      }
    }).data == expected
  end

  test "#tag_resource" do
    expected = %{
      "ResourceArn" => "resource.arn",
      "Tags" => %{
        "tag1" => "val1",
        "tag2" => "val2"
      }
    }

    tags = %{
      "tag1" => "val1",
      "tag2" => "val2"
    }
    assert CognitoIdentity.tag_resource("resource.arn", tags)
      .data == expected
  end

  test "#unlink_developer_identity" do
    expected = %{
      "DeveloperProviderName" => "dev name",
      "DeveloperUserIdentifier" => "dev user",
      "IdentityId" => "id",
      "IdentityPoolId" => "pool_id"
    }

    assert CognitoIdentity.unlink_developer_identity("id", "pool_id", "dev name", "dev user")
      .data == expected
  end

  test "#unlink_identity" do
    expected = %{
      "IdentityId" => "id",
      "Logins" => %{
        "key1" => "value1",
        "key2" => "value2",
      },
      "LoginsToRemove" => [ "login"]
    }

    logins = %{
      "key1" => "value1",
      "key2" => "value2",
    }
    assert CognitoIdentity.unlink_identity("id", logins, ["login"])
      .data == expected
  end

  test "#untag_resource" do
    expected = %{
      "ResourceArn" => "resource.arn",
      "TagKeys" => [ "tag"]
    }

    assert CognitoIdentity.untag_resource("resource.arn", ["tag"])
      .data == expected
  end

  test "#update_identity_pool with no opts" do
    expected = %{
      "IdentityPoolId" => "pool_id",
      "IdentityPoolName" => "name",
      "AllowUnauthenticatedIdentities" => true,
    }

    assert CognitoIdentity.update_identity_pool("pool_id", "name", true)
      .data == expected
  end

  test "#update_identity_pool with opts" do
    expected = %{
      "AllowClassicFlow" => true,
      "AllowUnauthenticatedIdentities" => true,
      "CognitoIdentityProviders" => [
        %{ "ProviderName" => "provider name1" },
        %{ "ProviderName" => "provider name2" }
      ],
      "DeveloperProviderName" => "dev name",
      "IdentityPoolId" => "pool_id",
      "IdentityPoolName" => "name",
      "IdentityPoolTags" => %{
        "tag1" => "1",
        "tag2" => "2"
      },
      "OpenIdConnectProviderArns" => [
        "open_id.test.arn.resource",
        "open_id.test.arn.resource"
      ],
      "SamlProviderArns" => [
        "saml.test.arn.resource",
        "saml.test.arn.resource"
      ],
      "SupportedLoginProviders" => %{
        "provider_name" => "app_id",
        "provider_name2" => "app_id2"
      }
    }

    assert CognitoIdentity.update_identity_pool("pool_id", "name", true, %{
      allow_classic_flow: true,
      cognito_identity_providers: [
        %{ "ProviderName" => "provider name1" },
        %{ "ProviderName" => "provider name2" }
      ],
      developer_provider_name: "dev name",
      identity_pool_tags: %{
        "tag1" => "1",
        "tag2" => "2"
      },
      open_id_connect_provider_arns: [
        "open_id.test.arn.resource",
        "open_id.test.arn.resource"
      ],
      saml_provider_arns: [
        "saml.test.arn.resource",
        "saml.test.arn.resource"
      ],
      supported_login_providers: %{
        "provider_name" => "app_id",
        "provider_name2" => "app_id2"
      }
    }).data == expected
  end
end
