# figure2.R  Recreate Figure 2 in DeSimone, Kim, and Murray (2020)

rm( list=ls() )

# fit a psychometric function (normal cdf) to number discrimination data
psymet <- function( subject='S1', adapt=0, refstim=1, plotflag=TRUE ) {
    # subject  = subject code ('S1' to 'S8')
    # adapt    = adaptation condition flag (0 or 1)
    # refstim  = reference stimulus number (1, 2, or 3)
    # plotflag = flag whether to plot data and fitted function (TRUE or FALSE)
    
    # read data
    fname <- sprintf( 'num_%s_%d.txt', subject, adapt )
    df <- read.csv( fname, header=TRUE, comment.char='#' )
    
    # keep trials that showed this reference stimulus
    df <- df[ df$refstim==refstim, ]
    
    # plot response probability vs. number of dots in test stimulus
    if( plotflag ) {
        psy <- aggregate( (response==2) ~ ntest, data=df, FUN=mean )
        plot( psy, xlab='number of test dots', ylab='P( choose test stimulus )',
              main=sprintf('subject %s, adapt=%d, refstim=%d', toupper(subject), adapt, refstim ) )
    }
    
    # fit psychometric function
    errfn <- function( p ) -sum(log( dbinom( df$response==2, 1, pnorm( df$ntest, p[1], p[2] ) ) ))
    phat <- optim( c(25,5), errfn )$par
    
    # plot fitted function
    if( plotflag ) {
        curve( pnorm( x, phat[1], phat[2] ), col='red', add=TRUE )
        abline( v=phat[1], lty='dashed' )
        text( phat[1] + 2, 0.05, sprintf('PSE = %.2f',phat[1]) )
    }
    
    return( phat )
    
}

# find PSEs for all subjects, adaptation conditions, and reference stimuli
psemat <- array( dim=c(2,3,8) )
for ( subject in 1:8 ) {
    for ( adapt in 0:1 ) {
        for( refstim in 1:3 ) {
            subjectname <- sprintf( 'S%d', subject )
            phat <- psymet( subjectname, adapt, refstim, plotflag=FALSE )
            psemat[adapt+1,refstim,subject] <- phat[1]
        }
    }
}

# find effect of adaptation on mean PSEs
psediff <- psemat[2,,] - psemat[1,,]  # adapted minus unadapted PSE
psediff_mean   <- apply( psediff, 1, mean )
psediff_stderr <- apply( psediff, 1, sd ) / sqrt( ncol(psediff) )

# plot effect of adapatation on mean PSEs
mid <- barplot( psediff_mean, ylab='Change in perceived number', main='Figure 2', ylim=c(-12,0),
         names.arg=c( 'reference\nstimulus 1\n(critical)', 'reference\nstimulus 2', 'reference\nstimulus 3' ) )
arrows( x0=mid, y0=psediff_mean-psediff_stderr, y1=psediff_mean+psediff_stderr, code=3, angle=90 )
