package com.example.watch_verse_back_end.helpers

import org.bson.types.ObjectId

fun String?.toObjectIdOrNew(): ObjectId =
    if (this != null && ObjectId.isValid(this)) ObjectId(this) else ObjectId.get()
