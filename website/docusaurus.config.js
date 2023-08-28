// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github')
const darkCodeTheme = require('prism-react-renderer/themes/dracula')

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'EV-Protocols',
  tagline: 'EV Protocols References',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://ev-protocols.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'aasanchez', // Usually your GitHub org/user name.
  projectName: 'ev-protocols', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en']
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.com/aasanchez/ev-protocols/tree/',
          lastVersion: 'current',
          versions: {
            current: {
              label: '2.2.1',
              path: ''
            }
          }
        },
        gtag: {
          trackingID: 'G-T3L8Q7QCG3',
          anonymizeIP: true
        },
        blog: {
          showReadingTime: true,
          editUrl: 'https://github.com/aasanchez/ev-protocols/tree/'
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css')
        },
        sitemap: {
          changefreq: 'weekly',
          priority: 0.5,
          ignorePatterns: ['/tags/**'],
          filename: 'sitemap.xml'
        }
      })
    ]
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      algolia: {
        appId: 'JLVRZRP9N9',
        apiKey: 'eab176d227cbdd45996af10f5641926e',
        indexName: 'ocpi',
        contextualSearch: true,
        externalUrlRegex: 'localhost:3000|ev-protocols',
        searchParameters: {},
        searchPagePath: 'search'
      },
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'EV Protocols',
        logo: {
          alt: 'EV-protocols',
          src: 'img/logo.png'
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'ocpi',
            position: 'left',
            label: 'OCPI'
          },
          {
            to: '/blog',
            label: 'Blog',
            position: 'left'
          },
          {
            type: 'docsVersionDropdown',
            position: 'right',
            dropdownActiveClassDisabled: true
          },
          {
            href: 'https://github.com/aasanchez/ev-protocols',
            label: 'GitHub',
            position: 'right'
          }
        ]
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'OCPI',
            items: [
              {
                label: 'Docs',
                to: '/docs/ocpi'
              },
              {
                label: 'Stack Overflow',
                href: 'https://stackoverflow.com/questions/tagged/ocpi'
              },
              {
                label: 'Reddit',
                href: 'https://www.reddit.com/r/ocpi/'
              }
            ]
          },
          {
            title: 'OCPP',
            items: [
              {
                label: 'Docs',
                to: '/docs/ocpi/'
              },
              {
                label: 'Stack Overflow',
                href: 'https://stackoverflow.com/questions/tagged/ocpp'
              },
              {
                label: 'Reddit',
                href: 'https://www.reddit.com/r/ocpp/'
              }
            ]
          }
        ],
        copyright: `Copyright © ${new Date().getFullYear()} EV-protocols`
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme
      }
    })
}

module.exports = config
