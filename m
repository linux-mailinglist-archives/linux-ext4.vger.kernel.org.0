Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA3C1F62
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfI3KnY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730725AbfI3KnW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3D84AEA7;
        Mon, 30 Sep 2019 10:43:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C8A651E4803; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/19] ext4: Do not iput inode under running transaction in ext4_mkdir()
Date:   Mon, 30 Sep 2019 12:43:21 +0200
Message-Id: <20190930104339.24919-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When ext4_mkdir() fails to add entry into directory, it ends up dropping
freshly created inode under the running transaction and thus inode
truncation happens under that transaction. That breaks assumptions that
ext4_evict_inode() does not get called from a transaction context
(although I'm not aware of any real issue) and is completely
unnecessary. Just stop the transaction before dropping inode reference.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129029534075..46e203f100de 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2781,8 +2781,9 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		clear_nlink(inode);
 		unlock_new_inode(inode);
 		ext4_mark_inode_dirty(handle, inode);
+		ext4_journal_stop(handle);
 		iput(inode);
-		goto out_stop;
+		goto out_retry;
 	}
 	ext4_inc_count(handle, dir);
 	ext4_update_dx_flag(dir);
@@ -2796,6 +2797,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 out_stop:
 	if (handle)
 		ext4_journal_stop(handle);
+out_retry:
 	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
 		goto retry;
 	return err;
-- 
2.16.4

