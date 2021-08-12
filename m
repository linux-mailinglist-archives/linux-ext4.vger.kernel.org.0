Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F73EA5BB
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhHLNcs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 09:32:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHLNcr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 09:32:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B57681FF43;
        Thu, 12 Aug 2021 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628775141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rYWsA8XcW9A2jsqwIxl+5DPp6ygf7LhgvmoPdVjCEjc=;
        b=OjuOhmpifvNVnfXDKRuyNbaHEaaBLlTtY8z+/MU7IFH8Kb27uDYbCZi6snHSXjCt55VMn4
        QOnxhM9KJsbkLYHxZs2Ahw5rVwOse0/seSU6wGQmSTnlv8bnAP3tvktQDby4XGCMKhCQNb
        SaeHj3pwPnguwf7TZVBG9h7Fz459b3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628775141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rYWsA8XcW9A2jsqwIxl+5DPp6ygf7LhgvmoPdVjCEjc=;
        b=mvGXEgcUOB7YPLVVHHO9OuSnwsY16BW9ndHMROZ6mvfLCsX2G3VTJTAEGtniz2fiW36k6k
        3qYkkh1KWmG6c6CA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A9F54A3F31;
        Thu, 12 Aug 2021 13:32:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8F9C31E0A2E; Thu, 12 Aug 2021 15:32:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] e2fsck: Make sure quota files are not referenced from dirs
Date:   Thu, 12 Aug 2021 15:32:16 +0200
Message-Id: <20210812133216.26539-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; h=from:subject; bh=oG9VKCoSmlgN+XDcN4XZzK5wXMZxG6wVl/hf46pcMWI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhFSLfXvu259PWfksNmdIv1yf1tiHXOjmRM8BTfr+f iIjugEaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYRUi3wAKCRCcnaoHP2RA2R/CCA Cbr9AqkwXMUG9I8SnqkQ0aFD1roVybHBrIxVHdBoEZcpewNsW2w3vswRPtefsFhsOeyOS18hmvkF1D BXBZI1CST7/zkZmYy65x4tfjDk60+Vqsa5farFOeEmMSWDgma1FW8Cw7neMycxvxDTON96M2V1hWm0 ht76p1eVS0J2gvPc4ZAz56/EDwgRM8wirVEBk8kSCmVMexaSj+mrxaj2YePBdZE1oVBEAI8mu6TvGy 8pGhSrd9abJCKEP2TlMepygqrccLDZIlSWf0TnfAxpuJwlW1+63vK6pEeqA1+zpPrQ095emf584uvx QWoPSW5rhXSkhG9bnvJg/nV1xBq392
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Quota files must not be referenced from directory entries. Otherwise
they can get corrupted under the hands of the kernel.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 e2fsck/pass2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index bd974c551b74..cb80d33311bc 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1441,7 +1441,10 @@ skip_checksum:
 		name_len = ext2fs_dirent_name_len(dirent);
 		if (((dirent->inode != EXT2_ROOT_INO) &&
 		     (dirent->inode < EXT2_FIRST_INODE(fs->super))) ||
-		    (dirent->inode > fs->super->s_inodes_count)) {
+		    (dirent->inode > fs->super->s_inodes_count) ||
+		    (dirent->inode == fs->super->s_usr_quota_inum) ||
+		    (dirent->inode == fs->super->s_grp_quota_inum) ||
+		    (dirent->inode == fs->super->s_prj_quota_inum)) {
 			problem = PR_2_BAD_INO;
 		} else if (ctx->inode_bb_map &&
 			   (ext2fs_test_inode_bitmap2(ctx->inode_bb_map,
-- 
2.26.2

