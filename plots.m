% Plots for NULMPC Paper
% Authors: Aidan Aalund and Zejiang Wang
% Description: run this script to run both the model-based and data-driven
% MPC controllers and plot associated performance data.

%% Running the data-driven and model-based controllers %%
nulmpc;
% this one will take a more time to finish
% nmpc;

%% Plotting %%

%% style parameters
lw = 3.5; % linewidth
ftsz = 40; % font size
pos_fig = [100 500 1200 800]; % sets popups to appear in one spot on your screen
close all

%% plot 1: tracking
figure
set(gcf,'paperpositionMode','auto','position', pos_fig);
box on
% plot(ans.spacing_mb, 'color', [0.8500 0.3250 0.0980], 'linewidth', lw);
hold on
plot(ans.spacing_dd, 'color', [0 0.4470 0.7410], 'linewidth', lw);
plot(ans.spacing_reference, '--', 'color', [0.9290 0.6940 0.1250], 'linewidth', lw);
grid on
title('')
legend('Model Based NMPC','NULMPC','Reference', 'Location','northeast', 'FontSize', 36);
ylim([-0.01,0.01])
xlabel('Time (s)','Interpreter', 'LaTeX','fontsize',ftsz)
ylabel('$$z_r$$ (m)','Interpreter', 'LaTeX','fontsize',ftsz)
set(gca, 'FontName', 'Times New Roman', 'fontsize',ftsz)
set(gcf,'color','w');

%% plot 2: ADE vs real
% lw = 2;
% figure
% set(gcf,'paperpositionMode','auto','position', pos_fig);
% box on
% plot(ans.adeDerivative, 'color', [0.8500 0.3250 0.0980],'linewidth', lw);
% hold on
% plot(ans.realDerivative, 'color', [0 0.4470 0.7410],"linewidth", lw);
% % xlim([0,2])
% % ylim([-0.005,0.015])
% grid on
% title('')
% legend('Algebraic Derivative Estimation','Real Value')
% xlabel('Time (s)','Interpreter', 'LaTeX','fontsize',ftsz)
% ylabel('Velocity (m/s)','Interpreter', 'LaTeX','fontsize',ftsz)
% set(gca, 'FontName', 'Times New Roman', 'fontsize',ftsz)
% set(gcf,'color','w');

%% plot 3: ADE vs direct differentiation
% figure
% set(gcf,'paperpositionMode','auto','position', pos_fig);
% box on
% hold on
% plot(ans.filterDerivative, 'color', [0.9290 0.6940 0.1250] ,"linewidth", lw);
% plot(ans.realDerivative, 'color', [0 0.4470 0.7410],"linewidth", lw);
% % xlim([0,2])
% % ylim([-0.005,0.015])
% grid on
% title('')
% legend('Direct Differentiation','Real Value')
% xlabel('Time (s)','Interpreter', 'LaTeX','fontsize',ftsz)
% ylabel('Velocity (m/s)','Interpreter', 'LaTeX','fontsize',ftsz)
% set(gca, 'FontName', 'Times New Roman', 'fontsize',ftsz)
% set(gcf,'color','w');

%% plot 4: energy generation (before and after cost fxn added)
% TODO

%% plot 5: energy comparison between NULMPC and NMPC
% figure
% set(gcf,'paperpositionMode','auto','position', pos_fig);
% box on
% plot(ans.energy_mb, 'color', [0.8500 0.3250 0.0980], 'linewidth', lw);
% hold on
% plot(ans.energy_dd, 'color', [0 0.4470 0.7410], 'linewidth', lw);
% grid on
% title('')
% legend('Model Based NMPC','NULMPC', 'Location','northeast', 'FontSize', 36);
% xlabel('Time (s)','Interpreter', 'LaTeX','fontsize',ftsz)
% ylabel('$$Energy (Joules)$$ (m)','Interpreter', 'LaTeX','fontsize',ftsz)
% set(gca, 'FontName', 'Times New Roman', 'fontsize',ftsz)
% set(gcf,'color','w');