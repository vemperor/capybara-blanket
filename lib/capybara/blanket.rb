require "capybara/blanket/version"

module Capybara
  module Blanket
    autoload 'CoverageData', 'capybara/blanket/coverage_data'
    autoload 'Extractor', 'capybara/blanket/extractor'
    autoload 'ReportGenerator', 'capybara/blanket/report_generator'

    class << self
      @@coverage_data = CoverageData.new

      def coverage_data
        @@coverage_data
      end

      def reset!
        @@coverage_data = CoverageData.new
      end

      def method_missing *args
        self.coverage_data.send(*args)
      end

      def extract_from page
        page_data = Extractor.extract page
        @@coverage_data.accrue! page_data
        return page_data
      end

      def coverage
        total_lines = 0
        covered_lines = 0
        self.files.each do |filename, linedata|
          linedata.compact.each do |cov_stat|
            if cov_stat > 0
              covered_lines += 1
            end
            total_lines += 1
          end
        end
        if total_lines > 0
          return ((covered_lines.to_f / total_lines)*100).round(2)
        else
          return 0.0
        end
      end

      def write_report
        FileUtils.mkdir_p 'coverage'
        Capybara::Blanket.write_html_report 'coverage/javascript_coverage.html'
      end

      def write_html_report path
        generator = ReportGenerator.new(:html, self)
        File.open(path, 'w') do |file|
          file.write(generator.render)
        end
      end
    end
  end
end