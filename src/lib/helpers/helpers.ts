import * as devalue from "devalue";


export function serializeNonPOJOs<T>(obj: T): T {
    return devalue.parse(devalue.uneval(obj))
  }