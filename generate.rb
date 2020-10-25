`rm -f output/cursors/*`
`mkdir -p output/cursors`
`mkdir -p tmp`

names = Dir["input/*"].map { |input_file| input_file.split("/")[1].split(".")[0] }

names.each do |name|
    `inkscape input/#{name}.svg --export-area-drawing -o tmp/#{name}.png 2>/dev/null`

    hotspot_x=-`inkscape input/#{name}.svg -X 2>/dev/null`.to_i
    hotspot_y=-`inkscape input/#{name}.svg -Y 2>/dev/null`.to_i

    `echo "16 #{hotspot_x} #{hotspot_y} tmp/#{name}.png" | xcursorgen - output/cursors/#{name}`
end

links = {
    "00008160000006810000408080010102" => "v_double_arrow",
    "028006030e0e7ebffc7f7070c0600140" => "h_double_arrow",
    "03b6e0fcb3499374a867c041f52298f0" => "crossed_circle",
    "08e8e1c95fe2fc01f976f1e063a24ccd" => "left_ptr_watch",
    "1081e37283d90000800003c07f3ef6bf" => "copy",
    "14fef782d02440884392942c11205230" => "sb_h_double_arrow",
    "2870a09082c103050810ffdffffe0204" => "sb_v_double_arrow",
    "3085a0e285430894940527032f8b26df" => "link",
    "3ecb610c1bf2410f44200f48c40d3599" => "left_ptr_watch",
    "4498f0e0c1937ffe01fd06f973665830" => "move",
    "5c6cd98b3f3ebcb1f9c7f1c204630408" => "question_arrow",
    "6407b0e94181790501fd1e167b474872" => "copy",
    "640fb0e74195791501fd1ed57b41487f" => "link",
    "9081237383d90e509aa00f00170e968f" => "move",
    "9d800788f1b08800ae810202380a0822" => "hand2",
    "alias" => "dnd-link",
    "arrow" => "left_ptr",
    "c7088f0f3e6c8088236ef8e1e3e70000" => "bd_double_arrow",
    "col-resize" => "sb_h_double_arrow",
    "copy" => "dnd-copy",
    "crosshair" => "cross",
    "cross_reverse" => "cross",
    "d9ce0ab605698f320427677b458ad60b" => "question_arrow",
    "default" => "left_ptr",
    "diamond_cross" => "cross",
    "dot_box_mask" => "dotbox",
    "double_arrow" => "sb_v_double_arrow",
    "draft_large" => "right_ptr",
    "draft_small" => "right_ptr",
    "draped_box" => "dotbox",
    "e29285e634086352946a0e7090d73106" => "hand2",
    "e-resize" => "right_side",
    "ew-resize" => "sb_h_double_arrow",
    "fcf1c3c7cd4491d801f1e1c78f100000" => "fd_double_arrow",
    "fleur" => "all-scroll",
    "grab" => "hand1",
    "hand" => "hand2",
    "h_double_arrow" => "sb_h_double_arrow",
    "help" => "question_arrow",
    "icon" => "dotbox",
    "left_ptr_help" => "question_arrow",
    "ne-resize" => "top_right_corner",
    "nesw-resize" => "fd_double_arrow",
    "no-drop" => "dnd-no-drop",
    "not-allowed" => "crossed_circle",
    "n-resize" => "top_side",
    "ns-resize" => "sb_v_double_arrow",
    "nw-resize" => "top_left_corner",
    "nwse-resize" => "bd_double_arrow",
    "pirate" => "X_cursor",
    "pointer" => "hand",
    "progress" => "left_ptr_watch",
    "row-resize" => "sb_v_double_arrow",
    "se-resize" => "bottom_right_corner",
    "size_all" => "fleur",
    "size_bdiag" => "fd_double_arrow",
    "size_fdiag" => "bd_double_arrow",
    "size_hor" => "h_double_arrow",
    "size_ver" => "v_double_arrow",
    "s-resize" => "bottom_side",
    "sw-resize" => "bottom_left_corner",
    "target" => "dotbox",
    "text" => "xterm",
    "top_left_arrow" => "left_ptr",
    "v_double_arrow" => "sb_v_double_arrow",
    "wait" => "watch",
    "w-resize" => "left_side",
}

links.each do |name, target|
    `ln -sf #{target} output/cursors/#{name}`
end

required = [
    "all-scroll",
    "bd_double_arrow",
    "bottom_left_corner",
    "bottom_right_corner",
    "bottom_side",
    "bottom_tee",
    "cell",
    "circle",
    "context-menu",
    "cross",
    "crossed_circle",
    "dnd-ask",
    "dnd-copy",
    "dnd-link",
    "dnd-move",
    "dnd-no-drop",
    "dnd-none",
    "dotbox",
    "fd_double_arrow",
    "grabbing",
    "hand1",
    "hand2",
    "left_ptr",
    "left_ptr_watch",
    "left_side",
    "left_tee",
    "link",
    "ll_angle",
    "lr_angle",
    "move",
    "pencil",
    "plus",
    "pointer-move",
    "question_arrow",
    "right_ptr",
    "right_side",
    "right_tee",
    "sb_down_arrow",
    "sb_h_double_arrow",
    "sb_left_arrow",
    "sb_right_arrow",
    "sb_up_arrow",
    "sb_v_double_arrow",
    "tcross",
    "top_left_corner",
    "top_right_corner",
    "top_side",
    "top_tee",
    "ul_angle",
    "ur_angle",
    "vertical-text",
    "watch",
    "X_cursor",
    "xterm",
    "zoom-in",
    "zoom-out",
]

(required - names).each do |name|
    puts "Creating fallback for '#{name}'..."
    `convert -fill blue -pointsize 32 label:#{name} tmp/#{name}.png`
    `echo "16 0 0 tmp/#{name}.png" | xcursorgen - output/cursors/#{name}`
end
