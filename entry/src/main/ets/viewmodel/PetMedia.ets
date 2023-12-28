import { usePut } from '../common/utils/HttpUtil'
import WebConstants from '../common/constants/WebConstants'


export function getAMediaAndRes(fullness: number, cleanliness: number, mood: number) {
  if (fullness <= 20 && cleanliness <= 20 && mood <= 20) {
    return { url: $r('app.media.hungry_and_begging'), res: '我又饿又难过，还生病了呜呜呜...' }
  } else if (fullness <= 20 && cleanliness <= 20) {
    return { url: $r('app.media.sad_and_cry'), res: '我好饿...好像还生病了...' }
  } else if (fullness <= 20 && mood <= 20) {
    return { url: $r('app.media.sad_and_cry'), res: '我好饿...好伤心...' }
  } else if (mood <= 20 && cleanliness <= 20) {
    return { url: $r('app.media.sad_and_cry'), res: '我好难过...好像还生病了...' }
  } else if (fullness < 20) {
    return { url: $r('app.media.eating_mud'), res: '好饿哟...已经在吃土了...' }
  } else if (cleanliness < 20) {
    return { url: $r('app.media.hungry_and_begging'), res: '好饿哟...已经在吃土了...' }
  } else if (mood < 20) {
    return { url: $r('app.media.angry_and_sad'), res: '主人你不要我了么！' }
  } else if (fullness <= 60 || cleanliness <= 60 || mood <= 60) {
    let choice = Math.floor(Math.random() * unhappyState.length);
    return unhappyState[choice]
  } else if (fullness <= 80 || cleanliness <= 80 || mood <= 80) {
    let choice = Math.floor(Math.random() * normalState.length);
    return normalState[choice]
  } else {
    let choice = Math.floor(Math.random() * happyState.length);
    return happyState[choice]
  }

}

const unhappyState = [{ url: $r('app.media.looking_stupid'), res: '我是谁？我在哪？我都有点神志不清了捏' }, {
  url: $r('app.media.want_food'),
  res: '妈妈，饿饿，饭饭'
}, { url: $r('app.media.want_to_play'), res: '嗨嗨！快来陪我Van呀！' }, {
  url: $r('app.media.nonono_state'),
  res: '不要不要不要！'
}, { url: $r('app.media.mad'), res: '人家状态不好啦！' }, {
  url: $r('app.media.proud_and_eager'),
  res: '哼！主人根本就不爱我！是不是嘛！'
}];
const normalState = [{ url: $r('app.media.little_dance'), res: '呼啦呼啦!呼啦呼啦~' }, {
  url: $r('app.media.drawing_love'),
  res: '啦啦啦，最爱我的主人啦！'
}, { url: $r('app.media.norm_rolling'), res: '滚呐滚~想快快滚到主人身边捏...' }, {
  url: $r('app.media.shy_and_happy'),
  res: '嘿嘿嘿，主人终于来找我咯!'
}, { url: $r('app.media.eating'), res: 'emm喵喵喵，好吃的嘞' }]
const happyState = [{ url: $r('app.media.giving_out_love'), res: '嘿嘿嘿，也要给主人小心心！' }, {
  url: $r('app.media.happy_rolling'),
  res: '诶嘿嘿，滚呐滚呐滚！'
}, { url: $r('app.media.shaking_head_happy'), res: '好耶好耶好耶！' }, {
  url: $r("app.media.spreading_love_around"),
  res: '嘿嘿嘿，也要给主人小心心！'
}, { url: $r('app.media.shaking_happy'), res: '嘿嘿嘿，主人，我的主人...' }]

export function getProperties(type: string) {
  switch (type) {
    case 'food':
      return food;
    case 'medicine':
      return medicine;
    case 'toys':
      return toy;
  }
}

