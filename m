Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7967C1CCC14
	for <lists+linux-ext4@lfdr.de>; Sun, 10 May 2020 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgEJP6N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 May 2020 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgEJP6N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 May 2020 11:58:13 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E3C061A0C
        for <linux-ext4@vger.kernel.org>; Sun, 10 May 2020 08:58:11 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ep1so3407301qvb.0
        for <linux-ext4@vger.kernel.org>; Sun, 10 May 2020 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxpsFW4ptnqFUTjyqgT2cDUk00m5fKFOAMZRIE22Q60=;
        b=ctINJRHSQfO/FzcokfKhz0iGG/nCoNqfq4lOFcLAQ2zlQy7v5Q2M0xwmotXz8aQgSg
         iYr1EA0z8Dulsb1VDshcP4h6h2B0kh+slPSeFzZ4vzyXKhKAXsrWfU2DrrQvef4MZApj
         CbNl+g4j9lkrlRtFpqUt0kwVrT8ZBYUEpr4h0f8LjvcIccmRPlIo1o0TddbeMav5g3it
         MykxRlZCBiHxympb77EQ/Bp8jghmUj9LL+yT3XxHGXU+J9OoN6h3APiz73tukk8BxbSw
         zyJSY4ZC8UwtFu2mu+hkgW8RkpIOyHbaGjpF412CfEG8ZmexoHtkygVKGZ5w7P+AEzfi
         3Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxpsFW4ptnqFUTjyqgT2cDUk00m5fKFOAMZRIE22Q60=;
        b=BdJS16E4kYgAxO5avArY6+mtjfqHURal7FG81P67J92v5aPL7zA6sot+PcTjb8uVq2
         hXI4sgum+HGzJxRdkz263pyzhTd40d7e6+Xc85WF8xW+Jq1bjHS4g38JtresPn1FauMh
         e6daVhS0F0Wyo1uBRv0Drbfzjk0kq20vmAQgdbev0+6Gx2FW3TdSgagUx89tl/ocNjuX
         ld1rnMiMfsBK1WkHP9DKtGcYcGdSbAoHKL9zF4bFNs7imDGtUZMHE/rgFFw5bZgoT6No
         fq+lw5V9A62fmExIFsdnx8+oCfEpdXgz14qJ+Nigo+PHXA7wuvJeqFa/OVWNsGAvVooj
         VfqQ==
X-Gm-Message-State: AGi0PuY0hZ1l5CaxGEBngjCIGaZBekj8kNarmyMCH+gFKy+NSLor1+/e
        8sf3CgzXvGjsZ97Mh8h5ku55erEV
X-Google-Smtp-Source: APiQypKLOI7Cr84HQnpUBoWxJ3cpgpk6uPF3e+eqS1ngUBjR6HNQ50VC1Q3UStS6G8scqcx8osS1JQ==
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr11532158qvb.225.1589126290440;
        Sun, 10 May 2020 08:58:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id j90sm6873438qte.20.2020.05.10.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:58:10 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: rework map struct instantiation in ext4_ext_map_blocks()
Date:   Sun, 10 May 2020 11:58:05 -0400
Message-Id: <20200510155805.18808-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The path performing block allocations in ext4_ext_map_blocks() contains
code trimming the length of a new extent that is repeated later
in the function.  This code is both redundant and unnecessary as the
exact length of the new extent has already been calculated.  Rewrite the
instantiation of the map struct in this case to use the available
values, avoiding the overhead of unnecessary conversions and improving
clarity.  Add another map struct instantiation tailored specifically to
the separate case for an existing written extent.  Remove an old comment
that no longer appears applicable to the current code.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..c01a204ce60b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4024,7 +4024,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	struct ext4_ext_path *path = NULL;
 	struct ext4_extent newex, *ex, *ex2;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	ext4_fsblk_t newblock = 0;
