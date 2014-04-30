class ModelMesh
{
  ArrayList<MeshNode> nodes;
  public ModelMesh()
  {
    nodes = new ArrayList<MeshNode>();
  }
  
  public void addNode(MeshNode node, int index)
  {
    nodes.add(index,node);
  }
  
  public MeshNode getNode(float[] pos)
  {
    for(MeshNode node : nodes)
    {
      float[] position = node.getPos();
      if((pos[0] == position[0]) &&
         (pos[1] == position[1]) &&
         (pos[2] == position[2]))
         return node;
    }
    return null;
  }
  public MeshNode getNode(int index)
  {
    return nodes.get(index);
//    for(MeshNode node : nodes)
//    {
//      int indx = node.getIndex();
//      if(indx == index)
//         return node;
//    }
//    return null;    
  } 
 
  public MeshNode getRandomNode()
  {
    return nodes.get((int)random(nodes.size()));
  }  

  public void drawMesh()
  {
    beginShape(POINTS);
    for(MeshNode node : nodes)
    {
       float[] position = node.getPos();
       vertex(position[0],position[1],position[2]);
    }
    endShape();    
  }
  
  public void removeLonelyNodes()
  {
    ArrayList<MeshNode> remove = new ArrayList<MeshNode>();
    for(MeshNode node : nodes)
    {
      if(node.getNeighborCount() < 1)
        remove.add(node);
    }
    for(MeshNode node : remove)
    {
      nodes.remove(node);
    }
  }
}
