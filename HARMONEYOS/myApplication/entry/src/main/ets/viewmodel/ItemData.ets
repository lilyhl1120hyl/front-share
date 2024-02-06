

/**
 * List item data entity.
 */
export default class ItemData {
  /**
   * The ID is used to distinguish the uniqueness of an item.
   */
  id?: number;

  /**
   * Text of list item.
   */
  title?: Resource;

  /**
   * Image of list item.
   */
  img?: Resource;

  /**
   * Other resource of list item.
   */
  others?: Resource;

  /**
   * Resource of click prompt.
   */
  clickPrompt?: Resource;
}