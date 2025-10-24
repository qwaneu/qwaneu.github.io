---
layout: post
title: three loops of software intensive product development
tags:
- systems thinking
author: Willem van den Ende, Rob Westgeest, Marc Evers
image: 
---
 <style>
  label {
    font-family: sans-serif;
    font-size: x-large;
    width:15em;
    display:block;
    float:left;
  }
  input {
    font-family: sans-serif;
    font-size: x-large;

  }

  </style>

 
  <script src="https://d3js.org/d3.v3.min.js"></script>
  <div id="start"></div>
  <div style="width:35%">
    <div id="prod-loop-div">
      <label for="prod-loop-speed">Product</label>
      <input id="prod-loop-speed"/>
    </div>
    <div id="gtd-loop-div">
      <label for="gtd-loop-speed">Getting Things Done Loop</label>
      <input id="gtd-loop-speed"/>
    </div>
    <div id="te-loop-div">
      <label for="te-loop-speed">Technical Excellence Loop</label>
      <input id="te-loop-speed"/>
    </div>
    </div>
<script>

var mode = 0;
const full_cycle_in_degrees = 360;

class XPLoop {
  constructor(name, xpos, ypos, radius, dot_radius, speed, color, next_loop) {
    this.name = name;
    this.xpos = xpos;
    this.ypos = ypos;
    this.speed = speed;
    this.radius = radius;
    this.color = color;
    this.dot_radius = dot_radius;
    this.angle = 0;
    this.next_loop = next_loop;
    this.rotations = 0;
    this.previous_rotations = 0;
    this.cycles = 0;
    this.previous_cycles = 0;
    this.rotations_per_cycle = 5;
  }

  addToSvg(rotateElements) {
    this.next_loop.addToSvg(rotateElements);
    rotateElements.append("circle")
      .attr('r', this.radius)
      .attr("cx", this.xpos)
      .attr("cy", this.ypos)
      .attr("fill", "none")
      .attr("stroke", this.color)
      .attr("id", this.name + "-background");

    rotateElements.append("circle")
      .attr("r", this.dot_radius)
      .attr("cx", this.xpos + this.radius)
      .attr("cy", this.ypos)
      .attr("fill", this.color)
      .attr("id", this.name);
    const my = this;
    function change_speed() {
      my.change_speed(parseInt(d3.select("#"+my.name+"-speed").node().value));
    }
    d3.select("#"+this.name+"-div > label").attr("style", "color:"+my.color);
    d3.select("#"+this.name+"-speed")
      .attr("value", this.speed)
      .on("change", change_speed );
  }

  change_speed(speed) {
    console.log("change speed", speed);
      this.speed = speed;
    }
  iterate() {
    if (this.previous_cycles !== this.cycles) {
      if (!this.next_loop.iterate()) return false;
      this.previous_cycles = this.cycles;
      return true;
    }
    this.angle = this.angle + this.speed;

    this.rotations = Math.floor(this.angle / full_cycle_in_degrees);
    this.cycles = Math.floor(this.rotations / this.rotations_per_cycle);
    var my = this;
    var transform = function() {
      return "rotate(" + my.angle + ", "+ my.xpos+", "+ my.ypos+")";
    };
    d3.selectAll("#"+this.name)
      .attr("transform", transform);
    if (this.previous_rotations !== this.rotations) {
      this.previous_rotations = this.rotations;
      return true;
    }
    return false;
  }

}

class NullLoop {
  addToSvg(svg) {}
  iterate() {
    return true;
  }
}

var te_loop = new XPLoop("te-loop", 650, 300, 100, 20, 15, "red",
                         new XPLoop("gtd-loop", 550, 300, 200, 25, 15, "green",
                                    new XPLoop("prod-loop", 450, 300, 300, 30, 15, "blue", new NullLoop())));

var svg = d3.select("#start")
    .append("svg")
    .attr("width", "100%")
    .attr("height", 700);


var rotateElements = svg.append("g");
te_loop.addToSvg(rotateElements);


d3.select("#start")
  .on("click", startAnimation);

function startAnimation() {
  if (mode === 0) {
    d3.timer(function() {
      var timestamp = Date.now();
        te_loop.iterate();
      if (mode === 0) {
        return true;
      } else {
        return false;
      }
    });
    mode = 1;
  } else {
    mode = 0;
  }

}
</script>
