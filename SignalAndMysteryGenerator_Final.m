
function SignalAndMysteryGenerator


    fig = figure( ...
        'Name','Signal Generator', ...
        'NumberTitle','off', ...
        'WindowState','maximized', ...
        'Color',[0.85 0.85 0.85], ...
        'MenuBar','none');

    t = -5:0.1:5;

    normalFig = [];
    mysteryFig = [];

    baseSignal = [];
    mysterySignal = [];
    currentSignalName = '';

    randomAnswerOps = {};
    customOperations = {};

    grey = [0.85 0.85 0.85];
    buttonGrey = [0.75 0.75 0.75];

    %HEADER

    addText('Signal Generator', ...
        [0.035 0.925 0.65 0.055], 20, true);

    addText('Normal signals and mystery signal generator', ...
        [0.037 0.89 0.7 0.03], 11, false);

    %NORMAL SIGNAL GENERATOR

    addText('Normal Signal Generator', ...
        [0.04 0.825 0.42 0.04], 15, true);

    addText('Select Signal:', ...
        [0.04 0.77 0.15 0.03], 11, false);

    signalMenu = uicontrol(fig, ...
        'Style','popupmenu', ...
        'Units','normalized', ...
        'Position',[0.17 0.765 0.22 0.045], ...
        'String',{'None','Impulse','Step','Ramp','Exponential'}, ...
        'Value',1, ...
        'FontSize',11, ...
        'BackgroundColor',[0.95 0.95 0.95]);

    makeButton('Generate Signal', ...
        [0.41 0.765 0.17 0.045], @generateNormal);

    addText('Select a signal and click Generate Signal.', ...
        [0.04 0.715 0.55 0.03], 10, false);

    %MYSTERY SIGNAL GENERATOR

    addText('Mystery Signal Generator', ...
        [0.04 0.645 0.5 0.04], 15, true);

    makeButton('Generate Mystery Signal', ...
        [0.04 0.575 0.23 0.05], @generateMystery);

    makeButton('Reveal Answer', ...
        [0.29 0.575 0.16 0.05], @revealAnswer);

    addText('Generate a mystery signal and apply operations below.', ...
        [0.04 0.53 0.75 0.03], 10, false);

    %OPERATION BUILDER

    addText('Operations', ...
        [0.04 0.455 0.48 0.04], 13, true);

    addText('Operation:', ...
        [0.04 0.405 0.12 0.03], 11, false);

    operationMenu = uicontrol(fig, ...
        'Style','popupmenu', ...
        'Units','normalized', ...
        'Position',[0.04 0.355 0.25 0.045], ...
        'String',{'Time Reversal','Time Shift', ...
                  'Time Compression','Time Expansion', ...
                  'Amplitude Scaling','DC Addition'}, ...
        'FontSize',11, ...
        'BackgroundColor',[0.95 0.95 0.95]);

    addText('Parameter:', ...
        [0.32 0.405 0.12 0.03], 11, false);

    parameterBox = uicontrol(fig, ...
        'Style','edit', ...
        'Units','normalized', ...
        'Position',[0.32 0.355 0.13 0.045], ...
        'String','1', ...
        'FontSize',11, ...
        'BackgroundColor',[0.95 0.95 0.95]);

    makeButton('Add Operation', ...
        [0.48 0.355 0.17 0.045], @addOperation);

    addText('Operations are applied in the order listed.', ...
        [0.04 0.315 0.5 0.025], 10, false);

    %OPERATION LIST

    addText('Operations List', ...
        [0.04 0.255 0.3 0.035], 12, true);

    operationList = uicontrol(fig, ...
        'Style','listbox', ...
        'Units','normalized', ...
        'Position',[0.04 0.07 0.43 0.17], ...
        'String',{}, ...
        'FontSize',11, ...
        'BackgroundColor',[0.95 0.95 0.95], ...
        'Max',2, ...
        'Min',0);

    %BUTTONS

    makeButton('Remove Selected', ...
        [0.51 0.195 0.19 0.05], @removeOperation);

    makeButton('Clear List', ...
        [0.72 0.195 0.15 0.05], @clearOperations);

    makeButton('Apply Operations', ...
        [0.51 0.125 0.36 0.055], @applyOperations);

    makeButton('Reset Signal', ...
        [0.51 0.055 0.36 0.05], @resetSignal);

    %HELPER FUNCTIONS

    function addText(str,pos,fontSize,isBold)

        if isBold
            weight = 'bold';
        else
            weight = 'normal';
        end

        uicontrol(fig, ...
            'Style','text', ...
            'Units','normalized', ...
            'Position',pos, ...
            'String',str, ...
            'FontSize',fontSize, ...
            'FontWeight',weight, ...
            'ForegroundColor','black', ...
            'BackgroundColor',grey, ...
            'HorizontalAlignment','left');
    end

    function makeButton(str,pos,callback)

        uicontrol(fig, ...
            'Style','pushbutton', ...
            'Units','normalized', ...
            'Position',pos, ...
            'String',str, ...
            'FontSize',11, ...
            'ForegroundColor','black', ...
            'BackgroundColor',buttonGrey, ...
            'Callback',callback);
    end

    %NORMAL SIGNAL

    function generateNormal(~,~)

        choice = signalMenu.Value;

        switch choice
            case 1
                return;

            case 2
                y = double(abs(t)<0.05);

            case 3
                y = double(t>=0);

            case 4
                y = t.*(t>=0);

            case 5
                y = exp(0.5*t);
        end

        if isempty(normalFig) || ~isgraphics(normalFig)
            normalFig = figure( ...
                'Name','Normal Signal Plot', ...
                'NumberTitle','off', ...
                'Color',grey);
        else
            figure(normalFig);
            clf(normalFig);
        end

        plot(t,y,'k','LineWidth',1.2);
        grid on;
        xlabel('Time');
        ylabel('Amplitude');
        title(['Signal: ' signalMenu.String{choice}]);
    end

    %MYSTERY SIGNAL

    function generateMystery(~,~)

        types = {'Impulse','Step','Ramp','Sinusoidal','Exponential'};
        type = randi(5);

        currentSignalName = types{type};

        switch type
            case 1
                baseSignal = double(abs(t)<0.05);

            case 2
                baseSignal = double(t>=0);

            case 3
                baseSignal = t.*(t>=0);

            case 4
                baseSignal = sin(2*pi*0.5*t);

            case 5
                baseSignal = exp(0.3*t);
        end

        mysterySignal = baseSignal;

        randomAnswerOps = {};
        customOperations = {};
        operationList.String = {};

        names = {'Time Reversal','Time Shift', ...
                 'Time Compression','Time Expansion', ...
                 'Amplitude Scaling','DC Addition'};

        selected = randperm(6,randi([2 4]));

        for k = 1:numel(selected)

            op = selected(k);

            switch op
                case 1
                    a = 1;

                case 2
                    a = randi(5)-3;
                    if a == 0
                        a = 1;
                    end

                case {3,4}
                    a = randi([2 3]);

                case 5
                    a = randi([2 5]);

                case 6
                    a = randi(5)-3;
            end

            mysterySignal = transform(mysterySignal,op,a);

            if op == 1
                randomAnswerOps{end+1} = names{op};
            else
                randomAnswerOps{end+1} = ...
                    sprintf('%s (%g)',names{op},a);
            end
        end

        drawPlot(mysterySignal,'Mystery Signal');
    end

    %REVEAL ANSWER

    function revealAnswer(~,~)

        if isempty(baseSignal)
            msgbox('Generate a mystery signal first.');
            return;
        end

        % Display the original mystery signal
        msg = sprintf('Original Signal: %s\n\n', ...
            currentSignalName);

        % Display the random transformations
        msg = [msg 'Random Operations:' newline];

        if isempty(randomAnswerOps)
            msg = [msg 'No random operations were applied.' newline];
        else
            msg = [msg strjoin(randomAnswerOps,newline) newline];
        end

        % Display the operations added by the user
        msg = [msg newline 'Your Added Operations:' newline];

        if isempty(customOperations)
            msg = [msg 'No operations added yet.'];
        else
            msg = [msg strjoin(customOperations,newline)];
        end

        % Display the final operation sequence
        msg = [msg newline newline 'Complete Operation Sequence:' newline];

        completeOperations = [randomAnswerOps customOperations];

        if isempty(completeOperations)
            msg = [msg 'No operations applied.'];
        else
            msg = [msg strjoin(completeOperations,newline)];
        end

        % Open the updated answer popup
        msgbox(msg,'Mystery Signal Answer');
    end

    %ADD OPERATION

    function addOperation(~,~)

        a = str2double(parameterBox.String);

        if ~isfinite(a)
            msgbox('Enter a valid number.');
            return;
        end

        op = operationMenu.Value;
        names = operationMenu.String;

        if op == 1
            entry = names{op};
        else
            entry = sprintf('%s (%g)',names{op},a);
        end

        customOperations{end+1} = entry;

        operationList.String = customOperations;
        operationList.Value = numel(customOperations);
    end

    %REMOVE OPERATION

    function removeOperation(~,~)

        selected = operationList.Value;

        if isempty(customOperations)
            return;
        end

        customOperations(selected) = [];

        operationList.String = customOperations;

        if isempty(customOperations)
            operationList.Value = 1;
        else
            operationList.Value = min(selected,numel(customOperations));
        end
    end

    %CLEAR OPERATIONS

    function clearOperations(~,~)

        customOperations = {};
        operationList.String = {};
    end

    %APPLY OPERATIONS

    function applyOperations(~,~)

        if isempty(baseSignal)
            msgbox('Generate a mystery signal first.');
            return;
        end

        y = baseSignal;

        for k = 1:numel(customOperations)

            entry = customOperations{k};
            op = findOperation(entry);

            if op == 1
                a = 1;
            else
                token = regexp(entry, ...
                    '\((-?\d+\.?\d*)\)','tokens','once');

                if isempty(token)
                    a = 1;
                else
                    a = str2double(token{1});
                end
            end

            if any(op == [3 4]) && a <= 0
                msgbox('Time factors must be positive.');
                return;
            end

            y = transform(y,op,a);
        end

        drawPlot(y,'Signal After Operations');
    end

    %RESET SIGNL
    function resetSignal(~,~)

        if isempty(baseSignal)
            msgbox('Generate a mystery signal first.');
            return;
        end

        customOperations = {};
        operationList.String = {};

        drawPlot(baseSignal,'Original Mystery Signal');
    end

    %FIND OPERATION

    function op = findOperation(entry)

        names = operationMenu.String;
        op = 1;

        for j = 1:numel(names)

            if startsWith(entry,names{j})
                op = j;
                return;
            end
        end
    end

    %TRANSFORM SIGNAL

    function y = transform(y,op,a)

        switch op
            case 1
                y = interp1(t,y,-t,'linear',0);

            case 2
                y = interp1(t,y,t-a,'linear',0);

            case 3
                y = interp1(t,y,a*t,'linear',0);

            case 4
                y = interp1(t,y,t/a,'linear',0);

            case 5
                y = a*y;

            case 6
                y = y+a;
        end
    end

    %PLOT SIGNAL
    function drawPlot(y,plotTitle)

        if isempty(mysteryFig) || ~isgraphics(mysteryFig)
            mysteryFig = figure( ...
                'Name','Mystery Signal Plot', ...
                'NumberTitle','off', ...
                'Color',grey);
        else
            figure(mysteryFig);
            clf(mysteryFig);
        end

        plot(t,y,'k','LineWidth',1.2);
        grid on;
        xlabel('Time');
        ylabel('Amplitude');
        title(plotTitle);
    end

end
