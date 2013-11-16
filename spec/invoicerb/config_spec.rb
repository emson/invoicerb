require_relative '../spec_helper'

module Invoicerb
  describe Config do

    subject { Config.instance }

    context 'Config#env_*' do

      it "should access the uppercase shell variable SAUSSAGE" do
        # mock the shell variable
        env = { "SAUSSAGE" => 'bratwurst' }
        subject.should_receive(:shell_env).and_return(env)
        # test
        subject.env_saussage.should == 'bratwurst'
      end

      it "should fail if the dynamic method does not start with env_*" do
        expect { subject.nosuch_env_variable }.to raise_error(NameError)
      end

      it "should try a config.yml file if no shell variable exists" do
        # mock the shell variable
        yaml = { "another_saussage" => "hot dog" }
        subject.should_receive(:config).and_return(yaml)
        subject.env_another_saussage.should == 'hot dog'
      end

      it "should raise an error if the variable is not a shell variable or a yaml variable" do
        # assume config/config.yml exists
        yaml = { "another_saussage" => "hot dog" }
        subject.should_receive(:config).and_return(yaml)
        expect{ subject.env_missing_saussage }.to raise_error(StandardError, "MISSING_SAUSSAGE is not a shell variable and 'missing_saussage' is not a YAML config key!")
      end

      it "should raise an error if no env_ variable is provided" do
        expect{ subject.env_ }.to raise_error(StandardError, "No environment variable was specified e.g. config.env_saussage")
      end

    end

  end
end

