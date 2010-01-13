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
  tinyMCE.execCommand('mceRemoveControl', false, textAreaId(partIndex) ); 
}

function addEditor(partIndex){
  tinyMCE.execCommand('mceAddControl', false, textAreaId(partIndex) );
}

function textAreaId(partIndex){
  return 'part_' + partIndex + '_content';
}