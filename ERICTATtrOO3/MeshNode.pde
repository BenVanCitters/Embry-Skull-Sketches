class MeshNode
{
  private ArrayList<MeshNode> neighbors;
  
  private float[] pos;
  private float[] nrm = new float[3];
  private int index;
  
  public MeshNode(float[] position, int meshIndex)
  {
    index = meshIndex;
    pos = position;
    neighbors = new ArrayList<MeshNode>();
  }
  
  public void addNormal(float[] normalf)
  {
    nrm[0] += normalf[0];
    nrm[1] += normalf[1];
    nrm[2] += normalf[2];
  }
  
  public float[] getNormal()
  {
    return normalizeVect(nrm);
  }
  
  public boolean equalsNode(MeshNode node)
  {
    return (pos[0] == node.pos[0]) &&
           (pos[1] == node.pos[1]) &&
           (pos[2] == node.pos[2]) &&
           (index == node.index);
           
  }
  
  public int getNeighborCount()
  {    
    return neighbors.size();
  }
  
  public void addNeighbor(MeshNode node)
  {
    if(equalsNode(node))     
        return; 
    for(MeshNode n : neighbors)
    {
      if(n.equalsNode(node))     
        return;      
    }
    neighbors.add(node);
  }
  
  public MeshNode getRandNeighbor()
  {
    return neighbors.get((int)random(neighbors.size()));
  }
  
  public MeshNode getNeighborFromDir(float[] dir)
  {
    //normalize "dir"
    float dirDist = dist(0,0,0,dir[0],dir[1],dir[2]);
    dir[0] /=dirDist;
    dir[1] /=dirDist;
    dir[2] /=dirDist;    
    
    MeshNode bestNode = neighbors.get(0);
    float bestDot = -2;
    for(MeshNode node : neighbors)
    {
      float[] dirToNeigh = new float[]{node.pos[0] - pos[0], 
                                       node.pos[1] - pos[1],
                                       node.pos[2] - pos[2]};
      float neighDist = dist(0,0,0, dirToNeigh[0],dirToNeigh[1],dirToNeigh[2]);                                      
      float dirDot = dir[0]*dirToNeigh[0]/neighDist+
                     dir[1]*dirToNeigh[1]/neighDist+
                     dir[2]*dirToNeigh[2]/neighDist;
      if(dirDot > bestDot)
      {
        bestDot = dirDot;
        bestNode = node;
      }
    }
    return bestNode;
  }
  
  public float[] getPos()
  {
    return new float[] {pos[0],pos[1],pos[2]};
  }
  
  public int getIndex()
  {
    return index;
  }
}
