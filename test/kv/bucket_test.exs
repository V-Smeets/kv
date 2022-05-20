defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "Get and delete a value", %{bucket: bucket} do
    key = "bread"
    value = 42
    assert KV.Bucket.get(bucket, key) == nil

    KV.Bucket.put(bucket, key, value)
    assert KV.Bucket.get(bucket, key) == value

    assert KV.Bucket.delete(bucket, key) == value
    assert KV.Bucket.get(bucket, key) == nil
  end
end
