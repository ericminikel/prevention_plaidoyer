options(stringsAsFactors=F)
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

tk = '#24AFB2'
sk = '#E67E23'

# plot of PrPC expression vs incubation time
imgsave(paste('figures/figure-1.',imgmode,sep=''),width=6.5*resx,height=3*resx,res=resx)
mousename = c("Prnp+/-","Prnp+/+","Tga19/+","Tga20/+","Tga20/Tga20")
explevel = c(.5,1,3.5,6.5,10) # PrPC expression level
terminal = c(415,166,100,68,62) # time to terminal illness
symptoms = c(290,131,87,64,60) # time to symptoms
par(mar=c(4,4,3,2))
plot(NA,NA,xlim=c(0,11),ylim=c(0,550),axes=FALSE,xaxs='i',yaxs='i',ann=FALSE)
axis(side=1, at=0:10, labels=NA, lwd=1, lwd.ticks=1, tck=-0.025)
axis(side=1, at=1:10 - 0.5, labels=NA, lwd=0, lwd.ticks=0.5, tck=-0.0125)
axis(side=1, at=c(0,1,5,10), labels=c(0,1,5,10), lwd=0, lwd.ticks=0)
mtext(side=1, line=2.5, text='PrP expression level (relative to wild-type)', adj=0)
axis(side=2, at=(0:6)*100, lwd=1, lwd.ticks=1, las=2)
mtext(side=2, line=3, text='days post-infection')

par(xpd=TRUE)
text(x=c(0.35,0.5,1,5), y=c(625,490,300,150), labels=c('complete protection in homozygous knockouts','disease delayed in heterozygous knockouts','wild-type','disease accelerated in\ntransgenic overexpressers'), pos=c(4,4,4,3), cex=0.8)
#points(x=c(0,0.5,1,5), y=c(600,500,300,150), pch=6, col='#000000')
segments(x0=0.4,x1=0.5,y0=555,y1=610)
segments(x0=0.5,x1=0.65,y0=415,y1=465)
segments(x0=1,x1=1.15,y0=166,y1=275)
segments(x0=5,x1=5,y0=80,y1=130)

legend(x=7,y=-120,c('time to fatal disease'),col=c(tk),text.col=c(tk),bty='n',lwd=3,pch=19,cex=0.8,text.font=2)

par(xpd=FALSE)

points(explevel,terminal,type='b',pch=19,lwd=3,col=tk)
#points(explevel,symptoms,type='b',pch=19,lwd=3,col=sk)
points(c(.5,.2),c(415,700),type='l',lwd=3,col=tk,lty=3)
#points(c(.5,.2),c(290,550),type='l',lwd=3,col=sk,lty=3)

dev.off()