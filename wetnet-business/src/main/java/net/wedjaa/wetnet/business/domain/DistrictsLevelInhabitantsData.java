package net.wedjaa.wetnet.business.domain;

import java.util.List;

public class DistrictsLevelInhabitantsData {

    private int mapLevel;
    private int eventVariableType;
    private int districtsCount;
    private List<Long> districtsInhabitants;
    private long districtsInhabitantsSum;
    private double districtsInhabitantsPercetage;

    public DistrictsLevelInhabitantsData() {
    }

    public DistrictsLevelInhabitantsData(int mapLevel, int districtsCount, List<Long> districtsInhabitants, long districtsInhabitantsSum, double districtsInhabitantsPercetage) {
        this.mapLevel = mapLevel;
        this.districtsCount = districtsCount;
        this.districtsInhabitants = districtsInhabitants;
        this.districtsInhabitantsSum = districtsInhabitantsSum;
        this.districtsInhabitantsPercetage = districtsInhabitantsPercetage;
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

    public List<Long> getDistrictsInhabitants() {
        return districtsInhabitants;
    }

    public void setDistrictsInhabitants(List<Long> districtsInhabitants) {
        this.districtsInhabitants = districtsInhabitants;
    }

    public double getDistrictsInhabitantsPercetage() {
        return districtsInhabitantsPercetage;
    }

    public void setDistrictsInhabitantsPercetage(double districtsInhabitantsPercetage) {
        this.districtsInhabitantsPercetage = districtsInhabitantsPercetage;
    }

    public long getDistrictsInhabitantsSum() {
        return districtsInhabitantsSum;
    }

    public void setDistrictsInhabitantsSum(long districtsInhabitantsSum) {
        this.districtsInhabitantsSum = districtsInhabitantsSum;
    }

    public int getEventVariableType() {
        return eventVariableType;
    }

    public void setEventVariableType(int eventVariableType) {
        this.eventVariableType = eventVariableType;
    }
}
