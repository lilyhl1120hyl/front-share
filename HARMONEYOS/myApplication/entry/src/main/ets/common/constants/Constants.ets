

import { VideoItem } from '../../viewmodel/VideoItem';
import resourceManager from '@ohos.resourceManager';


export enum FontSize {
  SMALL = 14,
  MIDDLE = 16,
  LARGE = 20,
};

export enum FontWeight {
  BOLD = '400',
  BOLDER = '500',
};


export const WEIGHT = '100%';
export const TIME = 1000;

export const APP_EXIT_INTERVAL: number = 4500;

export const DEFAULT_48: number = 48;

export const DEFAULT_56: number = 56;

export const DEFAULT_60: number = 60;

export const DEFAULT_100: number = 100;

export const DEFAULT_180: number = 180;

export const TAG: string = 'RankPage';

export const TITLE: Resource = $r('app.string.title');

class style {
  RANK_PADDING: number = 15;
  CONTENT_WIDTH: string = '90%';
  BORDER_RADIUS: number = 20;
  STROKE_WIDTH: number = 1;
  HEADER_MARGIN_TOP: number = 20;
  HEADER_MARGIN_BOTTOM: number = 15;
  LIST_HEIGHT: string = '65%';
}


export const Style: style = {
  RANK_PADDING: 15,
  CONTENT_WIDTH: '90%',
  BORDER_RADIUS: 20,
  STROKE_WIDTH: 1,
  HEADER_MARGIN_TOP: 20,
  HEADER_MARGIN_BOTTOM: 15,
  LIST_HEIGHT: '65%'
};

class listHeaderStyle {
  FONT_WEIGHT: number = 400;
  LAYOUT_WEIGHT_LEFT: string = '30%';
  LAYOUT_WEIGHT_CENTER: string = '50%';
  LAYOUT_WEIGHT_RIGHT: string = '20%';
}

export const ListHeaderStyle: listHeaderStyle = {
  FONT_WEIGHT: 400,
  LAYOUT_WEIGHT_LEFT: '30%',
  LAYOUT_WEIGHT_CENTER: '50%',
  LAYOUT_WEIGHT_RIGHT: '20%',
};

class itemStyle {
  TEXT_LAYOUT_SIZE: number = 24;
  CIRCLE_TEXT_BORDER_RADIUS: number = 24;
  CIRCLE_TEXT_SIZE: number = 24;
  CIRCLE_TEXT_COLOR_STOP_1: number = 0.5;
  CIRCLE_TEXT_COLOR_STOP_2: number = 1.0;
  BAR_HEIGHT: number = 48;
  LAYOUT_WEIGHT_LEFT: string = '30%';
  LAYOUT_WEIGHT_CENTER: string = '50%';
  LAYOUT_WEIGHT_RIGHT: string = '20%';
  BORDER_WIDTH: number = 1;
  COLOR_BLUE: Resource = $r('app.color.item_color');
  COLOR_BLACK: Resource = $r('app.color.item_color_black');
}


export const ItemStyle: itemStyle = {
  TEXT_LAYOUT_SIZE: 24,
  CIRCLE_TEXT_BORDER_RADIUS: 24,
  CIRCLE_TEXT_SIZE: 24,
  CIRCLE_TEXT_COLOR_STOP_1: 0.5,
  CIRCLE_TEXT_COLOR_STOP_2: 1.0,
  BAR_HEIGHT: 48,
  LAYOUT_WEIGHT_LEFT: '30%',
  LAYOUT_WEIGHT_CENTER: '50%',
  LAYOUT_WEIGHT_RIGHT: '20%',
  BORDER_WIDTH: 1,
  COLOR_BLUE: $r('app.color.item_color'),
  COLOR_BLACK: $r('app.color.item_color_black')
};

