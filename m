Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C325055B
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHXROd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 13:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgHXQhO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Aug 2020 12:37:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC1922D02;
        Mon, 24 Aug 2020 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287005;
        bh=u4IJMTS/G8l/ijc3tLxdY3Q7332lX//ETY2kIGJqiW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2goOFFWF+CQYtlzwEYfjMBc394cVj6YGsv7G8c7RbMfw57FvldSgX2EWRPxTOg6bj
         DNGJj3maxzLbUgSKi+1wbnh8Cz49hop0IW9IU3T+ezz2/QMTYBVc5LZ6HT7COo9Tkj
         yFfNiKmRp4Jo1Odcbob1gNA6fP1Exen6CXP890Bc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 08/54] ext4: handle option set by mount flags correctly
Date:   Mon, 24 Aug 2020 12:35:47 -0400
Message-Id: <20200824163634.606093-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

[ Upstream commit f25391ebb475d3ffb3aa61bb90e3594c841749ef ]

Currently there is a problem with mount options that can be both set by
vfs using mount flags or by a string parsing in ext4.

i_version/iversion options gets lost after remount, for example

$ mount -o i_version /dev/pmem0 /mnt
$ grep pmem0 /proc/self/mountinfo | grep i_version
310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,seclabel,i_version
$ mount -o remount,ro /mnt
$ grep pmem0 /proc/self/mountinfo | grep i_version

nolazytime gets ignored by ext4 on remount, for example

$ mount -o lazytime /dev/pmem0 /mnt
$ grep pmem0 /proc/self/mountinfo | grep lazytime
310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel
$ mount -o remount,nolazytime /mnt
$ grep pmem0 /proc/self/mountinfo | grep lazytime
310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel

Fix it by applying the SB_LAZYTIME and SB_I_VERSION flags from *flags to
s_flags before we parse the option and use the resulting state of the
same flags in *flags at the end of successful remount.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/20200723150526.19931-1-lczerner@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f4d7289462d9b..f9c692d7fd849 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5391,7 +5391,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct ext4_super_block *es;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	unsigned long old_sb_flags;
+	unsigned long old_sb_flags, vfs_flags;
 	struct ext4_mount_options old_opts;
 	int enable_quota = 0;
 	ext4_group_t g;
@@ -5434,6 +5434,14 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
 
+	/*
+	 * Some options can be enabled by ext4 and/or by VFS mount flag
+	 * either way we need to make sure it matches in both *flags and
+	 * s_flags. Copy those selected flags from *flags to s_flags
+	 */
+	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
+	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
+
 	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
 		err = -EINVAL;
 		goto restore_opts;
@@ -5487,9 +5495,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 	}
 
-	if (*flags & SB_LAZYTIME)
-		sb->s_flags |= SB_LAZYTIME;
-
 	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
 		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED) {
 			err = -EROFS;
@@ -5637,7 +5642,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 #endif
 
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
+	/*
+	 * Some options can be enabled by ext4 and/or by VFS mount flag
+	 * either way we need to make sure it matches in both *flags and
+	 * s_flags. Copy those selected flags from s_flags to *flags
+	 */
+	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
+
 	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
 	kfree(orig_data);
 	return 0;
-- 
2.25.1

