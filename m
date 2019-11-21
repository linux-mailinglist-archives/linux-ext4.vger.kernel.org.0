Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF0105206
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 13:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKUMD1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 07:03:27 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:46432 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUMD1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Nov 2019 07:03:27 -0500
Received: by mail-io1-f51.google.com with SMTP id i11so3016588iol.13
        for <linux-ext4@vger.kernel.org>; Thu, 21 Nov 2019 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L/x9tUqQhjdpRa2LtXLBLTJ2xFdOcU6J44P4Yyl8c68=;
        b=B3ntd+LBJtvOCmPSP/lGTQywwYMCWKqGHtp16wVlD534TwATKSEu3JZLH9nH1BDeDF
         T25N1f2JE8xkDWhh1GgfZOZgud7zPxFsKCW0yrwNpizFqW8qVUdagM3RiCtheqq28N9I
         RLfMSJsyRuf43nUd2Yzs7/C6unTmGGtlkL2GuHtswvVamtA+QVY63BhBxFxzBQIxeYmH
         AH6VkeP9khrTCvDSYFbH9Qk0PpYYUqriFXmNpWmjRHrik05OPxALLZ4xEC/O3vWcUe7q
         +qMz62/+O2fZEegf5hI0WEPs9sH7fVe542tGm+TvxDzUYzBqcLFNHUF3d0Z4j2oKnr/i
         5w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L/x9tUqQhjdpRa2LtXLBLTJ2xFdOcU6J44P4Yyl8c68=;
        b=JUyfUeMnXpFmyfZDZz0yyKf/Y+MepnQfyW3ri2EcqY6liMKOSgqUD7u0WjjqaLeepU
         a+Q+AKvgOqh7/X+2yxhbr7Z8U5k1ZOYChL1xXtvW/X6w/e08PpUPoqKdYYAWBL0ochjv
         hrhUaU9FkiGwOrv9yIbT8p0ZxBp8eZZHblHedUb5P/tL1WgfJaUkcACJYJ+gT87k6nwT
         rJ6RcddUhj1URJgMkGTKin0lxD6E7DujiCvx9L1YJ7oC2IE5v//KOCDFi1Bz6lTIjr75
         DQ5a3pkRoJmQP4ej6M50HSqLxMJMxBXitYxcqNH9Gq4QnVeViQRJSkD69I/RFxp2NezC
         v7XA==
X-Gm-Message-State: APjAAAWF9gVEU3K/849Zau0p0ZwSNuXlXr57bn+5QhwWPtRYBmkXztf8
        BxFIMoCM9aA29E3eugY/0NB9DOfH4X3IEw==
X-Google-Smtp-Source: APXvYqx8gz+zzfJFapLKFi54Puh2SQN2fQiCGAcpcVB87ocYp1tEUgRmX3TWv88cviv5aAKK8KQFCQ==
X-Received: by 2002:a6b:4e05:: with SMTP id c5mr7514032iob.6.1574337806155;
        Thu, 21 Nov 2019 04:03:26 -0800 (PST)
Received: from C02TN4C6HTD6.us.cray.com (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id r16sm1069166ilk.63.2019.11.21.04.03.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 04:03:25 -0800 (PST)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <c17828@cray.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, Vladimir Saveliev <c17830@cray.com>
Subject: [REF] LUS-6746 debugfs: fake_fill_fs to fragment filesystem
Date:   Thu, 21 Nov 2019 15:03:15 +0300
Message-Id: <20191121120315.14481-1-c17828@cray.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Vladimir Saveliev <c17830@cray.com>

New command is added to debugfs: fake_fill_fs <filling in %>

This command finds free blocks on a filesystem and mark as in use
specified fraction of those.

Example: debugfs -w -R 'fake_fill_fs 50' <device>

This can be to used in order to quickly fragment a filesystem which
may useful for block allocation improvement estimation.

Use it carefully, there is no way to recover free space but using
e2fsck.

Change-Id: Ib7ce7794eefac2726fef334810a5832d52a90398
Signed-off-by: Vladimir Saveliev <c17830@cray.com>
Signed-off-by: Artem Blagodarenko <c17828@cray.com>
Cray-bug-id: LUS-6746
---
 debugfs/debug_cmds.ct |  2 ++
 debugfs/debugfs.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/debugfs/debug_cmds.ct b/debugfs/debug_cmds.ct
index 1ff6c9dc..12557888 100644
--- a/debugfs/debug_cmds.ct
+++ b/debugfs/debug_cmds.ct
@@ -229,5 +229,7 @@ request do_journal_write, "Write a transaction to the journal",
 request do_journal_run, "Recover the journal",
 	journal_run, jr;
 
+request do_fake_fill_fs, "Make the filesystem to look as if it was full",
+	fake_fill_fs;
 end;
 
diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 9b701455..25731883 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -2209,6 +2209,36 @@ err:
 	ext2fs_free_mem(&buf);
 }
 
+void do_fake_fill_fs(int argc, char *argv[])
+{
+	__u64 block_count, i;
+	unsigned long v;
+	char *tmp;
+	int f;
+
+	if (common_args_process(argc, argv, 2, 2, argv[0],
+				"filling(%)", CHECK_FS_BITMAPS))
+		return;
+	if (check_fs_read_write(argv[0]))
+		return;
+	v = strtoul(argv[1], &tmp, 0);
+	if (v < 1 || v > 100) {
+		com_err("argv[0]", 0, "filling [1-100]");
+	}
+
+	block_count = ext2fs_blocks_count(current_fs->super);
+	for (i = 1, f = 0; i < block_count; i++) {
+		if (!ext2fs_test_block_bitmap2(current_fs->block_map, i)) {
+			f %= 100;
+			if (f < v)
+				ext2fs_block_alloc_stats2(current_fs, i, +1);
+			f ++;
+		}
+	}
+
+	ext2fs_mark_bb_dirty(current_fs);
+}
+
 #ifndef READ_ONLY
 void do_set_current_time(int argc, char *argv[],
 			 int sci_idx EXT2FS_ATTR((unused)),
-- 
2.14.3 (Apple Git-98)

