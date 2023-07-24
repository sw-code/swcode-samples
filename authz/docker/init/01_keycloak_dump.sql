--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
01531038-48f3-4482-b574-1da18cd2de59	\N	auth-cookie	63acd062-f967-4069-bfe4-7ed0f15dce58	19b59077-e813-4e32-a8c0-6883b9cf780b	2	10	f	\N	\N
7a85bb7f-d20a-4946-833a-f14faee9c526	\N	auth-spnego	63acd062-f967-4069-bfe4-7ed0f15dce58	19b59077-e813-4e32-a8c0-6883b9cf780b	3	20	f	\N	\N
20bedac0-2752-48cc-8e7f-48619dbe744c	\N	identity-provider-redirector	63acd062-f967-4069-bfe4-7ed0f15dce58	19b59077-e813-4e32-a8c0-6883b9cf780b	2	25	f	\N	\N
fada7c83-c767-41cb-8023-174d3103833c	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	19b59077-e813-4e32-a8c0-6883b9cf780b	2	30	t	529517aa-8fd6-48e9-8b4e-209559ef3c0a	\N
4602e43a-d07c-4f8e-87a1-37a949a88cd9	\N	auth-username-password-form	63acd062-f967-4069-bfe4-7ed0f15dce58	529517aa-8fd6-48e9-8b4e-209559ef3c0a	0	10	f	\N	\N
63113f0b-13ee-4116-91a3-427e584ed8a0	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	529517aa-8fd6-48e9-8b4e-209559ef3c0a	1	20	t	29ec66b2-436a-4640-90db-bb0d91dda91f	\N
b11275b1-050b-4d18-b0d4-87c725f71504	\N	conditional-user-configured	63acd062-f967-4069-bfe4-7ed0f15dce58	29ec66b2-436a-4640-90db-bb0d91dda91f	0	10	f	\N	\N
c3ab6c30-e9c9-4f4e-b753-975bcd66a7a9	\N	auth-otp-form	63acd062-f967-4069-bfe4-7ed0f15dce58	29ec66b2-436a-4640-90db-bb0d91dda91f	0	20	f	\N	\N
26aaa4cc-2426-4678-9610-9a1148f91859	\N	direct-grant-validate-username	63acd062-f967-4069-bfe4-7ed0f15dce58	c9146da9-a766-45cf-ad10-0f73b0cf0d5b	0	10	f	\N	\N
83dd1e3e-5a27-4847-b89c-45727ec95bf0	\N	direct-grant-validate-password	63acd062-f967-4069-bfe4-7ed0f15dce58	c9146da9-a766-45cf-ad10-0f73b0cf0d5b	0	20	f	\N	\N
d5c99816-d45b-46e0-8719-b75c7d97cdf3	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	c9146da9-a766-45cf-ad10-0f73b0cf0d5b	1	30	t	4b5323f6-052b-403a-b350-ea78b36845ca	\N
063b2537-7b0e-4902-a128-431f0fbffcc4	\N	conditional-user-configured	63acd062-f967-4069-bfe4-7ed0f15dce58	4b5323f6-052b-403a-b350-ea78b36845ca	0	10	f	\N	\N
ebce3a15-a087-4120-9c69-f742476cc852	\N	direct-grant-validate-otp	63acd062-f967-4069-bfe4-7ed0f15dce58	4b5323f6-052b-403a-b350-ea78b36845ca	0	20	f	\N	\N
6887b00f-d4af-41b3-a16a-f6a8c2633208	\N	registration-page-form	63acd062-f967-4069-bfe4-7ed0f15dce58	6d055054-ebfa-48bd-bfbe-9acaaf548771	0	10	t	78922624-fd97-4461-87b2-ee74e5239e39	\N
64d955c9-3035-47c0-8f74-520cf56b5c1c	\N	registration-user-creation	63acd062-f967-4069-bfe4-7ed0f15dce58	78922624-fd97-4461-87b2-ee74e5239e39	0	20	f	\N	\N
0e84f319-8748-4c7f-9bfc-5f6a1fc9499c	\N	registration-profile-action	63acd062-f967-4069-bfe4-7ed0f15dce58	78922624-fd97-4461-87b2-ee74e5239e39	0	40	f	\N	\N
4d94455d-a441-461f-a541-b99338389009	\N	registration-password-action	63acd062-f967-4069-bfe4-7ed0f15dce58	78922624-fd97-4461-87b2-ee74e5239e39	0	50	f	\N	\N
b086d5e1-2534-41ee-95c2-dfa97cc87298	\N	registration-recaptcha-action	63acd062-f967-4069-bfe4-7ed0f15dce58	78922624-fd97-4461-87b2-ee74e5239e39	3	60	f	\N	\N
02993451-94e4-48db-8879-6ec61a75c9bf	\N	registration-terms-and-conditions	63acd062-f967-4069-bfe4-7ed0f15dce58	78922624-fd97-4461-87b2-ee74e5239e39	3	70	f	\N	\N
0642050f-28ac-47ca-a070-1e50edd55447	\N	reset-credentials-choose-user	63acd062-f967-4069-bfe4-7ed0f15dce58	eec7c136-4dbe-43a6-862a-8daabc08696c	0	10	f	\N	\N
196ffcfb-a82f-417a-94eb-1fa8cf38c3d6	\N	reset-credential-email	63acd062-f967-4069-bfe4-7ed0f15dce58	eec7c136-4dbe-43a6-862a-8daabc08696c	0	20	f	\N	\N
ff1498a8-9dc5-4568-aa80-c627598bb75b	\N	reset-password	63acd062-f967-4069-bfe4-7ed0f15dce58	eec7c136-4dbe-43a6-862a-8daabc08696c	0	30	f	\N	\N
48a1c11b-cf23-47c2-b641-9ade863cece2	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	eec7c136-4dbe-43a6-862a-8daabc08696c	1	40	t	75db255e-8a8a-4cb4-a940-d7877c1ab418	\N
9e2019e8-b66a-4dc5-9ca0-632bcd6e90fc	\N	conditional-user-configured	63acd062-f967-4069-bfe4-7ed0f15dce58	75db255e-8a8a-4cb4-a940-d7877c1ab418	0	10	f	\N	\N
df81f54e-e3fc-462a-95ce-2a0a77a8eb46	\N	reset-otp	63acd062-f967-4069-bfe4-7ed0f15dce58	75db255e-8a8a-4cb4-a940-d7877c1ab418	0	20	f	\N	\N
1e17aff7-223d-498f-9d02-9dac97d9522a	\N	client-secret	63acd062-f967-4069-bfe4-7ed0f15dce58	030532a3-b592-4471-8fc3-a41cb33ddb21	2	10	f	\N	\N
4dfa9ff8-9d09-4e1d-8f17-005c9e5c8e68	\N	client-jwt	63acd062-f967-4069-bfe4-7ed0f15dce58	030532a3-b592-4471-8fc3-a41cb33ddb21	2	20	f	\N	\N
ca32cef6-198b-492c-bc58-66ca4f7638a5	\N	client-secret-jwt	63acd062-f967-4069-bfe4-7ed0f15dce58	030532a3-b592-4471-8fc3-a41cb33ddb21	2	30	f	\N	\N
955cba60-889c-40a3-91cf-4a0f72b14411	\N	client-x509	63acd062-f967-4069-bfe4-7ed0f15dce58	030532a3-b592-4471-8fc3-a41cb33ddb21	2	40	f	\N	\N
7069e48e-dcf2-4712-95c4-334f0a952d7e	\N	idp-review-profile	63acd062-f967-4069-bfe4-7ed0f15dce58	54fb80d4-90b4-4ee6-91ea-c3e636bcc587	0	10	f	\N	b0b1cdf9-8547-47fe-8585-fcd1693d9bb6
568903f5-e854-4c3c-8210-7fd74089e114	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	54fb80d4-90b4-4ee6-91ea-c3e636bcc587	0	20	t	0db4bf15-839e-4680-9673-ef644cf664f1	\N
e25695d0-1f57-4323-987c-b292b527dac0	\N	idp-create-user-if-unique	63acd062-f967-4069-bfe4-7ed0f15dce58	0db4bf15-839e-4680-9673-ef644cf664f1	2	10	f	\N	37c7b76a-f395-45c3-ae58-088448b9b8db
7927b957-5e66-4786-82bd-0d94baff6f22	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	0db4bf15-839e-4680-9673-ef644cf664f1	2	20	t	a3055da9-4b0f-40b2-bcb8-6f836206e563	\N
ad4baaf3-1da0-4693-872b-16bc6fcb1265	\N	idp-confirm-link	63acd062-f967-4069-bfe4-7ed0f15dce58	a3055da9-4b0f-40b2-bcb8-6f836206e563	0	10	f	\N	\N
1600edb3-a8d7-4934-8d37-57f178d7e339	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	a3055da9-4b0f-40b2-bcb8-6f836206e563	0	20	t	71d02285-78b8-47d2-af36-24b538ebb583	\N
dd7245a8-0ab2-47a1-a105-a2b548b32397	\N	idp-email-verification	63acd062-f967-4069-bfe4-7ed0f15dce58	71d02285-78b8-47d2-af36-24b538ebb583	2	10	f	\N	\N
51cde25d-9966-445e-a2e2-98903c0d93c7	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	71d02285-78b8-47d2-af36-24b538ebb583	2	20	t	fea5c84c-c93e-40be-8e3e-9e29a247a1d9	\N
43ccbd57-cb38-4ac5-9a0e-d50d4a6e23d3	\N	idp-username-password-form	63acd062-f967-4069-bfe4-7ed0f15dce58	fea5c84c-c93e-40be-8e3e-9e29a247a1d9	0	10	f	\N	\N
2ebab88f-8d39-42cb-9ff2-2c90a22c4ede	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	fea5c84c-c93e-40be-8e3e-9e29a247a1d9	1	20	t	e9333d41-8133-46f1-9091-eacfcdf17b51	\N
e17de7de-67b3-44be-8ed9-5b17ccdb531b	\N	conditional-user-configured	63acd062-f967-4069-bfe4-7ed0f15dce58	e9333d41-8133-46f1-9091-eacfcdf17b51	0	10	f	\N	\N
546e3f93-2f42-49cd-9699-b1085a0d93e7	\N	auth-otp-form	63acd062-f967-4069-bfe4-7ed0f15dce58	e9333d41-8133-46f1-9091-eacfcdf17b51	0	20	f	\N	\N
61ef32bf-7585-4214-aeda-87b5f10dba84	\N	http-basic-authenticator	63acd062-f967-4069-bfe4-7ed0f15dce58	4c3a036e-8429-44d8-a7cf-5669c3ce5d16	0	10	f	\N	\N
6f080c3d-a4a6-4c8c-8da9-19f2d5bdaad6	\N	docker-http-basic-authenticator	63acd062-f967-4069-bfe4-7ed0f15dce58	2a2d7c6f-26ca-4164-b5b4-d9975c95b4b2	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
19b59077-e813-4e32-a8c0-6883b9cf780b	browser	browser based authentication	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
529517aa-8fd6-48e9-8b4e-209559ef3c0a	forms	Username, password, otp and other auth forms.	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
29ec66b2-436a-4640-90db-bb0d91dda91f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
c9146da9-a766-45cf-ad10-0f73b0cf0d5b	direct grant	OpenID Connect Resource Owner Grant	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
4b5323f6-052b-403a-b350-ea78b36845ca	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
6d055054-ebfa-48bd-bfbe-9acaaf548771	registration	registration flow	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
78922624-fd97-4461-87b2-ee74e5239e39	registration form	registration form	63acd062-f967-4069-bfe4-7ed0f15dce58	form-flow	f	t
eec7c136-4dbe-43a6-862a-8daabc08696c	reset credentials	Reset credentials for a user if they forgot their password or something	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
75db255e-8a8a-4cb4-a940-d7877c1ab418	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
030532a3-b592-4471-8fc3-a41cb33ddb21	clients	Base authentication for clients	63acd062-f967-4069-bfe4-7ed0f15dce58	client-flow	t	t
54fb80d4-90b4-4ee6-91ea-c3e636bcc587	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
0db4bf15-839e-4680-9673-ef644cf664f1	User creation or linking	Flow for the existing/non-existing user alternatives	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
a3055da9-4b0f-40b2-bcb8-6f836206e563	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
71d02285-78b8-47d2-af36-24b538ebb583	Account verification options	Method with which to verity the existing account	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
fea5c84c-c93e-40be-8e3e-9e29a247a1d9	Verify Existing Account by Re-authentication	Reauthentication of existing account	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
e9333d41-8133-46f1-9091-eacfcdf17b51	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	f	t
4c3a036e-8429-44d8-a7cf-5669c3ce5d16	saml ecp	SAML ECP Profile Authentication Flow	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
2a2d7c6f-26ca-4164-b5b4-d9975c95b4b2	docker auth	Used by Docker clients to authenticate against the IDP	63acd062-f967-4069-bfe4-7ed0f15dce58	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
b0b1cdf9-8547-47fe-8585-fcd1693d9bb6	review profile config	63acd062-f967-4069-bfe4-7ed0f15dce58
37c7b76a-f395-45c3-ae58-088448b9b8db	create unique user config	63acd062-f967-4069-bfe4-7ed0f15dce58
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
37c7b76a-f395-45c3-ae58-088448b9b8db	false	require.password.update.after.registration
b0b1cdf9-8547-47fe-8585-fcd1693d9bb6	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
f41978f0-9155-4838-b235-d647ccb20155	t	f	master-realm	0	f	\N	\N	t	\N	f	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	63acd062-f967-4069-bfe4-7ed0f15dce58	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
cc1f3902-ede2-4cd8-a0e6-74997f498627	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	63acd062-f967-4069-bfe4-7ed0f15dce58	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
75f229a3-0dea-4b0c-8451-b52e9475f0d1	t	f	broker	0	f	\N	\N	t	\N	f	63acd062-f967-4069-bfe4-7ed0f15dce58	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
37e2224a-3146-4267-a017-7c7712bc4f6c	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	63acd062-f967-4069-bfe4-7ed0f15dce58	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
ff417939-2502-4d58-8612-03141753fdff	t	f	admin-cli	0	t	\N	\N	f	\N	f	63acd062-f967-4069-bfe4-7ed0f15dce58	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
50d72b62-c21d-41b3-b3f6-fa35f7178cef	t	t	postman	0	t	\N		f		f	63acd062-f967-4069-bfe4-7ed0f15dce58	openid-connect	-1	t	f		f	client-secret			\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
0a99fac4-fbe8-4608-aa13-2244b00e4e61	post.logout.redirect.uris	+
cc1f3902-ede2-4cd8-a0e6-74997f498627	post.logout.redirect.uris	+
cc1f3902-ede2-4cd8-a0e6-74997f498627	pkce.code.challenge.method	S256
37e2224a-3146-4267-a017-7c7712bc4f6c	post.logout.redirect.uris	+
37e2224a-3146-4267-a017-7c7712bc4f6c	pkce.code.challenge.method	S256
50d72b62-c21d-41b3-b3f6-fa35f7178cef	oauth2.device.authorization.grant.enabled	false
50d72b62-c21d-41b3-b3f6-fa35f7178cef	oidc.ciba.grant.enabled	false
50d72b62-c21d-41b3-b3f6-fa35f7178cef	backchannel.logout.session.required	true
50d72b62-c21d-41b3-b3f6-fa35f7178cef	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
41459e4d-e8b8-40b2-b131-481cef66d567	offline_access	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect built-in scope: offline_access	openid-connect
7b4e4a56-bdc2-41bb-8c28-8aedd54bc12a	role_list	63acd062-f967-4069-bfe4-7ed0f15dce58	SAML role list	saml
1b9047ed-a6de-4651-8972-e588e1b1fac6	profile	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect built-in scope: profile	openid-connect
a5877522-89a0-4351-bb1d-4d52b880021d	email	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect built-in scope: email	openid-connect
21e0847a-7d34-489f-b122-471047b1ef4e	address	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect built-in scope: address	openid-connect
feb6daf6-6ebc-465e-b36d-b5137340ce86	phone	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect built-in scope: phone	openid-connect
9bad0834-2715-4191-acdc-e523ce4f0f6f	roles	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect scope for add user roles to the access token	openid-connect
0c2dff31-186e-494f-9f66-1c6723428f7b	web-origins	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect scope for add allowed web origins to the access token	openid-connect
ed4fea3d-c9b1-4e7a-918c-10139572359f	microprofile-jwt	63acd062-f967-4069-bfe4-7ed0f15dce58	Microprofile - JWT built-in scope	openid-connect
2dda74e3-6a5b-40f1-93d0-442e8558596d	acr	63acd062-f967-4069-bfe4-7ed0f15dce58	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
41459e4d-e8b8-40b2-b131-481cef66d567	true	display.on.consent.screen
41459e4d-e8b8-40b2-b131-481cef66d567	${offlineAccessScopeConsentText}	consent.screen.text
7b4e4a56-bdc2-41bb-8c28-8aedd54bc12a	true	display.on.consent.screen
7b4e4a56-bdc2-41bb-8c28-8aedd54bc12a	${samlRoleListScopeConsentText}	consent.screen.text
1b9047ed-a6de-4651-8972-e588e1b1fac6	true	display.on.consent.screen
1b9047ed-a6de-4651-8972-e588e1b1fac6	${profileScopeConsentText}	consent.screen.text
1b9047ed-a6de-4651-8972-e588e1b1fac6	true	include.in.token.scope
a5877522-89a0-4351-bb1d-4d52b880021d	true	display.on.consent.screen
a5877522-89a0-4351-bb1d-4d52b880021d	${emailScopeConsentText}	consent.screen.text
a5877522-89a0-4351-bb1d-4d52b880021d	true	include.in.token.scope
21e0847a-7d34-489f-b122-471047b1ef4e	true	display.on.consent.screen
21e0847a-7d34-489f-b122-471047b1ef4e	${addressScopeConsentText}	consent.screen.text
21e0847a-7d34-489f-b122-471047b1ef4e	true	include.in.token.scope
feb6daf6-6ebc-465e-b36d-b5137340ce86	true	display.on.consent.screen
feb6daf6-6ebc-465e-b36d-b5137340ce86	${phoneScopeConsentText}	consent.screen.text
feb6daf6-6ebc-465e-b36d-b5137340ce86	true	include.in.token.scope
9bad0834-2715-4191-acdc-e523ce4f0f6f	true	display.on.consent.screen
9bad0834-2715-4191-acdc-e523ce4f0f6f	${rolesScopeConsentText}	consent.screen.text
9bad0834-2715-4191-acdc-e523ce4f0f6f	false	include.in.token.scope
0c2dff31-186e-494f-9f66-1c6723428f7b	false	display.on.consent.screen
0c2dff31-186e-494f-9f66-1c6723428f7b		consent.screen.text
0c2dff31-186e-494f-9f66-1c6723428f7b	false	include.in.token.scope
ed4fea3d-c9b1-4e7a-918c-10139572359f	false	display.on.consent.screen
ed4fea3d-c9b1-4e7a-918c-10139572359f	true	include.in.token.scope
2dda74e3-6a5b-40f1-93d0-442e8558596d	false	display.on.consent.screen
2dda74e3-6a5b-40f1-93d0-442e8558596d	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
0a99fac4-fbe8-4608-aa13-2244b00e4e61	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
0a99fac4-fbe8-4608-aa13-2244b00e4e61	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
0a99fac4-fbe8-4608-aa13-2244b00e4e61	0c2dff31-186e-494f-9f66-1c6723428f7b	t
0a99fac4-fbe8-4608-aa13-2244b00e4e61	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
0a99fac4-fbe8-4608-aa13-2244b00e4e61	a5877522-89a0-4351-bb1d-4d52b880021d	t
0a99fac4-fbe8-4608-aa13-2244b00e4e61	41459e4d-e8b8-40b2-b131-481cef66d567	f
0a99fac4-fbe8-4608-aa13-2244b00e4e61	21e0847a-7d34-489f-b122-471047b1ef4e	f
0a99fac4-fbe8-4608-aa13-2244b00e4e61	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
0a99fac4-fbe8-4608-aa13-2244b00e4e61	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
cc1f3902-ede2-4cd8-a0e6-74997f498627	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
cc1f3902-ede2-4cd8-a0e6-74997f498627	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
cc1f3902-ede2-4cd8-a0e6-74997f498627	0c2dff31-186e-494f-9f66-1c6723428f7b	t
cc1f3902-ede2-4cd8-a0e6-74997f498627	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
cc1f3902-ede2-4cd8-a0e6-74997f498627	a5877522-89a0-4351-bb1d-4d52b880021d	t
cc1f3902-ede2-4cd8-a0e6-74997f498627	41459e4d-e8b8-40b2-b131-481cef66d567	f
cc1f3902-ede2-4cd8-a0e6-74997f498627	21e0847a-7d34-489f-b122-471047b1ef4e	f
cc1f3902-ede2-4cd8-a0e6-74997f498627	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
cc1f3902-ede2-4cd8-a0e6-74997f498627	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
ff417939-2502-4d58-8612-03141753fdff	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
ff417939-2502-4d58-8612-03141753fdff	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
ff417939-2502-4d58-8612-03141753fdff	0c2dff31-186e-494f-9f66-1c6723428f7b	t
ff417939-2502-4d58-8612-03141753fdff	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
ff417939-2502-4d58-8612-03141753fdff	a5877522-89a0-4351-bb1d-4d52b880021d	t
ff417939-2502-4d58-8612-03141753fdff	41459e4d-e8b8-40b2-b131-481cef66d567	f
ff417939-2502-4d58-8612-03141753fdff	21e0847a-7d34-489f-b122-471047b1ef4e	f
ff417939-2502-4d58-8612-03141753fdff	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
ff417939-2502-4d58-8612-03141753fdff	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
75f229a3-0dea-4b0c-8451-b52e9475f0d1	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
75f229a3-0dea-4b0c-8451-b52e9475f0d1	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
75f229a3-0dea-4b0c-8451-b52e9475f0d1	0c2dff31-186e-494f-9f66-1c6723428f7b	t
75f229a3-0dea-4b0c-8451-b52e9475f0d1	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
75f229a3-0dea-4b0c-8451-b52e9475f0d1	a5877522-89a0-4351-bb1d-4d52b880021d	t
75f229a3-0dea-4b0c-8451-b52e9475f0d1	41459e4d-e8b8-40b2-b131-481cef66d567	f
75f229a3-0dea-4b0c-8451-b52e9475f0d1	21e0847a-7d34-489f-b122-471047b1ef4e	f
75f229a3-0dea-4b0c-8451-b52e9475f0d1	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
75f229a3-0dea-4b0c-8451-b52e9475f0d1	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
f41978f0-9155-4838-b235-d647ccb20155	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
f41978f0-9155-4838-b235-d647ccb20155	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
f41978f0-9155-4838-b235-d647ccb20155	0c2dff31-186e-494f-9f66-1c6723428f7b	t
f41978f0-9155-4838-b235-d647ccb20155	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
f41978f0-9155-4838-b235-d647ccb20155	a5877522-89a0-4351-bb1d-4d52b880021d	t
f41978f0-9155-4838-b235-d647ccb20155	41459e4d-e8b8-40b2-b131-481cef66d567	f
f41978f0-9155-4838-b235-d647ccb20155	21e0847a-7d34-489f-b122-471047b1ef4e	f
f41978f0-9155-4838-b235-d647ccb20155	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
f41978f0-9155-4838-b235-d647ccb20155	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
37e2224a-3146-4267-a017-7c7712bc4f6c	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
37e2224a-3146-4267-a017-7c7712bc4f6c	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
37e2224a-3146-4267-a017-7c7712bc4f6c	0c2dff31-186e-494f-9f66-1c6723428f7b	t
37e2224a-3146-4267-a017-7c7712bc4f6c	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
37e2224a-3146-4267-a017-7c7712bc4f6c	a5877522-89a0-4351-bb1d-4d52b880021d	t
37e2224a-3146-4267-a017-7c7712bc4f6c	41459e4d-e8b8-40b2-b131-481cef66d567	f
37e2224a-3146-4267-a017-7c7712bc4f6c	21e0847a-7d34-489f-b122-471047b1ef4e	f
37e2224a-3146-4267-a017-7c7712bc4f6c	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
37e2224a-3146-4267-a017-7c7712bc4f6c	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
50d72b62-c21d-41b3-b3f6-fa35f7178cef	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
50d72b62-c21d-41b3-b3f6-fa35f7178cef	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
50d72b62-c21d-41b3-b3f6-fa35f7178cef	0c2dff31-186e-494f-9f66-1c6723428f7b	t
50d72b62-c21d-41b3-b3f6-fa35f7178cef	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
50d72b62-c21d-41b3-b3f6-fa35f7178cef	a5877522-89a0-4351-bb1d-4d52b880021d	t
50d72b62-c21d-41b3-b3f6-fa35f7178cef	41459e4d-e8b8-40b2-b131-481cef66d567	f
50d72b62-c21d-41b3-b3f6-fa35f7178cef	21e0847a-7d34-489f-b122-471047b1ef4e	f
50d72b62-c21d-41b3-b3f6-fa35f7178cef	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
50d72b62-c21d-41b3-b3f6-fa35f7178cef	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
41459e4d-e8b8-40b2-b131-481cef66d567	415100ff-7bf9-41c1-8836-941b161d08a4
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
ceffe2d5-374e-4397-a556-f3f8b5c7f744	Trusted Hosts	63acd062-f967-4069-bfe4-7ed0f15dce58	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	anonymous
bc17d6b3-45c9-444d-97c8-f029495ccb4a	Consent Required	63acd062-f967-4069-bfe4-7ed0f15dce58	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	anonymous
76c8d34d-b46c-4502-a05b-f57320e5dbd5	Full Scope Disabled	63acd062-f967-4069-bfe4-7ed0f15dce58	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	anonymous
8f37d925-1740-44be-a78c-c909d3665552	Max Clients Limit	63acd062-f967-4069-bfe4-7ed0f15dce58	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	anonymous
844add30-280e-4237-b86b-f6f924b1381c	Allowed Protocol Mapper Types	63acd062-f967-4069-bfe4-7ed0f15dce58	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	anonymous
ff858b2e-0507-4d25-ba0e-939a709e4784	Allowed Client Scopes	63acd062-f967-4069-bfe4-7ed0f15dce58	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	anonymous
4eb0b33b-56c1-47b1-9097-70cc681d06cd	Allowed Protocol Mapper Types	63acd062-f967-4069-bfe4-7ed0f15dce58	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	authenticated
e03ad87e-db50-4d42-b76b-63633b3b2d56	Allowed Client Scopes	63acd062-f967-4069-bfe4-7ed0f15dce58	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	authenticated
4fc004e0-8f89-48de-ba9d-531e8d7c5530	rsa-generated	63acd062-f967-4069-bfe4-7ed0f15dce58	rsa-generated	org.keycloak.keys.KeyProvider	63acd062-f967-4069-bfe4-7ed0f15dce58	\N
ce977eb6-3695-4ff5-87a9-d9d701387f97	rsa-enc-generated	63acd062-f967-4069-bfe4-7ed0f15dce58	rsa-enc-generated	org.keycloak.keys.KeyProvider	63acd062-f967-4069-bfe4-7ed0f15dce58	\N
7e9db149-7836-4d45-b94b-7476db074e89	hmac-generated	63acd062-f967-4069-bfe4-7ed0f15dce58	hmac-generated	org.keycloak.keys.KeyProvider	63acd062-f967-4069-bfe4-7ed0f15dce58	\N
85c53e7b-1671-4e13-8d39-76797f740d8c	aes-generated	63acd062-f967-4069-bfe4-7ed0f15dce58	aes-generated	org.keycloak.keys.KeyProvider	63acd062-f967-4069-bfe4-7ed0f15dce58	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
242fbb58-9a3a-4d53-8205-6d0dfa220c93	ceffe2d5-374e-4397-a556-f3f8b5c7f744	host-sending-registration-request-must-match	true
17c7f9e6-f187-42be-8935-00e4b7e6185d	ceffe2d5-374e-4397-a556-f3f8b5c7f744	client-uris-must-match	true
da052440-1514-4b7f-ba16-cc6206046acc	ff858b2e-0507-4d25-ba0e-939a709e4784	allow-default-scopes	true
92949171-710f-45b8-889e-7671adad403b	e03ad87e-db50-4d42-b76b-63633b3b2d56	allow-default-scopes	true
b898d5ae-f8f8-4b0e-9b88-36187893d5a6	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	saml-user-attribute-mapper
a9ad7790-0304-42f5-9bf5-e1cd7ba70a38	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	saml-role-list-mapper
386f7a5f-b8bf-4307-a9b1-4b97c170711c	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	oidc-full-name-mapper
2eb5231d-b78f-4885-bb90-0ee7e1fbcdf8	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b927d48e-3070-4b3e-b41d-8732f5a24c54	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
24023514-d6ce-4f02-a995-e594dc5ec516	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
949d523b-6ed0-4432-88e1-d202b9abac45	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	oidc-address-mapper
874cc694-fee9-4e73-ba09-236142d6c590	844add30-280e-4237-b86b-f6f924b1381c	allowed-protocol-mapper-types	saml-user-property-mapper
a9027382-165b-417d-a8cd-aca91c23c8f0	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d089f39c-7f99-4bc7-a83d-4e58c3f1f392	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	saml-user-property-mapper
4f81b29e-520c-4da7-a465-f97174276046	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fa78f286-4bb1-4b51-9d73-4d44f9419a06	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2a458f8e-b5dd-4479-aa6f-5a798e1fd223	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	saml-role-list-mapper
d79be1e3-e68b-4a74-8963-2526a18e237e	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	oidc-full-name-mapper
10655440-5411-4d27-bdd6-6e50d76a3c37	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	saml-user-attribute-mapper
9a4f9912-ece4-4a55-9ac0-a8169faafeb5	4eb0b33b-56c1-47b1-9097-70cc681d06cd	allowed-protocol-mapper-types	oidc-address-mapper
72dee393-3173-471b-8361-e87ca3058eca	8f37d925-1740-44be-a78c-c909d3665552	max-clients	200
472d6c03-6385-4041-accb-ab1bf5554603	4fc004e0-8f89-48de-ba9d-531e8d7c5530	keyUse	SIG
c3911d5a-33fe-44b5-a08b-a473ca8efa4f	4fc004e0-8f89-48de-ba9d-531e8d7c5530	privateKey	MIIEpQIBAAKCAQEAqMqjYu/N2jTO94HA9cEVASrQiJFTgf9xwtpDq/p/4hDRf5stiR4gsa/wrTlLNi85vdnkfwYZ1/i+tB86d3pUrbp4GspCl1zkv/XRijHg0as/FzuEStaoBfBfASlCPN0AIh8oHwu3svC1+gnRsR2yoQBAxem6whRu0qJHkSLe7WDvSb/gkSVbSL601V0tnXegwKAw0YGdTJ/TNJxWkGmvMI1KJS2SS6mSkbI1KoduRzmbaeTjJn6p0F7a8ekUqSHnbfKzANweGISlgPyf5OIm2+PPzKze4A6y1Y4ceOEC2O/1V5rAa7a2pOhTjuFfuNUb7s5TO7I0aQ68LOzKF0HIuwIDAQABAoIBAAH2Gm9DJKA20How/bm/dmvA/BM2+m0aN4LtH9HqPOwuTB20vuhgpfpXZTwWmCVXPSSYFNiindjLerCdQmpUmaNuF3eWoFl3HZon1FtuIvHGXbSURZndBiZmt4HDewl+Jg8/cZGSyNESe+nIWjoGtsiYBORlttIK6ptJLKdRjjaHPba+A3PrKIse3tolsiW0aBGTnM8LjVRSp5zHDzXjyz9Oei2+bL2Yr9/sFWEcOik2th6KnsL2r/ORH/j0tOZ9uRiun1z2odRHa14QxwjM63IdMhj76ms5G7s5HPVmoW2gkOVtfZqjfdlFqFfHIpmZme8H2odmAzWOEqYIOgj7zhECgYEA4V6y99OvV5awp+imuKz8jYKL5rysb6h48fAzOwxEy6xMonfSd9MrKWYPK1hWj1JfpM1wYNMVuLv0kMyuIeUt45dmCFod3yf+DZ+vbOdAFF/Whf8RsmPwObL6e44KrS0MIcPtDPwq2o5s+ZCaWdJ7I10BKZ+ro9wqWd7XerI9WQkCgYEAv7toJUt5q0IEmiy8XSlDXtzVV42pxuJkcS3ohIGK/dxJHr1EN0L3m4wQDkhtwoaQuXqRVvdUVG57QK7rNrdT9doYYi3cNjTuEkKPousXn9diiRkxmE1N/+o+OgkHRTPQbASiTjT6Eddnd89vTYwDN9jko+7mBXqk+3iG0j+fWKMCgYEA22gxfhqFOxWGeIGERoiK+02b3A/VJIN0871wcs0X8N2WYhmbOnLIM26b2AwRgUilurES9gCqxgWeLJZH9NHEoi0T9Y+eQ1IRALx0seZUuUEwfZV8ahrnlZTMTRtVA5G2nOy8zIZ3Rf2g1DpWOpoyrZPu/NHo7Qb76DCNwXLjTNkCgYEAlLD5Jpsu42LSgOKavkEG72WhykGh3gyqyp9IyKJSMWgKCN3NLnIv5qCrvvfqr0Z+rGlil6g97TC1Q0ekQI3SfkLCUDmyoxNPYjfefwGFE8AMubghHzUsfYCi+40O51s0kuDRIoexO+7qXh8v+VrREBmTz5KxLqSbmC4zmJAgurMCgYEAoQAeLfdQk8pn9hLFRd3r6SQLqeo0bUiXM0h2rZhS95vN/8WT5HRf5gjdMRHYUQxJKyhXk5+s5oJSu23tVckGY8RjIouFSJkhdOUuHoBh1uxPsr5TFgKHNtbNVF3xdZe7Yc09u3HQOQsgofuM/VNx8Y/4iCkyz+8n3wNWWpmobGM=
1689d40f-abee-478a-886e-3bb8af55a2aa	4fc004e0-8f89-48de-ba9d-531e8d7c5530	priority	100
c0aa31d5-4914-4dcf-8c86-4b3aaeca5d8d	4fc004e0-8f89-48de-ba9d-531e8d7c5530	certificate	MIICmzCCAYMCBgGJdL9J9jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNzIwMTkxOTAwWhcNMzMwNzIwMTkyMDQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoyqNi783aNM73gcD1wRUBKtCIkVOB/3HC2kOr+n/iENF/my2JHiCxr/CtOUs2Lzm92eR/BhnX+L60Hzp3elStungaykKXXOS/9dGKMeDRqz8XO4RK1qgF8F8BKUI83QAiHygfC7ey8LX6CdGxHbKhAEDF6brCFG7SokeRIt7tYO9Jv+CRJVtIvrTVXS2dd6DAoDDRgZ1Mn9M0nFaQaa8wjUolLZJLqZKRsjUqh25HOZtp5OMmfqnQXtrx6RSpIedt8rMA3B4YhKWA/J/k4ibb48/MrN7gDrLVjhx44QLY7/VXmsBrtrak6FOO4V+41RvuzlM7sjRpDrws7MoXQci7AgMBAAEwDQYJKoZIhvcNAQELBQADggEBABdsSnNr26bDhpY/Ud9OHziyKCNjjfXYbJ+utLs8IsIPWGiJx7EW5aJFVhSTMpbILaAoNf8JTpY7fQE2+zTS5/zMBld+P1yCcYP+aFDJpoHbgMN3D2JP9Hrkf9haw5tUcGxMPfvIy6o+Vs/9vYVYfmq4LM6RvwC/N1E/orf38plcBUMM6ZTkXPJ/NTK8pEIFe+c0+N1PCNkBQNXwjK0RLyFZBuuRo2Te4UraQpuuSjGzc8+r7ZrAc+SSobdWoz7KDs/empOqNbnZaVbmEZ50phdWDyFFFvqo5RglJBznx0UBiO4iPl56nSQjk9mlNF9Y74YkrvR7g9Eal8I3kzJ2IlU=
1b019e97-d301-40a8-bc4f-b74e680fb195	7e9db149-7836-4d45-b94b-7476db074e89	priority	100
793a410b-ff26-45b1-ad34-46e7b016ecdd	7e9db149-7836-4d45-b94b-7476db074e89	algorithm	HS256
27f4a6ad-affa-4f0e-a070-90f1ee40c410	7e9db149-7836-4d45-b94b-7476db074e89	kid	a0d21249-3b4a-4d69-9979-5eebeea5c7a7
c865effa-fb05-422d-84fd-74a2e7ae419e	7e9db149-7836-4d45-b94b-7476db074e89	secret	U-eZIkjsqOz_8oQ0J2voHkwyMJ1vTG5JXOcHhV1g81k_01owj5cIJ7IaKnm0WxqHyKezMBkmVXKKPEwcW_h2bA
79377983-6b15-4fc5-922a-ff1a746da0f8	ce977eb6-3695-4ff5-87a9-d9d701387f97	privateKey	MIIEogIBAAKCAQEAsdBVTLMYFg07V9VyiRRC+uKG0My6mnF3bXbXMYRHG6BBr4FZFBjqsE1lRybz47YlHHNbxy/LYd7kSkt4gljw4CCfW9+ghpM7vnqwIcy2WE/Tz8WWelntj+AB7EUBn2seFvwnJjEUJVziDyB7QmJA7RCRNk5G+xez0C11Mt2HDMB2R9wyZZiP0NBac6jePitVgZtruuxPtk13y4r2DvX7VrHKSHjO6DmDaHX5F0rJklRmWDBgDh7607qhuOeA9bSIky6umAjgWmpQa9usUYrAM5AWy3EPz9LgOuuNOFK6v9/5QIFPyBjX+ek75/h5h0cR84p4YZd1AEnORvLZe2gFMwIDAQABAoIBABra5ichXV/nO7E2UYgWgU826zmZ0g0FWg40Rqf53Gt1trX1CSkZ4kgiSEuIvIkFt3EmkxPwSf1MFpqJ73dwS2DuTGMp0SrCDeHk0bkpG9kWpVzZ8LIl5tU19dRjT61uFitOhfMksnA6KQIz26nZAQlM2UGkbN/7YnLsiqjWAFGSdy5Sjm4qd6Gzvq/7VSE3g8iESM6Y58IiAgYPwLaGMb8yvXUrnjfHIGLIjWS260yeX/d0UaDAIHTne9HzCObLTiv7l2FXNSn69td31RCMbcCxD7VqucA2LCGKeOSFOkpTQdIBdUUEkX7pQaYZ7v0FKgws2RtkYHDNUCACorZWZrECgYEA5SX7IoXT6hOUARQGPJ1AlG92BL5YjqOXAFBMiLY3qie40QrmawBrWx91IwCjeWBGd5wOZfHfBFcFk21W5OXWRUAPI1U5OOkpYfYZ6/PWmlN0bmfdcNDSYuNR8znu/wOmQBp9yA/8mFJzwNIdUQXurK/ad8k9gOx9kF/hHDMfV5UCgYEAxqZpgAA62atapsPiBUsizRIk9EifzCrtZbyvYVaz3HMwTiC7Upek+lp2gxWppAGYFPdNPrmp0WxqIrDGEu+9cVQ3MzJLehkofqpYrck08SLQzCwPyfUfuWfGcCwP3KVFJroGchWwlxZX7gpvYaO9ftW+PvjwsSm8mJlAU8jZl6cCgYBfoc1AaCe7vfX7yTadH2evSyEu852T0fQX/msidyGeErvQCkOFjoQ/YE6LkB2pbyOZkXh01U+kyQibsXsdRkp5VjW7IjsiZDSQHJxO29HJUGD8Hr7M8WmMOaCe6KO0q/o7MJMj5oAdtfN3Gnl/sgEc8rszWLohTxFMKqeRFEjVTQKBgDugyBo7925PGS7lrXqZSyDzSVRqWE0YtZnMQXieZe7ORLmu6YupKURc0yYV4o3wTI4+jVk+sdLDEDjJhys3+02BUfB0MGO+GYGr8GJ5+wJGyRYAQ90DTzqAA/i3wSsiENfHDxg/mno/orU5PKW6WK8xyaFtaBJFzO6hUcXUjDwRAoGAZpGEuSCLXfQBfzMeuPaUOoYPBKYNiHLXQWZyA19CWke0fnKZciQ4NemlnrARKZM4aVPThvKXAm5jjp2T+gbf4NtLVAOzQ3LSRzNVxUlnaUOVxpSdjmFWGgkdw0rgx3sV/MJ6H5/9ejvEe4SKcrDUa2bBiquO04GihvA51NqEP0g=
a2ac750d-9805-4924-bc62-15f939457a4c	ce977eb6-3695-4ff5-87a9-d9d701387f97	keyUse	ENC
0c84b500-5185-4a1b-b50d-ca0b772ed1f7	ce977eb6-3695-4ff5-87a9-d9d701387f97	certificate	MIICmzCCAYMCBgGJdL9LijANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNzIwMTkxOTAxWhcNMzMwNzIwMTkyMDQxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCx0FVMsxgWDTtX1XKJFEL64obQzLqacXdtdtcxhEcboEGvgVkUGOqwTWVHJvPjtiUcc1vHL8th3uRKS3iCWPDgIJ9b36CGkzu+erAhzLZYT9PPxZZ6We2P4AHsRQGfax4W/CcmMRQlXOIPIHtCYkDtEJE2Tkb7F7PQLXUy3YcMwHZH3DJlmI/Q0FpzqN4+K1WBm2u67E+2TXfLivYO9ftWscpIeM7oOYNodfkXSsmSVGZYMGAOHvrTuqG454D1tIiTLq6YCOBaalBr26xRisAzkBbLcQ/P0uA66404Urq/3/lAgU/IGNf56Tvn+HmHRxHzinhhl3UASc5G8tl7aAUzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIRmf8lk5cmjplk2l6P9jIOHUELwak1uM8+MEG6Uz4o//cVocrT3YkSDfCldAi11ASukiFZJF8KTlH1WNmFFR/JR5CjjoreUBuHhMc2zlLyI2oNqVzOGpZtwbrhb75dOXYsnl4iSDM0a8KFFQHfkXSW++BpN3+f8evnhuBhP6hRZlIXcVIA3IwiIj2HttSMwYxaRMtnOuu7OH4hNTwIkoFj9mIiYCprUnMLcKOjsXcz1hcvpGbFXVf0Yp2DPmUthXXX0NG3z2rWn2l2iURb9+FjzrhwamIwJjykdGvXR4d0W1MmfDeoau2IJ/E2/k8PF48Oo9+P556mktxsQA6g5HqM=
817633e2-c63b-4185-9a54-a6be4af1366e	ce977eb6-3695-4ff5-87a9-d9d701387f97	priority	100
5de6eb88-9cd5-4ad9-9092-8c51106743a9	ce977eb6-3695-4ff5-87a9-d9d701387f97	algorithm	RSA-OAEP
44312b8c-0629-4850-afc7-c46b047f7992	85c53e7b-1671-4e13-8d39-76797f740d8c	priority	100
1163b3a7-48eb-40f3-92d2-0ed9684ec3d5	85c53e7b-1671-4e13-8d39-76797f740d8c	secret	vrQ5QoLAw_iIaxS_L4jcNw
ce260f73-116e-40b4-bcbc-8311d2ef42da	85c53e7b-1671-4e13-8d39-76797f740d8c	kid	b85dd348-ad18-4753-bbe3-cea49d325718
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
7a16a161-e422-44c9-a00e-be5f8d98a4a0	40d9569b-567c-4e08-bded-bd77f64525de
7a16a161-e422-44c9-a00e-be5f8d98a4a0	e2d7aeae-62ed-4f56-9f29-985117892f66
7a16a161-e422-44c9-a00e-be5f8d98a4a0	b77bba69-4fea-4271-a8f6-131fbc8b11b2
7a16a161-e422-44c9-a00e-be5f8d98a4a0	8d673f53-3639-43d2-be61-e1baecd722d6
7a16a161-e422-44c9-a00e-be5f8d98a4a0	c6d39574-4161-430e-a882-1fc7e52ede64
7a16a161-e422-44c9-a00e-be5f8d98a4a0	b7b66976-fa7b-45b1-b06a-c23ffaccf6a5
7a16a161-e422-44c9-a00e-be5f8d98a4a0	f5a4746f-1edc-4ea6-b807-3c664e34a5a5
7a16a161-e422-44c9-a00e-be5f8d98a4a0	aedf7cb7-d46d-4086-a577-1059d011ca2d
7a16a161-e422-44c9-a00e-be5f8d98a4a0	0753402a-97e1-4ee4-bccd-50be454c13cb
7a16a161-e422-44c9-a00e-be5f8d98a4a0	5ba6c94b-3b2a-4a4e-8ce6-100ab889a31e
7a16a161-e422-44c9-a00e-be5f8d98a4a0	726d3029-030f-46de-b19b-64a066d76890
7a16a161-e422-44c9-a00e-be5f8d98a4a0	0f93ca24-dc2c-497e-85f6-7d24fdd78154
7a16a161-e422-44c9-a00e-be5f8d98a4a0	91dd6139-9afd-4977-87f6-991bd1a8b2b8
7a16a161-e422-44c9-a00e-be5f8d98a4a0	0976a58d-9e88-4c50-94a6-12ab0c91b11c
7a16a161-e422-44c9-a00e-be5f8d98a4a0	32ba197b-a9e4-479a-86a0-6e9174c22f71
7a16a161-e422-44c9-a00e-be5f8d98a4a0	d55dc792-c1ce-436a-af63-f608afeeca61
7a16a161-e422-44c9-a00e-be5f8d98a4a0	839eae7f-3cd2-4bcc-ad82-70b513cc3197
7a16a161-e422-44c9-a00e-be5f8d98a4a0	fe666ac4-5826-4402-af71-3db6fb62a8bf
8d673f53-3639-43d2-be61-e1baecd722d6	32ba197b-a9e4-479a-86a0-6e9174c22f71
8d673f53-3639-43d2-be61-e1baecd722d6	fe666ac4-5826-4402-af71-3db6fb62a8bf
b5e1dda1-653a-4aa6-a097-cf9477f787c3	f3f80fd8-463b-4544-b3b5-8886147106fa
c6d39574-4161-430e-a882-1fc7e52ede64	d55dc792-c1ce-436a-af63-f608afeeca61
b5e1dda1-653a-4aa6-a097-cf9477f787c3	e831e03c-0f7a-4ea1-ba46-490412dae067
e831e03c-0f7a-4ea1-ba46-490412dae067	de499f78-2965-404a-8932-192706f16eb6
2e2800de-1fec-4a2e-9993-e1c852c2ad60	27648bfd-8aeb-48cb-beb1-36f4c8511889
7a16a161-e422-44c9-a00e-be5f8d98a4a0	f4f94319-a548-4946-8b9c-f5a727a36a4e
b5e1dda1-653a-4aa6-a097-cf9477f787c3	415100ff-7bf9-41c1-8836-941b161d08a4
b5e1dda1-653a-4aa6-a097-cf9477f787c3	5b5d212a-d334-4931-b8bb-e2fed2616b44
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
0d76fe9d-c036-4aa8-a4a6-67f215516278	\N	password	84059de0-00e4-43ab-82f5-5b7b217cf8dd	1689880841679	\N	{"value":"crJQjC2jI5sMtZ2WljBsrmxrP2UfihlXbFAP1NS+BEQ=","salt":"egIduUB32KVgozNF9zYeRA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f1c000bf-1bb6-42b4-bc08-4f1328c62195	\N	password	bb86ca2a-fe35-4594-9d5b-65d6a72119fa	1689970199406	My password	{"value":"8E0s/usG8vNskRPfFrOgUSA3uDThHOIrCp1bNI+0t80=","salt":"DwEdhpcWxJ/rCacXRpYcUA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-07-20 19:20:37.362358	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	9880836844
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-07-20 19:20:37.370141	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	9880836844
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-07-20 19:20:37.419781	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.20.0	\N	\N	9880836844
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-07-20 19:20:37.424581	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	9880836844
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-07-20 19:20:37.541305	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	9880836844
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-07-20 19:20:37.544543	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	9880836844
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-07-20 19:20:37.648529	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	9880836844
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-07-20 19:20:37.65108	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	9880836844
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-07-20 19:20:37.656028	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.20.0	\N	\N	9880836844
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-07-20 19:20:37.75924	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.20.0	\N	\N	9880836844
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-07-20 19:20:37.837383	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	9880836844
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-07-20 19:20:37.839775	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	9880836844
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-07-20 19:20:37.858221	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	9880836844
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-20 19:20:37.880567	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.20.0	\N	\N	9880836844
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-20 19:20:37.882796	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9880836844
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-20 19:20:37.885418	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.20.0	\N	\N	9880836844
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-20 19:20:37.8882	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	9880836844
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-07-20 19:20:37.930437	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.20.0	\N	\N	9880836844
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-07-20 19:20:37.987547	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	9880836844
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-07-20 19:20:37.992824	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	9880836844
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-07-20 19:20:37.994539	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	9880836844
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-07-20 19:20:37.996994	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	9880836844
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-07-20 19:20:38.0216	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.20.0	\N	\N	9880836844
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-07-20 19:20:38.027513	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	9880836844
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-07-20 19:20:38.029425	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	9880836844
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-07-20 19:20:38.067116	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.20.0	\N	\N	9880836844
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-07-20 19:20:38.160362	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.20.0	\N	\N	9880836844
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-07-20 19:20:38.164432	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	9880836844
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-07-20 19:20:38.249214	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.20.0	\N	\N	9880836844
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-07-20 19:20:38.266565	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.20.0	\N	\N	9880836844
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-07-20 19:20:38.287902	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.20.0	\N	\N	9880836844
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-07-20 19:20:38.2956	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.20.0	\N	\N	9880836844
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-20 19:20:38.304713	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9880836844
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-20 19:20:38.306624	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	9880836844
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-20 19:20:38.337523	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	9880836844
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-07-20 19:20:38.343544	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.20.0	\N	\N	9880836844
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-20 19:20:38.35149	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9880836844
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-07-20 19:20:38.35573	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.20.0	\N	\N	9880836844
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-07-20 19:20:38.360145	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.20.0	\N	\N	9880836844
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-20 19:20:38.362498	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	9880836844
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-20 19:20:38.364964	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	9880836844
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-07-20 19:20:38.371529	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.20.0	\N	\N	9880836844
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-20 19:20:38.563203	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.20.0	\N	\N	9880836844
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-07-20 19:20:38.56945	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.20.0	\N	\N	9880836844
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-20 19:20:38.576129	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	9880836844
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-20 19:20:38.583337	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.20.0	\N	\N	9880836844
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-20 19:20:38.585511	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	9880836844
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-20 19:20:38.636019	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.20.0	\N	\N	9880836844
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-20 19:20:38.642012	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.20.0	\N	\N	9880836844
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-07-20 19:20:38.700172	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.20.0	\N	\N	9880836844
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-07-20 19:20:38.748733	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.20.0	\N	\N	9880836844
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-07-20 19:20:38.754175	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9880836844
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-07-20 19:20:38.757871	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.20.0	\N	\N	9880836844
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-07-20 19:20:38.762417	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.20.0	\N	\N	9880836844
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-20 19:20:38.771674	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.20.0	\N	\N	9880836844
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-20 19:20:38.779615	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.20.0	\N	\N	9880836844
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-20 19:20:38.808138	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.20.0	\N	\N	9880836844
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-20 19:20:38.928165	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.20.0	\N	\N	9880836844
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-07-20 19:20:38.963408	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.20.0	\N	\N	9880836844
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-07-20 19:20:38.970388	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	9880836844
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-07-20 19:20:38.982114	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.20.0	\N	\N	9880836844
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-07-20 19:20:38.988897	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.20.0	\N	\N	9880836844
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-07-20 19:20:38.993454	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	9880836844
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-07-20 19:20:38.996719	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	9880836844
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-07-20 19:20:39.000166	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.20.0	\N	\N	9880836844
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-07-20 19:20:39.016524	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.20.0	\N	\N	9880836844
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-07-20 19:20:39.022993	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.20.0	\N	\N	9880836844
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-07-20 19:20:39.027882	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.20.0	\N	\N	9880836844
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-07-20 19:20:39.040609	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.20.0	\N	\N	9880836844
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-07-20 19:20:39.045943	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.20.0	\N	\N	9880836844
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-07-20 19:20:39.049893	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	9880836844
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-20 19:20:39.05563	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	9880836844
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-20 19:20:39.063452	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	9880836844
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-20 19:20:39.065473	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	9880836844
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-20 19:20:39.082958	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.20.0	\N	\N	9880836844
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-20 19:20:39.091421	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.20.0	\N	\N	9880836844
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-20 19:20:39.096273	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.20.0	\N	\N	9880836844
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-20 19:20:39.098203	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.20.0	\N	\N	9880836844
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-20 19:20:39.122762	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.20.0	\N	\N	9880836844
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-20 19:20:39.125747	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.20.0	\N	\N	9880836844
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-20 19:20:39.134666	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.20.0	\N	\N	9880836844
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-20 19:20:39.136589	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9880836844
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-20 19:20:39.142668	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9880836844
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-20 19:20:39.144541	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	9880836844
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-20 19:20:39.152193	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	9880836844
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-07-20 19:20:39.159054	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.20.0	\N	\N	9880836844
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-07-20 19:20:39.169258	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.20.0	\N	\N	9880836844
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-07-20 19:20:39.180738	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.20.0	\N	\N	9880836844
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.190028	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.20.0	\N	\N	9880836844
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.198567	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.20.0	\N	\N	9880836844
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.206357	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9880836844
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.217771	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.20.0	\N	\N	9880836844
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.219914	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	9880836844
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.231266	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	9880836844
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.233551	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.20.0	\N	\N	9880836844
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-20 19:20:39.241055	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.20.0	\N	\N	9880836844
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.256445	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	9880836844
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.258681	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9880836844
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.267703	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9880836844
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.275186	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9880836844
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.277262	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9880836844
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.285794	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.20.0	\N	\N	9880836844
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-20 19:20:39.292311	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.20.0	\N	\N	9880836844
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-07-20 19:20:39.298915	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.20.0	\N	\N	9880836844
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-07-20 19:20:39.307312	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.20.0	\N	\N	9880836844
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-07-20 19:20:39.314527	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.20.0	\N	\N	9880836844
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-07-20 19:20:39.321267	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.20.0	\N	\N	9880836844
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-20 19:20:39.328179	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	9880836844
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-20 19:20:39.329923	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	9880836844
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-20 19:20:39.337121	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	9880836844
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2023-07-20 19:20:39.343866	111	EXECUTED	8:8806cb33d2a546ce770384bf98cf6eac	customChange		\N	4.20.0	\N	\N	9880836844
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-07-20 19:20:39.393604	112	EXECUTED	8:fdb2924649d30555ab3a1744faba4928	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	9880836844
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-07-20 19:20:39.396681	113	MARK_RAN	8:1c96cc2b10903bd07a03670098d67fd6	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.20.0	\N	\N	9880836844
22.0.0-17484	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-07-20 19:20:39.407462	114	EXECUTED	8:4c3d4e8b142a66fcdf21b89a4dd33301	customChange		\N	4.20.0	\N	\N	9880836844
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
63acd062-f967-4069-bfe4-7ed0f15dce58	41459e4d-e8b8-40b2-b131-481cef66d567	f
63acd062-f967-4069-bfe4-7ed0f15dce58	7b4e4a56-bdc2-41bb-8c28-8aedd54bc12a	t
63acd062-f967-4069-bfe4-7ed0f15dce58	1b9047ed-a6de-4651-8972-e588e1b1fac6	t
63acd062-f967-4069-bfe4-7ed0f15dce58	a5877522-89a0-4351-bb1d-4d52b880021d	t
63acd062-f967-4069-bfe4-7ed0f15dce58	21e0847a-7d34-489f-b122-471047b1ef4e	f
63acd062-f967-4069-bfe4-7ed0f15dce58	feb6daf6-6ebc-465e-b36d-b5137340ce86	f
63acd062-f967-4069-bfe4-7ed0f15dce58	9bad0834-2715-4191-acdc-e523ce4f0f6f	t
63acd062-f967-4069-bfe4-7ed0f15dce58	0c2dff31-186e-494f-9f66-1c6723428f7b	t
63acd062-f967-4069-bfe4-7ed0f15dce58	ed4fea3d-c9b1-4e7a-918c-10139572359f	f
63acd062-f967-4069-bfe4-7ed0f15dce58	2dda74e3-6a5b-40f1-93d0-442e8558596d	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
b5e1dda1-653a-4aa6-a097-cf9477f787c3	63acd062-f967-4069-bfe4-7ed0f15dce58	f	${role_default-roles}	default-roles-master	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	\N
40d9569b-567c-4e08-bded-bd77f64525de	63acd062-f967-4069-bfe4-7ed0f15dce58	f	${role_create-realm}	create-realm	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	\N
7a16a161-e422-44c9-a00e-be5f8d98a4a0	63acd062-f967-4069-bfe4-7ed0f15dce58	f	${role_admin}	admin	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	\N
e2d7aeae-62ed-4f56-9f29-985117892f66	f41978f0-9155-4838-b235-d647ccb20155	t	${role_create-client}	create-client	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
b77bba69-4fea-4271-a8f6-131fbc8b11b2	f41978f0-9155-4838-b235-d647ccb20155	t	${role_view-realm}	view-realm	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
8d673f53-3639-43d2-be61-e1baecd722d6	f41978f0-9155-4838-b235-d647ccb20155	t	${role_view-users}	view-users	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
c6d39574-4161-430e-a882-1fc7e52ede64	f41978f0-9155-4838-b235-d647ccb20155	t	${role_view-clients}	view-clients	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
b7b66976-fa7b-45b1-b06a-c23ffaccf6a5	f41978f0-9155-4838-b235-d647ccb20155	t	${role_view-events}	view-events	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
f5a4746f-1edc-4ea6-b807-3c664e34a5a5	f41978f0-9155-4838-b235-d647ccb20155	t	${role_view-identity-providers}	view-identity-providers	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
aedf7cb7-d46d-4086-a577-1059d011ca2d	f41978f0-9155-4838-b235-d647ccb20155	t	${role_view-authorization}	view-authorization	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
0753402a-97e1-4ee4-bccd-50be454c13cb	f41978f0-9155-4838-b235-d647ccb20155	t	${role_manage-realm}	manage-realm	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
5ba6c94b-3b2a-4a4e-8ce6-100ab889a31e	f41978f0-9155-4838-b235-d647ccb20155	t	${role_manage-users}	manage-users	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
726d3029-030f-46de-b19b-64a066d76890	f41978f0-9155-4838-b235-d647ccb20155	t	${role_manage-clients}	manage-clients	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
0f93ca24-dc2c-497e-85f6-7d24fdd78154	f41978f0-9155-4838-b235-d647ccb20155	t	${role_manage-events}	manage-events	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
91dd6139-9afd-4977-87f6-991bd1a8b2b8	f41978f0-9155-4838-b235-d647ccb20155	t	${role_manage-identity-providers}	manage-identity-providers	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
0976a58d-9e88-4c50-94a6-12ab0c91b11c	f41978f0-9155-4838-b235-d647ccb20155	t	${role_manage-authorization}	manage-authorization	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
32ba197b-a9e4-479a-86a0-6e9174c22f71	f41978f0-9155-4838-b235-d647ccb20155	t	${role_query-users}	query-users	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
d55dc792-c1ce-436a-af63-f608afeeca61	f41978f0-9155-4838-b235-d647ccb20155	t	${role_query-clients}	query-clients	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
839eae7f-3cd2-4bcc-ad82-70b513cc3197	f41978f0-9155-4838-b235-d647ccb20155	t	${role_query-realms}	query-realms	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
fe666ac4-5826-4402-af71-3db6fb62a8bf	f41978f0-9155-4838-b235-d647ccb20155	t	${role_query-groups}	query-groups	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
f3f80fd8-463b-4544-b3b5-8886147106fa	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_view-profile}	view-profile	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
e831e03c-0f7a-4ea1-ba46-490412dae067	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_manage-account}	manage-account	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
de499f78-2965-404a-8932-192706f16eb6	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_manage-account-links}	manage-account-links	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
3d139b2d-2adb-49d8-94c4-59f9ab13bc0e	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_view-applications}	view-applications	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
27648bfd-8aeb-48cb-beb1-36f4c8511889	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_view-consent}	view-consent	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
2e2800de-1fec-4a2e-9993-e1c852c2ad60	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_manage-consent}	manage-consent	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
a4d3e63e-933b-4a51-983c-6d93fc6765f1	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_view-groups}	view-groups	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
7e49ec14-1d27-45a6-9f5a-1d1738eb5680	0a99fac4-fbe8-4608-aa13-2244b00e4e61	t	${role_delete-account}	delete-account	63acd062-f967-4069-bfe4-7ed0f15dce58	0a99fac4-fbe8-4608-aa13-2244b00e4e61	\N
ab8e2ef1-c383-407a-9aef-bc8a3fb591e4	75f229a3-0dea-4b0c-8451-b52e9475f0d1	t	${role_read-token}	read-token	63acd062-f967-4069-bfe4-7ed0f15dce58	75f229a3-0dea-4b0c-8451-b52e9475f0d1	\N
f4f94319-a548-4946-8b9c-f5a727a36a4e	f41978f0-9155-4838-b235-d647ccb20155	t	${role_impersonation}	impersonation	63acd062-f967-4069-bfe4-7ed0f15dce58	f41978f0-9155-4838-b235-d647ccb20155	\N
415100ff-7bf9-41c1-8836-941b161d08a4	63acd062-f967-4069-bfe4-7ed0f15dce58	f	${role_offline-access}	offline_access	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	\N
5b5d212a-d334-4931-b8bb-e2fed2616b44	63acd062-f967-4069-bfe4-7ed0f15dce58	f	${role_uma_authorization}	uma_authorization	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	\N
ebe7216e-8451-4fa5-805c-70013247f594	63acd062-f967-4069-bfe4-7ed0f15dce58	f		sales-manager	63acd062-f967-4069-bfe4-7ed0f15dce58	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
c58m0	22.0.1	1689880839
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
953d50ae-04d9-4cda-867c-0e9d1979e456	audience resolve	openid-connect	oidc-audience-resolve-mapper	cc1f3902-ede2-4cd8-a0e6-74997f498627	\N
21276706-d6ac-4f42-bd11-2689d1b36156	locale	openid-connect	oidc-usermodel-attribute-mapper	37e2224a-3146-4267-a017-7c7712bc4f6c	\N
b9748740-8ea4-4da2-870d-72d7500428fe	role list	saml	saml-role-list-mapper	\N	7b4e4a56-bdc2-41bb-8c28-8aedd54bc12a
fd16a280-aa4a-40f8-8117-92d3b97e7f7a	full name	openid-connect	oidc-full-name-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
8fed4147-194c-4f4d-a134-cfdbdd81f23d	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
bdec27b6-d5cf-444a-8c6d-8384e35258a8	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
5a662fe9-5306-439f-a660-1121c51f2243	username	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
881d3e58-2ea4-4c25-944b-ffeffb1281b3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
8ce0557a-df38-4329-8955-8f9005cbe625	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
6a0f0136-f549-4c37-a9b8-721b4c30cb46	website	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
e58b4e43-1077-4f8d-9462-bbf43a7c2655	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
c4690d30-f947-4ec1-8ef4-a747e73a75ab	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
a451fdd7-c449-414e-8da5-dce762a371fd	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	1b9047ed-a6de-4651-8972-e588e1b1fac6
817293b8-685f-43ca-be27-b7c83a1b44e6	email	openid-connect	oidc-usermodel-attribute-mapper	\N	a5877522-89a0-4351-bb1d-4d52b880021d
bdd982ba-8f97-4be6-8849-724cfffb1a98	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a5877522-89a0-4351-bb1d-4d52b880021d
2a88efdb-b5f9-4389-99fb-c56845bc1464	address	openid-connect	oidc-address-mapper	\N	21e0847a-7d34-489f-b122-471047b1ef4e
93cb0d3b-386f-459a-ae26-96031cbdb1cb	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	feb6daf6-6ebc-465e-b36d-b5137340ce86
d1ec0239-a954-4793-8329-32f5abc0c76d	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	feb6daf6-6ebc-465e-b36d-b5137340ce86
aedf73fc-bf29-419c-a7c8-4af97d729d50	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9bad0834-2715-4191-acdc-e523ce4f0f6f
46ad3242-3851-44e0-a686-a1d9abdac978	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9bad0834-2715-4191-acdc-e523ce4f0f6f
0d375a8f-7858-4803-ba07-d1f4682f8e82	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9bad0834-2715-4191-acdc-e523ce4f0f6f
8f1f8d9f-a8e7-4e18-8d59-ddd537c7ab08	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	0c2dff31-186e-494f-9f66-1c6723428f7b
1c565cc7-caa2-47ab-a905-996ec697f65f	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	ed4fea3d-c9b1-4e7a-918c-10139572359f
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	ed4fea3d-c9b1-4e7a-918c-10139572359f
58fb8e38-d752-48f8-8097-a717e4c094d1	acr loa level	openid-connect	oidc-acr-mapper	\N	2dda74e3-6a5b-40f1-93d0-442e8558596d
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
21276706-d6ac-4f42-bd11-2689d1b36156	true	userinfo.token.claim
21276706-d6ac-4f42-bd11-2689d1b36156	locale	user.attribute
21276706-d6ac-4f42-bd11-2689d1b36156	true	id.token.claim
21276706-d6ac-4f42-bd11-2689d1b36156	true	access.token.claim
21276706-d6ac-4f42-bd11-2689d1b36156	locale	claim.name
21276706-d6ac-4f42-bd11-2689d1b36156	String	jsonType.label
b9748740-8ea4-4da2-870d-72d7500428fe	false	single
b9748740-8ea4-4da2-870d-72d7500428fe	Basic	attribute.nameformat
b9748740-8ea4-4da2-870d-72d7500428fe	Role	attribute.name
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	true	userinfo.token.claim
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	firstName	user.attribute
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	true	id.token.claim
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	true	access.token.claim
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	given_name	claim.name
07ed344d-90fc-429f-a100-c1a6c0a1c4f4	String	jsonType.label
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	true	userinfo.token.claim
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	lastName	user.attribute
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	true	id.token.claim
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	true	access.token.claim
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	family_name	claim.name
2dc16f95-2b4d-49e5-a479-e0621aa0c69b	String	jsonType.label
5a662fe9-5306-439f-a660-1121c51f2243	true	userinfo.token.claim
5a662fe9-5306-439f-a660-1121c51f2243	username	user.attribute
5a662fe9-5306-439f-a660-1121c51f2243	true	id.token.claim
5a662fe9-5306-439f-a660-1121c51f2243	true	access.token.claim
5a662fe9-5306-439f-a660-1121c51f2243	preferred_username	claim.name
5a662fe9-5306-439f-a660-1121c51f2243	String	jsonType.label
6a0f0136-f549-4c37-a9b8-721b4c30cb46	true	userinfo.token.claim
6a0f0136-f549-4c37-a9b8-721b4c30cb46	website	user.attribute
6a0f0136-f549-4c37-a9b8-721b4c30cb46	true	id.token.claim
6a0f0136-f549-4c37-a9b8-721b4c30cb46	true	access.token.claim
6a0f0136-f549-4c37-a9b8-721b4c30cb46	website	claim.name
6a0f0136-f549-4c37-a9b8-721b4c30cb46	String	jsonType.label
881d3e58-2ea4-4c25-944b-ffeffb1281b3	true	userinfo.token.claim
881d3e58-2ea4-4c25-944b-ffeffb1281b3	profile	user.attribute
881d3e58-2ea4-4c25-944b-ffeffb1281b3	true	id.token.claim
881d3e58-2ea4-4c25-944b-ffeffb1281b3	true	access.token.claim
881d3e58-2ea4-4c25-944b-ffeffb1281b3	profile	claim.name
881d3e58-2ea4-4c25-944b-ffeffb1281b3	String	jsonType.label
8ce0557a-df38-4329-8955-8f9005cbe625	true	userinfo.token.claim
8ce0557a-df38-4329-8955-8f9005cbe625	picture	user.attribute
8ce0557a-df38-4329-8955-8f9005cbe625	true	id.token.claim
8ce0557a-df38-4329-8955-8f9005cbe625	true	access.token.claim
8ce0557a-df38-4329-8955-8f9005cbe625	picture	claim.name
8ce0557a-df38-4329-8955-8f9005cbe625	String	jsonType.label
8fed4147-194c-4f4d-a134-cfdbdd81f23d	true	userinfo.token.claim
8fed4147-194c-4f4d-a134-cfdbdd81f23d	middleName	user.attribute
8fed4147-194c-4f4d-a134-cfdbdd81f23d	true	id.token.claim
8fed4147-194c-4f4d-a134-cfdbdd81f23d	true	access.token.claim
8fed4147-194c-4f4d-a134-cfdbdd81f23d	middle_name	claim.name
8fed4147-194c-4f4d-a134-cfdbdd81f23d	String	jsonType.label
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	true	userinfo.token.claim
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	updatedAt	user.attribute
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	true	id.token.claim
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	true	access.token.claim
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	updated_at	claim.name
93a6ab03-ecc5-4338-a865-0c3d3bb0d77c	long	jsonType.label
a451fdd7-c449-414e-8da5-dce762a371fd	true	userinfo.token.claim
a451fdd7-c449-414e-8da5-dce762a371fd	locale	user.attribute
a451fdd7-c449-414e-8da5-dce762a371fd	true	id.token.claim
a451fdd7-c449-414e-8da5-dce762a371fd	true	access.token.claim
a451fdd7-c449-414e-8da5-dce762a371fd	locale	claim.name
a451fdd7-c449-414e-8da5-dce762a371fd	String	jsonType.label
bdec27b6-d5cf-444a-8c6d-8384e35258a8	true	userinfo.token.claim
bdec27b6-d5cf-444a-8c6d-8384e35258a8	nickname	user.attribute
bdec27b6-d5cf-444a-8c6d-8384e35258a8	true	id.token.claim
bdec27b6-d5cf-444a-8c6d-8384e35258a8	true	access.token.claim
bdec27b6-d5cf-444a-8c6d-8384e35258a8	nickname	claim.name
bdec27b6-d5cf-444a-8c6d-8384e35258a8	String	jsonType.label
c4690d30-f947-4ec1-8ef4-a747e73a75ab	true	userinfo.token.claim
c4690d30-f947-4ec1-8ef4-a747e73a75ab	zoneinfo	user.attribute
c4690d30-f947-4ec1-8ef4-a747e73a75ab	true	id.token.claim
c4690d30-f947-4ec1-8ef4-a747e73a75ab	true	access.token.claim
c4690d30-f947-4ec1-8ef4-a747e73a75ab	zoneinfo	claim.name
c4690d30-f947-4ec1-8ef4-a747e73a75ab	String	jsonType.label
e58b4e43-1077-4f8d-9462-bbf43a7c2655	true	userinfo.token.claim
e58b4e43-1077-4f8d-9462-bbf43a7c2655	birthdate	user.attribute
e58b4e43-1077-4f8d-9462-bbf43a7c2655	true	id.token.claim
e58b4e43-1077-4f8d-9462-bbf43a7c2655	true	access.token.claim
e58b4e43-1077-4f8d-9462-bbf43a7c2655	birthdate	claim.name
e58b4e43-1077-4f8d-9462-bbf43a7c2655	String	jsonType.label
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	true	userinfo.token.claim
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	gender	user.attribute
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	true	id.token.claim
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	true	access.token.claim
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	gender	claim.name
f0c4fec0-3e3f-4d71-a0df-3d10f20b722b	String	jsonType.label
fd16a280-aa4a-40f8-8117-92d3b97e7f7a	true	userinfo.token.claim
fd16a280-aa4a-40f8-8117-92d3b97e7f7a	true	id.token.claim
fd16a280-aa4a-40f8-8117-92d3b97e7f7a	true	access.token.claim
817293b8-685f-43ca-be27-b7c83a1b44e6	true	userinfo.token.claim
817293b8-685f-43ca-be27-b7c83a1b44e6	email	user.attribute
817293b8-685f-43ca-be27-b7c83a1b44e6	true	id.token.claim
817293b8-685f-43ca-be27-b7c83a1b44e6	true	access.token.claim
817293b8-685f-43ca-be27-b7c83a1b44e6	email	claim.name
817293b8-685f-43ca-be27-b7c83a1b44e6	String	jsonType.label
bdd982ba-8f97-4be6-8849-724cfffb1a98	true	userinfo.token.claim
bdd982ba-8f97-4be6-8849-724cfffb1a98	emailVerified	user.attribute
bdd982ba-8f97-4be6-8849-724cfffb1a98	true	id.token.claim
bdd982ba-8f97-4be6-8849-724cfffb1a98	true	access.token.claim
bdd982ba-8f97-4be6-8849-724cfffb1a98	email_verified	claim.name
bdd982ba-8f97-4be6-8849-724cfffb1a98	boolean	jsonType.label
2a88efdb-b5f9-4389-99fb-c56845bc1464	formatted	user.attribute.formatted
2a88efdb-b5f9-4389-99fb-c56845bc1464	country	user.attribute.country
2a88efdb-b5f9-4389-99fb-c56845bc1464	postal_code	user.attribute.postal_code
2a88efdb-b5f9-4389-99fb-c56845bc1464	true	userinfo.token.claim
2a88efdb-b5f9-4389-99fb-c56845bc1464	street	user.attribute.street
2a88efdb-b5f9-4389-99fb-c56845bc1464	true	id.token.claim
2a88efdb-b5f9-4389-99fb-c56845bc1464	region	user.attribute.region
2a88efdb-b5f9-4389-99fb-c56845bc1464	true	access.token.claim
2a88efdb-b5f9-4389-99fb-c56845bc1464	locality	user.attribute.locality
93cb0d3b-386f-459a-ae26-96031cbdb1cb	true	userinfo.token.claim
93cb0d3b-386f-459a-ae26-96031cbdb1cb	phoneNumber	user.attribute
93cb0d3b-386f-459a-ae26-96031cbdb1cb	true	id.token.claim
93cb0d3b-386f-459a-ae26-96031cbdb1cb	true	access.token.claim
93cb0d3b-386f-459a-ae26-96031cbdb1cb	phone_number	claim.name
93cb0d3b-386f-459a-ae26-96031cbdb1cb	String	jsonType.label
d1ec0239-a954-4793-8329-32f5abc0c76d	true	userinfo.token.claim
d1ec0239-a954-4793-8329-32f5abc0c76d	phoneNumberVerified	user.attribute
d1ec0239-a954-4793-8329-32f5abc0c76d	true	id.token.claim
d1ec0239-a954-4793-8329-32f5abc0c76d	true	access.token.claim
d1ec0239-a954-4793-8329-32f5abc0c76d	phone_number_verified	claim.name
d1ec0239-a954-4793-8329-32f5abc0c76d	boolean	jsonType.label
46ad3242-3851-44e0-a686-a1d9abdac978	true	multivalued
46ad3242-3851-44e0-a686-a1d9abdac978	foo	user.attribute
46ad3242-3851-44e0-a686-a1d9abdac978	true	access.token.claim
46ad3242-3851-44e0-a686-a1d9abdac978	resource_access.${client_id}.roles	claim.name
46ad3242-3851-44e0-a686-a1d9abdac978	String	jsonType.label
aedf73fc-bf29-419c-a7c8-4af97d729d50	true	multivalued
aedf73fc-bf29-419c-a7c8-4af97d729d50	foo	user.attribute
aedf73fc-bf29-419c-a7c8-4af97d729d50	true	access.token.claim
aedf73fc-bf29-419c-a7c8-4af97d729d50	realm_access.roles	claim.name
aedf73fc-bf29-419c-a7c8-4af97d729d50	String	jsonType.label
1c565cc7-caa2-47ab-a905-996ec697f65f	true	userinfo.token.claim
1c565cc7-caa2-47ab-a905-996ec697f65f	username	user.attribute
1c565cc7-caa2-47ab-a905-996ec697f65f	true	id.token.claim
1c565cc7-caa2-47ab-a905-996ec697f65f	true	access.token.claim
1c565cc7-caa2-47ab-a905-996ec697f65f	upn	claim.name
1c565cc7-caa2-47ab-a905-996ec697f65f	String	jsonType.label
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	true	multivalued
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	foo	user.attribute
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	true	id.token.claim
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	true	access.token.claim
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	groups	claim.name
819e0bbe-d63a-4bfa-a21e-8f3c25fc7184	String	jsonType.label
58fb8e38-d752-48f8-8097-a717e4c094d1	true	id.token.claim
58fb8e38-d752-48f8-8097-a717e4c094d1	true	access.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
63acd062-f967-4069-bfe4-7ed0f15dce58	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	f41978f0-9155-4838-b235-d647ccb20155	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	19b59077-e813-4e32-a8c0-6883b9cf780b	6d055054-ebfa-48bd-bfbe-9acaaf548771	c9146da9-a766-45cf-ad10-0f73b0cf0d5b	eec7c136-4dbe-43a6-862a-8daabc08696c	030532a3-b592-4471-8fc3-a41cb33ddb21	2592000	f	900	t	f	2a2d7c6f-26ca-4164-b5b4-d9975c95b4b2	0	f	0	0	b5e1dda1-653a-4aa6-a097-cf9477f787c3
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	63acd062-f967-4069-bfe4-7ed0f15dce58	
_browser_header.xContentTypeOptions	63acd062-f967-4069-bfe4-7ed0f15dce58	nosniff
_browser_header.referrerPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	no-referrer
_browser_header.xRobotsTag	63acd062-f967-4069-bfe4-7ed0f15dce58	none
_browser_header.xFrameOptions	63acd062-f967-4069-bfe4-7ed0f15dce58	SAMEORIGIN
_browser_header.contentSecurityPolicy	63acd062-f967-4069-bfe4-7ed0f15dce58	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	63acd062-f967-4069-bfe4-7ed0f15dce58	1; mode=block
_browser_header.strictTransportSecurity	63acd062-f967-4069-bfe4-7ed0f15dce58	max-age=31536000; includeSubDomains
bruteForceProtected	63acd062-f967-4069-bfe4-7ed0f15dce58	false
permanentLockout	63acd062-f967-4069-bfe4-7ed0f15dce58	false
maxFailureWaitSeconds	63acd062-f967-4069-bfe4-7ed0f15dce58	900
minimumQuickLoginWaitSeconds	63acd062-f967-4069-bfe4-7ed0f15dce58	60
waitIncrementSeconds	63acd062-f967-4069-bfe4-7ed0f15dce58	60
quickLoginCheckMilliSeconds	63acd062-f967-4069-bfe4-7ed0f15dce58	1000
maxDeltaTimeSeconds	63acd062-f967-4069-bfe4-7ed0f15dce58	43200
failureFactor	63acd062-f967-4069-bfe4-7ed0f15dce58	30
realmReusableOtpCode	63acd062-f967-4069-bfe4-7ed0f15dce58	false
displayName	63acd062-f967-4069-bfe4-7ed0f15dce58	Keycloak
displayNameHtml	63acd062-f967-4069-bfe4-7ed0f15dce58	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	63acd062-f967-4069-bfe4-7ed0f15dce58	RS256
offlineSessionMaxLifespanEnabled	63acd062-f967-4069-bfe4-7ed0f15dce58	false
offlineSessionMaxLifespan	63acd062-f967-4069-bfe4-7ed0f15dce58	5184000
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
63acd062-f967-4069-bfe4-7ed0f15dce58	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	63acd062-f967-4069-bfe4-7ed0f15dce58
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
0a99fac4-fbe8-4608-aa13-2244b00e4e61	/realms/master/account/*
cc1f3902-ede2-4cd8-a0e6-74997f498627	/realms/master/account/*
37e2224a-3146-4267-a017-7c7712bc4f6c	/admin/master/console/*
50d72b62-c21d-41b3-b3f6-fa35f7178cef	https://oauth.pstmn.io/v1/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
49cb74f6-8d82-4fe7-be95-558dc649fac1	VERIFY_EMAIL	Verify Email	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	VERIFY_EMAIL	50
01e4d2fe-4203-4b17-8f3a-d80aec385f63	UPDATE_PROFILE	Update Profile	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	UPDATE_PROFILE	40
11b71865-6c35-4bd1-a6c5-6cdd14ad0889	CONFIGURE_TOTP	Configure OTP	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	CONFIGURE_TOTP	10
73726597-553c-4eeb-9eed-16faa7268213	UPDATE_PASSWORD	Update Password	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	UPDATE_PASSWORD	30
d25d7983-d396-4a35-b23c-2dde0c49ff49	TERMS_AND_CONDITIONS	Terms and Conditions	63acd062-f967-4069-bfe4-7ed0f15dce58	f	f	TERMS_AND_CONDITIONS	20
8ddc1437-eb90-432e-8f8b-6823d9ea2057	delete_account	Delete Account	63acd062-f967-4069-bfe4-7ed0f15dce58	f	f	delete_account	60
f2d95239-bb23-47e1-8660-3fd123a46744	update_user_locale	Update User Locale	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	update_user_locale	1000
9674dfbf-574f-4890-8346-fbde8eb86e88	webauthn-register	Webauthn Register	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	webauthn-register	70
525af069-38e8-4093-a892-ba0c6145728c	webauthn-register-passwordless	Webauthn Register Passwordless	63acd062-f967-4069-bfe4-7ed0f15dce58	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
cc1f3902-ede2-4cd8-a0e6-74997f498627	a4d3e63e-933b-4a51-983c-6d93fc6765f1
cc1f3902-ede2-4cd8-a0e6-74997f498627	e831e03c-0f7a-4ea1-ba46-490412dae067
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
84059de0-00e4-43ab-82f5-5b7b217cf8dd	\N	21a65883-f3a0-46a0-85eb-a5b9f320c5ea	f	t	\N	\N	\N	63acd062-f967-4069-bfe4-7ed0f15dce58	admin	1689880841517	\N	0
bb86ca2a-fe35-4594-9d5b-65d6a72119fa	\N	fd6d4308-fab8-4601-9c42-4d4603847529	f	t	\N			63acd062-f967-4069-bfe4-7ed0f15dce58	fred	1689970192317	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
bb86ca2a-fe35-4594-9d5b-65d6a72119fa	UPDATE_PASSWORD
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
b5e1dda1-653a-4aa6-a097-cf9477f787c3	84059de0-00e4-43ab-82f5-5b7b217cf8dd
7a16a161-e422-44c9-a00e-be5f8d98a4a0	84059de0-00e4-43ab-82f5-5b7b217cf8dd
b5e1dda1-653a-4aa6-a097-cf9477f787c3	bb86ca2a-fe35-4594-9d5b-65d6a72119fa
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
37e2224a-3146-4267-a017-7c7712bc4f6c	+
50d72b62-c21d-41b3-b3f6-fa35f7178cef	https://oauth.pstmn.io
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

