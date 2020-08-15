% Paul Marchando
% Drubin Lab
% 04-26-20

% This function creates PDFs of contour plots created using the
% make_contours script of a protein of interest.

figure(1)

printPDF([protein_name 'FL1overlay.pdf'])
close

figure(2)

printPDF([protein_name 'FLoverlay.pdf'])
close

figure(3)

printPDF([protein_name 'LLoverlay.pdf'])
close