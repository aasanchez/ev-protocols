/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  docs: [
    'introduction',
    {
      type: 'category',
      label: 'Terminology and Definitions',
      link: {
        type: 'generated-index',
      },
      collapsed: true,
      items: [
        'terminology-and-definitions/requirement-keywords',
        'terminology-and-definitions/abbreviations',
        'terminology-and-definitions/ev-charging-market-roles',
        'terminology-and-definitions/terminology',
        'terminology-and-definitions/provider-and-operator-abbreviation',
        'terminology-and-definitions/charging-topology',
        'terminology-and-definitions/variable-names',
        'terminology-and-definitions/cardinality',
        'terminology-and-definitions/data-retention',
      ],
    },
    'supported-topologies',
    {
      type: 'category',
      label: 'Transport and format',
      link: {
        type: 'generated-index',
      },
      collapsed: true,
      items: [
        'transport_and_format',
        // 'transport_and_format/json-http-implementation-guide',
        // 'transport_and_format/unique-message-ids',
        // 'transport_and_format/interface-endpoints',
        // 'transport_and_format/offline-behaviour',
      ],
    },
    'status_codes',
    {
      type: 'category',
      label: 'Modules',
      link: {
        type: 'generated-index',
      },
      collapsed: true,
      items: [
        'mod_versions',
        'mod_credentials',
        'mod_locations',
        'mod_sessions',
        'mod_cdrs',
        'mod_tariffs',
        'mod_tokens',
        'mod_commands',
        'mod_charging_profiles',
        'mod_hub_client_info',
      ],
    },
    'types'


  ]
};

module.exports = sidebars
