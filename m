Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406E41AB2AA
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 22:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636959AbgDOUcT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636913AbgDOUcE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 16:32:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D5C061A10
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 13:32:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y3so18934801qky.8
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xMw3tPRboTpO36kDGfZC7YGAIzuOAm1qhilpSib7u8Q=;
        b=Y4RPc322oXP2sURFvAp7NhPwX8o8k0TDpZYPSCOY0Oxy0Y0rsR7lBjc6/aRyn/jOA/
         9MhgVSqAuep0NcY4nF8KkW+OtK5mQIyCGVHKkJvLb1uupX2Zms7EZIdlouMVLFp9iWZK
         yPbZFxWD6Lz5oH7U/qw2Br61wNWFtxFiipN2aw7UKO344BS+k1ZQsbnIcoSPQJJ9r195
         r9kLkiPyzArTYnT528MMs0i/RQfwqMmpGEEZ5PUYqp/RrQez/Sz2tQEHycdp0o77CkuZ
         QlC9xSsITAYtCV9L1Hk80iiPDmk8EzJDs0oPx6ZRWMSeHNYwzRi62epjWm8MhUji2Qv2
         50sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xMw3tPRboTpO36kDGfZC7YGAIzuOAm1qhilpSib7u8Q=;
        b=acORi/Uoqx9Wg9BYhAUpK5I2SBwDJ0Pq8BTg5pfw+KCeP+7uH+w6yxv+26XGAtxqjA
         0O02VJuVN9lxBkR3LRzS8PJv4a0uRbVJ0B/QZEkFa+cjLbJ8l5WWTn0Cvwxf6PWuMnTI
         IeL26ToSFueLIXtK3zkacG9oowZVRLvekqp0RHKIfhm7qxLQeXgQu2dmp+IqkoCAfPpd
         kt0QIyFdKmIjfKT+R4xTYeE164B6gzwqWTJKLBkakzbAXJVdJO7cRmgQHTHP+2TFbKj9
         Q4fjJD37YicEkotgOpBBt8HtHGuWU8cbVGm4iIEiYm5xMg0+5QvWnt8ITy/sU0nL1fnM
         dCMw==
X-Gm-Message-State: AGi0PubLRKRJe6TsSqfuWoVtYP59VOmxXAwoiCYwjMpBmnPF3CjBG9Yq
        1X2hcR2+1gkJpOxCkVD7Ue9310Dr
X-Google-Smtp-Source: APiQypKsndAviSNjPB1IaXfv/ANlIhZd8IERprl6p3k4TKRoqfi28icsD1siaCYo6Pee+VP7gRf6lQ==
X-Received: by 2002:a37:ac08:: with SMTP id e8mr9427999qkm.439.1586982723001;
        Wed, 15 Apr 2020 13:32:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id x8sm13198305qti.51.2020.04.15.13.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 13:32:02 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 1/2] ext4: remove EXT4_GET_BLOCKS_KEEP_SIZE flag
Date:   Wed, 15 Apr 2020 16:31:39 -0400
Message-Id: <20200415203140.30349-2-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200415203140.30349-1-enwlinux@gmail.com>
References: <20200415203140.30349-1-enwlinux@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The eofblocks code was removed in the 5.7 release by "ext4: remove
EOFBLOCKS_FL and associated code" (4337ecd1fe99).  The ext4_map_blocks()
flag used to trigger it can now be removed as well.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/ext4.h              |  2 --
 fs/ext4/extents.c           |  4 ----
 fs/ext4/inode.c             | 12 ++++--------
 include/trace/events/ext4.h |  1 -
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..c8d060627448 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -609,8 +609,6 @@ enum {
 #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
 	/* Don't normalize allocation size (used for fallocate) */
 #define EXT4_GET_BLOCKS_NO_NORMALIZE		0x0040
-	/* Request will not result in inode size update (user for fallocate) */
-#define EXT4_GET_BLOCKS_KEEP_SIZE		0x0080
 	/* Convert written extents to unwritten */
 #define EXT4_GET_BLOCKS_CONVERT_UNWRITTEN	0x0100
 	/* Write zeros to newly created written extents */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 031752cfb6f7..18ede2f9e4ad 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4507,8 +4507,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-	if (mode & FALLOC_FL_KEEP_SIZE)
-		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 
 	/* Wait all existing dio workers, newcomers will block on i_mutex */
 	inode_dio_wait(inode);
@@ -4647,8 +4645,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-	if (mode & FALLOC_FL_KEEP_SIZE)
-		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 
 	inode_lock(inode);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..97562c51c1c9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -432,11 +432,9 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, flags &
-					     EXT4_GET_BLOCKS_KEEP_SIZE);
+		retval = ext4_ext_map_blocks(handle, inode, map, 0);
 	} else {
-		retval = ext4_ind_map_blocks(handle, inode, map, flags &
-					     EXT4_GET_BLOCKS_KEEP_SIZE);
+		retval = ext4_ind_map_blocks(handle, inode, map, 0);
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
@@ -541,11 +539,9 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		retval = ext4_ext_map_blocks(handle, inode, map, flags &
-					     EXT4_GET_BLOCKS_KEEP_SIZE);
+		retval = ext4_ext_map_blocks(handle, inode, map, 0);
 	} else {
-		retval = ext4_ind_map_blocks(handle, inode, map, flags &
-					     EXT4_GET_BLOCKS_KEEP_SIZE);
+		retval = ext4_ind_map_blocks(handle, inode, map, 0);
 	}
 	if (retval > 0) {
 		unsigned int status;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19c87661eeec..40ff8a2fc763 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -45,7 +45,6 @@ struct partial_cluster;
 	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
 	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
 	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
-	{ EXT4_GET_BLOCKS_KEEP_SIZE,		"KEEP_SIZE" },		\
 	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" })
 
 /*
-- 
2.11.0

