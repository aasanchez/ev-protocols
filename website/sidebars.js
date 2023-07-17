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
      collapsed: false,
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
    'topology',
    'transport_and_format',
    'status_codes',
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
    'types'


  ]
};

module.exports = sidebars
