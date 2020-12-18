function [ newGrStruct ] = GR_Filter( grStruct, gr_options )
%filter all graph
%
%Syntax:
% [ newGrStruct ] = GR_Filter( grStruct, options )
%Arguments:
%   grStruct        -  graphs struct
%   gr_options      -  options struct. See init_gr.
%
%Outputs:
%   newGrStruct     -  new filtered graphs struct
%
% SEE ALSO: GR_SIZE, GR_CREATEGRAPHSTRUCT.
%


%take only cool graph :)

fields = fieldnames(gr_options);
structS = length( fields );

for i = 1 : structS
    status = 1;
    switch (fields{i})
        case 'dl'
            if isempty(gr_options.dl)
                status = 0;
            else
                filtered = ([grStruct(:).Diameter] <= gr_options.dl);
            end
        case 'dg'
            if isempty(gr_options.dg)
                status = 0;
            else
                filtered = ([grStruct(:).Diameter] >= gr_options.dg);
            end
        case 'de'
            if isempty(gr_options.de)
                status = 0;
            else
                filtered = ([grStruct(:).Diameter] == gr_options.de);
            end
        case 'pl'
            if isempty(gr_options.pl)
                status = 0;
            else
                filtered = ([grStruct(:).Power] <= gr_options.pl);
            end
        case 'pg'
            if isempty(gr_options.pg)
                status = 0;
            else
                filtered = ([grStruct(:).Power] >= gr_options.pg);
            end
        case 'pe'
            if isempty(gr_options.pe)
                status = 0;
            else
                filtered = ([grStruct(:).Power] == gr_options.pe);
            end
        case 'el'
            if isempty(gr_options.el)
                status = 0;
            else
                filtered = ([grStruct(:).EdgeCount] <= gr_options.el);
            end
        case 'eg'
            if isempty(gr_options.eg)
                status = 0;
            else
                filtered = ([grStruct(:).EdgeCount] >= gr_options.eg);
            end
        case 'ee'
            if isempty(gr_options.ee)
                status = 0;
            else
                filtered = ([grStruct(:).EdgeCount] == gr_options.ee);
            end
        otherwise
            warning('Unknown params');
            status = 0;
    end
    if status
        grStruct = [grStruct(filtered)];
    end   
end

newGrStruct = grStruct;

end

