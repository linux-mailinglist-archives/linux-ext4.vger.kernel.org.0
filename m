Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF052DF3F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiESVYj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiESVYe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 17:24:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714AED8C5
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 14:24:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EDE691F45F99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652995473;
        bh=n36NzGnXFuZBQyLINpfVhMRK9nBSM6nyts/SKCy4wzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m57SytYlEwhPdcab1KEpVPRwn1a1TDYapeVyAn3I1coKDcrrsPDKknqGBaVSesFJY
         QsDYsAAUIz7UMSAQFigwMjTKVRqChPpFERR/Huowy5aR5n3Brc5F/uvln0TsBHkOoq
         UiwCN0jZqoJL0QRZUwLHMatZd7u3LppvBpV0VseVLoSlKN7HqiITmlL7FTSWfMREdH
         UhBkNwKR3CgRKt9NquU854n8ZtIU9BRxHtyl0X6EOj7qo3K5P8BWO+E62QKmBSas3I
         O6yNZluYGcenYB9d+DeCgO4ls+L1/1CAN8WPcOHl8qJ6anP34+5VCVV2yhRJBBmcOU
         MpaDo/X0vcOrg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Eric Biggers <ebiggers@google.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v8 8/8] f2fs: Move CONFIG_UNICODE defguards into the code flow
Date:   Thu, 19 May 2022 17:23:59 -0400
Message-Id: <20220519212359.19442-9-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519212359.19442-1-krisman@collabora.com>
References: <20220519212359.19442-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v4:
  - Drop stub removal for !CONFIG_UNICODE case (eric)
---
 fs/f2fs/namei.c | 11 +++++------
 fs/f2fs/super.c |  8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5f213f05556d..8567a9045df1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -561,8 +561,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -571,7 +570,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		trace_f2fs_lookup_end(dir, dentry, ino, err);
 		return NULL;
 	}
-#endif
+
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
 	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
@@ -622,16 +621,16 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 	f2fs_delete_entry(de, page, dir, inode);
-#if IS_ENABLED(CONFIG_UNICODE)
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at f2fs_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
+
 	f2fs_unlock_op(sbi);
 
 	if (IS_DIRSYNC(dir))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index baefd398ec1a..b17bd7a70d53 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -283,7 +283,7 @@ struct kmem_cache *f2fs_cf_name_slab;
 static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
-							F2FS_NAME_LEN);
+						   F2FS_NAME_LEN);
 	if (!f2fs_cf_name_slab)
 		return -ENOMEM;
 	return 0;
@@ -1259,13 +1259,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (f2fs_sb_has_casefold(sbi)) {
+
+	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
 		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
-#endif
+
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
-- 
2.36.1

