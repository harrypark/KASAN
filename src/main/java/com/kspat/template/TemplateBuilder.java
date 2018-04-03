package com.kspat.template;

import java.util.Map;

public interface TemplateBuilder {
	/**
	 * Merge.
	 *
	 * @param templateName the template name
	 * @param model the model
	 * @return the string
	 */
	String merge(String templateName, @SuppressWarnings("rawtypes")
	Map model);
}
