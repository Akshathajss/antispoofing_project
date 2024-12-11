% LBPmanually.m
%block average lbp
function lbpImage =LBPmanually(img)
 % Convert image to grayscale if it's not already
        % Get the dimensions of the imageP
        [rows, cols] = size(img);
        
        % Initialize the LBP image
        lbpImage = zeros(rows-1, cols-1); % LBP will be of size (rows-2) x (cols-2)
        
        % Compute the LBP manually using a 3x3 neighborhood
        
        for j = 2:rows-2
            for i = 2:cols-2
                B1=round((img(j,i)+img(j,i-1)+img(j-1,i)+img(j-1,i-1))/4);
                B2=round((img(j,i)+img(j,i+1)+img(j-1,i)+img(j-1,i+1))/4);
                B3=round((img(j,i+1)+img(j-1,i+1)+img(j,i+2)+img(j-1,i+2))/4);
                B4=round((img(j,i)+img(j,i-1)+img(j+1,i)+img(j+1,i-1))/4);
                B5=round((img(j,i)+img(j,i+1)+img(j+1,i)+img(j+1,i+1))/4);
                B6=round((img(j,i+1)+img(j+1,i+1)+img(j,i+2)+img(j+1,i+2))/4);
                B7=round((img(j+1,i)+img(j+1,i-1)+img(j+2,i)+img(j+2,i-1))/4);
                B8=round((img(j+1,i)+img(j+1,i+1)+img(j+2,i)+img(j+2,i+1))/4);
                B9=round((img(j+1,i+1)+img(j+1,i+2)+img(j+2,i+1)+img(j+2,i+2))/4);
                center = B5;
                if center < B1
                    i1 = 1;
                else
                    i1= 0;
                end        
                if center < B2
                    i2= 1;
                else
                    i2 = 0;
                end
                if center <B3
                    i3 = 1;
                else
                    i3 = 0;
                end        
                if center <B6
                    i4 = 1;
                else
                    i4 = 0;
                end 
                if center <B9
                    i5 = 1;
                else
                    i5 = 0;
                end 
                if center <B8
                    i6 = 1;
                else
                    i6 = 0;
                end 
                if center <B7
                    i7 = 1;
                else
                    i7 = 0;
                end 
                if center <B4
                    i8 = 1;
                else
                    i8 = 0;
                end
                lbpImage(j,i) = 2^(7)*i1+2^(6)*i2+2^(5)*i3+2^(4)*i4+2^(3)*i5+2^(2)*i6+2^(1)*i7+2^(0)*i8; 
            end
        end
end
%h1=histogram(lbpImage,59);
%values=h1.Values;
%values
