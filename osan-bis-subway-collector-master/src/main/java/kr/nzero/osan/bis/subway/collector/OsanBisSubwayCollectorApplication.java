package kr.nzero.osan.bis.subway.collector;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
@EnableScheduling
@MapperScan(value = {"kr.nzero.osan.bis.subway.collector.mapper"})
@SpringBootApplication
public class OsanBisSubwayCollectorApplication {
	public static void main(String[] args) {
		SpringApplication.run(OsanBisSubwayCollectorApplication.class, args);
	}

}
