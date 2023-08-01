/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  docs: [
    'introduction',
    {
      type: 'category',
      label: 'Terminology and Definitions',
      link: {
        type: 'generated-index',
        slug: 'terminology-and-definitions',
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
        slug: 'transport-and-format',
      },
      collapsed: true,
      items: [
        'transport-and-format/json-http-implementation-guide',
        'transport-and-format/unique-message-ids',
        'transport-and-format/interface-endpoints',
        'transport-and-format/offline-behaviour'
      ],
    },
    'status_codes',
    {
      type: 'category',
      label: 'Modules',
      link: {
        type: 'generated-index',
        slug: 'modules'
      },
      collapsed: true,
      items: [
        {
          type: 'category',
          label: 'ℹ️ Versions',
          // slug: 'modules/version',
          link: {
            type: 'doc',
            id: 'versions/intro',
            
          },
          items: [
            'versions/interfaces-and-endpoints',
            'versions/object-description',
            'versions/data-types',
            'versions/custom-module'
          ],
        },
        {
          type: 'category',
          label: '🗝️ Credentials',
          link: {
            type: 'doc',
            id: 'credentials/intro',
            
          },
          items: [
            'credentials/use-cases',
            'credentials/interfaces-and-endpoints',
            'credentials/object-description',
            'credentials/data-types'
          ],
        },
        {
          type: 'category',
          label: '📍 Locations',
          link: {
            type: 'doc',
            id: 'locations/intro',
            
          },
          items: [
            'locations/flow-and-lifecycle',
            'locations/interfaces-and-endpoints',
            'locations/object-description',
            'locations/data-types'
          ],
        },
        {
          type: 'category',
          label: '📖 Sessions',
          link: {
            type: 'doc',
            id: 'locations/intro',
            
          },
          items: [
            'sessions/flow-and-lifecycle',
            'sessions/interfaces-and-endpoints',
            'sessions/object-description',
            'sessions/data-types'
          ],
        },
        'sessions',
        'cdrs',
        'tariffs',
        'tokens',
        'commands',
        'charging_profiles',
        'hub_client_info',
      ],
    },
    'types'


  ]
};

module.exports = sidebars
