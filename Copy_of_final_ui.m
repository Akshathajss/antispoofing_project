function projectUI()
    % Main function to launch the first UI screen
    createFirstScreen();
end

function createFirstScreen()
    % Create the first screen for project details
    fig = uifigure('Name', 'Project UI:FACE ANTI-SPOOFING USING BALBP', 'Position', [150, 150, 650, 650]); 
    % Panel to hold content with an outline
    panel = uipanel(fig, 'Title', 'Project Details', ...
        'FontSize', 8, 'Position', [50, 50, 500, 500]);
    txt1 = uicontrol(fig, 'Style', 'text', ...
        'String', '"FACE ANTI-SPOOFING USING BLOCK AVERAGE LOCAL BINARY PATTERN "','FontSize',12,'FontWeight','bold', ...
        'Position', [95.19999999999999,559.5999999999999,396.6100000000001,20],'OuterPosition',[81.19999999999999,426.5900000000001,396.6100000000001,53.00999999999982]);
    txt2 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Developed by: ','FontWeight','bold', ...
        'Position', [306,325.1999999999999,299.9999999999998,20]);
    txt5 = uicontrol(fig, 'Style', 'text', ...
        'String','  Akshatha J S      4JN21IS005     ', ...
        'Position', [304.4,283.2,300,20]);
    txt5 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Ananya S            4JN21IS011', ...
        'Position', [300.4000000000002,263.9999999999998,300.0000000000001,20]);
    txt5 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Nanditha A L        4JN21IS060', ...
        'Position', [300.4,244.8,299.9999999999997,20]);
    txt5 = uicontrol(fig, 'Style', 'text', ...
        'String', ' Nidhishritha B M   4JN21IS063 ', ...
        'Position', [301.2,224.8,300.0000000000003,20]);
    txt3 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Under the guidance of: ','FontWeight','bold', ...
        'Position', [3.599999999999966,322.4,300,20]);
    txt3 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Dr. Raghavendra R.J.', ...
        'Position', [-26.8,285.6,300,20]);
    txt3 = uicontrol(fig, 'Style', 'text', ...
        'String', 'B.E., M.Sc(Engg.), Ph. D', ...
        'Position', [172.0767999999999,271.61936,98.39999999999998,30.780640000000005],'FontSize',6);
    txt3 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Associate Professor & HOD', ...
        'Position', [9.200000000000017,250.4,300,35.190000000000055]);
    txt3 = uicontrol(fig, 'Style', 'text', ...
        'String', 'Department of ISE', ...
        'Position', [-13.799999999999898,247.1999999999999,300,20]);
    txt3 = uicontrol(fig, 'Style', 'text', ...
        'String', 'JNNCE,Shimoga', ...
        'Position', [-18.799999999999983,228.8,300,20]);

    % Next button to go to the second screen
    uibutton(fig, 'Text', 'Next', ...
        'Position', [250, 100, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) createSecondScreen(fig));
end

function createSecondScreen(fig)
    % Close the first screen
    close(fig);

    % Create the second figure
    fig2 = uifigure('Name', 'Image Testing Interface', 'Position', [100, 100, 700, 700]);

    % Load Image Button
    uibutton(fig2, 'Text', 'Load Image', ...
        'Position', [150, 200, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) loadImageAndTest(fig2));

    % Back Button
    uibutton(fig2, 'Text', 'Back', ...
        'Position', [450, 200, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) backToFirstScreen(fig2));

    % Image Display Area
    ax = uiaxes(fig2, 'Position', [200, 350, 350, 250]);
    ax.Tag = 'ImageAxes';
    title(ax, 'Loaded Image');

    % Result display area (axes for colored rectangle)
    resultAx = uiaxes(fig2, 'Position', [280, 50, 150, 150]);
    axis(resultAx, 'off');
    resultAx.Tag = 'ResultAxes';
end

function backToFirstScreen(fig)
    close(fig);
    createFirstScreen();
end

function loadImageAndTest(fig)
    % Load an image file
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'});
    if isequal(file, 0)
        return;
    end
    img = imread(fullfile(path, file));

    % Find the image display axes
    ax = findobj(fig, 'Type', 'axes', 'Tag', 'ImageAxes');
    if isempty(ax) || ~isa(ax, 'matlab.ui.control.UIAxes')
        error('Image display axes not found.');
    end
    imshow(img, 'Parent', ax);

    % Call the model test
    result = testSVMModel(img);

    % Display result in colored rectangle box
    drawResultBox(fig, result);
end

function result = testSVMModel(img)
    % Placeholder function for the SPM model test
    % Random result for demonstration
    if rand() > 0.5
        result = 'Real';
    else
        result = 'Fake';
    end
end

function drawResultBox(fig, result)
    % Find the result axes
    resultAx = findobj(fig, 'Type', 'axes', 'Tag', 'ResultAxes');
    if isempty(resultAx) || ~isa(resultAx, 'matlab.ui.control.UIAxes')
        error('Result display axes not found.');
    end

    % Clear previous drawings
    cla(resultAx);

    % Set rectangle color based on result
    if strcmp(result, 'Real')
        rectangle(resultAx, 'Position', [1 1 150 50], 'FaceColor', 'green', 'EdgeColor', 'black');
    else
        rectangle(resultAx, 'Position', [1 1 150 50], 'FaceColor', 'red', 'EdgeColor', 'black');
    end

    % Display text inside the rectangle
    text(resultAx, 75, 20, sprintf('Result: %s', result), ...
        'HorizontalAlignment', 'center', 'FontSize', 12, 'Color', 'white');
end
