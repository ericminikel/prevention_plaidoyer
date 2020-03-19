options(stringsAsFactors=FALSE)
if(interactive()) {
	setwd('~/d/sci/src/prevention_article')
}

imgmode = 'png'
#imgmode = 'pdf'
imgsave = get(imgmode) # get the function that saves as that type of image
if (imgmode == 'png') {
  resx = 600 # multiplier for image width, height, and resolution
} else if (imgmode == 'pdf') {
  resx = 1
}

percent = function(proportion,digits=2) {
  return ( gsub(' ','',paste(formatC(proportion*100, digits=digits, format='fg'),"%",sep="") ) )
}


data = read.table(textConnection("
compound	mouse	treatment_start_dpi	control_endpoint_dpi	treatment_endpoint_dpi
IND24	wt	-14	118	452
IND24	wt	1	118	204
IND24	wt	34	118	202
IND24	wt	46	118	197
IND24	wt	60	118	211
IND24	wt	61	118	221
IND24	wt	74	118	192
IND24	wt	75	118	162
IND24	wt	77	118	208
IND24	wt	90	118	118
"),sep='\t',header=TRUE,comment.char='#')

data$timepoint = data$treatment_start_dpi / data$control_endpoint_dpi
data$delay = data$treatment_endpoint_dpi / data$control_endpoint_dpi - 1

k_ind24 = '#FF2015'
k_anle138b = '#0001CD'
k_cpdb = '#FF9912'
k_pps = '#7D26CD'

data$color = ''
data$color[data$compound=='IND24'] = k_ind24
data$color[data$compound=='anle138b'] = k_anle138b
data$color[data$compound=='cpd-b'] = k_cpdb
data$color[data$compound=='PPS'] = k_pps


imgsave(paste0('figures/figure-2.',imgmode),width=6*resx, height=3*resx, res=resx)
par(mar=c(4,5,1,1)) 
plot(NA, NA, xlab='', ylab='', xlim=c(-20,125), ylim=c(0,625), yaxs='i', axes=FALSE)
abline(h=0, lwd=2, col='#000000')
#segments(x0=0,x1=0,y0=0,y1=500,lwd=0.25,col='#777777')
axis(side=1, at=c(-14,0,25,50,75,100,125), labels=c(-14,0,25,50,75,100,125), lwd=0, lwd.ticks=1, cex.axis=1)
axis(side=2, at=(0:5)*100, labels=(0:5)*100, lwd=0, lwd.ticks=.5, cex.axis=.9, las=2)
abline(h=118, lty=2, col='#777777', lwd=2)
text(x=37, y=118, pos=1, labels='untreated time to onset', col='#777777', cex=0.8, font=3)


text(x=c(-14, 0, 55, 118), y=c(500,315,235,180), labels=c('prophylactic\ntreatment', 'prion\ninfection\nbegins', 'prodromal\npathology', 'symptom\nonset'), pos=3, cex=0.8)
#points(x=c(-14, 0, 55, 111), y=c(500,300,235,180), pch=6, col='#000000')
segments(x0=-14,x1=-14,y0=452,y1=500)
segments(x0=0,x1=0,y0=225,y1=315)
segments(x0=55,x1=55,y0=210,y1=235)
segments(x0=118,x1=118,y0=125,y1=180)

for (compound in c('IND24')) {
  points(data$treatment_start_dpi[data$compound==compound], data$treatment_endpoint_dpi[data$compound==compound], type='b', lwd=3, pch=20, col=data$color[data$compound==compound], cex=2)
}
mtext(side=1, text='time when treatment is initiated (days post-infection)', font=1, line=2.5, cex=1)
mtext(side=2, text='time to onset\n(days post-infection)', font=1, line=3, cex=1)
# text(x=c(-14, 0, 55, 111, 118), y=c(500,250,235,180,135), labels=c('prophylactic\ntreatment', 'prion\ninfection\nbegins', 'prodromal\npathology\ndetectable', 'symptom\nonset', 'euthanasia'), pos=3, cex=0.8)
# points(x=c(-14, 0, 55, 111, 118), y=c(500,250,235,180,135), pch=6, col='#000000')

dev.off()