// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github')
const darkCodeTheme = require('prism-react-renderer/themes/dracula')

/** @type {import('@docusaurus/types').Config} */
const config = {

  title: 'OCPI.dev',
  tagline: 'OCPI Documentation',
  url: 'https://ocpi.dev',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'aasanchez', // Usually your GitHub org/user name.
  projectName: 'ocpi.dev', // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en']
  },
  plugins: [
    'plugin-image-zoom'
  ],
  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.dev/aasanchez/ocpi.dev'
        },
        blog: {
          showReadingTime: true,
          editUrl: 'https://github.dev/aasanchez/ocpi.dev'
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css')
        }
      })
    ]
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      imageZoom: {
        // CSS selector to apply the plugin to, defaults to '.markdown img'
        selector: '.markdown img',
        // Optional medium-zoom options
        // see: https://www.npmjs.com/package/medium-zoom#options
        options: {
          margin: 24,
          background: '#BADA55',
          scrollOffset: 0,
          container: '#zoom-container',
          template: '#zoom-template'
        }
      },
      navbar: {
        title: 'OCPI.dev',
        logo: {
          alt: 'OCPI logo',
          src: 'img/ocpi.svg'
        },
        items: [
          {
            type: 'doc',
            docId: 'intro',
            position: 'left',
            label: 'Tutorial'
          },
          {
            to: '/blog',
            label: 'Blog',
            position: 'left'
          },
          {
            href: 'https://github.com/aasanchez/ocpi.dev',
            label: 'GitHub',
            position: 'right'
          }
        ]
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Tutorial',
                to: '/docs/intro'
              }
            ]
          },
          {
            title: 'Community',
            items: [
              {
                label: 'Stack Overflow',
                href: 'https://stackoverflow.com/questions/tagged/ocpi'
              },
              {
                label: 'Discord',
                href: 'https://discordapp.com/invite/openchargeplatform'
              },
              {
                label: 'Twitter',
                href: 'https://twitter.com/openchargeplatform'
              }
            ]
          },
          {
            title: 'More',
            items: [
              {
                label: 'Blog',
                to: '/blog'
              },
              {
                label: 'GitHub',
                href: 'https://github.com/aasanchez/ocpi.dev'
              }
            ]
          }
        ],
        copyright: `Copyright © ${new Date().getFullYear()} OCPI Development Platform. Built with Docusaurus.<br>This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.`
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme
      }
    })
}

async function createConfig () {
  const mdxMermaid = await import('mdx-mermaid')

  return {
    presets: [
      [
        'classic',
        {
          docs: {
            remarkPlugins: [mdxMermaid.default]
          }
        }
      ]
    ]
  }
}
module.exports = createConfig
module.exports = config
