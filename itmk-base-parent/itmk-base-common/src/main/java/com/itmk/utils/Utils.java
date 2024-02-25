package com.itmk.utils;


import org.apache.commons.lang.StringUtils;

/**
 * @Author java实战基地
 * @Version 2383404558
 */
public class Utils {
    /**
     * 截取字符串str中指定字符 strStart、strEnd之间的字符串
     */
    public static String subString(String str, String strStart, String strEnd) {

        /* 找出指定的2个字符在 该字符串里面的 位置 */
        int strStartIndex = str.indexOf(strStart);
        int strEndIndex = str.indexOf(strStartIndex+1);

        /* index 为负数 即表示该字符串中 没有该字符 */
        if (strStartIndex < 0) {
            return "字符串 :---->" + str + "<---- 中不存在 " + strStart + ", 无法截取目标字符串";
        }
        if (strEndIndex < 0) {
            return "字符串 :---->" + str + "<---- 中不存在 " + strEnd + ", 无法截取目标字符串";
        }
        /* 开始截取 */
        String result = str.substring(strStartIndex, strEndIndex).substring(strStart.length());
        return result;
    }

   /**
     * 姓名脱敏
     * 一位时不脱敏，两位时‘姓’脱敏，两位以上保留首尾中间脱敏
     * @param str
     * @return
     */
    public static String subName(String str) {
        if(StringUtils.isEmpty(str)) {
		// if (str == null || str.equals("")){
            return str;
        }
        char[] sArr = str.toCharArray();
        if (sArr.length == 2) {
            return "*" + sArr[1];
        } else if (sArr.length  > 2) {
            for (int i = 1; i < sArr.length -1; i++) {
                // if ('·' != sArr[i]) {
                    sArr[i] = '*';
                // }
            }
            return new String(sArr);
        }
        return str;
    }
    public static String subNum(String phoneNumber){
        if(StringUtils.isNotEmpty(phoneNumber)){
            phoneNumber = phoneNumber.replaceAll("(\\w{3})\\w*(\\w{4})", "$1****$2");
        }
        return phoneNumber;
    }
}
