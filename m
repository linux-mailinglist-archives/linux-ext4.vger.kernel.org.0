Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1D1BE8FF
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 22:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgD2UrA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 16:47:00 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:26956 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727119AbgD2Uq6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 16:46:58 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 29 Apr 2020 13:46:54 -0700
Received: from localhost.localdomain (ashwinh-vm-1.vmware.com [10.110.19.225])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id F3E9040A68;
        Wed, 29 Apr 2020 13:46:53 -0700 (PDT)
From:   ashwin-h <ashwinh@vmware.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <rostedt@goodmis.org>,
        <srostedt@vmware.com>, <gregkh@linuxfoundation.org>,
        <ashwin.hiranniah@gmail.com>, Ashwin H <ashwinh@vmware.com>
Subject: [PATCH 4/5] ext4: fix block validity checks for journal inodes using indirect blocks
Date:   Thu, 30 Apr 2020 10:05:20 +0530
Message-ID: <df5dda74a3a798b3453d431d4d2860ecdb23674d.1587718568.git.ashwinh@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587718568.git.ashwinh@vmware.com>
References: <cover.1587718568.git.ashwinh@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: ashwinh@vmware.com does not
 designate permitted sender hosts)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 170417c8c7bb2cbbdd949bf5c443c0c8f24a203b upstream.

Commit 345c0dbf3a30 ("ext4: protect journal inode's blocks using
block_validity") failed to add an exception for the journal inode in
ext4_check_blockref(), which is the function used by ext4_get_branch()
for indirect blocks.  This caused attempts to read from the ext3-style
journals to fail with:

[  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block

Fix this by adding the missing exception check.

Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ashwin H <ashwinh@vmware.com>
---
 fs/ext4/block_validity.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 093639b..3f3d82d 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -274,6 +274,11 @@ int ext4_check_blockref(const char *function, unsigned int line,
 	__le32 *bref = p;
 	unsigned int blk;
 
+	if (ext4_has_feature_journal(inode->i_sb) &&
+	    (inode->i_ino ==
+	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+		return 0;
+
 	while (bref < p+max) {
 		blk = le32_to_cpu(*bref++);
 		if (blk &&
-- 
2.7.4

