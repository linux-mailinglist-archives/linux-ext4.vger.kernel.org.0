Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9296182388
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Mar 2020 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgCKUvi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Mar 2020 16:51:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40954 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgCKUvh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Mar 2020 16:51:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so3532159qka.7
        for <linux-ext4@vger.kernel.org>; Wed, 11 Mar 2020 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QTtaneo3wh2z0TL5PhS32xV1b/cXxegk+fltvl/LBIk=;
        b=luGjYBe/OfEo6cu8tBiuHqE/jeVhdViL2vghuPQyh88z7n2f4OJDG2LSy3pzj3xHMA
         /ht9SuC06R0D6XHlqCw3ragjWZPN8anolVjcvkCJb4MMsN1KViZtAq/7rpEPbTZrk5T5
         jqgMGV6HotsZ/hSOqolZmuSho0hecDaGEcWevKF4eeJlqIZgERhwOauG8YJ+aEjbKpTT
         9ZAwB9YXqCLPGIwWhVSdvim0kyNs2Jp6rL94tJlTTYrTT3zO8zEz4XYGttGwHGbH4gGw
         s/LwOpg3ZLvUfjyi58DRKkZ70NKOSPvjpduKQFBrJA5NmXjsLaH78melUe4DgieCSpwD
         WTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QTtaneo3wh2z0TL5PhS32xV1b/cXxegk+fltvl/LBIk=;
        b=oZbsNzvVHExxvK73H5qA4Ns5fXCEWnGVoIFg/MpP0uuVy6d+eLhwRiTWZapjDjxkpI
         QQAL8jfq/JZklmwLO/PTv6TlQVWWarX+Z2ZArjBBKr2q3jsK2g0pBV3S+WlOZ+FcA0sT
         uUZdy6a2VcVWLMuEWugxPqsMG6amYmI2ETafx8tY182h3E1WsQ0Rlj4DmZ5t4PGJXluy
         R8Lwn157GKu2QbKCaNM3Jk91iXg4n9/W5xE80ARWTe/2xhHFEhRMeZ934vQ/IVlZ5ppv
         TmPujUg/CeXW2OMDQ+sAHhRw86W4v0eWGYjNjnmUcJh0VJCvg10xw9AXzo6ifcKSIwym
         4NWg==
X-Gm-Message-State: ANhLgQ1EI3Zs7/5qUuKJbhm6XxxfrUesXTpZ7qW6SaUPs13SN5UhyT4g
        U7TtoSa2zfq/2Twv7IuSfarWws7W
X-Google-Smtp-Source: ADFU+vscAgw60xSlfBxi63Bs1eqRdc9q4GB0+DCiLDVSBmuZvQ6GsmG1W/NZon1tTEt5GhwLlXjvtw==
X-Received: by 2002:a37:8707:: with SMTP id j7mr2202228qkd.394.1583959894824;
        Wed, 11 Mar 2020 13:51:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id 65sm26299047qtf.95.2020.03.11.13.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 13:51:34 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: remove map_from_cluster from ext4_ext_map_blocks
Date:   Wed, 11 Mar 2020 16:51:25 -0400
Message-Id: <20200311205125.25061-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We can use the variable allocated_clusters rather than map_from_clusters
to control reserved block/cluster accounting in ext4_ext_map_blocks.
This eliminates a variable and associated code and improves readability
a little.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bc96529d1509..b12c9e52746c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4181,7 +4181,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
-	bool map_from_cluster = false;
 
 	ext_debug("blocks %u/%u requested for inode %lu\n",
 		  map->m_lblk, map->m_len, inode->i_ino);
@@ -4296,7 +4295,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	    get_implied_cluster_alloc(inode->i_sb, map, ex, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
-		map_from_cluster = true;
 		goto got_allocated_blocks;
 	}
 
@@ -4317,7 +4315,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	    get_implied_cluster_alloc(inode->i_sb, map, ex2, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
-		map_from_cluster = true;
 		goto got_allocated_blocks;
 	}
 
@@ -4418,7 +4415,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * clusters discovered to be delayed allocated.  Once allocated, a
 	 * cluster is not included in the reserved count.
 	 */
-	if (test_opt(inode->i_sb, DELALLOC) && !map_from_cluster) {
+	if (test_opt(inode->i_sb, DELALLOC) && allocated_clusters) {
 		if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) {
 			/*
 			 * When allocating delayed allocated clusters, simply
-- 
2.11.0

