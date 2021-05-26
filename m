Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF609391287
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhEZIor (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhEZIor (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:44:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEA5C061574;
        Wed, 26 May 2021 01:43:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mp9-20020a17090b1909b029015fd1e3ad5aso290385pjb.3;
        Wed, 26 May 2021 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4LdU1IyFk5jvDk1Nl40hPYUk7CeobfdR18WaEyapyXQ=;
        b=TJDwf28bqzJFlal2kVIxfgBd6L+rgX6x0lMFzoAcLO52VggIinNKRDoMjet0sUlJ3G
         0PpFHCDzit1bkD8V4bBin43MOojojRHpKwsZfGd0oi+gMJgM3VCRZMsAA1+54CwCAMDl
         rfcJfcQl//tERIfFg6SrDIcWQjySjMAa62Y1XnGK1dFErt/l0k/5NI+heKBMvmby1fjx
         xKbpN0lrx91GuvAMSs9fdAOE/9ucqbtwOt3GpsjXwAWwKzmxahQZId/xziva3V/w8tqt
         Pbg9/bDxNM/73BQG26y9N2ruhnrZQnxB1q6MncxDC27G0jZvXU4dUcWxulO/UPk0nq0A
         2BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4LdU1IyFk5jvDk1Nl40hPYUk7CeobfdR18WaEyapyXQ=;
        b=MuSkxbt54PLHiO2cVJxaIKZvP3zt8gV1I8g6z+t0mpZWrg3iYq4LV7vFIQ9Fds57hN
         0iNHRT55xZRu8jo6zeU62AR21zCGKWEmdFAP6nCHc7oI9+idHswkwCEhMaXDfGC/w2Oy
         RrIaOUExNjp4xrLV263dLfxX5euL1UeJOeUZRNt7WbqenC9OL0SY3ZI36n8CmR9ThCH2
         G3vuXr7tFNPW3sVP07RFiU7sbER4r6Gaz+bradTC3sNDdjLe18MUnb2bmk8uDQG62fCx
         c9yxEdP/RHkZ5jqVhfWvFOGZziOF+NSZw1ZqrwQXW/FX8qvZzKjfzXkTK0qUDVbiK0PR
         0sug==
X-Gm-Message-State: AOAM531RNf5fWTe/IgZFUPGCvWfqZVCx69IeXxgBXVnu6l89IzRWTWEh
        TWtndHls5pQ73XZyTFGdVHscVj1s5A7STQ==
X-Google-Smtp-Source: ABdhPJz4BZozaSwOS57pOi6QKanMU3cOaeheRqfbhyN54+cz8zNn33YQ2Sssg4VWNrE+j6xc8BjZmQ==
X-Received: by 2002:a17:902:f281:b029:f0:bdf2:2fe5 with SMTP id k1-20020a170902f281b02900f0bdf22fe5mr33908602plc.68.1622018596099;
        Wed, 26 May 2021 01:43:16 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id d91sm899593pjk.6.2021.05.26.01.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:43:15 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 2/7] ext4: add new helper interface
 ext4_try_to_trim_range()
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
Message-ID: <72360aac-48f9-95c6-539f-739464f9fc9e@gmail.com>
Date:   Wed, 26 May 2021 16:43:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no functional change in this patch but just split the
codes, which serachs free block and does trim, into a new function
ext4_try_to_trim_range. This is preparing for the following async
backgroup discard.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d81f1fd22..f984f15 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5685,6 +5685,54 @@ static int ext4_trim_extent(struct super_block *sb,
 	return ret;
 }
 
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+{
+	ext4_grpblk_t next, count, free_count;
+	void *bitmap;
+	int ret = 0;
+
+	bitmap = e4b->bd_bitmap;
+	start = (e4b->bd_info->bb_first_free > start) ?
+		e4b->bd_info->bb_first_free : start;
+	count = 0;
+	free_count = 0;
+
+	while (start <= max) {
+		start = mb_find_next_zero_bit(bitmap, max + 1, start);
+		if (start > max)
+			break;
+		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		if ((next - start) >= minblocks) {
+			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			if (ret && ret != -EOPNOTSUPP)
+				break;
+			ret = 0;
+			count += next - start;
+		}
+		free_count += next - start;
+		start = next + 1;
+
+		if (fatal_signal_pending(current)) {
+			count = -ERESTARTSYS;
+			break;
+		}
+
+		if (need_resched()) {
+			ext4_unlock_group(sb, e4b->bd_group);
+			cond_resched();
+			ext4_lock_group(sb, e4b->bd_group);
+		}
+
+		if ((e4b->bd_info->bb_free - free_count) < minblocks)
+			break;
+	}
+
+	return count;
+}
+
 /**
  * ext4_trim_all_free -- function to trim all free space in alloc. group
  * @sb:			super block for file system
@@ -5708,10 +5756,8 @@ static int ext4_trim_extent(struct super_block *sb,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -5721,57 +5767,23 @@ static int ext4_trim_extent(struct super_block *sb,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
-	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
-		goto out;
-
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
 
-	while (start <= max) {
-		start = mb_find_next_zero_bit(bitmap, max + 1, start);
-		if (start > max)
-			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
-
-		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, &e4b);
-			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
-			count += next - start;
-		}
-		free_count += next - start;
-		start = next + 1;
-
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
-
-		if (need_resched()) {
-			ext4_unlock_group(sb, group);
-			cond_resched();
-			ext4_lock_group(sb, group);
-		}
-
-		if ((e4b.bd_info->bb_free - free_count) < minblocks)
-			break;
+	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
+		if (ret >= 0)
+			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
+	} else {
+		ret = 0;
 	}
 
-	if (!ret) {
-		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
-out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
-		count, group);
+		ret, group);
 
 	return ret;
 }
-- 
1.8.3.1
