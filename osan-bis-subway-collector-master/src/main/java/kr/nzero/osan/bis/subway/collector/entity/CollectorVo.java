package kr.nzero.osan.bis.subway.collector.entity;
import javax.persistence.Id;

import lombok.*;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "ARRIVAL_HISTORY_DEMO")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CollectorVo {
    @Id
    @Column(name = "TRAIN_NO")
    private String TRAIN_NO;
    @Column(name = "STATION_NAME")
    private String STATION_NAME;
    @Column(name = "RECEPTION_DATE")
    private Timestamp RECEPTION_DATE;
    @Column(name = "CURRENT_STATION")
    private String CURRENT_STATION;
    @Column(name = "EXPRESS_YN")
    private String EXPRESS_YN;
    @Column(name = "REMAINING_STATIONS_COUNT")
    private int REMAINING_STATIONS_COUNT;
    @Column(name = "SUBWAY_NAME")
    private String SUBWAY_NAME;
    @Column(name = "TRAIN_LINE_NAME")
    private String TRAIN_LINE_NAME;
    @Column(name = "UP_DOWN_LINE")
    private String UP_DOWN_LINE;

    @Builder
    public CollectorVo(String TRAIN_NO, String STATION_NAME, Timestamp RECEPTION_DATE, String CURRENT_STATION, String EXPRESS_YN,
                       Integer REMAINING_STATIONS_COUNT, String SUBWAY_NAME, String TRAIN_LINE_NAME, String UP_DOWN_LINE) {
        this.TRAIN_NO = TRAIN_NO;
        this.STATION_NAME = STATION_NAME;
        this.RECEPTION_DATE = RECEPTION_DATE;
        this.CURRENT_STATION = CURRENT_STATION;
        this.EXPRESS_YN = EXPRESS_YN;
        this.REMAINING_STATIONS_COUNT = REMAINING_STATIONS_COUNT;
        this.SUBWAY_NAME = SUBWAY_NAME;
        this.TRAIN_LINE_NAME = TRAIN_LINE_NAME;
        this.UP_DOWN_LINE = UP_DOWN_LINE;
    }
}
