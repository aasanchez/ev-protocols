/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  docs: [
    'introduction/introduction',
    {
      type: 'category',
      label: '📚 Terminology and Definitions',
      link: {
        type: 'generated-index',
        slug: 'terminology-and-definitions'
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
        'terminology-and-definitions/data-retention'
      ]
    },
    'supported-topologies/supported-topologies',
    {
      type: 'category',
      label: '✏️ Transport and format',
      link: {
        type: 'generated-index',
        slug: 'transport-and-format'
      },
      collapsed: true,
      items: [
        'transport-and-format/json-http-implementation-guide',
        'transport-and-format/unique-message-ids',
        'transport-and-format/interface-endpoints',
        'transport-and-format/offline-behaviour'
      ]
    },
    'status-codes/status-codes',
    {
      type: 'category',
      label: '📦 Modules',
      link: {
        type: 'generated-index',
        slug: 'modules'
      },
      collapsed: true,
      items: [
        'versions',
        'credentials',
        'locations',
        'sessions',
        'cdrs',
        'tariffs',
        'tokens',
        'commands',
        'charging_profiles',
        'hub_client_info'
      ]
    },
    'types/types'

  ]
}

module.exports = sidebars
