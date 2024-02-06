import { VideoSpeed } from '../../viewmodel/VideoSpeed';

export default class CommonConstants {

  static readonly FULL_OPACITY: number = 1;

  static readonly SIXTY_OPACITY: number = 0.6;

  static readonly EIGHTY_OPACITY: number = 0.8;

  static readonly FONT_WEIGHT_FIVE: number = 500;

  static readonly WATER_FLOW_LAYOUT_WEIGHT: number = 1;

  static readonly WATER_FLOW_COLUMNS_TEMPLATE: string = '1fr 1fr';

  static readonly INVALID_INDEX: number = -1;

  static readonly FULL_LENGTH: string = '100%';

  static readonly TITLE_WIDTH: string = '80%';

  static readonly LIST_DEFAULT_WIDTH: string = '93.3%';

  static readonly OPACITY_DEFAULT: number = 1;

  static readonly OPACITY_COMPLETED: number = 0.4;

  static readonly BORDER_RADIUS: number = 24;

  static readonly FONT_WEIGHT: number = 500;

  static readonly COLUMN_SPACE: number = 16;

  static readonly TAG_ABILITY: string = 'EntryAbility';

  static readonly TAG_LOGIN_PAGE: string = 'LoginPage';

  static readonly TAG_MAIN_PAGE: string = 'MainPage';

  static readonly TAG_COMMON_UTILS: string = 'CommonUtils';

  static readonly TAG_LIST_ITEM: string = 'ListItem';

  static readonly TAG_MINE_PAGE: string = 'MinePage';

  static readonly LOGIN_TEXT: string = 'login';

  static readonly TOAST_DURATION: number = 3000;

  static readonly HOME_TITLE: string = '首页';

  static readonly FIND_TITLE: string = '发现';

  static readonly MEDIA_TITLE: string = '视频';

  static readonly RANK_TITLE: string = '排行榜';

  static readonly MINE_TITLE: string = '我的';

  static readonly HOME_TAB_INDEX: number = 0;

  static readonly FIND_TAB_INDEX: number = 1;

  static readonly MEDIA_TAB_INDEX: number = 2;

  static readonly RANK_TAB_INDEX: number = 3;

  static readonly MINE_TAB_INDEX: number = 4;

  static readonly SWIPER_CACHE_COUNT: number = 3;

  static readonly MAIN_PAGE_URL: string = 'pages/MainPage';

  static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';

  static readonly SM: string = 'sm';

  static readonly MD: string = 'md';

  static readonly LG: string = 'lg';

  static readonly WIDTH_CONDITION_SM: string = '(320vp<=width<520vp)';

  static readonly WIDTH_CONDITION_MD: string = '(520vp<=width<840vp)';

  static readonly WIDTH_CONDITION_LG: string = '(840vp<=width)';

  static readonly LOGIN_BUTTON_ID: string = 'loginButtonId';

  static readonly TABLET_DEVICE_TYPE: string = 'tablet';

  static readonly TODO_DATA: Array<string> = [
    "早起晨练",
    "准备早餐",
    "阅读名著",
    "学习ArkTS",
    "看剧放松"
  ];

  static readonly TAG_HOME: string = 'HomePage';

  static readonly TAG_CUSTOM: string = 'CustomDialogWidget';

  static readonly FULL_WIDTH: string = '100%';

  static readonly FULL_HEIGHT: string = '100%';

  static readonly DATE_YEAR: string = '年';

  static readonly DATE_MONTH: string = '月';

  static readonly DATE_DAY: string = '日';

  static readonly START_TIME: string = '1900-1-1';

  static readonly SELECT_TIME: string = '1990-1-1';

  static readonly BACK_MARGIN_LEFT: string = '7.2%';

  static readonly AVATAR_MARGIN_TOP: string = '5.5%';

  static readonly PERSONAL_MARGIN_TOP: string = '2.1%';

  static readonly COMMON_DIALOG_WIDTH: string = '93.3%';

  static readonly COMMA: string = '，';

  static readonly BACK_MARGIN_TOP: number = 19;

  static readonly BIGGER: number = 500;

  static readonly DY_OFFSET: number = -20;

  static readonly PLUS_ONE: number = 1;


  static readonly WEIGHT_ONE: number = 1;


  static readonly ONE_LINES: number = 1;


  // thousandth
  static readonly GOODS_LIST_HEIGHT: string = '20%';
  static readonly GOODS_IMAGE_WIDTH: string = '40%';
  static readonly GOODS_FONT_WIDTH: string = '60%';
  static readonly GOODS_LIST_WIDTH: string = '94%';
  static readonly LAYOUT_WIDTH_OR_HEIGHT: string = '100%';

  // font-size
  static readonly GOODS_LIST_PADDING: number = 8;
  static readonly GOODS_EVALUATE_FONT_SIZE: number = 12;
  static readonly NORMAL_FONT_SIZE: number = 16;
  static readonly BIGGER_FONT_SIZE: number = 20;
  static readonly MAX_FONT_SIZE: number = 32;

  // margin
  static readonly REFRESH_ICON_MARGIN_RIGHT: number = 20;
  static readonly MARGIN_RIGHT: number = 32;

  // width or height
  static readonly ICON_WIDTH: number = 40;
  static readonly ICON_HEIGHT: number = 40;

  // list space
  static readonly LIST_ITEM_SPACE: number = 16;

  // navigation title
  static readonly STORE: string = '商城';

  // offset range
  static readonly MAX_OFFSET_Y: number = 100;

