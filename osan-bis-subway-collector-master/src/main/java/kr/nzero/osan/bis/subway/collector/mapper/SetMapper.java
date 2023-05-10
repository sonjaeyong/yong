package kr.nzero.osan.bis.subway.collector.mapper;

import kr.nzero.osan.bis.subway.collector.entity.CollectorVo;
import kr.nzero.osan.bis.subway.collector.entity.StationVo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SetMapper {

    //지하철 실시간 도착정보
    @Delete("delete from ARRIVAL_HISTORY_DEMO")
    public void deleteAllRows();
    public void getArrivalInfo(CollectorVo vo);

    //지하철 실시간 위치정보
    public void getStationInfo(StationVo vo);
}
