Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B313E1FF662
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgFRPQT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRPQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:16:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A207C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:16:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so2818747pjd.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hAaJ/11zKQnyczJkvfW1v/dYIsmrUv9V2z9pRYtyNYQ=;
        b=azMcJi++/sV/ILQlcskZAKmfTHcAGBuKKoybSTB8tmd+n/VZ8unGMC2NBI+kuRyW2Y
         lK26OA77IoA9nGtc/8ALNnhRvtQmcnIvPuUk1gDvPFXQm5vhlBnJliRn4H9AIjQyWMW1
         WGFfstufO6asgQW1iNagAFiEygACeCTouZRaKLqHgZSIGXQ8i8b+j07LdJVU+2GwYvLK
         Effe5d+Psmmo/VqUpKywY9JjlY6hMgRl0NGWmTOmcwCaWt+5Ou2XioXGA9VDuTtYUsOr
         ok+eRonF+LWdlxv9FZKgCIVRDdNViND21gEteYKHk5QQ+r5VOdaapVI20hbUtMHpRJSb
         nhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hAaJ/11zKQnyczJkvfW1v/dYIsmrUv9V2z9pRYtyNYQ=;
        b=kNMJwwmJ9T+WMtuBV25jE0pg4+yP4wIj+TFgst2bl205lVIPUNT9Kc0RXnpSUJ9QLt
         sJTLa1CcBu6UaKMw1AcCqQNkDvPCxEhEKM4zjYVaYHM2lCB3e5hoKPKQHdDggRib3b3G
         tEfurVfnKbOeofomnjokapVtWSP70PWoTTs8JpEMy9wqIy/lzjvJMowpvYDIO6Y+m4ul
         xGYLCm3tKiIyFfIJ3sRczCikV3/NU7ZSLQn74cABrBiWgtaAkaCDD2pWw1BroXwxnnyj
         xCRgSsxiar5DGl2CzvtY+9qJhZVYMGUx3hH0rzN0bHNnSyriyBXpkFOSMCdbralvXzzD
         BltQ==
X-Gm-Message-State: AOAM530susjnNVvkREvQ+1OXQQ7mOO17lDs4iOkmTW/dXQyT5pZV95eN
        LRA+UB0/F6FbEC/Hyn2a5aJ+ghHwQvI=
X-Google-Smtp-Source: ABdhPJywUC6tc1ZSSluQwcAK/Vbdec0m+JVLqscGKh3dzKEgCZN1qGlPjhq/ACcUvSNxCAGPaTn+zg==
X-Received: by 2002:a17:902:fe95:: with SMTP id x21mr4200656plm.17.1592493378263;
        Thu, 18 Jun 2020 08:16:18 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id 10sm3211935pfn.6.2020.06.18.08.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:16:17 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>
Subject: [PATCH] ext2fs: fix to avoid invalid memory access
Date:   Fri, 19 Jun 2020 00:16:03 +0900
Message-Id: <1592493363-24778-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Valgrind reported error messages like following:

==129205==  Address 0x1b804b04 is 4 bytes after a block of size 4,096 alloc'd
==129205==    at 0x483980B: malloc (vg_replace_malloc.c:307)
==129205==    by 0x44F973: ext2fs_get_mem (ext2fs.h:1846)
==129205==    by 0x44F973: ext2fs_get_pathname (get_pathname.c:162)
==129205==    by 0x430917: print_pathname (message.c:212)
==129205==    by 0x430FB1: expand_percent_expression (message.c:462)
==129205==    by 0x430FB1: print_e2fsck_message (message.c:544)
==129205==    by 0x430BED: expand_at_expression (message.c:262)
==129205==    by 0x430BED: print_e2fsck_message (message.c:528)
==129205==    by 0x430450: fix_problem (problem.c:2494)
==129205==    by 0x423F8B: e2fsck_process_bad_inode (pass2.c:1929)
==129205==    by 0x425AE8: check_dir_block (pass2.c:1407)
==129205==    by 0x426942: check_dir_block2 (pass2.c:961)
==129205==    by 0x445736: ext2fs_dblist_iterate3.part.0 (dblist.c:254)
==129205==    by 0x423835: e2fsck_pass2 (pass2.c:187)
==129205==    by 0x414B19: e2fsck_run (e2fsck.c:257)

Dir block might be corrupted and cause the next dirent is out
of block size boundary, even though we have the check to avoid
problem, memory check tools like valgrind still complains it.

Patch try to fix the problem by checking if offset exceed max
offset firstly before getting the pointer.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 lib/ext2fs/csum.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
index c2550365..643777fd 100644
--- a/lib/ext2fs/csum.c
+++ b/lib/ext2fs/csum.c
@@ -260,22 +260,24 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
 	void *top;
 	struct ext2_dir_entry_tail *t;
 	unsigned int rec_len;
+	unsigned int max_len;
 	errcode_t retval = 0;
 	__u16 (*translate)(__u16) = (need_swab ? disk_to_host16 : do_nothing16);
 
 	d = dirent;
 	top = EXT2_DIRENT_TAIL(dirent, fs->blocksize);
 
+	max_len = (char *)top - (char *)dirent;
 	rec_len = translate(d->rec_len);
 	while ((void *) d < top) {
 		if ((rec_len < 8) || (rec_len & 0x03))
 			return EXT2_ET_DIR_CORRUPTED;
+		if ((char *)d - (char *)dirent + rec_len > max_len)
+			return EXT2_ET_DIR_CORRUPTED;
 		d = (struct ext2_dir_entry *)(((char *)d) + rec_len);
 		rec_len = translate(d->rec_len);
 	}
 
-	if ((char *)d > ((char *)dirent + fs->blocksize))
-			return EXT2_ET_DIR_CORRUPTED;
 	if (d != top)
 		return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;
 
-- 
2.25.4

