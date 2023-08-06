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
          label: '🗺️ Locations',
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
        {
          type: 'category',
          label: '📊 CDRs',
          link: {
            type: 'doc',
            id: 'modules/cdrs/intro'
          },
          collapsed: true,
          items: [
            'modules/cdrs/flow-and-lifecycle',
            'modules/cdrs/interfaces-and-endpoints',
            'modules/cdrs/object-description',
            'modules/cdrs/data-types'
          ]
        },
        {
          type: 'category',
          label: '💰 Tariffs',
          link: {
            type: 'doc',
            id: 'modules/tariffs/intro'
          },
          collapsed: true,
          items: [
            'modules/tariffs/flow-and-lifecycle',
            'modules/tariffs/interfaces-and-endpoints',
            'modules/tariffs/object-description',
            'modules/tariffs/data-types'
          ]
        },
        {
          type: 'category',
          label: '👤 Tokens',
          link: {
            type: 'doc',
            id: 'modules/tokens/intro'
          },
          collapsed: true,
          items: [
            'modules/tokens/flow-and-lifecycle',
            'modules/tokens/interfaces-and-endpoints',
            'modules/tokens/object-description',
            'modules/tokens/data-types'
          ]
        },
        {
          type: 'category',
          label: '⚙️ Commands',
          link: {
            type: 'doc',
            id: 'modules/commands/intro'
          },
          collapsed: true,
          items: [
            'modules/commands/flow',
            'modules/commands/interfaces-and-endpoints',
            'modules/commands/object-description',
            'modules/commands/data-types'
          ]
        },
        {
          type: 'category',
          label: '🔌 ChargingProfiles',
          link: {
            type: 'doc',
            id: 'modules/charging-profiles/intro'
          },
          collapsed: true,
          items: [
            'modules/charging-profiles/smart-charging-topologies',
            'modules/charging-profiles/use-cases',
            'modules/charging-profiles/flow',
            'modules/charging-profiles/interfaces-and-endpoints',
            'modules/charging-profiles/object-description',
            'modules/charging-profiles/data-types'
          ]
        },
        {
          type: 'category',
          label: '⛓️ HubClientInfo',
          link: {
            type: 'doc',
            id: 'modules/hubclientinfo/intro'
          },
          collapsed: true,
          items: [
            'modules/hubclientinfo/scenarios',
            'modules/hubclientinfo/flow-and-lifecycle',
            'modules/hubclientinfo/interfaces',
            'modules/hubclientinfo/object-description',
            'modules/hubclientinfo/data-types'
          ]
        },
      ]
    },
    'types/intro'

  ]
}

module.exports = sidebars
