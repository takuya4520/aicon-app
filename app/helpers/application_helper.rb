module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-info"
    when :alert  then "bg-warning"
    when :error  then "bg-error"
    else "bg-success"
    end
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults')
    options.reverse_merge!(defaults)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('og_image.png')
    configs = {
      separator: '|',
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url('favicon.png')
      },
      og: {
        type: 'website',
        title: title.presence || site,
        description:,
        url: request.original_url,
        image:,
        site_name: site
      },
      twitter: {
        site: '@takuywater',
        card: 'summary_large_image',
        image:
      }
    }
    set_meta_tags(configs)
  end
end
