/////// Initialization
//var AnimationUtility = function () {
//    this.setMethod();
//};
//
//AnimationUtility.prototype.setMethod = function () {
//    // we default to css, do better if we can
//    this.setPosition = this['setPositionUsingCSS'];
//    this.setOpacity = this['setOpacityUsingCSS'];
//    this.setRadius = this['setRadiusUsingCSS'];
//};
//
//// These functions are what will be called externally, we will point them to the proper method,
//AnimationUtility.prototype.setPosition = function (divElement, xpos, ypos) {
//    throw "setPosition not set!";
//};
//AnimationUtility.prototype.setOpacity = function (divElement, newOpacity) {
//    throw "setOpacity not set!";
//};
//AnimationUtility.prototype.setRadius = function (divElement, newRadius) {
//    throw "setRadius not set!";
//};
//
//// Available method types
//AnimationUtility.prototype.METHOD_TYPES = { CSS: 'CSS', TRANSFORM: 'Transform', JQUERY: 'Jquery' };
//AnimationUtility.prototype.DEFAULT_METHOD = AnimationUtility.prototype.METHOD_TYPES.JQUERY;
//
///**
// * Positioning via CSS 'style' property access
// * @param {HTMLDivElement} divElement    Reference to HTMLElement
// * @param {Number} xpos            X position
// * @param {Number} ypos            Y Position
// */
//AnimationUtility.prototype.setPositionUsingCSS = function (divElement, xpos, ypos) {
//    // console.log(xpos, ypos);
//    divElement.style.left = (xpos << 0) + "px";
//    divElement.style.top = (ypos << 0) + "px";
//};
//
///**
// * @inheritDoc
// */
//AnimationUtility.prototype.setPositionUsingTransforms3d = function (divElement, xpos, ypos) {
//    // TODO: These should be fixed only on first run
//    if (divElement.style.left !== '0px')
//        divElement.style.left = '0px';
//    if (divElement.style.top !== '0px')
//        divElement.style.top = '0px';
//
//    // Matrix translate the position of the object in webkit & firefox & IE, maybe another day IE will support this.
//    var transformString = "translate3d(" + (xpos << 0) + "px," + (ypos << 0) + "px, 0px)";
//    divElement.style.msTransform = divElement.style.MozTransform = divElement.style.webkitTransform = transformString;
//};
//
///**
// * @inheritDoc
// */
//AnimationUtility.prototype.setPositionUsingTransforms = function (divElement, xpos, ypos) {
//    // TODO: These should be fixed only on first run
//    if (divElement.style.left !== '0px')
//        divElement.style.left = '0px';
//    if (divElement.style.top !== '0px')
//        divElement.style.top = '0px';
//
//    // Matrix translate the position of the object in webkit, firefox, IE9
//    divElement.style.msTransform = divElement.style.MozTransform = divElement.style.webkitTransform = "translate(" + (xpos << 0) + "px," + (ypos << 0) + "px)";
//};
//
/////// Alpha
///**
// * Set an elements opacity property
// * @param {Number} divElement    Reference to HTMLElement
// * @param {Number} newOpacity     New opacity value
// */
//AnimationUtility.prototype.setOpacityUsingCSS = function (divElement, newOpacity) {
//    if (newOpacity > 0.99) newOpacity = 1.0;
//    divElement.style.opacity = newOpacity
//};