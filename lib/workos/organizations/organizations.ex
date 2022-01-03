
defmodule WorkOS.Organizations do
  alias WorkOS.Api
  @moduledoc """
  The Organizations module provides resource methods for working with Organizations
  """

  @doc """
    Create an organization

    ### Parameters
    - params (map)
      - allow_profiles_outside_organization (boolean) Whether the Connections within this Organization should allow Profiles that do not have a domain that is set
      - domains (list of strings) List of domains that belong to the organization
      - name (string) A unique, descriptive name for the organization

    ### Example
    WorkOS.Portal.create_organization(%{
      domains: ["workos.com"],
      name: "WorkOS"
    })
    """
    def create_organization(params, opts \\ [])

    def create_organization(params, opts)
      when (is_map_key(params, :domains) or is_map_key(params, :allow_profiles_outside_organization)) and is_map_key(params, :name) do
        query = Api.process_params(params, [:name, :domains, :allow_profiles_outside_organization])
        Api.post("/organizations", query, opts)
    end

    def create_organization(_params, _opts),
      do: raise(ArgumentError, message: "need both domains(unless external profiles set to true) and name in params")

    @doc """
    Delete an organization

    ### Parameters
    - organization_id (string) the id of the organization to delete

    ### Example
    WorkOS.Portal.delete_organization("organization_12345")
    """
    def delete_organization(organization, opts \\ []) do
      Api.delete("/organizations/#{organization}", %{}, opts)
    end

    @doc """
    Update an organization

    ### Parameters
    - organization_id (string) the id of the organization to update
    - name (string) name of the organization
    - allow_profiles_outside_organization (boolean - optional)
    - domains (array of strings - optional if allow_profiles_outside_organization is set to true)

    ### Example
    WorkOS.Portal.update_organization(organization="organization_12345")
    """
    def update_organization(organization, params, opts \\ [])
      when (is_map_key(params, :domains) or is_map_key(params, :allow_profiles_outside_organization)) and is_map_key(params, :name) do
        query = Api.process_params(params, [:name, :domains, :allow_profiles_outside_organization])
        Api.post("/organizations/#{organization}", query, opts)
    end

    def get_organization(organization, opts) do
      Api.get("/organizations/#{organization}", %{}, opts)
    end

    def list_organizations(params, opts \\ []) do
      Api.get("/organizations", %{}, opts)
    end
end
