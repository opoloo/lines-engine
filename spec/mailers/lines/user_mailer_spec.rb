require "spec_helper"

module Lines
  describe UserMailer do
    describe "password_reset" do
      let(:user) { FactoryGirl.create(:user) }
      let(:mail) { UserMailer.password_reset(user) }

      before(:each) do
        user.create_reset_digest
      end

      it "renders the headers" do
        mail.subject.should eq("Forgot your LINES password?")
        mail.to.should eq([user.email])
      end

      it "renders the body" do
        mail.body.encoded.should match("password")
      end
    end

  end
end
