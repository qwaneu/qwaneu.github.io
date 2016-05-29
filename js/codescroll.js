// gevonden op internet - zou scrollbars moeten displayen in code die te breed is - RWE
var sc;
$(document).ready(function(){
    //constantly update the scroll position:
    sc=setInterval(scrollDown,200);

    //optional:stop the updating if it gets a click
    $('.highlighter-rouge .highlight').mousedown(function(e){
        clearInterval(sc);
    });
});
function scrollDown(){
    //find every div with class "mydiv" and apply the fix
    for(i=0;i<=$('.highlighter-rouge .highlight').length;i++){
        try{
            var g=$('.highlighter-rouge .highlight')[i];
            g.scrollTop+=1;
            g.scrollTop-=1;
        } catch(e){
            //eliminates errors when no scroll is needed
        }
    }
}
