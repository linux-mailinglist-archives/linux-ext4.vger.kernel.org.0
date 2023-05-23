Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A170DD49
	for <lists+linux-ext4@lfdr.de>; Tue, 23 May 2023 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbjEWNOi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjEWNOh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 09:14:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC05118;
        Tue, 23 May 2023 06:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F5B4205BF;
        Tue, 23 May 2023 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684847675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ny+bUixye0AimuZoDHDUfbMnbqu5VFeD5uG3RHHRsek=;
        b=FDOVTqloCfcovwDADwOwUKaaLoaqpL9yF+1U/Yoc3QDKaGCBSOe6y7tzDlkhHMQmcKLWqi
        oNKSceNrrrPgYVKUnowW5VbIrVYct5r4eCwnSzWhGSp+0GIs0IVpl8+i2aS4avWsMIrxDD
        KMwB2OxRAogqBkUmytzG5gXD3jEn7DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684847675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ny+bUixye0AimuZoDHDUfbMnbqu5VFeD5uG3RHHRsek=;
        b=Kmn/y1lSffuw1rLQBtVPyK/2mtbypjn2dB8/ZP5WyjW9wPeF8LWN/RMAmcqImxemGanbK9
        9tYuMnk2i6q59ODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A95C713A10;
        Tue, 23 May 2023 13:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QeRMKTq8bGQ7QAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 13:14:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27665A075D; Tue, 23 May 2023 15:14:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH] ext4: Fix possible corruption when moving a directory with RENAME_EXCHANGE
Date:   Tue, 23 May 2023 15:14:08 +0200
Message-Id: <20230523131408.13470-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=jack@suse.cz; h=from:subject; bh=zWR7wi5AkSZmJ0EPVdDjSqaDjas6W9CeqOL+C2hKgcI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbLwZYNC8LlDITBZQOef/xGv09xQgg3X7igF0Hc+f utnsdAmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZGy8GQAKCRCcnaoHP2RA2WGkCA CSFMJt7lbr3mWnWqBh1gpR6aLMMnx+XPDmhFsAxVXyJWmoM0IntF+YFQrYMVZqbAps+Y6JxQ8gtI3+ wlgFC7JVkybXgWipGO43GJm74uuxlkkgKrUUEPmziur/CENAEHjb+4KCxwa94NWZn5Ag1PbehslFhq j0FqhtTjtKKeC38lvJskS61n6UsxPVI1VhcNxeKuk4eTJyqBL0gGKm2qYFCPeOJ6g5Fu/xZyQ+k/Ns lMAhixRg1vmkVIK63E6f1nE8DtbCtOq3BI3wSyTXW2xX/8lxKmaejnzvCung3xosz45zaSu+nL5MMG IbYlaIUCLdcqC5PXj7LnYvtdR7QOym
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 0813299c586b ("ext4: Fix possible corruption when moving a
directory") forgot that handling of RENAME_EXCHANGE renames needs the
protection of inode lock when changing directory parents for moved
directories. Add proper locking for that case as well.

CC: stable@vger.kernel.org
Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 45b579805c95..b91abea1c781 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4083,10 +4083,25 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (retval)
 		return retval;
 
+	/*
+	 * We need to protect against old.inode and new.inode directory getting
+	 * converted from inline directory format into a normal one. The lock
+	 * ordering does not matter here as old and new are guaranteed to be
+	 * incomparable in the directory hierarchy.
+	 */
+	if (S_ISDIR(old.inode->i_mode))
+		inode_lock(old.inode);
+	if (S_ISDIR(new.inode->i_mode))
+		inode_lock_nested(new.inode, I_MUTEX_NONDIR2);
+
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
 				 &old.de, &old.inlined);
-	if (IS_ERR(old.bh))
-		return PTR_ERR(old.bh);
+	if (IS_ERR(old.bh)) {
+		retval = PTR_ERR(old.bh);
+		old.bh = NULL;
+		goto end_rename;
+	}
+
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
 	 *  We might rmdir the source, keep it as pwd of some process
@@ -4186,6 +4201,10 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	retval = 0;
 
 end_rename:
+	if (S_ISDIR(old.inode->i_mode))
+		inode_unlock(old.inode);
+	if (S_ISDIR(new.inode->i_mode))
+		inode_unlock(new.inode);
 	brelse(old.dir_bh);
 	brelse(new.dir_bh);
 	brelse(old.bh);
-- 
2.35.3

