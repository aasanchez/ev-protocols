// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github')
const darkCodeTheme = require('prism-react-renderer/themes/dracula')
const simplePlantUML = require("@akebifiky/remark-simple-plantuml");

async function createConfig () {
  const mdxMermaid = await import('mdx-mermaid')

  /** @type {import('@docusaurus/types').Config} */
  return {
    title: 'OCPI',
    tagline: 'A scalable, automated EV roaming setup between CPOs and e-MSPs',
    url: 'https://ocpi.dev',
    baseUrl: '/',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    favicon: 'img/favicon.ico',
    organizationName: 'aasanchez', // Usually your GitHub org/user name.
    projectName: 'ocpi.dev', // Usually your repo name.
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
            remarkPlugins: [simplePlantUML, mdxMermaid.default],
            sidebarPath: require.resolve('./sidebars.js'),
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
        title: 'OCPI',
        logo: {
          alt: 'OCPI logo',
          src: 'img/ocpi.svg'
        },
        items: [
          {
            type: 'doc',
            docId: 'intro',
            position: 'left',
            label: 'Docs'
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
                label: 'Docs',
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
              }
            ]
          },
          {
            title: 'More',
            items: [
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
}
module.exports = createConfig
