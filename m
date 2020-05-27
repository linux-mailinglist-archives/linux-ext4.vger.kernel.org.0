Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4791E453F
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgE0OJD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgE0OJD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 10:09:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83FC08C5C1
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 07:09:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so11791279pgm.13
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jQNRI+l8uJJt0mnUF9lyAireteisnpWtnB1IBiEZvZk=;
        b=mpABZHQfVwzcrFdW24kkfOV79i0ng5zJwbFiek0w9BPRfy2Tu4XTT7FVZ/0gQyEuEj
         sIYI+DbTZXAcdOyAB+iWQdOX13stltqUjQEqwgAEYLztxUEjBjJX1J6uOZEFuYptrUtw
         qmnIEch567sZiDbeimIDOf8x/WHEWvstFx9GnasRxKDPKj08epFiR7hDQULbTNV3LavO
         PE8dU9kf8hI5KrL6KbMtotHSIgXcJUKxkLeqYFOX0rltvoUquLp4Bo/6A6QAEeYKBmAm
         3NWbdqUYUiku3IFehZ5wckuDSe69/nvm9PRVMdG3u2ScNC4vy17JVVXWSnWRvJtjDgzo
         urTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jQNRI+l8uJJt0mnUF9lyAireteisnpWtnB1IBiEZvZk=;
        b=b/Tg17BaqHM6ZPD3Pdq+c6KUQxF7b/RXUSiAq+v1V+nQUfH2/CjC4x8ynv8Od36+Qk
         LiHswCkMLZVRA3tD2FAgU7udcqnmJZ5dU4NI5s1jI7ikJhddykWdxt9we/tgrnDoD+su
         +iy6rAeUrRBbtvATSeUMBTz9mJS/N500sqQfgB2T1ZDAxKgZxzI8PRPiYFsYcJTxc6px
         Cl5l76jfEmqBwX8ZCwfbP7hULn0+8WHSGkLPn/s8Jzz3ogyvukYEKuWloijbne0ZhyNo
         hr1WCbaRn9CoQWdsH1Lf76sWHm/IKU+s4JVRuZx6zTAedeO0mj5XsLuZUMQsMOh0xpUu
         sXRA==
X-Gm-Message-State: AOAM533fMKR4Ph2p/JTk8elbdiOoxx4G73WHCU2IC8Wm5/QCLGlpxpFr
        dyxwm70QIQYC0cE2oJ/iM6wQViXd0qo=
X-Google-Smtp-Source: ABdhPJxkfLaG3/V0grfE6Rs6ipiMpgO9VCDfc5+sd/SFeiFKHyXrdQiE8P7uUZZiyWJxqcFJw7/I0w==
X-Received: by 2002:a63:9347:: with SMTP id w7mr4023591pgm.409.1590588542233;
        Wed, 27 May 2020 07:09:02 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id q201sm2292580pfq.40.2020.05.27.07.08.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 07:09:01 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 1/2] e2fsprogs: add EXT2_FLAG_BG_WAS_TRIMMED to optimize fstrim
Date:   Wed, 27 May 2020 23:08:43 +0900
Message-Id: <1590588525-29669-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

1)mkfs will set this flag if discard is triggered.
2)whenver we free blocks from block group, this flag will be cleared.
3)make dumpe2fs aware of new flag.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Cc: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 lib/ext2fs/alloc_stats.c  | 8 ++++++--
 lib/ext2fs/alloc_tables.c | 2 ++
 lib/ext2fs/ext2_fs.h      | 1 +
 lib/ext2fs/ext2fs.h       | 1 +
 misc/dumpe2fs.c           | 2 ++
 misc/mke2fs.c             | 3 +++
 6 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
index 3949f618..2a6e0557 100644
--- a/lib/ext2fs/alloc_stats.c
+++ b/lib/ext2fs/alloc_stats.c
@@ -69,10 +69,12 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, blk64_t blk, int inuse)
 #endif
 		return;
 	}
