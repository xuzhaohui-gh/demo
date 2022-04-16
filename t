const getMapItem = Symbol('getMapItem')
const setMapItem = Symbol('setMapItem')
const getKeyPath = Symbol('getKeyPath')

class CodeMap {
  constructor() {
    this.codeMap = {}
  }

  /**
   * 添加元素
   * @param {String} keyPath 参数路径，多层使用点号（.）连接，支持多层级 
   * @param {any} value 属性值
   * @param {String} name 属性描述
   * @param {String} aliasName 属性描述别名
   */
  add(keyPath, value, name, aliasName) {
    let keyPathArr = this[getKeyPath](keyPath)
    this[setMapItem](this.codeMap, keyPathArr, { value, name, aliasName })
  }

  /**
   * 获取某个属性全部元素
   * @param {String} keyPath 参数路径，多层使用点号（.）连接，支持多层级 
   * @returns
   */
  get(keyPath) {
    let keyPathArr = this[getKeyPath](keyPath)
    return this[getMapItem](this.codeMap, keyPathArr)
  }

  /**
   * 获取某个属性全部元素并将其转成数组
   * @param {String} keyPath 参数路径，多层使用点号（.）连接，支持多层级 
   * @returns
   */
  getArray(keyPath) {
    let obj = this.get(keyPath) || {}
    return Object.entries(obj).map(o => {
      let [key, value] = o || []
      return {
        key,
        ...value
      }
    })
  }

  /**
   * 获取某个属性value属性值
   * @param {String} keyPath 参数路径，多层使用点号（.）连接，支持多层级 
   * @returns
   */
  getValue(keyPath) {
    let { value } = this.get(keyPath) || {}
    return value
  }

  /**
   * 获取某个属性name描述
   * @param {String} keyPath 参数路径，多层使用点号（.）连接，支持多层级 
   * @returns
   */
  getName(keyPath) {
    let { name } = this.get(keyPath) || {}
    return name
  }

  /**
   * 获取某个属性aliasName描述别名
   * @param {String} keyPath 参数路径，多层使用点号（.）连接，支持多层级 
   * @returns
   */
  getAliasName(keyPath) {
    let { aliasName } = this.get(keyPath) || {}
    return aliasName
  }

  [getKeyPath](keyPath) {
    if (!keyPath || typeof keyPath !== 'string') {
      return []
    }
    return keyPath.split('.')
  }

  [setMapItem](obj, keyPath, value) {
    if (!keyPath.length) {
      return
    }

    let key = keyPath[0]
    obj[key] = obj.hasOwnProperty(key) ? obj[key] : {}

    // 最后一个路径则直接赋值
    if (keyPath.length === 1) {
      obj[key] = value
    }
    // 非最后一个路径则迭代查找最后一个路径
    if (keyPath.length > 1) {
      keyPath.shift()
      this[setMapItem](obj[key], keyPath, value)
    }
  }

  [getMapItem](obj, keyPath) {
    if (!keyPath.length) {
      return null
    }

    let key = keyPath[0]

    if (obj.hasOwnProperty(key)) {
      let resObj = null
      if (keyPath.length === 1) {
        resObj = obj.hasOwnProperty(key) ? obj[key] : null
      } else {
        keyPath.shift()
        resObj = this[getMapItem](obj[key], keyPath)
      }
      return resObj
    }
  
    return null
  }
}

export default CodeMap
