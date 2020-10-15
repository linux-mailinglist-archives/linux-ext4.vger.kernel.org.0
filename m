Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE02E28F09E
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgJOLDd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 07:03:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:34794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgJOLDd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Oct 2020 07:03:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2FC9AFA0;
        Thu, 15 Oct 2020 11:03:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5AF271E1338; Thu, 15 Oct 2020 13:03:31 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Andreas Dilger <adilger@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext4: Detect already used quota file early
Date:   Thu, 15 Oct 2020 13:03:30 +0200
Message-Id: <20201015110330.28716-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When we try to use file already used as a quota file again (for the same
or different quota type), strange things can happen. At the very least
lockdep annotations may be wrong but also inode flags may be wrongly set
/ reset. When the file is used for two quota types at once we can even
corrupt the file and likely crash the kernel. Catch all these cases by
checking whether passed file is already used as quota file and bail
early in that case.

This fixes occasional generic/219 failure due to lockdep complaint.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b49b345..d31ae5a87859 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6042,6 +6042,11 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 	/* Quotafile not on the same filesystem? */
 	if (path->dentry->d_sb != sb)
 		return -EXDEV;
+
+	/* Quota already enabled for this file? */
+	if (IS_NOQUOTA(d_inode(path->dentry)))
+		return -EBUSY;
+
 	/* Journaling quota? */
 	if (EXT4_SB(sb)->s_qf_names[type]) {
 		/* Quotafile not in fs root? */
-- 
2.16.4

