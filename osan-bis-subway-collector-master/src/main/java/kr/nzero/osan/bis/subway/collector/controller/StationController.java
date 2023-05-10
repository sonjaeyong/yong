package kr.nzero.osan.bis.subway.collector.controller;

import kr.nzero.osan.bis.subway.collector.entity.StationVo;
import kr.nzero.osan.bis.subway.collector.mapper.SetMapper;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import javax.annotation.PostConstruct;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

@Controller
@PropertySource("classpath:config.properties") //키 값 경로
@Slf4j
public class StationController {

    @Autowired
    private SetMapper setMapper;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Value("${apikey}") //키 값 가져오기
    private String apikey;
    @Scheduled(cron = "*/60 * * * * *") //60초마다 api 호출
    public void getStationInfo(){
        System.out.println("---------- 결과 ----------");
        try{
            logger.info("----- 1호선 지하철 실시간 위치정보 호출 시작 -----");
            String str = "";
            StringBuilder urlBuilder = new StringBuilder("http://swopenAPI.seoul.go.kr/api/subway");
            urlBuilder.append("/" +  URLEncoder.encode(apikey,"UTF-8") );
            for (String s : Arrays.asList("json", "realtimePosition", "0", "100", "1호선")) {
                urlBuilder.append("/" +  URLEncoder.encode(s,"UTF-8") );
            }

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;

            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();
            str = sb.toString();
            JSONParser parser = new JSONParser(); //JSON 데이터 파싱 객체 생성
            JSONObject object = (JSONObject) parser.parse(str); //호출 결과 파싱
            System.out.println("object: "+str); //파싱 결과 출력
            JSONArray realtimePositionList = (JSONArray) object.get("realtimePositionList"); //파싱 결과 중 위치 정보만 가져오기

            Set<StationVo> voSet = new HashSet<>();
            List<StationVo> checkList = new ArrayList<>();
            List<StationVo> uniqueList = new ArrayList<>();

            for(int i=0; i<realtimePositionList.size(); i++){
                //jsonobject 객체에 실시간위치정보 담음
                object = (JSONObject) realtimePositionList.get(i);

                StationVo vo = new StationVo((String) object.get("subwayId"),
                        (String) object.get("statnId"),
                        (String) object.get("statnNm"),
                        "1호선");
                checkList.add(vo);
            }

            uniqueList = removeDuplicates(checkList);
            for(StationVo station : uniqueList){

                StationVo lastVo = new StationVo(station.getSubwayId(),
                        station.getStatnId(),
                        station.getStatnNm(),
                        station.getSubNm());
                setMapper.getStationInfo(lastVo);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        logger.info("----- 호출종료 -----");
    }
    //중복 제거 메소드
    public List<StationVo> removeDuplicates(List<StationVo> check){
        List<StationVo> process = new ArrayList<>();

        for(StationVo station : check){
            boolean isDuplicate = false;
            for(StationVo pp : process){
                if(station.getStatnId().equals(pp.getStatnId())){
                    isDuplicate = true;
                    break;
                }
            }
            if(!isDuplicate){
                process.add(station);
            }
        }
        return process;
    }
}
