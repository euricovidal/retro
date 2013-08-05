# encoding : utf-8
require 'spec_helper'

describe Retrospectives::BadsController do

  before { controller.session[:user_id] = FactoryGirl.create(:user).id }

  describe "#to_good" do
    subject { get :to_good, retrospective_id: params_stub[:retrospective_id], id: params_stub[:id] }


    context 'success' do
      let(:params_stub) { { :id => 123, :retrospective_id => 456 } }
      let(:bad)   { FactoryGirl.create(:bad, id: params_stub[:id], retrospective_id: params_stub[:retrospective_id]) }
    #  let(:good)  { FactoryGirl.build(:good) }


      before do
        Retrospectives::BadsController.stub(:params).and_return(params_stub)
#        Good.stub(:new).and_return(good)
      end

    it 'aew' do
      require 'pry'; binding.pry
    end

      it 'retrospective id should be equal from the bad' do

        good.retrospective_id.shoud eql bad.retrospective_id
        subject
      end
    end
  end

  #def to_good
  #  bad = Bad.find(params[:id])
  #  good = Good.new
  #  good.retrospective_id = params[:retrospective_id]
  #  good.description = "Corrigido: #{bad.description}!"
  #  good.votes = bad.votes
  #  bad.destroy
  #  raise RuntimeError, "Erro ao mover post-it" unless good.save
  #  redirect_to retrospective_path(params[:retrospective_id])
  #end

  describe "GET keep" do
    subject { get :keep, retrospective_id: params_stub[:retrospective_id], id: params_stub[:id] }

    context "with invalid attributes" do
      let(:params_stub) { { :id => "", :retrospective_id => "" } }

      #it 'should not keep the bad post-it' do
        #expect { subject }.to_not change(Bad, :count)
      #end

      #its(:status)	{ should eq 500 }
      #its(:body)	{ should include "Error" }
    end

    context "with valid attributes" do
      let(:params_stub) { { :id => "4567", :retrospective_id => 120 } }
      let(:bad)		{ Bad.new(:id => params_stub[:id], :retrospective_id => params_stub[:retrospective_id]) }

      before do
        Retrospectives::BadsController.stub(:params).and_return(params_stub)
        Bad.stub(:find).with(params_stub[:id]).and_return(bad)
        bad.stub(:save).and_return(true)
      end

      it 'should find Bad by id' do
	Bad.should_receive(:find).with(params_stub[:id])
	subject
      end

      it 'should assign retrospective_id' do
        subject
        bad.retrospective_id.should eq params_stub[:retrospective_id]
      end

      it 'should preffix description' do
       bad.should_receive(:preffix_description!).once
       subject
      end

      it 'should call keep method' do
       bad.should_receive(:keep!).once
       subject
      end

      it 'should save bad' do
        bad.should_receive(:save).once
        subject
      end

      it 'should redirect to retrospective_path' do
        subject.should redirect_to retrospective_path(params_stub[:retrospective_id])
      end

      its(:status) { should eq 302 }

      context 'when save returns false' do

        before do
          bad.stub(:save).and_return(false)
        end

        #its (:status) { should eq 500 }
      end
    end
  end
end
