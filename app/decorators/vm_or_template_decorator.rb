class VmOrTemplateDecorator < MiqDecorator
  def self.fonticon
    'pficon pficon-virtual-machine'
  end

  def fonticon
    nil
  end

  def fileicon
    "svg/vendor-#{vendor.downcase}.svg"
  end

  def quadicon(settings = {})
    show_compliance = settings[:show_compliance] && settings[:policies].present?
    {
      :top_left     => {
        :fileicon => os_image,
        :tooltip  => os_image_name.humanize.downcase
      },
      :top_right    => {
        :fileicon   => "svg/currentstate-#{ERB::Util.h(normalized_state.downcase)}.svg",
        :tooltip    => normalized_state
      },
      :bottom_left  => {
        :fileicon => fileicon,
        :tooltip  => type
      },
      :bottom_right => show_compliance ? compliance_image(settings[:policies].keys) : total_snapshots
    }
  end

  private

  def os_image
    "svg/os-#{ERB::Util.h(os_image_name.downcase)}.svg"
  end
end
