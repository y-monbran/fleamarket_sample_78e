$(document).on('turbolinks:load', ()=> {
  function categoryOption(category){
    var optionHtml = `<option value="${category.id}">${category.name}</option>`;
    return optionHtml;
  }
  $('#category-select-parent').on('change', function(){
    let parentCategoryId = $(this).val();
    console.log(parentCategoryId)
    if (parentCategoryId == ''){
      $('#select-children-box').remove();
      $('#select-grandchildren-box').remove();
    }else{
      $.ajax({
        url: '/items/parentCategoryId/category_children',
        type: 'GET',
        data: { parent_id: parentCategoryId },
        dataType: 'json'
      })
      .done(function(category_children){
        $('#select-children-box').remove();
        $('#select-grandchildren-box').remove();
        let optionHtml = '';
        category_children.forEach(function(child){
          optionHtml += categoryOption(child);
        });
        $('#error-category').before(`<div class="sell-collection_select " id="select-children-box">
                                        <label class="sell-collection_select__label" for="item_category_id">
                                          <select class="form" id="category-select-children" required="required" name="item[category_id]">
                                            <option value="">選択して下さい</option>
                                            ${optionHtml}
                                          </select>
                                          <i class="fas fa-chevron-down"></i>
                                        </label>
                                      </div>`
        );
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }
  });
  $('.Sell__page__body__details').on('change', '#category-select-children', function(){
    let childrenCategoryId = $(this).val();
    console.log(childrenCategoryId)
    if (childrenCategoryId == ''){
      $('#select-grandchildren-box').remove(); 
    }else{
      $.ajax({
        url: '/items/childrenCategoryId/category_grandchildren',
        type: 'GET',
        data: { child_id: childrenCategoryId },
        dataType: 'json'
      })
      .done(function(category_grandchildren){
        $('#select-grandchildren-box').remove();
        let optionHtml = '';
        category_grandchildren.forEach(function(grandchildren){
          optionHtml += categoryOption(grandchildren);
        });
        $('#error-category').before(`<div class="sell-collection_select " id="select-grandchildren-box">
                                        <label class="sell-collection_select__label" for="item_category_id">
                                          <select class="form" id="category-select-grandchildren" required="required" name="item[category_id]">
                                            <option value="">選択して下さい</option>
                                            ${optionHtml}
                                          </select>
                                        </label>
                                      </div>`
        );
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }
  });

  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="Sell__page__body__img__form">
                    <input class="Sell__page__body__img__form__body" type="file"
                    name="item[item_imgs_attributes][${index}][url]"
                    id="item_item_imgs_attributes_${index}_url">
                    <span class="Sell__page__body__img__form__remove">削除</span>
                  </div>`;
    return html;
  }

  document.getElementById("#image-box")
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];


  $('#image-box').on('change', '.Sell__page__body__img__form__body', function(e) {
    if ($("#image-box").children().length<=2){
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

  $('#image-box').on('click', '.Sell__page__body__img__form__remove', function() {
    $(this).parent().remove();
    if ($('.Sell__page__body__img__form__body').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});

