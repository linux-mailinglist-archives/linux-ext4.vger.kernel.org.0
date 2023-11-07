Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D27E4D8E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Nov 2023 00:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjKGXlb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Nov 2023 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjKGXlX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Nov 2023 18:41:23 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC30526F
        for <linux-ext4@vger.kernel.org>; Tue,  7 Nov 2023 15:31:35 -0800 (PST)
From:   Sam James <sam@gentoo.org>
To:     linux-ext4@vger.kernel.org
Cc:     Sam James <sam@gentoo.org>
Subject: [PATCH e2fsprogs] ext2fs: Fix -Walloc-size
Date:   Tue,  7 Nov 2023 23:31:20 +0000
Message-ID: <20231107233122.2013191-1-sam@gentoo.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

GCC 14 introduces a new -Walloc-size included in -Wextra which gives:
```
lib/ext2fs/hashmap.c:37:36: warning: allocation of insufficient size ‘1’ for type ‘struct ext2fs_hashmap’ with size ‘20’ [-Walloc-size]
```

The calloc prototype is:
```
void *calloc(size_t nmemb, size_t size);
```

So, just swap the number of members and size arguments to match the prototype, as
we're initialising 1 struct of size `sizeof(...)`. GCC then sees we're not
doing anything wrong.

Signed-off-by: Sam James <sam@gentoo.org>
---
 lib/ext2fs/hashmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/hashmap.c b/lib/ext2fs/hashmap.c
index 697b2bcc..15794673 100644
--- a/lib/ext2fs/hashmap.c
+++ b/lib/ext2fs/hashmap.c
@@ -34,8 +34,8 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
 				uint32_t(*hash_fct)(const void*, size_t),
 				void(*free_fct)(void*), size_t size)
 {
-	struct ext2fs_hashmap *h = calloc(sizeof(struct ext2fs_hashmap) +
-				sizeof(struct ext2fs_hashmap_entry) * size, 1);
+	struct ext2fs_hashmap *h = calloc(1, sizeof(struct ext2fs_hashmap) +
+				sizeof(struct ext2fs_hashmap_entry) * size);
 	if (!h)
 		return NULL;
 
-- 
2.42.1