class titleBarStyle {
  IMAGE_BACK_SIZE: number = 21;
  IMAGE_BACK_MARGIN_RIGHT: number = 18;
  IMAGE_LOADING_SIZE: number = 22;
  BAR_HEIGHT: number = 47;
  BAR_MARGIN_HORIZONTAL: number = 26;
  BAR_MARGIN_TOP: number = 10;
  WEIGHT: string = '50%';
}


export const TitleBarStyle: titleBarStyle = {
  IMAGE_BACK_SIZE: 21,
  IMAGE_BACK_MARGIN_RIGHT: 18,
  IMAGE_LOADING_SIZE: 22,
  BAR_HEIGHT: 47,
  BAR_MARGIN_HORIZONTAL: 26,
  BAR_MARGIN_TOP: 10,
  WEIGHT: '50%',
};

export const SECOND_PAGE: string = 'pages/VideoPlay';

export const SOURCE: string = 'source';

export const NET: string = '网络视频地址*****';

export const MESSAGE: string = '请检查网络';

export const START_TIME: string = '00:00';

export const ZERO_STR: string = '0';

export const SPLIT: string = ':';

export const DEFAULT_OPACITY: number = Number.parseFloat('0.2');

export const SMALL_TRACK_THICK_NESS: number = 2;

export const BIG_TRACK_THICK_NESS: number = 4;

export const COMMON_NUM_DOUBLE: number = 10;

export const COMMON_NUM_MINUTE: number = 60;

export const COMMON_NUM_FONT_WEIGHT: number = 500;

export const COMMON_NUM_DURATION: number = 5000;

export const LIST: string[] = ['最近播放', '为你推荐'];

export const ALL_PERCENT: string = '100%';

export const IMAGE_SIZE: number = 24;


export const enum STRING_PERCENT {
  SLIDER_WITH = '46.7%',
  NINETY_PERCENT = '88%',
  INDEX_COMPONENT_WITH_PERCENT = '93.3%',
  INDEX_SWIPER_HEIGHT_PERCENT = '24.1%',
  INDEX_MODULE_HEIGHT_PERCENT = '22.8%',
  INDEX_SWIPER_LEFT_RIGHT_MARGIN = '3.3%'
}

export const enum MARGIN_FONT_SIZE {
  FIRST_MARGIN = 12,
  SECOND_MARGIN = 16,
  THIRD_MARGIN = 18,
  FOURTH_MARGIN = 24,
  FIFTH_MARGIN = 50,
  SIXTH_MARGIN = 94,
  SEVENTH_MARGIN = 132
}

export const enum VIDEO_TYPE {
  INNER = 'inner',
  NET = 'net'
}

export const enum STACK_STYLE {
  IMAGE_Z_INDEX = 2,
  PROGRESS_VALUE = 0,
  PROGRESS_TOTAL = 100,
  PROGRESS_STROKE_WIDTH = 15,
  PROGRESS_SCALE_COUNT = 15,
  PROGRESS_SCALE_WIDTH = 5,
  PROGRESS_Z_INDEX = 1,
  PROGRESS_WIDTH = 80,
  PROGRESS_STEP = 10,
  MILLI_SECONDS = 100
}


export enum AvplayerStatus {
  IDLE = 'idle',
  INITIALIZED = 'initialized',
  PREPARED = 'prepared',
  PLAYING = 'playing',
  PAUSED = 'paused',
  COMPLETED = 'completed',
  STOPPED = 'stopped',
  RELEASED = 'released',
  ERROR = 'error'
}

export enum Events {
  STATE_CHANGE = 'stateChange',
  TIME_UPDATE = 'timeUpdate',
  ERROR = 'error'
}

export enum SliderMode {
  MOVING = 1,
  END = 2,
  CLICK = 3
}


export const VIDEO_DATA: VideoItem[] = [
  new VideoItem('video1', {} as resourceManager.RawFileDescriptor, 'video1.mp4',),
  new VideoItem('video2', {} as resourceManager.RawFileDescriptor, 'video2.mp4',)
]

