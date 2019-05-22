Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1FF26010
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEVJD2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 05:03:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728518AbfEVJD2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 May 2019 05:03:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F098B04F;
        Wed, 22 May 2019 09:03:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C7F91E3C75; Wed, 22 May 2019 11:03:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext4: Do not delete unlinked inode from orphan list on failed truncate
Date:   Wed, 22 May 2019 11:03:16 +0200
Message-Id: <20190522090317.28716-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190522090317.28716-1-jack@suse.cz>
References: <20190522090317.28716-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It is possible that unlinked inode enters ext4_setattr() (e.g. if
somebody calls ftruncate(2) on unlinked but still open file). In such
case we should not delete the inode from the orphan list if truncate
fails. Note that this is mostly a theoretical concern as filesystem is
corrupted if we reach this path anyway but let's be consistent in our
orphan handling.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9bcb7f2b86dd..c7f77c643008 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5625,7 +5625,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ext4_journal_stop(handle);
 			if (error) {
-				if (orphan)
+				if (orphan && inode->i_nlink)
 					ext4_orphan_del(NULL, inode);
 				goto err_out;
 			}
-- 
2.16.4

