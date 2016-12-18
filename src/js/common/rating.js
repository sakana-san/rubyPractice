
function Rating() {
	this.initialize();
}

Rating.prototype = {
	initialize: function() {
		this.totalCount = 0;
		this.currentNumber = 0;
		this.getItemPositions();
		this.bindScroll();
	},
	getItemPositions: function() {
		var that = this;
		this.cassettes = [];
		this.headerHeight = $('.js-header-position').outerHeight();
		this.$cassettes = $('.js-measure-number');
		$.each(that.$cassettes, function(index, value) {
			//コンテンツのそれぞれの高さを計測
			that.cassettes.push($(value).offset().top - that.headerHeight);
			that.totalCount = index;
		});
	},
	bindScroll: function() {
		var that = this;
		//スクロールした時のカセット到達率を計測
		$(window).on('scroll', function() {
			var currentScrollTop = $(document).scrollTop();
			$.each(that.cassettes, function(index, value) {
				if (value > currentScrollTop) {
					that.currentNumber = index;
					return false;
				} else if (that.currentNumber >= that.$cassettes.length - 1) {
					return that.currentNumber =  that.$cassettes.length;
				}
			});
			that.getArrivalFactor();
		});
	},
	getArrivalFactor: function() {
		this.alreadyReadRatingLine = $('.js-line-variable');
		//カセット数 / カセットのトータル(0から数えてしまうので+1をしている) * 100
		var arrivalFactor = (this.currentNumber / (this.totalCount + 1)) * 100;
		this.alreadyReadRatingLine.css({'width': arrivalFactor + '%', 'display': 'block'});
	}
};

module.exports = Rating;