import { WebPlugin } from '@capacitor/core';
import { FirebaseDynamicLinkPlugin } from './definitions';

export class FirebaseDynamicLinkWeb extends WebPlugin implements FirebaseDynamicLinkPlugin {
  constructor() {
    super({
      name: 'FirebaseDynamicLink',
      platforms: ['web'],
    });
  }
}

const FirebaseDynamicLink = new FirebaseDynamicLinkWeb();

export { FirebaseDynamicLink };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(FirebaseDynamicLink);
