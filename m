Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD62B80F8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKRPmQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgKRPmO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:14 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F24C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u3so1390454pfm.22
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W6rzihCPF7UlsyHHaLuAFfmf9xopI8dxJp/W6QNsfwk=;
        b=HK3BJvrAKA0WvPBDJPe3DM3KlGJ+EbfEsirJHno6aHRYClkh5nEmhAXNDYZSxoi70x
         KrNAzJfnhii44CeFnPDru+hobjnLUVTyOisZkplo9SijzNSV7O5AcCNGyVCGsSEzxSTL
         mUjr5fgBQ7CYfPNDJcCW8josxZd61DGImuphj3KXMyWXVVpqDMqntsTYnb1IJQ27yVk5
         dih9Pnuf5ZoQUqznYTtnn5/ofJ3EAP3yDHkkKlcz4MlPK3IZpVKBoS8QhqRVqpEW9CGE
         4QH5IBRIj977+GYU/xTaWvXoxsCLpq83OlO1gd75a9h7pyQaw9WMZKNNBOggHFXWw1/N
         3qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W6rzihCPF7UlsyHHaLuAFfmf9xopI8dxJp/W6QNsfwk=;
        b=i8jGIQ+jyg565aJAZLlwVURbV0L9AZRNjUVUBsIySZMdcA21aC1QQ3T89UlRHDJnRn
         6Mt59wFMZeDkJKMVJtmUJ2013jOqZncW+M3qp3tmjl44wtMDBXZW/nPuRiUPSRu8JChQ
         sTKQVpcMoHgzAlRlHSJZrAfgiZiZ7z29XeiUeT9B2l6xwr0/jfDIMmBRd1FvRVkwVxfA
         rnvKYAdRSN7spF7jbA/LYN1DE+VENClo73NhTcVkMp6tLuryIukOti0jW+Q/IrtJQMEM
         zSbMkph8zgkgtCFHSV6iIR7VqDSM75/sp+ejF0sIERrkHpxDN/HZfJEn5dd1XhxGC9LO
         jb9w==
X-Gm-Message-State: AOAM532WNr1Lz+xFImgTCL11Efxi+QPph+JxsVr0RnciXpmi2fiprnX3
        9z6iEGVznxRtDCazzMkmzO8zhvJvKxZ7Mn7JZOtsphHq3YPGijHtcUn9PVXtbLcN0pSmtAAwt65
        iM87ACAATxc2aTXrsP5DjZ4UcD0PPXw7ROtnvetnqyJaUIoxuZ4NAJzCIw4gDNrxsBekKaTZyv6
        NDPeCgEqY=
X-Google-Smtp-Source: ABdhPJyKDuVjAvFf3NyFopb/zzYEFjlSS9ZQ1ktp2J6VOZHp2A0QyppnrzhaQDHLtW3S1gs3DmEHikaGKvGg6tELDFI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a62:1896:0:b029:197:491c:be38 with
 SMTP id 144-20020a6218960000b0290197491cbe38mr5020930pfy.15.1605714133245;
 Wed, 18 Nov 2020 07:42:13 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:43 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-58-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 57/61] ext2fs: fix to set tail flags with pfsck enabled
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

If any of block/inode bitmap block checksum error happen,
tail flag should be set properly.

However, we firstly set tail flags in each thread, after
threads finish we clear those tail problem wrongly.

This will make fsck miss bitmap checksum erors later,
patch try to fix the problem by move all this kind of
logic in read_bitmaps_range_end()

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 lib/ext2fs/rw_bitmaps.c | 46 +++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index 5fde2632..b66ba773 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -264,7 +264,7 @@ cleanup:
 
 static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_block,
 					  dgrp_t start, dgrp_t end, pthread_mutex_t *mutex,
-					  io_channel io)
+					  io_channel io, int *tail_flags)
 {
 	dgrp_t i;
 	char *block_bitmap = 0, *inode_bitmap = 0;
@@ -272,7 +272,6 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 	errcode_t retval = 0;
 	int block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
 	int inode_nbytes = EXT2_INODES_PER_GROUP(fs->super) / 8;
-	int tail_flags = 0;
 	int csum_flag;
 	unsigned int	cnt;
 	blk64_t	blk;
@@ -343,7 +342,7 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 			blk_itr += cnt;
 			blk_cnt -= cnt;
 		}
-		goto success_cleanup;
+		goto cleanup;
 	}
 
 	blk_itr += ((blk64_t)start * (block_nbytes << 3));
