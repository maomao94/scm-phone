/**
 * Created by 28773 on 2017/3/11.
 */
function valueToText(str, value) {
    str = str.substring(1, str.length - 1);
    var array = str.split(",");
    for (var i = 0; i < array.length; i++) {
        var array2 = array[i].split("=");
        if ($.trim(value) == $.trim(array2[0])) {
            return array2[1];
        }
    }
    return "未知类型";
}

function parseDate(dateStr) {
    var strArray = dateStr.split("-");
    if (strArray.length == 3) {
        return new Date(strArray[0], strArray[1], strArray[2]);
    } else {
        return new Date();
    }
}
