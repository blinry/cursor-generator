input = "emoji/input"
output = "emoji/output"

# Clean up.
`rm -f #{output}/cursors/*`
`mkdir -p #{output}/cursors`
`mkdir -p tmp`

# Lists of required cursors and symlinks between cursors taken from
# https://github.com/GNOME/adwaita-icon-theme/tree/master/Adwaita/cursors
required = IO.read("required").split("\n")
links = IO.read("links").split("\n").map{|l| l.split(" ")}

# For each required cursor...
required.each do |name|
    print "#{name}: "

    desc = ""
    if File.exists?("#{input}/#{name}.svg")
        # Either generate it from a SVG:
        print "Generating static image..."
        `inkscape #{input}/#{name}.svg --export-area-drawing -o tmp/#{name}.png 2>/dev/null`

        hotspot_x=-`inkscape #{input}/#{name}.svg -X 2>/dev/null`.to_i
        hotspot_y=-`inkscape #{input}/#{name}.svg -Y 2>/dev/null`.to_i

        desc = "16 #{hotspot_x} #{hotspot_y} tmp/#{name}.png"
    elsif File.exists?("#{input}/#{name}-00.svg")
        # Or from a sequence of SVGs, as an animation:
        print "Generating animation..."
        frames = Dir["#{input}/#{name}-??.svg"]
        desc = []
        frames.each do |frame|
            fullname = frame.split("/")[1].split(".")[0]
            `inkscape #{input}/#{fullname}.svg --export-area-drawing -o tmp/#{fullname}.png 2>/dev/null`
            hotspot_x=[0, -`inkscape #{input}/#{fullname}.svg -X 2>/dev/null`.to_i].max
            hotspot_y=[0,-`inkscape #{input}/#{fullname}.svg -Y 2>/dev/null`.to_i].max
            desc << "16 #{hotspot_x} #{hotspot_y} tmp/#{fullname}.png 100"
        end
        desc = desc.join("\n")
    else
        # Or generate a fallback:
        print "Creating fallback..."
        `convert -fill blue -pointsize 32 label:#{name} tmp/#{name}.png`
        desc = "16 0 0 tmp/#{name}.png"
    end
    STDOUT.flush
    `echo "#{desc}" | xcursorgen - #{output}/cursors/#{name}`
    puts
    STDOUT.flush
end

# Put the symlinks in place.
links.each do |name, target|
    `ln -sf #{target} #{output}/cursors/#{name}`
end