  // refresh time
  static readonly REFRESH_TIME: number = 1500;

  // Magnification
  static readonly MAGNIFICATION: number = 2;
  static readonly MAX_DATA_LENGTH: number = 12;

  static readonly FULL_PERCENT: string = '100%';

  static readonly NINETY_PERCENT: string = '90%';

  static readonly FIFTY_PERCENT: string = '50%';

  static readonly PLAY_PAGE: string = 'pages/PlayPage';

  static readonly TYPE_LOCAL: number = 0;

  static readonly TYPE_INTERNET: number = 1;

  static readonly STATUS_START: number = 1;

  static readonly STATUS_PAUSE: number = 2;

  static readonly STATUS_STOP: number = 3;

  static readonly ASPECT_RATIO: number = 1;

  static readonly ONE_HUNDRED: number = 100;

  static readonly A_THOUSAND: number = 1000;

  static readonly SPEED_ARRAY: VideoSpeed[] = [
    new VideoSpeed('0.75X', 0),
    new VideoSpeed('1.0X', 1),
    new VideoSpeed('1.25X', 2),
    new VideoSpeed('1.75X', 3),
    new VideoSpeed('2.0X', 4)
  ];

  static readonly TIME_UNIT: number = 60;

  static readonly INITIAL_TIME_UNIT: string = '00';

  static readonly PADDING_LENGTH: number = 2;

  static readonly PADDING_STR: string = '0';

  static readonly SCREEN_OFF: string = 'usual.event.SCREEN_OFF';

  static readonly OPERATE_STATE: Array<string> = ['prepared', 'playing', 'paused', 'completed'];

  static readonly BANNER_IMG_LIST: Array<Resource> = [
  $r('app.media.ic_scene_1'),
  $r('app.media.ic_food_0'),
  $r('app.media.ic_life_0'),
  $r('app.media.ic_men_0')
  ];


  static readonly SCENE_LIST: Array<Resource> = [
  $r('app.media.ic_scene_1'),
  $r('app.media.ic_scene_2'),
  $r('app.media.ic_scene_0')
  ];


  static readonly MEN_LIST: Array<Resource> = [
  $r('app.media.ic_men_0'),
  $r('app.media.ic_men_2'),
  $r('app.media.ic_men_3')
  ];

  static readonly FOOD_LIST: Array<Resource> = [
  $r('app.media.ic_food_1'),
  $r('app.media.ic_food_0'),
  ];


  static readonly LIFE_LIST: Array<Resource> = [
  $r('app.media.ic_life_1'),
  $r('app.media.ic_life_0'),
  $r('app.media.ic_life_2'),
  $r('app.media.ic_life_3'),
  $r('app.media.ic_life_4'),
  $r('app.media.ic_life_5')
  ];


  static readonly IMG_ARR: Resource[][] = [
  new Array<Resource>().concat(CommonConstants.SCENE_LIST, CommonConstants.LIFE_LIST, CommonConstants.MEN_LIST),
  new Array<Resource>().concat(CommonConstants.MEN_LIST, CommonConstants.LIFE_LIST, CommonConstants.SCENE_LIST),
  new Array<Resource>().concat(CommonConstants.FOOD_LIST, CommonConstants.SCENE_LIST, CommonConstants.SCENE_LIST),
  new Array<Resource>().concat(CommonConstants.LIFE_LIST, CommonConstants.FOOD_LIST, CommonConstants.MEN_LIST)
  ];

  static readonly TITLE_FONT_WEIGHT: number = 500;

  static readonly BANNER_ASPECT_RATIO: number = 1.5;

  static readonly BANNER_ANIMATE_DURATION: number = 300;

  static readonly SHARE_TRANSITION_DELAY: number = 100;

  static readonly STACK_IMG_RATIO: number = 0.7;

  static readonly CACHE_IMG_SIZE: number = 4;

  static readonly CACHE_IMG_LIST: string[] = ['', '', '', ''];

  static readonly PAGE_TITLE: string = '电子相册';

  static readonly PARAM_PHOTO_ARR_KEY: string = 'photoArr';

  static readonly SELECTED_INDEX_KEY: string = 'selectedIndex';

  static readonly GRID_COLUMNS_TEMPLATE: string = '1fr 1fr 1fr 1fr';

  static readonly INDEX_COLUMNS_TEMPLATE: string = '1fr 1fr';

  static readonly PHOTO_ITEM_PERCENT: string = '90%';

  static readonly SHOW_COUNT: number = 8;

  static readonly DEFAULT_WIDTH: number = 360;

  static readonly PHOTO_ITEM_PADDING: number = 8;

  static readonly PHOTO_ITEM_OFFSET: number = 16;

  static readonly ITEM_OPACITY_OFFSET: number = 0.2;

  static readonly DOUBLE_NUMBER: number = 2;

  static readonly URL_LIST_PAGE: string = 'pages/ListPage';

  static readonly URL_DETAIL_LIST_PAGE: string = 'pages/DetailListPage';

  static readonly URL_DETAIL_PAGE: string = 'pages/DetailPage';

  static readonly TAG_INDEX_PAGE: string = 'IndexPage push error ';

  static readonly TAG_LIST_PAGE: string = 'ListPage push error ';

  static readonly TAG_DETAIL_PAGE: string = 'DetailListPage push error ';

  static readonly SERVER: string = 'https://www.harmonyos.com';

  static readonly SUCCESS_CODE: number = 200;

  static readonly READ_TIMEOUT: number = 50000;

  static readonly CONNECT_TIMEOUT: number = 50000;


}






