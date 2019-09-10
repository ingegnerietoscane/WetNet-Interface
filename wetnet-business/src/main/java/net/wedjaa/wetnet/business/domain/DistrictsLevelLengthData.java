package net.wedjaa.wetnet.business.domain;
import java.util.List;

public class DistrictsLevelLengthData {

    private int mapLevel;
    private int eventVariableType;
    private int districtsCount;    
    private List<Double> districtsLength;
    private double districtsLengthSum;
    private double districtsLengthPercetage;

    public DistrictsLevelLengthData(){};

    public DistrictsLevelLengthData(int mapLevel, int count, List<Double> length, float lengthPercetage, double lengthSum) {
        this.mapLevel = mapLevel;
        this.districtsCount = count;
        this.districtsLength = length;
        this.districtsLengthPercetage = lengthPercetage;
        this.districtsLengthSum = lengthSum;
    }

    public int getMapLevel() {
        return mapLevel;
    }

    public void setMapLevel(int mapLevel) {
        this.mapLevel = mapLevel;
    }

    public int getDistrictsCount() {
        return districtsCount;
    }

    public void setDistrictsCount(int districtsCount) {
        this.districtsCount = districtsCount;
    }

    public List<Double> getDistrictsLength() {
        return districtsLength;
    }

    public void setDistrictsLength(List<Double> districtsLength) {
        this.districtsLength = districtsLength;
    }

    public double getDistrictsLengthPercetage() {
        return districtsLengthPercetage;
    }

    public void setDistrictsLengthPercetage(double districtsLengthPercetage) {
        this.districtsLengthPercetage = districtsLengthPercetage;
    }

    public double getDistrictsLengthSum() {
        return districtsLengthSum;
    }

    public void setDistrictsLengthSum(double districtsLengthSum) {
        this.districtsLengthSum = districtsLengthSum;
    }

    public int getEventVariableType() {
        return eventVariableType;
    }

    public void setEventVariableType(int eventVariableType) {
        this.eventVariableType = eventVariableType;
    }
}
