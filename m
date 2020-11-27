Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618F2C63F0
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgK0LeJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgK0LeJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 234C7AC2F;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A8AA11E1316; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 01/12] ext4: Don't remount read-only with errors=continue on reboot
Date:   Fri, 27 Nov 2020 12:33:54 +0100
Message-Id: <20201127113405.26867-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_handle_error() with errors=continue mount option can accidentally
remount the filesystem read-only when the system is rebooting. Fix that.

Fixes: 1dc1097ff60e ("ext4: avoid panic during forced reboot")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 94472044f4c1..2b08b162075c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -666,19 +666,17 @@ static bool system_going_down(void)
 
 static void ext4_handle_error(struct super_block *sb)
 {
+	journal_t *journal = EXT4_SB(sb)->s_journal;
+
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
-	if (sb_rdonly(sb))
+	if (sb_rdonly(sb) || test_opt(sb, ERRORS_CONT))
 		return;
 
-	if (!test_opt(sb, ERRORS_CONT)) {
-		journal_t *journal = EXT4_SB(sb)->s_journal;
-
-		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
-		if (journal)
-			jbd2_journal_abort(journal, -EIO);
-	}
+	ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
+	if (journal)
+		jbd2_journal_abort(journal, -EIO);
 	/*
 	 * We force ERRORS_RO behavior when system is rebooting. Otherwise we
 	 * could panic during 'reboot -f' as the underlying device got already
-- 
2.16.4

