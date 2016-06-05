
function Rating() {
	this.initialize();
}

Rating.prototype = {
	initialize: function() {
		this.totalCount = 11;
		this.currentNumber = 0;
		this.getItemPositions();
		this.bindScroll();
	},
	getItemPositions: function() {
		var that = this;
		this.cassettes = [];
		this.headerHeight = $('.l-headerContent').outerHeight();
		console.log(this.headerHeight);
		this.$cassettes = $('.p-cassettesContent');
		$.each(that.$cassettes, function(index, value) {
			//コンテンツのそれぞれの高さを計測
			that.cassettes.push($(value).offset().top - that.headerHeight);
			console.log(that.cassettes);
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
		this.alreadyReadRatingLine = $('.p-alreadyReadRatingLine');
		//カセット数 / カセットのトータル * 100
		var arrivalFactor = (this.currentNumber / this.totalCount) * 100;
		this.alreadyReadRatingLine.css({'width': arrivalFactor + '%', 'display': 'block'});
	}
};

module.exports = Rating;