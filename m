Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CB2A8DD5
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKFD71 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD71 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:27 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E6C0613D2
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:27 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so120616pfn.0
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iqE4INhNABlrwChA0F3o0aFxOLjzY4wiZ+eGXCuc8g=;
        b=LrJAk2tgzrxNAH2fg9deQAG7DZu2IwiU6DDpG1YBedwJVffb795etstXMa6Do6Oc9W
         ha8uzEA8vaCGvR389LU/yaV99HiGn8BN1MSsuvhA6yVCjXTvhmlXBLDKYZQsszXV2C1i
         Q8X9A0MVpEzqxxebe9ksweSuoRWXUfY5AiBHtjj4QcUvF1OHfDLQ7Htu9Ns5eZPeNcPv
         ucPLuIIz8PpSe+yfeZ0fXW83KOQw0OQ/dZCpYD7b5yv3+Vqp4hoxaEnZyDEuLGMSAkyF
         jOvaFA9clXR1oL5MYVI8Y7RmhaWWQB33666sqCaQP1paQqejge9IngIl1szPZJsPa35b
         HpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iqE4INhNABlrwChA0F3o0aFxOLjzY4wiZ+eGXCuc8g=;
        b=Pgfr19i/ph7gZsCs5s6QOjk76/CYQX0D3TBNuwIExMDjicpbKVb3mkGabyH7yOJp9B
         Ja80y3WaQQLJmJTU7Xd11/NwtQx8AwmM51hw7LR0sGVKTLRfFONC25G948Rvh46QCDhp
         blN+4t2Ic2xgevnD27GZbck6bXleo9pN4FGDh4Iv4U9WjfPqKGzPfZYVdVF8qxoI29aN
         HujXhgD6LLQLBNJzTxwxYQTwa0WVL0gT6xudd6jrUj9f7Li5eNAzdmHU86qtm5I7UGki
         hmhoZ2WuvaeGXttqA8c/02IRm/YCjNCcpDzFvD9sMqzKMDMLG2JK2j3AjldJ/P7AOTsS
         QlbQ==
X-Gm-Message-State: AOAM532+mnd7N8Nv+RY/jDUIhln9WqnvxRGQvb6+zfxsmTeRKn13o3ws
        Um5V9eebcyTg0ag8vimvaC53glpp880=
X-Google-Smtp-Source: ABdhPJyWZoHCKlbhSYQeBJ6wedQ/Um+EFgJwAhW2239mIRGs/fYq3RMc3EL0dbiBdmNPSb7hIBVO8A==
X-Received: by 2002:aa7:9207:0:b029:18a:ab6f:3a7a with SMTP id 7-20020aa792070000b029018aab6f3a7amr198754pfo.72.1604635166192;
        Thu, 05 Nov 2020 19:59:26 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:25 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 03/22] ext4: drop redundant calls ext4_fc_track_range
Date:   Thu,  5 Nov 2020 19:58:52 -0800
Message-Id: <20201106035911.1942128-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_fc_track_range() should only be called when blocks are added or
removed from an inode. So, the only places from where we need to call
this function are ext4_map_blocks(), punch hole, collapse / zero
range, truncate. Remove all the other redundant calls to ths function.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/extents.c | 5 -----
 fs/ext4/super.c   | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 559100f3e23c..1db762c770ca 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3723,7 +3723,6 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
 out:
 	ext4_ext_show_leaf(inode, path);
-	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
 	return err;
 }
 
@@ -3795,7 +3794,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	if (*allocated > map->m_len)
 		*allocated = map->m_len;
 	map->m_len = *allocated;
-	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
 	return 0;
 }
 
@@ -4329,7 +4327,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	map->m_len = ar.len;
 	allocated = map->m_len;
 	ext4_ext_show_leaf(inode, path);
-	ext4_fc_track_range(inode, map->m_lblk, map->m_lblk + map->m_len - 1);
 out:
 	ext4_ext_drop_refs(path);
 	kfree(path);
@@ -4651,8 +4648,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
-	ext4_fc_track_range(inode, offset >> blkbits,
-			(offset + len - 1) >> blkbits);
 
 	ext4_fc_start_update(inode);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d92de21212e9..804f9fc5bdbd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6561,10 +6561,6 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	brelse(bh);
 out:
 	if (inode->i_size < off + len) {
-		ext4_fc_track_range(inode,
-			(inode->i_size > 0 ? inode->i_size - 1 : 0)
-				>> inode->i_sb->s_blocksize_bits,
-			(off + len) >> inode->i_sb->s_blocksize_bits);
 		i_size_write(inode, off + len);
 		EXT4_I(inode)->i_disksize = inode->i_size;
 		err2 = ext4_mark_inode_dirty(handle, inode);
-- 
2.29.1.341.ge80a0c044ae-goog

