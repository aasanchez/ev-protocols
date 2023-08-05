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
        {
          type: 'category',
          label: '🇻 Versions',
          link: {
            type: 'doc',
            id: 'modules/versions/intro'
          },
          collapsed: true,
          items: [
            'modules/versions/information-endpoint',
            'modules/versions/details-endpoint'
          ]
        },
        {
          type: 'category',
          label: '🔐 Credentials',
          link: {
            type: 'doc',
            id: 'modules/credentials/intro'
          },
          collapsed: true,
          items: [
            'modules/credentials/use-cases',
            'modules/credentials/interfaces-and-endpoints',
            'modules/credentials/object-description',
            'modules/credentials/data-types'
          ]
        },
        {
          type: 'category',
          label: '📍 Locations',
          link: {
            type: 'doc',
            id: 'modules/locations/intro'
          },
          collapsed: true,
          items: [
            'modules/locations/flow-and-lifecycle',
            'modules/locations/interfaces-and-endpoints',
            'modules/locations/object-description',
            'modules/locations/data-types'
          ]
        },
        {
          type: 'category',
          label: '🍪 Sessions',
          link: {
            type: 'doc',
            id: 'modules/sessions/intro'
          },
          collapsed: true,
          items: [
            'modules/sessions/flow-and-lifecycle',
            'modules/sessions/interfaces-and-endpoints',
            'modules/sessions/object-description',
            'modules/sessions/data-types'
          ]
        },
        'cdrs',
        'tariffs',
        'tokens',
        'commands',
        'charging_profiles',
        'hub_client_info'
      ]
    },
    'types/intro'

  ]
}

module.exports = sidebars
