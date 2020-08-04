import { PluginListenerHandle } from "@capacitor/core";

declare module '@capacitor/core' {
  interface PluginRegistry {
    FirebaseDynamicLink: FirebaseDynamicLinkPlugin;
  }
}

export interface FirebaseDynamicLinkPlugin {
  addListener(eventName: 'deepLinkOpen', listenerFunc: (data: DeepLinkOpen) => void): PluginListenerHandle;
}

export interface DeepLinkOpen {
  url: string
}
