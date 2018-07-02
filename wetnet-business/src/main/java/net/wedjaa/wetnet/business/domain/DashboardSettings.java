package net.wedjaa.wetnet.business.domain;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DashboardSettings {
	
	@XmlAttribute
	public int level;
	
	@XmlAttribute
	public int zoom;
	
	@XmlAttribute
	public boolean districtLevel1;
	
	@XmlAttribute
	public boolean districtLevel2;
	
	@XmlAttribute
	public boolean districtLevel3;
	
	@XmlAttribute
	public boolean districtLevel4;
	
	@XmlAttribute
	public boolean measureType0;
	
	@XmlAttribute
	public boolean measureType1;
	
	@XmlAttribute
	public boolean measureType2;
	
	@XmlAttribute
	public boolean measureType3;
	
	@XmlAttribute
	public boolean measureType4;

	@XmlAttribute
	public boolean eventType1;
	
	@XmlAttribute
	public boolean eventType2;
	
	@XmlAttribute
	public boolean eventType3;
	
	@XmlAttribute
	public boolean eventType4;
	
	@XmlAttribute
	public boolean eventType5;
	
	@XmlAttribute
	public boolean eventRanking;
	
	@XmlAttribute
	public boolean eventValue;
	
	@XmlAttribute
	public boolean eventDuration;
	
	@XmlAttribute
	public boolean eventDelta;
	
	@XmlAttribute
	public boolean areal;
	
	@XmlAttribute
	public boolean linear;
	
	@XmlAttribute
	public boolean punctual;
	
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getZoom() {
		return zoom;
	}
	public void setZoom(int zoom) {
		this.zoom = zoom;
	}
	public boolean isDistrictLevel1() {
		return districtLevel1;
	}
	public void setDistrictLevel1(boolean districtLevel1) {
		this.districtLevel1 = districtLevel1;
	}
	public boolean isDistrictLevel2() {
		return districtLevel2;
	}
	public void setDistrictLevel2(boolean districtLevel2) {
		this.districtLevel2 = districtLevel2;
	}
	public boolean isDistrictLevel3() {
		return districtLevel3;
	}
	public void setDistrictLevel3(boolean districtLevel3) {
		this.districtLevel3 = districtLevel3;
	}
	public boolean isDistrictLevel4() {
		return districtLevel4;
	}
	public void setDistrictLevel4(boolean districtLevel4) {
		this.districtLevel4 = districtLevel4;
	}
	public boolean isMeasureType0() {
		return measureType0;
	}
	public void setMeasureType0(boolean measureType0) {
		this.measureType0 = measureType0;
	}
	public boolean isMeasureType1() {
		return measureType1;
	}
	public void setMeasureType1(boolean measureType1) {
		this.measureType1 = measureType1;
	}
	public boolean isMeasureType2() {
		return measureType2;
	}
	public void setMeasureType2(boolean measureType2) {
		this.measureType2 = measureType2;
	}
	public boolean isMeasureType3() {
		return measureType3;
	}
	public void setMeasureType3(boolean measureType3) {
		this.measureType3 = measureType3;
	}
	public boolean isMeasureType4() {
		return measureType4;
	}
	public void setMeasureType4(boolean measureType4) {
		this.measureType4 = measureType4;
	}
	public boolean isEventType1() {
		return eventType1;
	}
	public void setEventType1(boolean eventType1) {
		this.eventType1 = eventType1;
	}
	public boolean isEventType2() {
		return eventType2;
	}
	public void setEventType2(boolean eventType2) {
		this.eventType2 = eventType2;
	}
	public boolean isEventType3() {
		return eventType3;
	}
	public void setEventType3(boolean eventType3) {
		this.eventType3 = eventType3;
	}
	public boolean isEventType4() {
		return eventType4;
	}
	public void setEventType4(boolean eventType4) {
		this.eventType4 = eventType4;
	}
	public boolean isEventType5() {
		return eventType5;
	}
	public void setEventType5(boolean eventType5) {
		this.eventType5 = eventType5;
	}
	public boolean isEventRanking() {
		return eventRanking;
	}
	public void setEventRanking(boolean eventRanking) {
		this.eventRanking = eventRanking;
	}
	public boolean isEventValue() {
		return eventValue;
	}
	public void setEventValue(boolean eventValue) {
		this.eventValue = eventValue;
	}
	public boolean isEventDuration() {
		return eventDuration;
	}
	public void setEventDuration(boolean eventDuration) {
		this.eventDuration = eventDuration;
	}
	public boolean isEventDelta() {
		return eventDelta;
	}
	public void setEventDelta(boolean eventDelta) {
		this.eventDelta = eventDelta;
	}
	public boolean isAreal() {
		return areal;
	}
	public void setAreal(boolean areal) {
		this.areal = areal;
	}
	public boolean isLinear() {
		return linear;
	}
	public void setLinear(boolean linear) {
		this.linear = linear;
	}
	public boolean isPunctual() {
		return punctual;
	}
	public void setPunctual(boolean punctual) {
		this.punctual = punctual;
	}
	@Override
	public String toString() {
		return "DashboardSettings [level=" + level + ", zoom=" + zoom + ", districtLevel1=" + districtLevel1
				+ ", districtLevel2=" + districtLevel2 + ", districtLevel3=" + districtLevel3 + ", districtLevel4="
				+ districtLevel4 + ", measureType0=" + measureType0 + ", measureType1=" + measureType1
				+ ", measureType2=" + measureType2 + ", measureType3=" + measureType3 + ", measureType4=" + measureType4
				+ ", eventType1=" + eventType1 + ", eventType2=" + eventType2 + ", eventType3=" + eventType3
				+ ", eventType4=" + eventType4 + ", eventType5=" + eventType5 + ", eventRanking=" + eventRanking
				+ ", eventValue=" + eventValue + ", eventDuration=" + eventDuration + ", eventDelta=" + eventDelta
				+ ", areal=" + areal + ", linear=" + linear + ", punctual=" + punctual + "]";
	}
	
	
	
	
	
	
	
	

}
