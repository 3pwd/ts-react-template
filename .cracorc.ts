import { CracoConfig } from '@craco/types'
import { resolve } from 'path'

const config: CracoConfig = {
  webpack: {
    alias: {
      '#': resolve(__dirname, 'src', 'components')
    }
  }
}

export default config