Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87372F0345
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbfKEQoo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:41608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390357AbfKEQok (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6FC0B1D4;
        Tue,  5 Nov 2019 16:44:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3EC321E4AB6; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/25] ext4: Fix ext4_should_journal_data() for EA inodes
Date:   Tue,  5 Nov 2019 17:44:13 +0100
Message-Id: <20191105164437.32602-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Similarly to directories, EA inodes do only journalled modifications to
their data. Change ext4_should_journal_data() to return true for them so
that we don't have to special-case them during truncate.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index ef8fcf7d0d3b..99fe72522960 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -407,6 +407,7 @@ static inline int ext4_inode_journal_mode(struct inode *inode)
 		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
 	/* We do not support data journalling with delayed allocation */
 	if (!S_ISREG(inode->i_mode) ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
 	    !test_opt(inode->i_sb, DELALLOC))) {
-- 
2.16.4

