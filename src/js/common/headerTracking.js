function HeaderTracking() {
	this.initialize();
}

HeaderTracking.prototype = {
	initialize: function() {
		this.elementMove = $('.l-headerContent');
		this.bindScroll();
	},
	bindScroll: function() {
		var that = this;
		$(window).on('scroll', function() {
			that.bindHeaderConent();
		});
	},
	bindHeaderConent: function() {
		var count = $(document).scrollTop();
		if(count <= 0) {
			this.elementMove.removeClass('js-HeaderScroll');
		} else {
			this.elementMove.addClass('js-HeaderScroll');
		}
	}
};

module.exports = HeaderTracking;