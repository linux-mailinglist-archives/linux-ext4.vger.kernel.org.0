Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D5224932
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEUHoH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 03:44:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfEUHoH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 May 2019 03:44:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E026DAD62;
        Tue, 21 May 2019 07:44:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CF4221E3C5F; Tue, 21 May 2019 09:44:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext4: Do not delete unlinked inode from orphan list on failed truncate
Date:   Tue, 21 May 2019 09:43:57 +0200
Message-Id: <20190521074358.17186-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521074358.17186-1-jack@suse.cz>
References: <20190521074358.17186-1-jack@suse.cz>
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

