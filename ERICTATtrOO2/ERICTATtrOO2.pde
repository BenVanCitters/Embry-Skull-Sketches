import processing.video.*;

import processing.opengl.*;

boolean recordVid = false;
private MovieMaker mm;

String[] lines;
float[] pts;
ArrayList<float[]> ptLst;
ArrayList<int[]> triLst;
int index = 0;
PImage skullTexture;

ModelMesh mesh;
Snakes snk;

void setup() 
{
size(screen.width,screen.height,OPENGL);
//  size(640, 480,OPENGL);
//  skullTexture = loadImage("Cross_hatch_Gradient_by_Auraea_elm.jpg");
  skullTexture = loadImage("lines.png");
  if(recordVid)
  {
    println("beginning screen capture initialization process...");
    mm= new MovieMaker(this, width, height, "draw3456ing.mov");
//    ,30, MovieMaker.H263, MovieMaker.HIGH);
    println("...initialized the recording!");
  }

  //parse faces
  parsePointsAndFaces();
  snk = new Snakes(mesh,700);
}

void parsePointsAndFaces()
{
  mesh = new ModelMesh();
  lines = loadStrings("untitled3.obj");
  float pts[] = new float[3];
  int tri[];
  ptLst = new ArrayList<float[]>();
  triLst = new ArrayList<int[]>();
  
  //println("lines.length: " + lines.length);
    
  //parse verticies from obj file
  int vCount = 0;
  for(int i = 0; i < lines.length; i++)
  {
    String[] pieces = split(lines[i], ' ');
    if(pieces[0].equals("v"))
    {
      pts = new float[]{float(pieces[1]),-1.0f*float(pieces[2]),float(pieces[3])+700};
      ptLst.add(pts);      
      
      mesh.addNode(new MeshNode(pts,vCount),vCount);
      vCount++;
      //println("pt: {" + float(pieces[2]) + ", " + float(pieces[3]) +", " + float(pieces[4]) + "}"); 
    }
    else if(pieces[0].equals("f"))
    {
      if(pieces.length >= 4)
      {
        //println("tri {" + int(pieces[1]) + ", " + int(pieces[2]) +", " + int(pieces[3]) + "}"); 
        tri = new int[]{int(pieces[1]),int(pieces[2]),int(pieces[3])};
        MeshNode[] nodes = new MeshNode[]{mesh.getNode(tri[0]-1),
                                          mesh.getNode(tri[1]-1),
                                          mesh.getNode(tri[2]-1)};
        float[] nrm = getNormal(nodes[0].getPos(),nodes[1].getPos(),nodes[2].getPos());
        for(int j = 0; j < nodes.length; j++)
        {
          if(nodes[j] != null)
          {
            for(int k = 0; k < nodes.length; k++)
            {
              if(j!=k)
              {
                nodes[j].addNeighbor(nodes[k]);
                nodes[j].addNormal(nrm);
              }  
            }
          }
        }
        triLst.add(tri);
      }
    }
  }
  mesh.removeLonelyNodes();
}

void draw() 
{
  float tm = millis()/1000.f;
  if(recordVid)
    tm = frameCount*30.f/1000.f;
  background(0);

  snk.update(tm);
  
  translate(width/2,340,100);
  {
    rotateZ(PI);
    rotateY(HALF_PI - mouseX*TWO_PI/width - PI);
    rotateZ(-.1);
    translate(0,0,-50);
  }
  scale(50.5);
  
  stroke(255,255,0,50);
  //mesh.drawMesh();
  drawWholeSkull(tm);
  snk.draw();

  if(recordVid)
    mm.addFrame();
  println("frameRate: " + frameRate);
}


