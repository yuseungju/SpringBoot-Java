package com.gnbang.webserver.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnbang.webserver.mapper.ConsultMapper;

@Service
public class ConsultService {

	private final static Logger logger = LoggerFactory.getLogger(ConsultService.class);
	
	@Autowired
	private ConsultMapper consultMapper;
	
}
