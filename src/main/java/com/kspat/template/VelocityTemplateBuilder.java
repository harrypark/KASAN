package com.kspat.template;

import java.util.Map;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.ui.velocity.VelocityEngineUtils;

public class VelocityTemplateBuilder implements TemplateBuilder {

	/** The velocity engine.2 */
	private VelocityEngine velocityEngine;

	/** The encoding. */
	private String encoding = "UTF-8";

	/**
	 * Sets the velocity engine.
	 *
	 * @param velocityEngine the new velocity engine
	 */
	public void setVelocityEngine(VelocityEngine velocityEngine) {
		this.velocityEngine = velocityEngine;
	}

	/**
	 * Sets the encoding.
	 *
	 * @param encoding the new encoding
	 */
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	/* (non-Javadoc)
	 * @see com.samsung.dbm.template.TemplateBuilder#merge(java.lang.String, java.util.Map)
	 */
	@SuppressWarnings("rawtypes")
	public String merge(String templateName, Map model) {
		return VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, templateName, encoding, model);
	}

}
