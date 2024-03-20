video = VideoReader("demo.mp4");
static_video = VideoWriter("static_video.mp4", "MPEG-4");
reverse_video = VideoWriter("reverse_video.mp4", "MPEG-4");
open(static_video);
open(reverse_video);
static_T = 75;
reverse_T = 74;
cnt = 0;
written_frames1 = 0;
written_frames2 = 0;

while true
    cnt = cnt + 1;
    if hasFrame(video) == false
        video.CurrentTime = 0;
    end
    frame = readFrame(video);

    if mod(cnt, static_T) == 0
        writeVideo(static_video, frame);
        written_frames1 = written_frames1 + 1;
    end

    if mod(cnt, reverse_T) == 0
        writeVideo(reverse_video, frame);
        written_frames2 = written_frames2 + 1;
    end
    
    if (written_frames1 >= 150) & (written_frames2 >= 150)
        break;
    end
end
close(static_video);
close(reverse_video);
