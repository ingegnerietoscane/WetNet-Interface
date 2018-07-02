/**
 * 
 */
package net.wedjaa.wetnet.business.dao;

import java.util.Date;
import java.util.List;

import net.wedjaa.wetnet.business.domain.DayStatisticJoinMeasures;

/**
 * @author massimo ricci
 *
 */
public interface MeasuresDayStatisticDAO {

    public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasures(Date startDate, Date endDate, long idMeasures);

    /*GC 04/11/2015*/
	public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresAvg(Date startDate, Date endDate, long idMeasures);

	/* GC 18/11/2015*/
	 public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresonMonths(Date startDate, Date endDate, long idMeasures);
	 public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresonYears(Date startDate, Date endDate, long idMeasures);

	 /*09/02/2017*/
	public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedGiornoAVG(Date startDate, Date endDate,
			long idMeasures);
	public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedSettimanaAVG(Date startDate, Date endDate,
			long idMeasures);
	public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedMeseAVG(Date startDate, Date endDate,
			long idMeasures);
	public List<DayStatisticJoinMeasures> getDayStatisticJoinMeasuresOnTimebasedAnnoAVG(Date startDate, Date endDate,
			long idMeasures);


}
