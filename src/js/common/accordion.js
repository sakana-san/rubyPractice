var $ = require('jquery');

function accordion () {
	$('.c-AdBtn').on('click', function() {
		var adMove = $('+.p-accordionList__title', this);
		adMove.slideToggle();
		$('.p-accordionList__title').not(adMove).slideUp();
		clickCurrent(this);
	});
	function clickCurrent(action) {
		var rm = ['c-iconSubNav--aboutUs-hover', 'c-iconSubNav--cafe-hover', 'c-iconSubNav--bread-hover', 'c-iconSubNav--history-hover'];
		var count = 0;
		count = $('.c-AdBtn').index(action);
		if(count === 0) {
			$('.c-AdBtn').eq(count).toggleClass('c-iconSubNav--aboutUs-hover');
		} else if(count === 1) {
			$('.c-AdBtn').eq(count).toggleClass('c-iconSubNav--cafe-hover');
		} else if(count === 2) {
			$('.c-AdBtn').eq(count).toggleClass('c-iconSubNav--bread-hover');
		} else if(count === 3) {
			$('.c-AdBtn').eq(count).toggleClass('c-iconSubNav--history-hover');
		}
		for(var i=0; i<rm.length; i++) {
			$('.c-AdBtn').not($('.c-AdBtn').eq(count)).removeClass(rm[i]);
		}
	}
	return clickCurrent;
}

module.exports = accordion;