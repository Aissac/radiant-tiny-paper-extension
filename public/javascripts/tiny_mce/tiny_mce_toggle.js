function instantiateEditor(partIndex){
  var usedFilter = $('part_' + partIndex +'_filter_id');
  if(usedFilter.value == 'Rich Text Editor'){
    addEditor(partIndex);
  }
}

function toggleEditor(partIndex){
  var filterId = $('part_' + partIndex + '_filter_id');
 
  if(filterId.value == 'Rich Text Editor'){
    addEditor(partIndex)
  }
  else{
    removeEditor(partIndex)
  } 
}

function removeEditor(partIndex){
  var usedTextArea = $('part_' + partIndex + '_content')
  tinyMCE.execCommand('mceRemoveControl', false, usedTextArea ); 
}

function addEditor(partIndex){
  var usedTextArea = $('part_' + partIndex + '_content')  
  tinyMCE.execCommand('mceAddControl', false, usedTextArea);   
}