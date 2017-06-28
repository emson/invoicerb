# encoding: UTF-8
module Invoicerb
  class RendererPdf
    SIZE = 8

    def build(formatter, config_hash, invoice_type, output_file='output.pdf')
      @formatter = formatter
      title(invoice_type)
      invoice_details
      contact
      description
      items_table(@formatter.jobs, @formatter.totals)
      payment_details
      footer
      pdf.render_file(output_file)
    end

    def description
      pdf.move_down 20
      pdf.font_size(SIZE) do
        pdf.text @formatter.description
      end
    end

    def items_table(jobs, totals)
      data = [['Qty', 'Unit', 'Description', 'Discount', 'Price', 'Total']]
      data = data + jobs
      data = data + totals
      pdf.move_down 20
      pdf.font_size(SIZE) do
        # pdf.table(data, :position => :center, :row_colors => ["FFFFFF"], :header => true, :width => 540, :column_widths => {0=>5,1=>5,2=>290,3=>40,4=>50,5=>50}) do
        pdf.table(data, :position => :left, :row_colors => ["FFFFFF"], :header => true, :width => 520, column_widths: [30,30,310,40,50,60]) do
          # set table header
          row(0).borders = [:bottom]
          row(0).border_width = 2
          row(0).font_style = :bold
          # underline each item row
          (1..data.size - 1).each do |i|
            row(i).borders = [:bottom]
          end
          # change formatting for the totals rows
          row_start = data.size - 4
          row_end   = data.size - 1
          row(row_start..row_end).borders = []
          # underline the grand total cells in bold
          cols = cells.columns(3..-1)
          selected_cells = cols.rows(data.size - 2..-1)
          selected_cells.borders = [:bottom]
          selected_cells.border_width = 2
        end
      end
    end

    def data_invoice_details
      @formatter.invoice_details
    end

    def data_client
      @formatter.contact
    end

    # def bounding_box
    #   pdf.bounding_box([10, pdf.cursor], :width => 400, :height => pdf.cursor) do
    #     pdf.transparent(0.5) { pdf.stroke_bounds }
    #     pdf.text "Inside box"
    #   end
    # end

    def title(invoice_type='Invoice')
      pdf.text "<b>#{invoice_type}</b>", size:20, inline_format:true
    end

    def invoice_details
      pdf.stroke_horizontal_rule
      pdf.move_down 5
      pdf.font_size(SIZE) do
        pdf.table(data_invoice_details, :row_colors => ["FFFFFF"],  :column_widths => {0=>100, 1=>100}) do
          cells.borders = []
          cells.padding = 0
          cells.align = :left
        end
      end
      pdf.move_down 5
      pdf.stroke_horizontal_rule
    end

    def contact
      pdf.move_down 20
      pdf.font_size(SIZE) do
        pdf.table(data_client, :row_colors => ["FFFFFF"], :width => pdf.bounds.width) do
          cells.borders = []
          cells.padding = 0
        end
      end
    end


    def payment_details
      pdf.bounding_box([0, 100], :width => pdf.bounds.width, :height => 120) do
        pdf.stroke_horizontal_rule
        pdf.font_size(SIZE) do
          pdf.pad(20) do
            pdf.text(load_template('company.erb'), :align => :center, inline_format:true)
          end
        end
      end
    end

    def load_template(filename)
      filename = File.join([templates_dir, filename])
      ERB.new(File.read(filename)).result
    end

    def templates_dir
      begin
        templates = Config.instance.default_config_templates
      rescue
        raise "Please create a templates variable in your config.yml"
      end
      raise "The templates directory does not exist. Check that \"#{templates}\" directory has been created." unless File.exists?(templates)
      templates
    end

    def footer
      pdf.font_size(SIZE) do
        pdf.number_pages("Page <page> of <total>", {:at => [pdf.bounds.right - 150, 0], :align => :right})
      end
    end

    def date
      DateTime.now.strftime('%F')
    end

    def pdf
      @pdf ||= Prawn::Document.new(:page_size => "A4")
    end
  end

end
