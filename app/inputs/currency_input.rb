class CurrencyInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_options = input_html_options.merge({data: {autonumeric: {vMin: 0.00, vMax: 10000000000000.00}}})
    merged_input_options = merge_wrapper_options(input_options, wrapper_options)

    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.text_field(attribute_name, merged_input_options)
    end
  end
end