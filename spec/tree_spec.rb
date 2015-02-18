require 'spec_helper'

RSpec.describe Tree do
  let(:tree) { Tree.new('parent') }

  describe 'Initialization' do
    it 'assigns data' do
      expect(tree.data).to eq 'parent'
    end

    it 'has an empty array of children' do
      expect(tree.children).to eq []
    end

    it 'has no parent' do
      expect(tree.parent).to be_nil
    end
  end

  describe 'Methods' do
    describe '#add' do
      before { tree.add('child') }

      it 'adds a new tree children' do
        expect(tree.children.first).to be_a Tree
      end

      it 'adds data to the child tree' do
        expect(tree.children.first.data).to eq 'child'
      end

      it 'references itself as parent in the children' do
        expect(tree.children.first.parent).to eq tree
      end
    end

    describe '#remove' do
      context 'tree is the parent' do
        it 'sets data to nil' do
          tree.remove('parent')
          expect(tree.data).to be_nil
        end

        it 'removes all the children', f: true do
          tree.add('child')
          tree.remove('parent')
          expect(tree.children).to eq []
        end
      end

      context 'tree is a child' do
        before { tree.add('child') }

        it 'removes the child' do
          expect {
            tree.remove('child')
          }.to change(tree.children, :size).by(-1)
        end
      end
    end

    describe '#root?' do
      context 'tree is root' do
        it 'returns true' do
          expect(tree.root?).to be_truthy
        end
      end

      context 'tree is not root' do
        before { tree.add('child') }

        it 'returns false' do
          expect(tree.children.first.root?).to be_falsey
        end
      end
    end
  end
end
