import 'package:dart_kollection/dart_kollection.dart';

/**
 * A collection that holds pairs of objects (keys and values) and supports efficiently retrieving
 * the value corresponding to each key. Map keys are unique; the map holds only one value for each key.
 * Methods in this interface support only read-only access to the map; read-write access is supported through
 * the [KMutableMap] interface.
 * @param K the type of map keys. The map is invariant on its key type, as it
 *          can accept key as a parameter (of [containsKey] for example) and return it in [keys] set.
 * @param V the type of map values. The map is covariant on its value type.
 */
abstract class KMap<K, V> implements KMapExtension<K, V> {
  // Query Operations
  /**
   * Returns the number of key/value pairs in the map.
   */
  int get size;

  /**
   * Returns `true` if the map is empty (contains no elements), `false` otherwise.
   */
  bool isEmpty();

  /**
   * Returns `true` if the map contains the specified [key].
   */
  bool containsKey(K key);

  /**
   * Returns `true` if the map maps one or more keys to the specified [value].
   */
  bool containsValue(V value);

  /**
   * Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
   */
  @nullable
  V get(K key);

  /**
   * Returns the value corresponding to the given [key], or `null` if such a key is not present in the map.
   */
  @nullable
  V operator [](K key);

  /**
   * Returns the value corresponding to the given [key], or [defaultValue] if such a key is not present in the map.
   */
  @nullable
  V getOrDefault(K key, V defaultValue);

  // Views
  /**
   * Returns a read-only [KSet] of all keys in this map.
   */
  KSet<K> get keys;

  /**
   * Returns a read-only [KCollection] of all values in this map. Note that this collection may contain duplicate values.
   */
  KCollection<V> get values;

  /**
   * Returns a read-only [KSet] of all key/value pairs in this map.
   */
  KSet<KMapEntry<K, V>> get entries;
}

/**
 * Represents a key/value pair held by a [KMap].
 */
abstract class KMapEntry<K, V> {
  /**
   * Returns the key of this key/value pair.
   */
  K get key;

  /**
   * Returns the value of this key/value pair.
   */
  @nullable
  V get value;
}

abstract class KMapExtension<K, V> {
  /**
   * Populates the given [destination] map with entries having the keys obtained
   * by applying the [transform] function to each entry in this [Map] and the values of this map.
   *
   * In case if any two entries are mapped to the equal keys, the value of the latter one will overwrite
   * the value associated with the former one.
   */
  M mapKeysTo<R, M extends KMutableMap<R, V>>(M destination, R Function(KMapEntry<K, V> entry) transform);
}
