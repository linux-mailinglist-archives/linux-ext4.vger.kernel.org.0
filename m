Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA972B86A4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 22:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKRVe3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 16:34:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:52538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgKRVe2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Nov 2020 16:34:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53FB1B01D;
        Wed, 18 Nov 2020 21:34:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79CE71E133C; Wed, 18 Nov 2020 16:30:33 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix bogus warning in ext4_update_dx_flag()
Date:   Wed, 18 Nov 2020 16:30:32 +0100
Message-Id: <20201118153032.17281-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The idea of the warning in ext4_update_dx_flag() is that we should warn
when we are clearing EXT4_INODE_INDEX on a filesystem with metadata
checksums enabled since after clearing the flag, checksums for internal
htree nodes will become invalid. So there's no need to warn (or actually
do anything) when EXT4_INODE_INDEX is not set.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 48a34311953d ("ext4: fix checksum errors with indexed dirs")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f976b5089476..5ee04ee27769 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2685,7 +2685,8 @@ void ext4_insert_dentry(struct inode *inode,
 			struct ext4_filename *fname);
 static inline void ext4_update_dx_flag(struct inode *inode)
 {
-	if (!ext4_has_feature_dir_index(inode->i_sb)) {
+	if (!ext4_has_feature_dir_index(inode->i_sb) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_INDEX)) {
 		/* ext4_iget() should have caught this... */
 		WARN_ON_ONCE(ext4_has_feature_metadata_csum(inode->i_sb));
 		ext4_clear_inode_flag(inode, EXT4_INODE_INDEX);
-- 
2.16.4