const food = [{ id: 0, url: $r("app.media.icons8_hamburger_100"), text: '风味汉堡', effect: [30, -5, 0] }, {
  id: 1,
  url: $r("app.media.icons8_racked_lamb_100"),
  text: '烤羊排',
  effect: [50, -10, 0]
}, { id: 2, url: $r("app.media.icons8_cocktail_100"), text: '鸡尾酒', effect: [20, 0, 10] }, {
  id: 3,
  url: $r("app.media.icons8_bread_100"),
  text: '麦香面包',
  effect: [20, 0, 0]
}, { id: 4, url: $r("app.media.icons8_pizza_100"), text: '披萨', effect: [35, -10, 0] }, {
  id: 5,
  url: $r("app.media.icons8_coke_64"),
  text: '可乐',
  effect: [10, -3, 0]
}, { id: 6, url: $r("app.media.icons8_ice_cream_100"), text: '冰淇淋', effect: [15, 0, 5] }, {
  id: 7,
  url: $r("app.media.icons8_milk_100"),
  text: '牛奶',
  effect: [15, 0, 0]
}, { id: 8, url: $r("app.media.icons8_coffee_100"), text: '咖啡', effect: [10, 0, 20] }, {
  id: 15,
  url: $r("app.media.icons8_noodles_64"),
  text: '面条',
  effect: [25, 0, 0]
}]
const medicine = [{ id: 9, url: $r("app.media.icons8_psychotherapy_100"), text: '心理治疗', effect: [0, 0, 60] }, {
  id: 10,
  url: $r("app.media.icons8_pills_100"),
  text: '药丸',
  effect: [0, 10, 0]
}, { id: 11, url: $r("app.media.icons8_prescription_100"), text: '处方药', effect: [0, 30, 0] }, {
  id: 12,
  url: $r("app.media.icons8_take_a_shower_64"),
  text: '洗澡',
  effect: [0, 15, 0]
}, { id: 13, url: $r("app.media.icons8_do_cleaning_100"), text: '打扫卫生', effect: [0, 10, 0] }, {
  id: 14,
  url: $r("app.media.icons8_wash_hands_100"),
  text: '洗手',
  effect: [0, 5, 0]
}, { id: 22, url: $r("app.media.icons8_stick_100"), text: '专家会诊', effect: [0, 60, 0] }]
const toy = [{ id: 16, url: $r("app.media.icons8_water_gun_100"), text: '打水仗', effect: [0, 0, 10] }, {
  id: 17,
  url: $r("app.media.icons8_story_book"),
  text: '一起读故事',
  effect: [0, 0, 20]
}, { id: 20, url: $r("app.media.icons8_brain_game_100"), text: '益智玩具', effect: [0, 15, 0] }, {
  id: 21,
  url: $r("app.media.icons8_spirit"),
  text: '小精灵',
  effect: [0, 0, 30]
}, { id: 23, url: $r("app.media.icons_tire_swing_100"), text: '荡秋千', effect: [0, 0, 15] }, {
  id: 24,
  url: $r("app.media.icons8_rubber_duck_100"),
  text: '游泳',
  effect: [0, 0, 20]
}]

export interface reqObject {
  propId: number,
  updateAmount: number,
  type: string,
  name: string,
}

export function getRandomProperty(userid: string) {
  let property = null
  switch (Number(Math.floor(Math.random() * 3))) {
    case 0:
      property = food[Math.floor(Math.random() * food.length)]
      putPropertyUpdate('food', property, userid, 1)
      return property
    case 1:
      property = medicine[Math.floor(Math.random() * medicine.length)]
      putPropertyUpdate('medicine', property, userid, 1)
      return property
    case 2:
      property = toy[Math.floor(Math.random() * toy.length)]
      putPropertyUpdate('toy', property, userid, 1)
      return property
  }
}

export interface property {
  id: number,
  url: Resource,
  text: string,
  effect: number[]
}

export function putPropertyUpdate(type: string, property:property, userid: string, amount: number) {
  usePut<undefined, reqObject[]>(WebConstants.TEST_ENVIRONMENT + `/user/${userid}/prop`, [{
    propId: property.id,
    updateAmount: amount,
    type: type,
    name: property.text
  }])
}
