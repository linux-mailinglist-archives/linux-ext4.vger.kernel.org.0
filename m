Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07F2AA27B
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKGFKd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 00:10:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55279 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbgKGFKc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 00:10:32 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A75A5mr005910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Nov 2020 00:10:06 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B5801420107; Sat,  7 Nov 2020 00:10:05 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     harshads@google.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] ext4: fix sparse warnings in fast_commit code
Date:   Sat,  7 Nov 2020 00:09:58 -0500
Message-Id: <20201107050959.2561329-1-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add missing __acquire() and __releases() annotations, and make
fc_ineligible_reasons[] static, as it is not used outside of
fs/ext4/fast_commit.c.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/fast_commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5cd6630ab1b9..f2033e13a273 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -156,6 +156,7 @@ void ext4_fc_init_inode(struct inode *inode)
 
 /* This function must be called with sbi->s_fc_lock held. */
 static void ext4_fc_wait_committing_inode(struct inode *inode)
+__releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
 {
 	wait_queue_head_t *wq;
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -911,6 +912,8 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 
 /* Commit all the directory entry updates */
 static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
+__acquires(&sbi->s_fc_lock)
+__releases(&sbi->s_fc_lock)
 {
 	struct super_block *sb = (struct super_block *)(journal->j_private);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -2106,7 +2109,7 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
 	journal->j_fc_cleanup_callback = ext4_fc_cleanup;
 }
 
-const char *fc_ineligible_reasons[] = {
+static const char *fc_ineligible_reasons[] = {
 	"Extended attributes changed",
 	"Cross rename",
 	"Journal flag changed",
-- 
2.28.0

