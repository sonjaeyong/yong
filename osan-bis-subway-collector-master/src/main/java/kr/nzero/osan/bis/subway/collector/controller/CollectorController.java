package kr.nzero.osan.bis.subway.collector.controller;

import kr.nzero.osan.bis.subway.collector.entity.CollectorVo;
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

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@PropertySource("classpath:config.properties") //키 값 경로
@Slf4j
public class CollectorController {
    @Autowired
    private SetMapper setMapper;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Value("${apikey}") //키 값 가져오기
    private String apikey;

    @Scheduled(cron = "*/60 * * * * *") //60초마다 api 호출
    public void getSubwayArrivalInfo() {
        System.out.println("---------------- 결과 ---------------");
        try{
            setMapper.deleteAllRows();
            logger.info("-----오산역 지하철 도착정보 API 호출 시작 -----");
            //지하철 실시간 도착정보 호출
            String str = "";
            StringBuilder urlBuilder = new StringBuilder("http://swopenAPI.seoul.go.kr/api/subway");
            List<String> strings = Arrays.asList(apikey, "json", "realtimeStationArrival", "0", "10", "오산");
            for (String s : strings) {
                urlBuilder.append("/" +  URLEncoder.encode(s, "UTF-8"));
            }
            System.out.println(urlBuilder);
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode()); // 연결 확인
            BufferedReader rd;

            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) { // 200~300 사이 숫자: 정상
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

            str = sb.toString(); //호출 결과
            JSONParser parser = new JSONParser(); //JSON 데이터 파싱 객체 생성
            JSONObject object = (JSONObject) parser.parse(str); //호출 결과 파싱
            System.out.println("object: "+str); //파싱 결과 출력
            JSONArray realtimeArrivalList = (JSONArray) object.get("realtimeArrivalList"); //파싱 결과 중 도착 정보만 가져오기

            String arvlMsg = "";
            List<String> arvlMsg3List = new ArrayList<>();
            List<String> bstatNmList = new ArrayList<>();
            for(int i=0; i<realtimeArrivalList.size(); i++){ //필요한 데이터만 꺼내오기
                String arvlMsg3 = (String) ((JSONObject) realtimeArrivalList.get(i)).get("arvlMsg3"); //현재 지하철 위치한 역
                arvlMsg3List.add(arvlMsg3);
                String bstatNm = (String) ((JSONObject) realtimeArrivalList.get(i)).get("bstatnNm"); //운행하는 지하철 행선지
                String firstBstNm = bstatNm.split(" ")[0]; //(급행) 제거한 행선지 정보
                bstatNmList.add(firstBstNm);
            }

            //지하철역별 코드 호출
            String str2 = "";
            StringBuilder urlBuilder2 = new StringBuilder("http://openapi.seoul.go.kr:8088");
            List<String> strings2 = Arrays.asList(apikey, "json", "SearchSTNBySubwayLineInfo", "0", "100", "%20", "%20", "1호선");
            for (String s2 : strings2) {
                urlBuilder2.append("/" +  URLEncoder.encode(s2, "UTF-8"));
            }
            System.out.println(urlBuilder2);
            URL url2 = new URL(urlBuilder2.toString());
            HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
            conn2.setRequestMethod("GET");
            conn2.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn2.getResponseCode()); // 연결 확인
            BufferedReader rd2;