-	if (inuse > 0)
+	if (inuse > 0) {
 		ext2fs_mark_block_bitmap2(fs->block_map, blk);
-	else
+	} else {
 		ext2fs_unmark_block_bitmap2(fs->block_map, blk);
+		ext2fs_bg_flags_clear(fs, group, EXT2_BG_WAS_TRIMMED);
+	}
 	ext2fs_bg_free_blocks_count_set(fs, group, ext2fs_bg_free_blocks_count(fs, group) - inuse);
 	ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
 	ext2fs_group_desc_csum_set(fs, group);
@@ -138,6 +140,8 @@ void ext2fs_block_alloc_stats_range(ext2_filsys fs, blk64_t blk,
 			ext2fs_bg_free_blocks_count(fs, group) -
 			inuse*n/EXT2FS_CLUSTER_RATIO(fs));
 		ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
+		if (inuse < 0)
+			ext2fs_bg_flags_clear(fs, group, EXT2_BG_WAS_TRIMMED);
 		ext2fs_group_desc_csum_set(fs, group);
 		ext2fs_free_blocks_count_add(fs->super, -inuse * (blk64_t) n);
 		blk += n;
diff --git a/lib/ext2fs/alloc_tables.c b/lib/ext2fs/alloc_tables.c
index 971a6ceb..17087890 100644
--- a/lib/ext2fs/alloc_tables.c
+++ b/lib/ext2fs/alloc_tables.c
@@ -250,6 +250,8 @@ errcode_t ext2fs_allocate_group_table(ext2_filsys fs, dgrp_t group,
 		}
 		ext2fs_inode_table_loc_set(fs, group, new_blk);
 	}
+	if (fs->flags & EXT2_FLAG_BG_WAS_TRIMMED)
+		ext2fs_bg_flags_set(fs, group, EXT2_BG_WAS_TRIMMED);
 	ext2fs_group_desc_csum_set(fs, group);
 	return 0;
 }
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 6c20ea77..86d6f438 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -211,6 +211,7 @@ struct ext4_group_desc
 #define EXT2_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not initialized */
 #define EXT2_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not initialized */
 #define EXT2_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT2_BG_WAS_TRIMMED	0x0008	/* Block group was trimmed */
 
 /*
  * Data structures used by the directory indexing feature
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 69c8a3ff..3dd99430 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -206,6 +206,7 @@ typedef struct ext2_file *ext2_file_t;
 #define EXT2_FLAG_IGNORE_SB_ERRORS	0x800000
 #define EXT2_FLAG_BBITMAP_TAIL_PROBLEM	0x1000000
 #define EXT2_FLAG_IBITMAP_TAIL_PROBLEM	0x2000000
+#define EXT2_FLAG_BG_WAS_TRIMMED	0x4000000
 
 /*
  * Special flag in the ext2 inode i_flag field that means that this is
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index d295ba4d..a305ec9b 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -131,6 +131,8 @@ static void print_bg_opts(ext2_filsys fs, dgrp_t i)
  		     &first);
 	print_bg_opt(bg_flags, EXT2_BG_INODE_ZEROED, "ITABLE_ZEROED",
  		     &first);
+	print_bg_opt(bg_flags, EXT2_BG_WAS_TRIMMED, "WAS_TRIMMED",
+		     &first);
 	if (!first)
 		fputc(']', stdout);
 	fputc('\n', stdout);
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index c90dcf0e..07ee620e 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -403,6 +403,7 @@ static errcode_t packed_allocate_tables(ext2_filsys fs)
 		ext2fs_block_alloc_stats_range(fs, goal,
 					       fs->inode_blocks_per_group, +1);
 		ext2fs_inode_table_loc_set(fs, i, goal);
+		ext2fs_bg_flags_set(fs, i, EXT2_BG_WAS_TRIMMED);
 		ext2fs_group_desc_csum_set(fs, i);
 	}
 	return 0;
@@ -3037,6 +3038,8 @@ int main (int argc, char *argv[])
 	/* Can't undo discard ... */
 	if (!noaction && discard && dev_size && (io_ptr != undo_io_manager)) {
 		retval = mke2fs_discard_device(fs);
+		if (!retval)
+			fs->flags |= EXT2_FLAG_BG_WAS_TRIMMED;
 		if (!retval && io_channel_discard_zeroes_data(fs->io)) {
 			if (verbose)
 				printf("%s",
-- 
2.25.4

