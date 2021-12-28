classdef Sort
    properties
        %Order of ball based on detection... so green first, yellow second,
        %orange third, and red fourth.
        green = 0;
        yellow = 1;
        orange = 2;
        red = 3;
        
        %End points for all of the balls
        green_Position = [-150 -90 60];
        orange_Position = [150 100 60];
        red_Position = [-150 100 60];
        yellow_Position = [130 -140 60];
        
        %Will wait at this pose until further instruction
        wait_Pose = [100 0 100];
        
        limit = 25;
    end
    methods
        function [start_Points, end_Points] = sort(obj, colors, points)
           start_Points = [-1 -1 -1];
           end_Points = [-1 -1 -1];
           index = -1;
           for i = 1:size(colors,2)
              %For Green Sorting - Documentation same for other balls
              %Determines if the color is green and if the points are of
              %valid distance based off of the limit and distance
              %parameters of obj.
              if ((colors(i) == obj.green) &&...
                  (obj.distance(obj.green_Position, points(i,:)) > obj.limit))
                      %Next start and end points are defined and the index
                      %is iterated.
                      start_Points = points(i,:);
                      end_Points = obj.green_Position;
                      index = i;
              %For Yellow Sorting
              elseif ((colors(i) == obj.yellow) &&...
                      (obj.distance(obj.yellow_Position,points(i,:)) > obj.limit))
                          start_Points = points(i,:);
                          end_Points = obj.yellow_Position;
                          index = i;
              %For Orange Sorting
              elseif ((colors(i) == obj.orange) &&...
                      (obj.distance(obj.orange_Position,points(i,:)) > obj.limit))
                          start_Points = points(i,:);
                          end_Points = obj.orange_Position;
                          index = i;
              %For Red Sorting
              elseif ((colors(i) == obj.red) &&...
                      (obj.distance(obj.red_Position,points(i,:)) > obj.limit))
                          start_Points = points(i,:);
                          end_Points = obj.red_Position;
                          index = i;
              end
           end
           %% If the index is past sorting all of the balls it will go to its wait pose for new instruction.
           if (index > -1)
               for i = 1:size(colors,2)
                   if ((i ~= index) && (obj.distance(end_Points(1,:),points(i,:)) < obj.limit))
                      start_Points(2,:) = start_Points(1,:);
                      start_Points(1,:) = points(i,:);
                      end_Points(2,:) = end_Points(1,:);
                      end_Points(1,:) = obj.wait_Pose;
                   end
               end
           end    
        end
        %% Creates the distance between point 1 and 2 to determine if the points are within the limit.
        function distance = distance(obj, point_1, point_2)
           distance = sqrt((point_1(1) - point_2(1))^2 +  (point_1(2) - point_2(2))^2);
        end
    end 
end
