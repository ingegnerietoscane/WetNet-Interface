/**
 * 
 */
package net.wedjaa.wetnet.business.dao;

import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import net.wedjaa.wetnet.business.BusinessesException;
import net.wedjaa.wetnet.business.dao.params.DataMeasuresFilter;
import net.wedjaa.wetnet.business.domain.DayStatisticJoinMeasures;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author massimo ricci
 *
 */
public class MeasuresDayStatisticDAOImpl implements MeasuresDayStatisticDAO {

    private static final Logger logger = Logger.getLogger("MeasuresDayStatisticDAOImpl");

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasures(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasures'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasures", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    
    
    /*09/02/2017*/
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedGiornoAVG(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasuresOnTimebasedGiornoAVG'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresOnTimebasedGiornoAVG", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedSettimanaAVG(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasuresOnTimebasedSettimanaAVG'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresOnTimebasedSettimanaAVG", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedMeseAVG(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasuresOnTimebasedMeseAVG'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresOnTimebasedMeseAVG", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedAnnoAVG(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasuresOnTimebasedAnnoAVG'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresOnTimebasedAnnoAVG", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    
    
    
    
    /*GC 04/11/2015*/
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresAvg(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasuresAvg'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresAvg", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    
 /*GC 18/11/2015*/
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresonMonths(Date startDate, Date endDate, long idMeasures) {
        try {
            logger.info("Received request for 'getDayStatisticJoinMeasuresonMonths'");
            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresonMonths", objFilter);
            return districtsDayStatisticList;

        } catch (Exception e) {
            throw new BusinessesException(e);
        }

    }
    
    @Override
    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresonYears(Date startDate, Date endDate, long idMeasures) {
	        try {
	            logger.info("Received request for 'getDayStatisticJoinMeasuresonYears'");
	            DataMeasuresFilter objFilter = new DataMeasuresFilter(startDate, endDate, idMeasures);
	            List<DayStatisticJoinMeasures> districtsDayStatisticList = sqlSessionTemplate.selectList("measuresDayStatistic.getDayStatisticJoinMeasuresonYears", objFilter);
	            return districtsDayStatisticList;

	        } catch (Exception e) {
	            throw new BusinessesException(e);
	        }

	    }

    
}
