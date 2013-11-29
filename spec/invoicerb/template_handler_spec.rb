require 'spec_helper'

module Invoicerb
  describe TemplateHandler do

    subject { TemplateHandler.new }
    let(:tokens) { {} }

    it "should write a template file to the filesystem" do
      source_path = File.join(subject.template_dir, 'invoice', 'invoice_template.rb.mustache')
      target_path = File.join(Dir.home, 'my_file.rb')
      # stub writing to the file system
      File.stub(:open).with(target_path, 'wb').and_return(target_path)
      subject.should_receive(:say).with(target_path)
      subject.write_file(source_path, target_path, tokens)
    end

    it "should write files and dirs to the file system" do
      source = File.join(subject.template_dir, '_name_', 'config.yml')
      target = File.join(Dir.home)
      final_path = File.join([target, 'config.yml'])
      # stub writing to the file system
      File.stub(:open).with(final_path, 'wb').and_return(final_path)
      subject.write_file_system(source, target, tokens)
    end

    context 'TemplateHandler#replace_token' do

      it "should replace tokens" do
        subject.replace_token('Hello _name_ how are you', 'sausage').should == 'Hello sausage how are you'
      end

      it "should replace tokens from token parameter" do
        subject.replace_token('Hello Ben how are you', 'sausage', 'Ben').should == 'Hello sausage how are you'
      end

    end

    context 'TemplateHandler#path_strip' do

      it "should strip the part of a files path" do
        path = '/some/great/path/to/snoopy_file'
        subject.path_strip(path, '/some/great/path/').should == 'to/snoopy_file'
      end

      it "should strip the template dir" do
        template_dir = '/some/great/path/templates'
        path = File.join([template_dir, 'to', 'snoopy_file'])
        subject.stub(:template_dir).and_return(template_dir)
        subject.path_strip(path).should == '/to/snoopy_file'
      end

    end

    context 'TemplateHandler#create_file' do

      let(:destination) { File.join([Dir.home, 'invoicerb_tests', 'snoopy.rb']) }
      let(:data) { 'Snoopy and Charlie Brown are pals' }

      before(:each) do
        File.stub(:open).with(destination, 'wb')
      end

      it "should create a specified file" do
        FileUtils.should_receive(:mkdir_p).with(File.join([Dir.home, 'invoicerb_tests']))
        subject.should_receive(:say).with(destination)
        subject.create_file(destination, data, tokens)
      end

      it "should not create the file if it exists already" do
        File.should_receive(:exists?).with(destination).and_return(true)
        FileUtils.should_not_receive(:mkdir_p).with(File.join([Dir.home, 'invoicerb_tests']))
        subject.should_receive(:say).with(destination, '  -x ')
        subject.create_file(destination, data, tokens)
      end
    end

  end
end
