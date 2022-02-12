function diary2html(filename)
% DIARY2HTML Creates a formatted HTML version of a diary file
%   DIARY2HTML(FILENAME) outputs a formatted HTML version of a diary file
%   to an HTML file (e.g. if filename is "diary.txt", the HTML file generated
%   will be "diary.html")

    arguments
       filename (1,:) char {mustBeNonempty}
    end
    
    txt = fileread(filename);
    
    % Display errors in red
    txt = regexprep(txt, {'\{', '\}'}, {'\<span style="color:red"\>', '\<\/span\>'});
    
    % Display warnings in orange
    txt = regexprep(txt, {'\[', '\]'}, {'\<span style="color:darkorange"\>', '\<\/span\>'});
    
    % HTML document template
    txt = ['<meta charset="utf-8">' ... % Use UTF-8 encoding
           '<body style="background-color:whitesmoke">' ...
           '<pre style="font-family:monospace">' ... % Display all white spaces and use a monospaced font, like in the command window
           txt ...
           '</pre>' ...
           '</body>'];
    
    % Output to .html file
    [~, name, ~] = fileparts(filename);
    f = fopen([name '.html'], 'w');
    fwrite(f, unicode2native(txt, 'UTF-8'), 'uint8'); % Get the byte representation of the unicode chars and write bytes to file
    fclose(f);
end