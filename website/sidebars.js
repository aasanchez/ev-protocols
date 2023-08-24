/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  ocpi: [
    'ocpi/introduction/introduction',
    // {
    //   type: 'category',
    //   label: '📚 Terminology and Definitions',
    //   link: {
    //     type: 'generated-index',
    //     slug: 'ocpi/terminology-and-definitions'
    //   },
    //   collapsed: true,
    //   items: [
    //     'ocpi/terminology-and-definitions/requirement-keywords',
    //     'ocpi/terminology-and-definitions/abbreviations',
    //     'ocpi/terminology-and-definitions/ev-charging-market-roles',
    //     'ocpi/terminology-and-definitions/terminology',
    //     'ocpi/terminology-and-definitions/provider-and-operator-abbreviation',
    //     'ocpi/terminology-and-definitions/charging-topology',
    //     'ocpi/terminology-and-definitions/variable-names',
    //     'ocpi/terminology-and-definitions/cardinality',
    //     'ocpi/terminology-and-definitions/data-retention'
    //   ]
    // },
    // 'ocpi/supported-topologies/supported-topologies',
    // {
    //   type: 'category',
    //   label: '✏️ Transport and format',
    //   link: {
    //     type: 'generated-index',
    //     slug: 'ocpi/transport-and-format'
    //   },
    //   collapsed: true,
    //   items: [
    //     'ocpi/transport-and-format/json-http-implementation-guide',
    //     'ocpi/transport-and-format/unique-message-ids',
    //     'ocpi/transport-and-format/interface-endpoints',
    //     'ocpi/transport-and-format/offline-behaviour'
    //   ]
    // },
    // 'ocpi/status-codes/status-codes',
    // {
    //   type: 'category',
    //   label: '📦 Modules',
    //   link: {
    //     type: 'generated-index',
    //     slug: 'ocpi/modules'
    //   },
    //   collapsed: true,
    //   items: [
    //     {
    //       type: 'category',
    //       label: '🇻 Versions',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/versions/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/versions/information-endpoint',
    //         'ocpi/modules/versions/details-endpoint'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '🔐 Credentials',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/credentials/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/credentials/use-cases',
    //         'ocpi/modules/credentials/interfaces-and-endpoints',
    //         'ocpi/modules/credentials/object-description',
    //         'ocpi/modules/credentials/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '🗺️ Locations',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/locations/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/locations/flow-and-lifecycle',
    //         'ocpi/modules/locations/interfaces-and-endpoints',
    //         'ocpi/modules/locations/object-description',
    //         'ocpi/modules/locations/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '🍪 Sessions',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/sessions/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/sessions/flow-and-lifecycle',
    //         'ocpi/modules/sessions/interfaces-and-endpoints',
    //         'ocpi/modules/sessions/object-description',
    //         'ocpi/modules/sessions/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '📊 CDRs',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/cdrs/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/cdrs/flow-and-lifecycle',
    //         'ocpi/modules/cdrs/interfaces-and-endpoints',
    //         'ocpi/modules/cdrs/object-description',
    //         'ocpi/modules/cdrs/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '💰 Tariffs',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/tariffs/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/tariffs/flow-and-lifecycle',
    //         'ocpi/modules/tariffs/interfaces-and-endpoints',
    //         'ocpi/modules/tariffs/object-description',
    //         'ocpi/modules/tariffs/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '👤 Tokens',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/tokens/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/tokens/flow-and-lifecycle',
    //         'ocpi/modules/tokens/interfaces-and-endpoints',
    //         'ocpi/modules/tokens/object-description',
    //         'ocpi/modules/tokens/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '⚙️ Commands',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/commands/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/commands/flow',
    //         'ocpi/modules/commands/interfaces-and-endpoints',
    //         'ocpi/modules/commands/object-description',
    //         'ocpi/modules/commands/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '🔌 ChargingProfiles',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/charging-profiles/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/charging-profiles/smart-charging-topologies',
    //         'ocpi/modules/charging-profiles/use-cases',
    //         'ocpi/modules/charging-profiles/flow',
    //         'ocpi/modules/charging-profiles/interfaces-and-endpoints',
    //         'ocpi/modules/charging-profiles/object-description',
    //         'ocpi/modules/charging-profiles/data-types'
    //       ]
    //     },
    //     {
    //       type: 'category',
    //       label: '⛓️ HubClientInfo',
    //       link: {
    //         type: 'doc',
    //         id: 'ocpi/modules/hubclientinfo/intro'
    //       },
    //       collapsed: true,
    //       items: [
    //         'ocpi/modules/hubclientinfo/scenarios',
    //         'ocpi/modules/hubclientinfo/flow-and-lifecycle',
    //         'ocpi/modules/hubclientinfo/interfaces',
    //         'ocpi/modules/hubclientinfo/object-description',
    //         'ocpi/modules/hubclientinfo/data-types'
    //       ]
    //     },
    //   ]
    // },
    // 'ocpi/types/intro'
  ]
}

module.exports = sidebars
