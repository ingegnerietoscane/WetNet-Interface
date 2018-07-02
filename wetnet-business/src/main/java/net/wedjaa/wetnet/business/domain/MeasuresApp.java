package net.wedjaa.wetnet.business.domain;

import java.util.Date;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author massimo ricci
 * @author alessandro vincelli
 *
 */
@XmlRootElement
public class MeasuresApp implements Comparable<MeasuresApp> {

    @XmlAttribute(required = false)
    private long idMeasures;
    @XmlAttribute(required = false)
    private String name;
    @XmlAttribute(required = false)
    private String description;
    @XmlAttribute(required = false)
    private int type;
    @XmlAttribute(required = false)
    private String latitudeApp;
    @XmlAttribute(required = false)
    private String longitudeApp;
    
    
    public MeasuresApp(long idMeasures, String name, String description, int type, String latitudeApp,
			String longitudeApp) {
		super();
		this.idMeasures = idMeasures;
		this.name = name;
		this.description = description;
		this.type = type;
		this.latitudeApp = latitudeApp;
		this.longitudeApp = longitudeApp;
	}

	public long getIdMeasures() {
        return idMeasures;
    }

    public void setIdMeasures(long idMeasures) {
        this.idMeasures = idMeasures;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

	public String getLatitudeApp() {
		return latitudeApp;
	}

	public void setLatitudeApp(String latitudeApp) {
		this.latitudeApp = latitudeApp;
	}

	public String getLongitudeApp() {
		return longitudeApp;
	}

	public void setLongitudeApp(String longitudeApp) {
		this.longitudeApp = longitudeApp;
	}

	@Override
	public int compareTo(MeasuresApp o) {
		if (o != null) {
            return getName().compareToIgnoreCase(o.getName());
        }
		return 0;
	}
}
