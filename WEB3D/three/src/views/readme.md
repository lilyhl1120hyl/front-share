js实现截屏

简若澈

于 2018-02-09 12:06:24 发布

23309
 收藏 9
分类专栏： 前端 文章标签： js截屏
版权

前端
专栏收录该内容
13 篇文章0 订阅
订阅专栏
前言：借助html2canvas实现

1.html部分

需要截屏的容器
<div class="js-capture hide"></>
 
截屏生成的图片存放的位置，注意：img没有src的时候不要写src属性，不然会重新刷新页面
<img alt="" class="js-Base64Img hide">
js部分
function generatePicture(cb) {
 图片是一祯一祯加载的，为了确保图片加载完再截屏，放在延时加载器里
 setTimeout(() => {
    getBase64($('.js-capture')[0], function(data) {
      $('.js-Base64Img').attr('src', data);
      if (cb) {
        cb();
      }
    });
  }, 1000);
}
 
ready是所以资源加载完毕之后才执行
$(() => {
 截屏之前把截屏区域显示，隐藏状态下不可截屏
 $('.js-capture').removeClass('hide');
  generatePicture(() => {
  截屏之后把截屏区域给隐藏掉
  $('.js-capture').addClass('hide');
    $('.js-Base64Img').removeClass('hide');
  });
})
3.截屏相关

注意点：背景图片某些手机无法截屏，截屏区域中的图片不能跨越，不同机型识别二维码的能力不同，要想全部识别，设计设计页面应当简单
import html2canvas from 'html2canvas';
 
function DPR() {
  if (window.devicePixelRatio && window.devicePixelRatio > 1) {
    return window.devicePixelRatio;
  }
  return 1;
}
 
function parseValue(value) {
  return parseInt(value, 10);
}
 
export default function getBase64(el, callback) {
  const dom = el;
  const box = window.getComputedStyle(dom);
  const width = parseValue(box.width);
  const height = parseValue(box.height);
  const scaleBy = DPR();
  const canvas = document.createElement('canvas');
  canvas.width = width * scaleBy;
  canvas.height = height * scaleBy;
  canvas.style.width = `${width}px`;
  canvas.style.height = `${height}px`;
  const context = canvas.getContext('2d');
  context.scale(scaleBy, scaleBy);
  html2canvas(dom, {
    canvas,
  }).then(c => {
    把canvas转位base64
    callback(c.toDataURL('image/png') || '');
  });
