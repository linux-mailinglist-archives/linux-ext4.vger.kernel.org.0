Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE17200029
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 04:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgFSC00 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 22:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFSC0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 22:26:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24EC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:26:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ne5so3434695pjb.5
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UqVaagynY59uZFcArkL4jE3eXVudc6htekLGUw1E/tk=;
        b=lgCQHYKPcB8+ix398h9MKCoh6iazDibzEVTqIyWSW3kgR0wM4Udd01ZJgc7zwzWtkH
         mQwVklY6lZluPXWopvxd6sTj6VdunYNKlgnopj/3rdYyAJhr2B9mwdqGBwk16GbVPBoy
         IR/7kcH+mLE4NfJHJ2tZsi45pD9D9wMveu6hO1PQoML28aZReGZg7Unzkmore5Q6Zvuq
         CHEA4GgwKwRsZlONKGA6e7P87bfhLL5W01COHm6imq5lbBQkpVSpo2ko/c0BhJ1wBYoo
         TzqcdxZpu6QHtRyj5XLNdrZTICWxzeLZbO3Cw5XK6PiNPT9BUQuNx/gfWDyTE8lvFySF
         uRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UqVaagynY59uZFcArkL4jE3eXVudc6htekLGUw1E/tk=;
        b=WMCs1QP0ESXHJ9D0/wfNsuUJq4IU8qeh8dKCLaQqc+TobEl4f/X7i8iWuaiVj/fyxC
         kcnOOfgwjaSHHpiY1rFtcj6mGa9vCAPSjUhZc9XdOxbee8Req7gb6AA7s6UCHJg/Lb+K
         sCQr80PLMnyJMzctF3YxKBMz2l3RtLcvoUQh/oaSE4EhWsc2Ecg6yns691F3D3o77dne
         UbIgEFamX5Jcw6JRPAeW4G9c0LWeCV6kVDlnzlmzFUi+OvANpUE4NnC83O+gJ7A86ndW
         xSOJexxFDIkFlvyiptfQ07fiFRv3iOcXaTVjNf9lrR2/4ggqiu3idGikqEyLnvinvfvd
         J1DA==
X-Gm-Message-State: AOAM533wWaT93HoGdr1t7Y7glHUYlN+ksoUk6cVc8LGTfQAtbF9/4XFr
        aLG/xEL464ebkixiU/odNLwDUwpwtcU=
X-Google-Smtp-Source: ABdhPJz+Y2O1R5dqi7Wai8ZTkdeDxPt8UVRb+PEgeGE1BvDi6O9DIMgRlUMjJqyI1Uza2/O/rAv/CQ==
X-Received: by 2002:a17:902:b40e:: with SMTP id x14mr6295248plr.285.1592533583348;
        Thu, 18 Jun 2020 19:26:23 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id j123sm4118305pfd.160.2020.06.18.19.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 19:26:22 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     ebiggers@kernel.org, Wang Shilong <wshilong@ddn.com>
Subject: [PATCH v2] Valgrind reported error messages like following:
Date:   Fri, 19 Jun 2020 11:26:14 +0900
Message-Id: <1592533574-24249-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

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

