package kr.nzero.osan.bis.subway.collector.entity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Objects;

@Entity
@Table(name = "STATION_DEMO")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class StationVo {

    @Column(name = "SUBWAY_ID")
    private String subwayId;

    @Id
    @Column(name = "STATN_ID")
    private String statnId;

    @Column(name = "STATN_NM")
    private String statnNm;

    @Column(name = "SUB_NM")
    private String subNm;

    @Builder
    public StationVo(String subwayId, String statnId, String statnNm, String subNm) {
        this.subwayId = subwayId;
        this.statnId = statnId;
        this.statnNm = statnNm;
        this.subNm = subNm;
    }

    public String getSubwayId() {
        return subwayId;
    }

    public String getStatnId() {
        return statnId;
    }

    public String getStatnNm() {
        return statnNm;
    }

    public String getSubNm() {
        return subNm;
    }
}
