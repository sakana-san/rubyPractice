
function Tooltip() {
	this.initialize();
}

Tooltip.prototype = {
	initialize: function() {
		this.$el = $('body');
		this.bindClick();
	},
	bindClick: function() {
		this.$el.find('.is-attention').on('click', function() {
			if (window.confirm('初期化しますか？初期化するなら実行を押してください')) {
				location.href = 'http://localhost:8088/init';
				return true;
			}
			return false;
		});
	}
}

module.exports = Tooltip;