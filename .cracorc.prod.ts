import { CracoConfig } from '@craco/types'
import { resolve } from 'path'

const config: CracoConfig = {
  eslint: {
    enable: false,
  },
  webpack: {
    alias: {
      '#': resolve(__dirname, 'src', 'components'),
    },
    configure: {
      watchOptions: {
        ignored: /test/,
      },
    },
  },
}

export default config
