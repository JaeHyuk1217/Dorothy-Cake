package com.dorothy.admin.goods.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dorothy.admin.goods.dao.AdminGoodsDao;
import com.dorothy.common.file.FileUploadUtil;
import com.dorothy.member.goods.vo.MemberGoodsVO;
import com.dorothy.member.order.customOrder.vo.CustomOrderBoardVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AdminGoodsServiceImpl implements AdminGoodsService {

	private AdminGoodsDao adminGoodsDao;
	@Override
	public List<MemberGoodsVO> goodsList(MemberGoodsVO gvo) {
		List<MemberGoodsVO> list = adminGoodsDao.goodsList(gvo);
		return list;
	}
	
	@Override
	public int goodsListCnt(MemberGoodsVO gvo) {
		return adminGoodsDao.goodsListCnt(gvo);
	}

	@Override
	public MemberGoodsVO goodsDetail(MemberGoodsVO gvo) {
		MemberGoodsVO detail = adminGoodsDao.goodsDetail(gvo);
		return detail;
	}

	@Override
	public int goodsDelete(MemberGoodsVO gvo) throws Exception {
		int result = 0;
		
		if(!gvo.getG_file().isEmpty()) {
			FileUploadUtil.fileDelete(gvo.getG_file());
		}
		
		result = adminGoodsDao.goodsDelete(gvo);
		return result;
	}

	@Override
	public MemberGoodsVO goodsUpateForm(MemberGoodsVO gvo) throws Exception {
		MemberGoodsVO updateData = null;
		updateData = adminGoodsDao.goodsDetail(gvo);
		return updateData;
	}

	@Override
	public int goodsUpdate(MemberGoodsVO gvo) throws Exception {
		int result = 0;
		
		if(!gvo.getFile().isEmpty()) {
			if(!gvo.getG_file().isEmpty()) {
				FileUploadUtil.fileDelete(gvo.getG_file());
			}
			
			String fileName = FileUploadUtil.fileUpload(gvo.getFile(), "goods");
			gvo.setG_file(fileName);
		}
		result = adminGoodsDao.goodsUpdate(gvo);
		return result;
	}

	@Override
	public int goodsInsert(MemberGoodsVO gvo) throws Exception {
		int result = 0;
		
		if(gvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(gvo.getFile(), "goods");
			gvo.setG_file(fileName);
		}
		
		result = adminGoodsDao.goodsInsert(gvo);
		return result;
	}

	@Override
	public int deleteAll(String[] numArr) throws IOException {
		int result = 0;
		
		for(int i = 0 ; i < numArr.length ; i++) {
			int g_code = Integer.parseInt(numArr[i]);
			MemberGoodsVO gvo = adminGoodsDao.deleteVO(g_code);
			
			if(!gvo.getG_file().isEmpty()) {
				FileUploadUtil.fileDelete(gvo.getG_file());
			}
			
			result += adminGoodsDao.goodsDelete(gvo);
		}
		
		return result;
	}

	@Override
	public List<MemberGoodsVO> goodsListExcel(MemberGoodsVO gvo) {
		List<MemberGoodsVO> list = adminGoodsDao.goodsListExcel(gvo);
		return list;
	}
	

	@Override
	public int customOrderGoodsInsert(MemberGoodsVO mgvo) throws Exception {
		int result = 0;
		
		if(mgvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(mgvo.getFile(), "goods");
			mgvo.setG_file(fileName);
		}
		
		result = adminGoodsDao.customOrderGoodsInsert(mgvo);
		return result;
	}

	@Override
	public int getCode(CustomOrderBoardVO cobvo) {
		int g_code;
		g_code = adminGoodsDao.getCode(cobvo);
		return g_code;
	}

}
