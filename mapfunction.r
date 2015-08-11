
makemap <- function(data,colors) {

    ## set up cuts: dependent on data type (add really high right side)
    if(data[1,3] == 2 | data[1,3] == 3) {
        fleg <- c(' < $1k      ',' $1k - $2k',' $2k - $3k',' $3k - $4k',
                  ' $4k - $5k',' $5k - $6k',' $6k - $7k',' $7k - $8k',
                  ' $8k - $9k', ' > $9k')
    } else if (data[1,3] == 4) {
        fleg <- c(' < $500     ',' $500 - $1k',' $1k - $1.5k',' $1.5k - $2k',
                  ' $2k - $2.5k',' $2.5k - $3k',' $3k - $3.5k',' $3.5k - $4k',
                  ' $4k - $4.5k',' > $4.5k')
    } else {
        fleg <- c(' < $3k',' $3k - $6k',' $6k - $9k',' $9k - $12k',
                  ' $12k - $15k',' $15k - $18k',' $18k - $21k',' $21k - $24k',
                  ' $24k - $27k', ' > $27k')
    }
    
    ## create plot
    par(mar=c(.5,0,0,6), xpd = TRUE, family = 'mono')
    map('county', col = colors[data[,4]], fill = TRUE, resolution = 0,
        lty = 0, projection = 'polyconic', myborder = 0, bg = 'white')
    map('state', col = 'white', fill = FALSE, add = TRUE, lty = 1, lwd = 1,
        projection = '',bg = 'white')
    map('usa', col = 'black', fill = FALSE, add = TRUE, lty = 1, lwd = 2,
        projection = '',bg = 'white')
    legend(x = .32, y = .7, rev(fleg), title = 'Price', col = rev(colors),
           fill = rev(colors), bty = 'n', xpd = TRUE, inset = c(0,0),
           xjust = 0, yjust = .7)

}
                
