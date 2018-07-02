package net.wedjaa.wetnet.business.dao;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import net.wedjaa.wetnet.business.domain.DataDistricts;

/**
 * @author massimo ricci
 *
 */
public interface DataDistrictsDAO {

    /**
     * restituisce tutti i profili dei distretti
     * 
     * @return
     */
    public List<DataDistricts> getAllDataDistricts();

    /**
     * restituisce i profili di un distretto
     * 
     * @param districtId
     * 
     * @return
     */
    public List<DataDistricts> getDataDistrictsByDistrictId(long districtId);

    /**
     * 
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedDataDistrictsByDistrictId(long districtId);

    /**
     * 
     * @return
     */
    List<DataDistricts> getJoinedDataDistricts();
    
    /**
     * dati raggruppati per giorno
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * 
     * @return
     */
    List<DataDistricts> getJoinedDataDistrictsAVGOnDays(Date startDate, Date endDate, long districtId);

    /**
     * tutti i dati, nessun raggruppamento
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedAllDataDistricts(Date startDate, Date endDate, long districtId);

    
    /**
     * dato raggruppati per ora
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedDataDistrictsAVGOnHours(Date startDate, Date endDate, long districtId);

    /**
     * dati raggruppati per giorno
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    public List<DataDistricts> getJoinedEnergyProfileAVGOnDays(Date startDate, Date endDate, long idDistricts);

    /**
     * dati raggruppati per ora
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    public List<DataDistricts> getJoinedEnergyProfileAVGOnHours(Date startDate, Date endDate, long idDistricts);

    /**
     * dato non raggruppato
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    public List<DataDistricts> getJoinedAllEnergyProfile(Date startDate, Date endDate, long idDistricts);

    /**
     * dati raggruppati per giorno
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedLossesProfileAVGOnDays(Date startDate, Date endDate, long idDistricts);

    /**
     * dati raggruppati per ora
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedLossesProfileAVGOnHours(Date startDate, Date endDate, long idDistricts);

    /**
     * dati non raggruppati
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedAllLossesProfile(Date startDate, Date endDate, long idDistricts);

	
  

    /** GC 03/11/2015
     * media
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedDataDistrictsAVG(Date startDate, Date endDate, long districtId);
    
    
    /** GC 03/11/2015
     * media
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedEnergyProfileAVG(Date startDate, Date endDate, long districtId);
    
    /** GC 03/11/2015
     * media
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    List<DataDistricts> getJoinedLossesProfileAVG(Date startDate, Date endDate, long districtId);

    /** GC 18/11/2015
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
	public List<DataDistricts> getJoinedDataDistrictsAVGOnMonths(Date startDate, Date endDate, long idDistricts);

	/** GC 18/11/2015
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
	
	public List<DataDistricts> getJoinedDataDistrictsAVGOnYears(Date startDate, Date endDate, long idDistricts);
	
	
	 
    /** GC 18/11/2015
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
	
    public List<DataDistricts> getJoinedEnergyProfileAVGOnMonths(Date startDate, Date endDate, long idDistricts);

    
    
    /** GC 18/11/2015
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
	
    public List<DataDistricts> getJoinedEnergyProfileAVGOnYears(Date startDate, Date endDate, long idDistricts);

    /** GC 18/11/2015
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    public List<DataDistricts> getJoinedLossesProfileAVGOnMonths(Date startDate, Date endDate, long idDistricts);

    /** GC 18/11/2015
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
    public List<DataDistricts> getJoinedLossesProfileAVGOnYears(Date startDate, Date endDate, long idDistricts);

    
    /*08/02/2017
     * 
     * @param startDate
     * @param endDate
     * @param districtId
     * @return
     */
     
    public List<DataDistricts> getJoinedDataDistrictsFilteredOnTimebaseGiornoAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedDataDistrictsFilteredOnTimebaseSettimanaAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedDataDistrictsFilteredOnTimebaseMeseAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedDataDistrictsFilteredOnTimebaseAnnoAVG(Date startDate, Date endDate, long districtId);
    
    public List<DataDistricts> getJoinedAllEnergyProfileFilteredOnTimebaseGiornoAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedAllEnergyProfileFilteredOnTimebaseSettimanaAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedAllEnergyProfileFilteredOnTimebaseMeseAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedAllEnergyProfileFilteredOnTimebaseAnnoAVG(Date startDate, Date endDate, long districtId);

    public List<DataDistricts> getJoinedLossesProfileOnTimebaseGiornoAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedLossesProfileOnTimebaseSettimanaAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedLossesProfileOnTimebaseMeseAVG(Date startDate, Date endDate, long districtId);
    public List<DataDistricts> getJoinedLossesProfileOnTimebaseAnnoAVG(Date startDate, Date endDate, long districtId);
}
