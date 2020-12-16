Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA63D2DBE84
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLPKUM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:20:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:49042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgLPKUM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:20:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D8AFAF2C;
        Wed, 16 Dec 2020 10:18:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DFEF81E1368; Wed, 16 Dec 2020 11:18:49 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] ext4: Use sbi instead of EXT4_SB(sb) in ext4_update_super()
Date:   Wed, 16 Dec 2020 11:18:41 +0100
Message-Id: <20201216101844.22917-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201216101844.22917-1-jack@suse.cz>
References: <20201216101844.22917-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

No behavioral change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3f6ea48e7b4b..502ae491d07d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5470,8 +5470,8 @@ static int ext4_load_journal(struct super_block *sb,
 static void ext4_update_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
-	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
+	struct ext4_super_block *es = sbi->s_es;
+	struct buffer_head *sbh = sbi->s_sbh;
 
 	lock_buffer(sbh);
 	/*
@@ -5488,21 +5488,20 @@ static void ext4_update_super(struct super_block *sb)
 		ext4_update_tstamp(es, s_wtime);
 	if (sb->s_bdev->bd_part)
 		es->s_kbytes_written =
-			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
+			cpu_to_le64(sbi->s_kbytes_written +
 			    ((part_stat_read(sb->s_bdev->bd_part,
 					     sectors[STAT_WRITE]) -
-			      EXT4_SB(sb)->s_sectors_written_start) >> 1));
+			      sbi->s_sectors_written_start) >> 1));
 	else
-		es->s_kbytes_written =
-			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written);
-	if (percpu_counter_initialized(&EXT4_SB(sb)->s_freeclusters_counter))
+		es->s_kbytes_written = cpu_to_le64(sbi->s_kbytes_written);
+	if (percpu_counter_initialized(&sbi->s_freeclusters_counter))
 		ext4_free_blocks_count_set(es,
-			EXT4_C2B(EXT4_SB(sb), percpu_counter_sum_positive(
-				&EXT4_SB(sb)->s_freeclusters_counter)));
-	if (percpu_counter_initialized(&EXT4_SB(sb)->s_freeinodes_counter))
+			EXT4_C2B(sbi, percpu_counter_sum_positive(
+				&sbi->s_freeclusters_counter)));
+	if (percpu_counter_initialized(&sbi->s_freeinodes_counter))
 		es->s_free_inodes_count =
 			cpu_to_le32(percpu_counter_sum_positive(
-				&EXT4_SB(sb)->s_freeinodes_counter));
+				&sbi->s_freeinodes_counter));
 	/* Copy error information to the on-disk superblock */
 	spin_lock(&sbi->s_error_lock);
 	if (sbi->s_add_error_count > 0) {
-- 
2.16.4