+	ext4_fsblk_t newblock = 0, pblk;
 	int err = 0, depth, ret;
 	unsigned int allocated = 0, offset = 0;
 	unsigned int allocated_clusters = 0;
@@ -4040,7 +4040,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
 		path = NULL;
-		goto out2;
+		goto out;
 	}
 
 	depth = ext_depth(inode);
@@ -4056,7 +4056,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 				 (unsigned long) map->m_lblk, depth,
 				 path[depth].p_block);
 		err = -EFSCORRUPTED;
-		goto out2;
+		goto out;
 	}
 
 	ex = path[depth].p_ext;
@@ -4090,8 +4090,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
 				err = convert_initialized_extent(handle,
 					inode, map, &path, &allocated);
-				goto out2;
+				goto out;
 			} else if (!ext4_ext_is_unwritten(ex)) {
+				map->m_flags |= EXT4_MAP_MAPPED;
+				map->m_pblk = newblock;
+				if (allocated > map->m_len)
+					allocated = map->m_len;
+				map->m_len = allocated;
+				ext4_ext_show_leaf(inode, path);
 				goto out;
 			}
 
@@ -4102,7 +4108,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 				err = ret;
 			else
 				allocated = ret;
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -4127,7 +4133,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_pblk = 0;
 		map->m_len = min_t(unsigned int, map->m_len, hole_len);
 
-		goto out2;
+		goto out;
 	}
 
 	/*
@@ -4151,12 +4157,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	ar.lleft = map->m_lblk;
 	err = ext4_ext_search_left(inode, path, &ar.lleft, &ar.pleft);
 	if (err)
-		goto out2;
+		goto out;
 	ar.lright = map->m_lblk;
 	ex2 = NULL;
 	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
 	if (err)
-		goto out2;
+		goto out;
 
 	/* Check if the extent after searching to the right implies a
 	 * cluster we can use. */
@@ -4217,7 +4223,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.flags |= EXT4_MB_USE_RESERVED;
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
-		goto out2;
+		goto out;
 	ext_debug("allocate new block: goal %llu, found %llu/%u\n",
 		  ar.goal, newblock, allocated);
 	allocated_clusters = ar.len;
@@ -4227,7 +4233,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 
 got_allocated_blocks:
 	/* try to insert new extent into found leaf and return */
-	ext4_ext_store_pblock(&newex, newblock + offset);
+	pblk = newblock + offset;
+	ext4_ext_store_pblock(&newex, pblk);
 	newex.ee_len = cpu_to_le16(ar.len);
 	/* Mark unwritten */
 	if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
@@ -4252,16 +4259,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 					 EXT4_C2B(sbi, allocated_clusters),
 					 fb_flags);
 		}
-		goto out2;
+		goto out;
 	}
 
-	/* previous routine could use block we allocated */
-	newblock = ext4_ext_pblock(&newex);
-	allocated = ext4_ext_get_actual_len(&newex);
-	if (allocated > map->m_len)
-		allocated = map->m_len;
-	map->m_flags |= EXT4_MAP_NEW;
-
 	/*
 	 * Reduce the reserved cluster count to reflect successful deferred
 	 * allocation of delayed allocated clusters or direct allocation of
@@ -4307,14 +4307,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_update_inode_fsync_trans(handle, inode, 1);
 	else
 		ext4_update_inode_fsync_trans(handle, inode, 0);
-out:
-	if (allocated > map->m_len)
-		allocated = map->m_len;
+
+	map->m_flags |= (EXT4_MAP_NEW | EXT4_MAP_MAPPED);
+	map->m_pblk = pblk;
+	map->m_len = ar.len;
+	allocated = map->m_len;
 	ext4_ext_show_leaf(inode, path);
-	map->m_flags |= EXT4_MAP_MAPPED;
-	map->m_pblk = newblock;
-	map->m_len = allocated;
-out2:
+
+out:
 	ext4_ext_drop_refs(path);
 	kfree(path);
 
-- 
2.20.1

