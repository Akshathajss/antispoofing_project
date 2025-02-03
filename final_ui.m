function projectUI()
    % Main function to launch the first UI screen
    createFirstScreen();
end

function createFirstScreen()
    % Create the first screen for project details
    fig = uifigure('Name', 'Project UI', 'Position', [500, 300, 600, 400]);

    % Panel to hold content with an outline
    panel = uipanel(fig, 'Title', 'Project Details', ...
        'FontSize', 14, 'Position', [50, 100, 500, 250]);

    % Title label with bold text inside the panel
    uilabel(panel, 'Text', 'Project Title: Image Authenticity Detection Using SPM', ...
        'Position', [20, 160, 460, 30], 'FontSize', 14, 'FontWeight', 'bold');

    % Project guide information inside the panel
    uilabel(panel, 'Text', 'Project Guide: Dr. John Doe (Professor of AI)', ...
        'Position', [20, 120, 460, 30]);

    % Developer information inside the panel
    uilabel(panel, 'Text', 'Developer: Your Name (Software Engineer)', ...
        'Position', [20, 80, 460, 30]);

    % Next button to go to the second screen
    uibutton(fig, 'Text', 'Next', ...
        'Position', [250, 50, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) createSecondScreen(fig));
end


function createSecondScreen(fig)
    % Close the first screen
    close(fig);

    % Create the second figure
    fig2 = uifigure('Name', 'Image Testing Interface', 'Position', [100, 100, 700, 700]);

    % Load Image Button
    uibutton(fig2, 'Text', 'Load Image', ...
        'Position', [50, 320, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) loadImageAndTest(fig2));

    % Back Button
    uibutton(fig2, 'Text', 'Back', ...
        'Position', [450, 320, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) backToFirstScreen(fig2));

    % Image Display Area
    ax = uiaxes(fig2, 'Position', [200, 100, 350, 250]);
    ax.Tag = 'ImageAxes';
    title(ax, 'Loaded Image');

    % Result display area (axes for colored rectangle)
    resultAx = uiaxes(fig2, 'Position', [250, 50, 150, 40]);
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
