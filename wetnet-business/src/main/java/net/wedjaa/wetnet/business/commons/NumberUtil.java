package net.wedjaa.wetnet.business.commons;

import java.text.DecimalFormat;

/**
 * @author massimo ricci
 *
 */
public final class NumberUtil {

    /**
     * Format #.## con due cifre dopo la virgola
     */
    public static final DecimalFormat DECIMALFORMAT_2D = new DecimalFormat("0.00");

    /**
     * Ritorna il number arrotondato ai decimals passati come parametro
     * @param number
     * @param decimals
     * @return
     */
    public static double roundToAnyDecimal(double number, double decimals){
        double pow = Math.pow(10, decimals);
        double result = Math.round(number*pow)/pow;
        return result;
    }

    public static double percentage(double value, double total) {
        return total != 0 ? value * 100 / total : 0;
    }

    public static double percentage(double value, double total, int precision) {
        double percentage = total != 0 ? value * 100 / total : 0;
        double f = 10 * precision;
        return Math.round(percentage * f) / f;
    }

}
