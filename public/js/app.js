var expertises = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
        url: '/expertises.json',
        filter: function(list) {
            return $.map(list, function(val){ return { value: val }; });
        }
    }
});

expertises.initialize();

$(function() {
    $('.validate').typeahead({
        highlight: true
    },{
        name: 'expertise',
        displayKey: 'value',
        source: expertises.ttAdapter()
    });

    $('.validate').bind('keypress', function(e) {
        if(e.keyCode==13){
            console.log("enter")
        }
    });
});
