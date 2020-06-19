Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52921200034
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 04:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFSC36 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 22:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgFSC36 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 22:29:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419BC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:29:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so3969671pje.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1vNYzU723rnH34dc3A/qQf7lbzeNCyVcvQcdqpZQ58s=;
        b=Illj7ntHhrwPos4H8sFiENT+JcsW9S2bzdA0TSlCuRPbNcd/nViiiskZK1eZpNfUzy
         M0DK/K1jzglx9c2jaoRAb3+M+aCy4CqAorvTij7wQE9WejyODisIV3XOHApEQuxKIVzJ
         wX/5EKtAsfNJIKj7mL6TyjZ3zGWGxcmshifMkjLEKwfWymMELx8/WGF2y32+mz50F/Wf
         Fb1rwUEx8SrhitIOX10OdLqQeEvoIQDU0zw2o7ezRmD8OStQat8WYZVPi7f3ehw7bewK
         38QXFLrKcl0K2HD3Vv5MmFEj0ayxU2XCPPjIFrmcyswcRlv1FCdd+/090lpmZx+zqt/N
         aJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1vNYzU723rnH34dc3A/qQf7lbzeNCyVcvQcdqpZQ58s=;
        b=s9pKmTis6W2iFEWOoaz9xlt6seE0kx8HDIKb2j5LutgOmXKTgs0cUeH1327IeuQG7N
         j6/MXGtRc0p7ZFroeSWbuZilyUuZG70usbj+KGfuZBgs1/Lgfdp5dZKTl4xjpJZ6ZOgK
         mSCDfar8zIYBkPDq1/bgo6sPdyCtSOr3DSSEAmHPQ+Kksf7tTb6OR8LH56tM9pwCk4GS
         sH85omFyrjx4syFLfsYQnLs8JqVoxclrAz0l3n+0cOlYBe9BagErkJ6Li/721mYv89dQ
         mt6irstEtCC/HHMm8jxnbKlv4In1rPprfASy3rJXCKEYOf6o8DH0nSZoi47QYqfuYUe9
         cAjw==
X-Gm-Message-State: AOAM533p5hEt/nbIxpa31ZOfxCAcrwLQuOFXp04kdzHb+LZxJ+W1nz81
        a10yNnuLmENaJRiI1JSvVVkIErzn+qM=
X-Google-Smtp-Source: ABdhPJx6z+qCzvGtLZ0R2L2ylv9f5EKB+hyg54YI2AM/mkkzQSUIYlHyElXZmf7X3x36yQpWjk71ww==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5mr5941834pls.187.1592533797235;
        Thu, 18 Jun 2020 19:29:57 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y5sm3557158pgl.85.2020.06.18.19.29.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 19:29:56 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     ebiggers@kernel.org, Wang Shilong <wshilong@ddn.com>
Subject: [PATCH v3] ext2fs: fix to avoid invalid memory access
Date:   Fri, 19 Jun 2020 11:29:48 +0900
Message-Id: <1592533788-24392-1-git-send-email-wangshilong1991@gmail.com>
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
v2->v3:
fixed patch title
v1->v2:
kept same return value for corruption case as before.
---
 lib/ext2fs/csum.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
index c2550365..417a1fba 100644
--- a/lib/ext2fs/csum.c
+++ b/lib/ext2fs/csum.c
@@ -266,16 +266,14 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
 	d = dirent;
 	top = EXT2_DIRENT_TAIL(dirent, fs->blocksize);
 
-	rec_len = translate(d->rec_len);
 	while ((void *) d < top) {
-		if ((rec_len < 8) || (rec_len & 0x03))
+		rec_len = translate(d->rec_len);
+		if ((rec_len < 8) || (rec_len & 0x03) ||
+		    (rec_len > (char *)dirent + fs->blocksize - (char *)d))
 			return EXT2_ET_DIR_CORRUPTED;
 		d = (struct ext2_dir_entry *)(((char *)d) + rec_len);
-		rec_len = translate(d->rec_len);
 	}
 
-	if ((char *)d > ((char *)dirent + fs->blocksize))
-			return EXT2_ET_DIR_CORRUPTED;
 	if (d != top)
 		return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;
 
-- 
2.25.4

