require 'spec_helper'

describe Yao::Designate::Resources::Domain do
  let(:test_domain) { 'yao-designate-test.rollingapple.net.' }
  let(:test_subdomain) { 'sub.' + test_domain }
  let(:test_email) { 'info@yao-designate-test.rollingapple.net' }
  let(:test_recorddata) { '192.0.2.42' }
  let(:test_recorddata2) { '192.0.2.43' }

  shared_context 'with a domain' do |destroy: true|
    let(:domain) { described_class.create(name: test_domain, email: test_email) }
    if destroy
      after do
        described_class.destroy(domain.id)
      end
    end
  end

  shared_context 'with a record' do |destroy: true|
    let(:record) { domain.records.create(name: test_subdomain, type: 'A', data: test_recorddata) }
    if destroy
      after do
        domain.records.destroy(record.id)
      end
    end
  end

  describe '.list' do
    include_context 'with a domain'

    subject { described_class.list }

    it { is_expected.to be_kind_of(Array).and all(be_kind_of(Yao::Designate::Resources::Domain)) }
    its(:size) { is_expected.to be > 0 }
  end

  describe '.create' do
    subject { described_class.create(name: test_domain, email: test_email) }
    after do
      described_class.destroy(subject.id)
    end

    it { is_expected.to be_kind_of Yao::Designate::Resources::Domain }
  end

  describe '.get' do
    include_context 'with a domain'

    subject { described_class.get(domain.id) }

    it { is_expected.to be_kind_of Yao::Designate::Resources::Domain }
  end

  describe '.destroy' do
    include_context 'with a domain', destroy: false

    subject { described_class.destroy(domain.id) }

    it { is_expected.to be_truthy }  # Really??
  end

  describe '#servers' do
    include_context 'with a domain'

    describe '.list' do
      subject { domain.servers.list }

      it { is_expected.to be_kind_of(Array).and all(be_respond_to(:name)) }
    end
  end

  describe '#records' do
    include_context 'with a domain'

    describe '.list' do
      include_context 'with a record'

      subject { domain.records.list }

      it { is_expected.to be_kind_of(Array) }
      its(:size) { is_expected.to be > 0 }
    end

    describe '.update' do
      include_context 'with a record'

      subject { domain.records.update(record.id, data: test_recorddata2) }

      its(:data) { is_expected.to eq test_recorddata2 }
    end

    describe '.destroy' do
      include_context 'with a record', destroy: false

      subject { domain.records.destroy(record.id) }

      it { is_expected.to be_truthy }  # ???
    end
  end
end
