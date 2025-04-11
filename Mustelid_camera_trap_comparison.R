####-----------------------------------------------------------------------------------------------------####
####----------------------------                                          -------------------------------####
####----------------------------   Small mustelid monitoring comparison   -------------------------------####
####----------------------------                                          -------------------------------####
####-----------------------------------------------------------------------------------------------------####

rm(list=ls())
dir <- "PO_mustelid_monitoring"

setwd(dir)

## Open library
library(jagsUI)

####----------------------------  Defining all models in JAGS language  --------------------------------####
# Model with all parameters
cat(file="MSocc-MD_all.txt", 
    "
    model{
    
    # Priors and model for params
    
    int.psi <- logit(psi0)            #Intercept for occupancy probability
    psi0 ~ dunif(0,1)        
    
    for(t in 1:3){
    int.theta[t] <- logit(theta0[t])        #Intercepts for availability probability
    theta0[t] ~ dunif(0,1) 
    }
    
    for(t in 1:3){               #Intercepts for detection probability per method
    int.p[t] <- logit(p0[t])
    p0[t] ~ dunif(0,1)     
    }
    
    #Slope of psi covariates
    for(t in 1:2){
    beta.lpsi[t] ~ dnorm(0,0.01)
    }

    #Slope of p covariates # different slope per method
    for(t in 1:4){
    beta.lp[t] ~ dnorm(0,0.01)
    }
    
    #Likelihood (or basic model structure)
    for(i in 1:n.site){
    
    #Occurrence in site i
    z[i] ~ dbern(psi[i])
    logit(psi[i]) <- int.psi +
    beta.lpsi[1] * landscape_feature[i] +
    beta.lpsi[2] * study_area[i]
    
    for(j in 1:n.cts){
    
    #Occurrence at camera location j
    a[i,j] ~ dbern(mu.a[i,j])
    mu.a[i,j] <- z[i] * theta[i,j]
    logit(theta[i,j]) <- int.theta[j]
    
    for(k in 1:n.days){
    
    # detection probability on day k
    y[i,j,k] ~ dbern(mu.y[i,j,k])
    mu.y[i,j,k] <- a[i,j] * p[i,j,k]
    logit(p[i,j,k]) <- int.p[j] + 
    beta.lp[j] * bait[i,j,k] +
    beta.lp[4] * passage[i]

    }
    }
    }
    } #End Model
    ")

####----------------------------  Running the models  --------------------------------####

# Parameters monitored
params <- c("int.psi","int.theta","int.p","beta.lpsi","beta.lp")

# MCMC settings
ni <- 50000; nt <- 10; nb <- 20000; nc <- 3

#ni <- 1000; nt <- 5; nb <- 3; nc <- 3 #do not run

#####---------- Weasel ----------#####

# Load data
load("MSOcc_weasel.RData")
attach(data.ws) 
win.data <- list(y=y, n.site=dim(y)[1],n.cts=dim(y)[2],n.days=dim(y)[3],
                 bait=bait,habitat=habitat,landscape_feature=landscape_feature,passage=passage,study_area=study_area)
zst <- apply(y,1,max,na.rm=T)      #inits for presence (z)
ast <- apply(y,c(1,2),max,na.rm=T) #inits for availability (a)
inits <- function()list(z=zst, a=ast, psi0=0.5, beta.lpsi=c(0,0))
outJ.weasel <- jags(win.data, inits, params, "MSocc-MD_all.txt", n.chains=nc, n.thin=nt, n.iter=ni, n.burnin=nb, parallel=T)
save(outJ.weasel,file="outJ-weasel.RData")
detach(data.ws); rm("data.ws")

#####---------- Stoat ----------#####

# Load data
load("MSOcc_stoat.RData")
attach(data.st) 
win.data <- list(y=y, n.site=dim(y)[1],n.cts=dim(y)[2],n.days=dim(y)[3],
                 bait=bait,habitat=habitat,landscape_feature=landscape_feature,passage=passage,study_area=study_area)
# Initial values
zst <- apply(y,1,max,na.rm=T)      #inits for presence (z)
ast <- apply(y,c(1,2),max,na.rm=T) #inits for availability (a)
inits <- function()list(z=zst, a=ast, psi0=0.5, beta.lpsi=c(0,0))
outJ.stoat <- jags(win.data, inits, params, "MSocc-MD_all.txt", n.chains=nc, n.thin=nt, n.iter=ni, n.burnin=nb, parallel=T)
save(outJ.stoat,file="outJ-stoat.RData")
detach(data.st); rm("data.st")

####---------- Polecat ----------####

# Load data
load("MSOcc_polecat.RData")
attach(data.pc) 
win.data <- list(y=y, n.site=dim(y)[1],n.cts=dim(y)[2],n.days=dim(y)[3],
                 bait=bait,habitat=habitat,landscape_feature=landscape_feature,passage=passage, study_area=study_area)
# Initial values
zst <- apply(y,1,max,na.rm=T)      #inits for presence (z)
ast <- apply(y,c(1,2),max,na.rm=T) #inits for availability (a)
inits <- function()list(z=zst, a=ast, psi0=0.5, beta.lpsi=c(0,0))
outJ.polecat <- jags(win.data, inits, params, "MSocc-MD_all.txt", n.chains=nc, n.thin=nt, n.iter=ni, n.burnin=nb, parallel=T)
save(outJ.polecat,file="outJ-polecat.RData")
detach(data.pc); rm("data.pc")

##########END##########