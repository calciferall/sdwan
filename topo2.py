#!/usr/bin/python3
"""Alta3 Research | Custom topology example

   Two directly connected switches plus a host for each switch:

      host --- switch --- switch --- host

   Adding the 'topos' dict with a key/value pair to generate our newly defined
   topology enables one to pass in '--topo=mytopo' from the command line.
   """

from mininet.topo import Topo

class MyTopo( Topo ):
       "Simple topology example."

       def __init__( self ):
           "Create custom topo."

           # Initialize topology
           Topo.__init__( self )

           # Add hosts and switches
           oneHost = self.addHost( 'h1' )
           twoHost = self.addHost( 'h2' )
           threeHost = self.addHost('h3')
           fourHost = self.addHost('h4')
           fiveHost = self.addHost('h5')
           sixHost = self.addHost('h6')

           oneSwitch = self.addSwitch('s1')
           twoSwitch = self.addSwitch( 's2' )
           threeSwitch = self.addSwitch( 's3' )

           # Add links
           self.addLink( oneHost, twoSwitch )
           self.addLink( twoHost, twoSwitch )
           self.addLink( twoSwitch, oneSwitch )
           self.addLink( threeSwitch, fourHost )
           self.addLink( threeSwitch, threeHost )
           self.addLink( threeSwitch, oneSwitch )
           self.addLink( fiveHost, oneSwitch )
           self.addLink( sixHost, oneSwitch )


topos = { 'newtopo': ( lambda: MyTopo() ) }

