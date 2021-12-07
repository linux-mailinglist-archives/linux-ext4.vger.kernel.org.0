Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F346BC67
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Dec 2021 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhLGN1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Dec 2021 08:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLGN1c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Dec 2021 08:27:32 -0500
X-Greylist: delayed 113 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Dec 2021 05:24:02 PST
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E7C061574
        for <linux-ext4@vger.kernel.org>; Tue,  7 Dec 2021 05:24:02 -0800 (PST)
Received: from sas1-3cba3404b018.qloud-c.yandex.net (sas1-3cba3404b018.qloud-c.yandex.net [IPv6:2a02:6b8:c08:bd26:0:640:3cba:3404])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A0E462E1266;
        Tue,  7 Dec 2021 16:22:05 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-3cba3404b018.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id wmhcicDE9Z-M4L0KOYj;
        Tue, 07 Dec 2021 16:22:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1638883325; bh=hSsMpGpTiWx56hVhebXdpy2CNk65gk9DOxqT8at/XK0=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=ARguXs9vZtzQGpqhOfllscCPPSUcMABLpU5cE5WbwWs4e+FOdR3w/h11gug5hxHAV
         pNQO/z5x/2QSkP7AyzRQvnZdBC/+jIwxzP7LBPaOC9Q1NZcdp4kcYE4xukIDtA6XD0
         P4Oq0nl3z6gkeI7Z3DLBgK3fxAiFqCBwDywjN2p8=
Authentication-Results: sas1-3cba3404b018.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MgmvWEnvra-M4QehhLF;
        Tue, 07 Dec 2021 16:22:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID rather than check EXT4_INODE_PROJINHERIT flag
Date:   Tue,  7 Dec 2021 16:18:42 +0300
Message-Id: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
ext4_statfs() output incorrect (function does not apply quota limits
on used/available space, etc) when called on dentry of regular file
with project quota enabled.

This patch fixes this by comparing inode's i_projid with
EXT4_DEF_PROJID, as there is no point in calling ext4_statfs_project()
for inode with default project id.

$ sudo project_quota info dir/
project   2147516417
usage     4096
limit     5242880
inodes    4
ilimit    0
$ sudo project_quota info dir/file | grep project
project   2147516417
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      232M  2.1M  214M   1% /mnt/ext4img

without patch:
$ df -h dir/
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      5.0M  4.0K  5.0M   1% /mnt/ext4img
$ df -h dir/file
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      232M  2.1M  214M   1% /mnt/ext4img

with patch:
$ df -h dir/
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      5.0M  4.0K  5.0M   1% /mnt/ext4img
$ df -h dir/file
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      5.0M  4.0K  5.0M   1% /mnt/ext4img

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
---
 fs/ext4/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 79b6a0c..682d675 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6074,6 +6074,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
+	kprojid_t kprojid;
 	ext4_fsblk_t overhead = 0, resv_blocks;
 	s64 bfree;
 	resv_blocks = EXT4_C2B(sbi, atomic64_read(&sbi->s_resv_clusters));
@@ -6098,9 +6099,10 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_fsid = uuid_to_fsid(es->s_uuid);
 
 #ifdef CONFIG_QUOTA
-	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
+	kprojid = EXT4_I(dentry->d_inode)->i_projid;
+	if ((from_kprojid(current_user_ns(), kprojid) != EXT4_DEF_PROJID) &&
 	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
-		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
+		ext4_statfs_project(sb, kprojid, buf);
 #endif
 	return 0;
 }
-- 
2.7.4

