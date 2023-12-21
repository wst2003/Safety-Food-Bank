package cn.tju.sse.spring_backend.repository.cus.indent;

import cn.tju.sse.spring_backend.model.CommodityEntity;

import org.springframework.data.jpa.repository.JpaRepository;

public interface IndentCommodityRepository  extends JpaRepository<CommodityEntity,Integer> {
}