            if(conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) { // 200~300 사이 숫자: 정상
                rd2 = new BufferedReader(new InputStreamReader(conn2.getInputStream()));
            } else {
                rd2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream()));
            }
            StringBuilder sb2 = new StringBuilder();
            String line2;
            while ((line2 = rd2.readLine()) != null) {
                sb2.append(line2);
            }
            rd2.close();
            conn2.disconnect();

            str2 = sb2.toString(); //호출 결과
            JSONParser parser2 = new JSONParser(); //JSON 데이터 파싱 객체 생성
            JSONObject object2 = (JSONObject) parser2.parse(str2);
            JSONObject object3 = (JSONObject) parser2.parse(str2);
            //객체형식이라 JSONObject로 선언해야함
            JSONObject searchSTNBySubwayLineInfo = (JSONObject) object2.get("SearchSTNBySubwayLineInfo");
            JSONObject bstInfo = (JSONObject) object3.get("SearchSTNBySubwayLineInfo");
            //배열형식이라 JSONArray로 선언해야함
            JSONArray row = (JSONArray) searchSTNBySubwayLineInfo.get("row");
            JSONArray bstRow = (JSONArray) bstInfo.get("row");
            JSONArray object2List = new JSONArray(); //현재역 코드 가져올 배열
            JSONArray bstObject2List = new JSONArray(); //종착역 코드 가져올 배열

            System.out.println(arvlMsg3List);
            System.out.println(bstatNmList);
            for(int i=0; i<row.size(); i++){ //현재역 중복제거
                Object value = ((JSONObject) row.get(i)).get("STATION_NM");
                if(!arvlMsg3List.contains(value)){
                    row.remove(i);
                    i--;
                }
                else{
                    object2 = (JSONObject) row.get(i);
                    object2List.add(object2);
                }
            }
            for(int j=0; j<bstRow.size(); j++){ //종착지 중복제거
                Object value2 = ((JSONObject) bstRow.get(j)).get("STATION_NM");
                if(!bstatNmList.contains(value2)){
                    bstRow.remove(j);
                    j--;
                }
                else{
                    object3 = (JSONObject) bstRow.get(j);
                    bstObject2List.add(object3);
                }
            }
            for(int i=0; i<realtimeArrivalList.size(); i++){
                String bstatnNm = (String) ((JSONObject) realtimeArrivalList.get(i)).get("bstatnNm"); //목적지가 담긴 키
                String updnLine = (String) ((JSONObject) realtimeArrivalList.get(i)).get("updnLine"); //상,하행 정보가 담긴 키
                String currentStation = (String) ((JSONObject) realtimeArrivalList.get(i)).get("arvlMsg3");

                for(int j=0; j<object2List.size(); j++){ //현재역 코드 객체에 삽입
                    if(((JSONObject) object2List.get(j)).get("STATION_NM").equals(((JSONObject) realtimeArrivalList.get(i)).get("arvlMsg3"))){
                        ((JSONObject) realtimeArrivalList.get(i)).put("stationCd", ((JSONObject) object2List.get(j)).get("STATION_CD"));
                    }
                }
                for(int k=0; k<bstObject2List.size(); k++){ //종착역 코드 객체에 삽입
                    if(((JSONObject) bstObject2List.get(k)).get("STATION_NM").equals(
                            ((String) ((JSONObject) realtimeArrivalList.get(i)).get("bstatnNm")).split(" ")[0])){
                        ((JSONObject) realtimeArrivalList.get(i)).put("endCd", ((JSONObject) bstObject2List.get(k)).get("STATION_CD"));
                    }
                }

                if(currentStation.contains("지제")) ((JSONObject) realtimeArrivalList.get(i)).put("stationCd", "1723");
                else if(currentStation.contains("쌍용")) ((JSONObject) realtimeArrivalList.get(i)).put("stationCd", "1402");

                if(("서동탄".equals(bstatnNm)) || (("병점".equals(bstatnNm))&&("하행".equals(updnLine)))) {
                    continue;
                }
                else {
                    object = (JSONObject) realtimeArrivalList.get(i);
                }
                System.out.println(object);
                String dateStr = (String) object.get("recptnDt");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = dateFormat.parse(dateStr);
                Timestamp timestamp = new Timestamp(date.getTime());

                //급행여부
                String express = "Y";
                if(!"급행".equals(object.get("btrainSttus"))){
                    express = "N";
                }
                //몇전역
                arvlMsg = (String) object.get("arvlMsg2");
                if(!arvlMsg.matches(".*[0-9].*")){
                    if(arvlMsg.contains("전역")){
                        arvlMsg = String.valueOf(1);
                    }
                    else if(arvlMsg.contains("오산")){
                        arvlMsg = String.valueOf(0);
                    }
                }
                else {
                    arvlMsg = arvlMsg.replaceAll("[^0-9]", "");
                }
                //상하행여부
                String updn = "0";
                if(!"상행".equals(object.get("updnLine"))){
                    updn = "1";
                }
                //DB등록 객체 생성
                CollectorVo vo = new CollectorVo(
                        (String) object.get("btrainNo"),
                        (String) object.get("statnNm"),
                        timestamp,
                        (String) object.get("stationCd"),
                        express,
                        Integer.parseInt(arvlMsg),
                        "1호선",
                        (String) object.get("endCd"),
                        updn);
                setMapper.getArrivalInfo(vo);
            }
        } catch(Exception e) {
            logger.error("", e);
        }
        logger.info("----- 호출 종료 -----");
    }
}