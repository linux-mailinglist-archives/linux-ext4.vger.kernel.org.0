Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC0149D47
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2020 23:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgAZWLs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jan 2020 17:11:48 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:53246 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgAZWLp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jan 2020 17:11:45 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jan 2020 17:11:44 EST
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id vq0Ei1dErRnrKvq0Gibz51; Sun, 26 Jan 2020 15:03:36 -0700
X-Authority-Analysis: v=2.3 cv=L7FjvNb8 c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=RPJ6JBhKAAAA:8 a=qvgq-4WEZONlWX85OdcA:9
 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] ext4: don't assume that mmp_nodename/bdevname have NUL
Date:   Sun, 26 Jan 2020 15:03:34 -0700
Message-Id: <1580076215-1048-1-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1579983942-11927-1-git-send-email-adilger@dilger.ca>
References: <1579983942-11927-1-git-send-email-adilger@dilger.ca>
X-CMAE-Envelope: MS4wfHK4orTQoqpBv8hdwMUMayl+Wwg4xqVhIRJXniO/z5BqdTmrie3chfgQ1PEI0XQK7DOwn6w9eQoBGmlwQCWVAC7RmF7gvXQvAmLr6CZCoX1tMuHaqRQD
 JvlnGo5pzllyOSpKtYKwxmEd1jH+JTnjftqYy+2fSUxH8bOunNnKINqjJa5laECq5/h4GHKnafhcgrrJUBwcguqVcwAz6jwO3RrShkbl2bjF8Henu/+umuXI
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't assume that the mmp_nodename and mmp_bdevname strings are NUL
terminated, since they are filled in by snprintf(), which is not
guaranteed to do so.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/mmp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 2305b43..9d00e0d 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -120,10 +120,10 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
 {
 	__ext4_warning(sb, function, line, "%s", msg);
 	__ext4_warning(sb, function, line,
-		       "MMP failure info: last update time: %llu, last update "
-		       "node: %s, last update device: %s",
-		       (long long unsigned int) le64_to_cpu(mmp->mmp_time),
-		       mmp->mmp_nodename, mmp->mmp_bdevname);
+		       "MMP failure info: last update time: %llu, last update node: %.*s, last update device: %.*s",
+		       (unsigned long long)le64_to_cpu(mmp->mmp_time),
+		       (int)sizeof(mmp->mmp_nodename), mmp->mmp_nodename,
+		       (int)sizeof(mmp->mmp_bdevname), mmp->mmp_bdevname);
 }
 
 /*
@@ -154,6 +154,7 @@ static int kmmpd(void *data)
 	mmp_check_interval = max(EXT4_MMP_CHECK_MULT * mmp_update_interval,
 				 EXT4_MMP_MIN_CHECK_INTERVAL);
 	mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
+	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
 	bdevname(bh->b_bdev, mmp->mmp_bdevname);
 
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
@@ -375,7 +376,8 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
 	 */
-	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, mmpd_data, "kmmpd-%s",
+	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, mmpd_data, "kmmpd-%.*s",
+					     (int)sizeof(mmp->mmp_bdevname),
 					     bdevname(bh->b_bdev,
 						      mmp->mmp_bdevname));
 	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
-- 
1.8.0

