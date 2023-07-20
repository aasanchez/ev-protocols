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
        // {
        //   type: 'category',
        //   label: 'Versions',
        //   link: {
        //     type: 'doc',
        //     id: 'guides/markdown-features/introduction',
        //   },
        //   items: [
        //     'guides/markdown-features/react',
        //     'guides/markdown-features/tabs',
        //     'guides/markdown-features/code-blocks',
        //     'guides/markdown-features/admonitions',
        //     'guides/markdown-features/toc',
        //     'guides/markdown-features/assets',
        //     'guides/markdown-features/links',
        //     'guides/markdown-features/plugins',
        //     'guides/markdown-features/math-equations',
        //     'guides/markdown-features/diagrams',
        //     'guides/markdown-features/head-metadata',
        //   ],
        // },
        'credentials',
        'locations',
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
