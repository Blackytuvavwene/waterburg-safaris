export function serializeNonPOJOs<T>(obj: T): T {
    return JSON.parse(JSON.stringify(obj))
  }