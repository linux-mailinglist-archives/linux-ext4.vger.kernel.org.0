Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE13EA5B7
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 15:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhHLNb4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 09:31:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhHLNbx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 09:31:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 86C0B1FF44;
        Thu, 12 Aug 2021 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628775087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p1SSmc5Fh+0CH2li65ZMkp4QQnaodc5HT64+DdjKQ1E=;
        b=BfD9UcWt6rk2cJ+i7l44bL2KrNUC018DEEBki3hjwDOempL2Poj+qY16iiqW7B391x4V+l
        yCzxPx9ethofzAHCo0uoBLTzvCupy0k5mJkkioDSx/YKoHETv+rSOwyHGv15lKVyhBIFo6
        JHIemlSORLH5LiooP1IQ6GBVFkLjLBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628775087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p1SSmc5Fh+0CH2li65ZMkp4QQnaodc5HT64+DdjKQ1E=;
        b=p+KC8YTTSq9Sdo9OrruRiq2oS+QzY8j8hMiyxNPfxYHQclllujQB2i5owIxskx7Rz5a+sQ
        qVTBRGf2BX9+ldCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7C2DBA3F7C;
        Thu, 12 Aug 2021 13:31:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5C9531E0A2E; Thu, 12 Aug 2021 15:31:26 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Make sure quota files are not grabbed accidentally
Date:   Thu, 12 Aug 2021 15:31:22 +0200
Message-Id: <20210812133122.26360-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; h=from:subject; bh=jKx54rgTw+/LZiX6ntE3BJHR5Dh7dWDX6PND18ZvdYo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhFSKkNMIbkMJXEFhrm0fOBmNfdYjmSH4nrjZ/W9yL Mgkvt/aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYRUipAAKCRCcnaoHP2RA2VRjB/ 9XYAWcI5XFSww+pYV9p02Vs8/mX/6MuSD9IcxgDfWmZT++2VkFR+6FOPrI+HWj7qcc0p6Dx+W3P/5y KAZ/SfJmJ3HtO4PreZmmVLdCMZpEb/bSSLPWwFBlLNLq467KcGuf++h3QN6ZG0LEUK2He7rUBgeUU6 /x4Qx6QHnQ+H6tFCBKOkZSJBC5KgJhCysBxFnL4QZulMWkkzt6SXErbeQ/eAIbWiEvCYv8ZDO7EA7t ZnNRPekNUNpQ19iYpefyle26wgsYOARJxYB3BHCmjN3ddQdh2XKYRovTB6Zt/Qvtd0p11MSyDFY/gk R+MtCOlCTsGjMV+H5L2KpxIFc5O1af
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ext4 filesystem is corrupted so that quota files are linked from
directory hirerarchy, bad things can happen. E.g. quota files can get
corrupted or deleted. Make sure we are not grabbing quota file inodes
when we expect normal inodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..2c33c795c4a7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4603,6 +4603,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_iloc iloc;
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
@@ -4613,9 +4614,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	projid_t i_projid;
 
 	if ((!(flags & EXT4_IGET_SPECIAL) &&
-	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
+	     ((ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO) ||
+	      ino == le32_to_cpu(es->s_usr_quota_inum) ||
+	      ino == le32_to_cpu(es->s_grp_quota_inum) ||
+	      ino == le32_to_cpu(es->s_prj_quota_inum))) ||
 	    (ino < EXT4_ROOT_INO) ||
-	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
+	    (ino > le32_to_cpu(es->s_inodes_count))) {
 		if (flags & EXT4_IGET_HANDLE)
 			return ERR_PTR(-ESTALE);
 		__ext4_error(sb, function, line, false, EFSCORRUPTED, 0,
-- 
2.26.2

