package net.wedjaa.wetnet.business.domain;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author daniele montagni
 */
@XmlRootElement
public class WmsServices implements Comparable<WmsServices> {

    @XmlAttribute(required = false)
    protected long idwms_services;
    @XmlAttribute(required = false)
    protected String name;
    @XmlAttribute(required = false)
    protected String url;
    @XmlAttribute(required = false)
    protected String layer;
    @XmlAttribute(required = false)
    protected String server_type;

   /* User preferences */
    //protected long districtId = -1;


    public long getIdwms_services() {
        return idwms_services;
    }

    public void setIdwms_services(long idwms_services) {
        this.idwms_services = idwms_services;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLayer() {
        return layer;
    }

    public void setLayer(String layer) {
        this.layer = layer;
    }

    public String getServer_type() {
        return server_type;
    }

    public void setServer_type(String server_type) {
        this.server_type = server_type;
    }

    @Override
    public int compareTo(WmsServices o) {
        if (o != null) {
            return getName().compareTo(o.getName());
        }
        return 0;
    }

}