@@ -374,7 +373,7 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 				}
 				if (!bitmap_tail_verify((unsigned char *) block_bitmap,
 							block_nbytes, fs->blocksize - 1))
-					tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
+					*tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
 			} else
 				memset(block_bitmap, 0, block_nbytes);
 			cnt = block_nbytes << 3;
@@ -414,7 +413,7 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 				}
 				if (!bitmap_tail_verify((unsigned char *) inode_bitmap,
 							inode_nbytes, fs->blocksize - 1))
-					tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+					*tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
 			} else
 				memset(inode_bitmap, 0, inode_nbytes);
 			cnt = inode_nbytes << 3;
@@ -430,14 +429,6 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 		}
 	}
 
-success_cleanup:
-	if (start == 0 && end == fs->group_desc_count - 1) {
-		if (inode_bitmap)
-			fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-		if (block_bitmap)
-			fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
-	}
-	fs->flags |= tail_flags;
 cleanup:
 	if (inode_bitmap)
 		ext2fs_free_mem(&inode_bitmap);
@@ -450,7 +441,7 @@ cleanup:
 }
 
 static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_block,
-					errcode_t retval)
+					errcode_t retval, int tail_flags)
 {
 
 	if (retval)
@@ -461,7 +452,11 @@ static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_blo
 		retval = mark_uninit_bg_group_blocks(fs);
 		if (retval)
 			goto cleanup;
+		fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
 	}
+	if (do_inode)
+		fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
+	fs->flags |= tail_flags;
 
 	return 0;
 cleanup:
@@ -480,14 +475,16 @@ static errcode_t read_bitmaps_range(ext2_filsys fs, int do_inode, int do_block,
 				    dgrp_t start, dgrp_t end)
 {
 	errcode_t retval;
+	int tail_flags = 0;
 
 	retval = read_bitmaps_range_prepare(fs, do_inode, do_block);
 	if (retval)
 		return retval;
 
-	retval = read_bitmaps_range_start(fs, do_inode, do_block, start, end, NULL, NULL);
+	retval = read_bitmaps_range_start(fs, do_inode, do_block, start, end, NULL,
+					  NULL, &tail_flags);
 
-	return read_bitmaps_range_end(fs, do_inode, do_block, retval);
+	return read_bitmaps_range_end(fs, do_inode, do_block, retval, tail_flags);
 }
 
 #ifdef CONFIG_PFSCK
@@ -499,6 +496,7 @@ struct read_bitmaps_thread_info {
 	dgrp_t		rbt_grp_end;
 	errcode_t	rbt_retval;
 	pthread_mutex_t *rbt_mutex;
+	int		rbt_tail_flags;
 	io_channel      rbt_io;
 };
 
@@ -534,7 +532,7 @@ static void* read_bitmaps_thread(void *data)
 	rbt->rbt_retval = read_bitmaps_range_start(rbt->rbt_fs,
 				rbt->rbt_do_inode, rbt->rbt_do_block,
 				rbt->rbt_grp_start, rbt->rbt_grp_end,
-				rbt->rbt_mutex, rbt->rbt_io);
+				rbt->rbt_mutex, rbt->rbt_io, &rbt->rbt_tail_flags);
 	return NULL;
 }
 #endif
@@ -550,7 +548,7 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 	errcode_t retval;
 	errcode_t rc;
 	dgrp_t average_group;
-	int i;
+	int i, tail_flags = 0;
 	io_manager manager = unix_io_manager;
 #else
 	int num_threads = 1;
@@ -584,6 +582,7 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		thread_infos[i].rbt_do_inode = do_inode;
 		thread_infos[i].rbt_do_block = do_block;
 		thread_infos[i].rbt_mutex = &rbt_mutex;
+		thread_infos[i].rbt_tail_flags = 0;
 		if (i == 0)
 			thread_infos[i].rbt_grp_start = 0;
 		else
@@ -614,6 +613,7 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
 		rc = thread_infos[i].rbt_retval;
 		if (rc && !retval)
 			retval = rc;
+		tail_flags |= thread_infos[i].rbt_tail_flags;
 		io_channel_close(thread_infos[i].rbt_io);
 	}
 out:
@@ -623,15 +623,7 @@ out:
 	free(thread_infos);
 	free(thread_ids);
 
-	retval = read_bitmaps_range_end(fs, do_inode, do_block, retval);
-	if (!retval) {
-		if (do_inode)
-			fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-		if (do_block)
-			fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
-	}
-
-	return retval;
+	return read_bitmaps_range_end(fs, do_inode, do_block, retval, tail_flags);
 #endif
 }
 
-- 
2.29.2.299.gdc1121823c-goog

