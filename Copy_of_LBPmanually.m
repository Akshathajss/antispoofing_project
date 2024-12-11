% LBPmanually.m

function lbpImage =LBPmanually(img)
 % Convert image to grayscale if it's not already
        if size(img,3) == 3
            grey_img = img;
        end
        % Get the dimensions of the imageP
        [rows, cols] = size(grey_img);
        % Initialize the LBP image
        lbpImage = zeros(rows, cols); % LBP will be of size (rows-2) x (cols-2) 
        % Compute the LBP manually using a 3x3 neighborhood
        for j = 2:rows-1
            for i = 2:cols-1
                if j1 == rows-1 && i1 == cols-1
                    j=j1-1;
                    i=i1;
                elseif j1 == rows-1
                    j=j1 +1;
                    i=i1;
                elseif i1 == cols-1
                    i=i1 -1;
                    j=j1;
                else
                    i=i1;
                    j=j1;
                end
                center = grey_img( j,i);
        
                if center < grey_img(j-1,i-1)
                    i1 = 1;
                else
                    i1= 0;
                end        
                if center < grey_img(j-1,i)
                    i2= 1;
                else
                    i2 = 0;
                end
                if center <grey_img( j-1,i+1)
                    i3 = 1;
                else
                    i3 = 0;
                end        
                if center <grey_img( j,i-1)
                    i4 = 1;
                else
                    i4 = 0;
                end 
                if center <grey_img( j,i+1)
                    i5 = 1;
                else
                    i5 = 0;
                end 
                if center <grey_img( j+1,i-1)
                    i6 = 1;
                else
                    i6 = 0;
                end 
                if center <grey_img( j+1,i)
                    i7 = 1;
                else
                    i7 = 0;
                end 
                if center <grey_img(j+1, i+1)
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
