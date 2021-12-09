shared_examples "aoc_challenge_part1_example" do |part1_res|
  before(:each) do
    path = File.join(__dir__, "../fixtures/#{described_class.to_s.downcase}_example.txt")
    allow(File).to receive(:read).and_return(File.read(path))
    allow(File).to receive(:open).and_return(File.open(path))
  end
  
  context "part1" do
    it "should return #{part1_res} with example input" do
        expect(described_class.part1).to be == part1_res
    end
  end
end

shared_examples "aoc_challenge_part2_example" do |part2_res|
  before(:each) do
    path = File.join(__dir__, "../fixtures/#{described_class.to_s.downcase}_example.txt")
    allow(File).to receive(:read).and_return(File.read(path))
    allow(File).to receive(:open).and_return(File.open(path))
  end

  context "part2" do
      it "should return #{part2_res} with example input" do
          expect(described_class.part2).to be == part2_res
      end
  end
end

shared_examples "aoc_challenge_part1_real_input" do |part1_res|
  context "part1" do
    it "should return #{part1_res} with real input" do
        expect(described_class.part1).to be == part1_res
    end
  end
end

shared_examples "aoc_challenge_part2_real_input" do |part2_res|
  context "part2" do
      it "should return #{part2_res} with real input" do
          expect(described_class.part2).to be == part2_res
      end
  end
end