void drawWholeSkull(float tm)
{
//  lights();
//  pointLight(0,255,0,width/2,height/2,0);
//  directionalLight(100,100,100,0,1,-.5);
//  directionalLight(0,255,0,-1,0,0);
//  directionalLight(255,0,0,1,0,0);
//  ambientLight(80,80,80);
//lightSpecular(255,0,0);
//shininess(250.f*mouseX/width);
//specular(255,255,255);


  float[] lightDir = new float[]{sin(tm),
                                 cos(tm/1.3),
                                 cos(tm/2.1)};
  lightDir = normalizeVect(lightDir);
  directionalLight(255,255,255,-lightDir[0],-lightDir[1],-lightDir[2]);
  //,255,0);

  //noFill();
  fill(70,120,255);
  float tintLightness = .2f;
  fill(tintLightness*70,tintLightness*120,tintLightness*255);
  tint(255);
  float strokeLightness = 0.f;
//  stroke(strokeLightness*70,strokeLightness*120,strokeLightness*255);
  noStroke();         //http://vimeo.com/42021396
//  strokeWeight(5);
//  float[] tris = (float[])triLst.toArray();
  textureMode(NORMAL);
  beginShape(TRIANGLES);
//  texture(skullTexture);
  //iterate through triangle list
  float rndPtAmt = 0;//20.0f*mouseX/width;
//  translate(width/2,340,100);
  {
  //rotateX(-HALF_PI*1.3);
  //rotateZ(mouseX*TWO_PI/width - PI);  
  }
  {
//    rotateX(PI);
//    rotateZ(PI);
//    rotateY(HALF_PI - mouseX*TWO_PI/width - PI);
//    rotateZ(-.1);
  }
//  scale(50.5);
  float pct = 1;//mouseY*2.f/height-1;
  
  for(Iterator<int[]> i = triLst.iterator();i.hasNext();)
  {
    int[] tmp = i.next();
    //fill(random(255),random(255),random(255));
    //for each corner of the triangle...
    float[] pt1 = ptLst.get(tmp[0]-1);
    float[] pt2 = ptLst.get(tmp[1]-1);
    float[] pt3 = ptLst.get(tmp[2]-1);
    
    //float[] nrm = normalizeVect(getNormal(pt1,pt2,pt3));
    //float dt = max(0,lightDir[0]*nrm[0]+lightDir[1]*nrm[1]+lightDir[2]*nrm[2]);
    //float[][] texCoords = getTexCoordsFromPct(dt);
//    float[] mid = new float[]{(pt1[0]+pt2[0]+pt3[0])/3,
//                              (pt1[1]+pt2[1]+pt3[1])/3,
//                              (pt1[2]+pt2[2]+pt3[2])/3};

    for(int j = 0; j < 3; j++)
    {
      //point(pts[0]*10+100, pts[1]*10+100,pts[2]*10-100);
      float[] pt = ptLst.get(tmp[j]-1);
//      pt = new float[]{(pt[0]-mid[0])*pct,
//                       (pt[1]-mid[1])*pct,
//                       (pt[2]-mid[2])*pct};

      vertex(pt[0], pt[1], pt[2]
//      vertex(pt[0]+mid[0], pt[1]+mid[1], pt[2]+mid[2]
//        ,texCoords[j][0],texCoords[j][1]
      );
    }
  }
  endShape();  
}


float[] getNormal(float[] pt1, float[] pt2, float[] pt3)
{
  float[] a = new float[]{pt2[0]-pt1[0],pt2[1]-pt1[1],pt2[2]-pt1[2]};
  float[] b = new float[]{pt3[0]-pt1[0],pt3[1]-pt1[1],pt3[2]-pt1[2]};
  
  float[] result = new float[]{
         a[1]*b[2]-a[2]*b[1],
         a[2]*b[0]-a[0]*b[2],
         a[0]*b[1]-a[1]*b[0]};  
  return result;
}

float[] normalizeVect(float[] a)
{
  float d = dist(0,0,0,a[0],a[1],a[2]);
  return new float[]{a[0]/d,a[1]/d,a[2]/d};
}

float[][] getTexCoordsFromPct(float pct)
{  
  float[][] result = new float[3][2];
  result[0][0] = pct*(skullTexture.width-skullTexture.height)/skullTexture.width;
  result[0][1] = 0;
  result[1][0] = pct*(skullTexture.width-skullTexture.height)/skullTexture.width;
  result[1][1] = 1;
  result[2][0] = pct+skullTexture.height*1.f/skullTexture.width;
  result[2][1] = 0;  

  return result;
}
void exit()
{
  println("exiting...");
  if(recordVid)
  {
    mm.finish();
  println("...completed recording");
  }
  super.exit();
}
