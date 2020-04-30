Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB011BE915
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 22:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD2Utk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 16:49:40 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:27436 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgD2Utk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 16:49:40 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 29 Apr 2020 13:46:57 -0700
Received: from localhost.localdomain (ashwinh-vm-1.vmware.com [10.110.19.225])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6EBBD40A68;
        Wed, 29 Apr 2020 13:46:57 -0700 (PDT)
From:   ashwin-h <ashwinh@vmware.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <rostedt@goodmis.org>,
        <srostedt@vmware.com>, <gregkh@linuxfoundation.org>,
        <ashwin.hiranniah@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ashwin H <ashwinh@vmware.com>
Subject: [PATCH 5/5] ext4: unsigned int compared against zero
Date:   Thu, 30 Apr 2020 10:05:21 +0530
Message-ID: <2ead7f45424af49aa7ce34debf479531d0a12904.1587718568.git.ashwinh@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587718568.git.ashwinh@vmware.com>
References: <cover.1587718568.git.ashwinh@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: ashwinh@vmware.com does not
 designate permitted sender hosts)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit fbbbbd2f28aec991f3fbc248df211550fbdfd58c upstream.

There are two cases where u32 variables n and err are being checked
for less than zero error values, the checks is always false because
the variables are not signed. Fix this by making the variables ints.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ashwin H <ashwinh@vmware.com>
---
 fs/ext4/block_validity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 3f3d82d..ccd80f2 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -141,7 +141,8 @@ static int ext4_protect_reserved_inode(struct super_block *sb, u32 ino)
 	struct inode *inode;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_map_blocks map;
-	u32 i = 0, err = 0, num, n;
+	u32 i = 0, num;
+	int err = 0, n;
 
 	if ((ino < EXT4_ROOT_INO) ||
 	    (ino > le32_to_cpu(sbi->s_es->s_inodes_count)))
-- 
2.7.4

