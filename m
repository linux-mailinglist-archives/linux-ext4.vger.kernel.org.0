Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3935735D5EF
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Apr 2021 05:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbhDMDb5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 23:31:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45503 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241613AbhDMDb5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 23:31:57 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13D3VX6q000587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 23:31:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2EB1715C3B1E; Mon, 12 Apr 2021 23:31:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH] ext4: allow the dax flag to be set and cleared on inline directories
Date:   Mon, 12 Apr 2021 23:31:24 -0400
Message-Id: <20210413033124.2256508-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is needed to allow generic/620 to pass for file systems with the
inline data_feature enabled, and it allows the use of file systems
where the directories use inline_data, while the files are accessed
via DAX.

Cc: stable@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ialloc.c | 3 ++-
 fs/ext4/ioctl.c  | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 5f0c7fe32672..71d321b3b984 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1292,7 +1292,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
-	if (ext4_has_feature_inline_data(sb))
+	if (ext4_has_feature_inline_data(sb) &&
+	    (!(ei->i_flags & EXT4_DAX_FL) || S_ISDIR(mode)))
 		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	ret = inode;
 	err = dquot_alloc_inode(inode);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a2cf35066f46..0796bfa72829 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -315,6 +315,12 @@ static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
 static bool dax_compatible(struct inode *inode, unsigned int oldflags,
 			   unsigned int flags)
 {
+	/* Allow the DAX flag to be changed on inline directories */
+	if (S_ISDIR(inode->i_mode)) {
+		flags &= ~EXT4_INLINE_DATA_FL;
+		oldflags &= ~EXT4_INLINE_DATA_FL;
+	}
+
 	if (flags & EXT4_DAX_FL) {
 		if ((oldflags & EXT4_DAX_MUT_EXCL) ||
 		     ext4_test_inode_state(inode,
-- 
2.31.0

