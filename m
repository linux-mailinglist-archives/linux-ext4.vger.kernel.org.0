Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EE5F852B
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Oct 2022 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJHMFi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 Oct 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJHMFh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 Oct 2022 08:05:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E293BC59
        for <linux-ext4@vger.kernel.org>; Sat,  8 Oct 2022 05:05:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so6764229pgb.6
        for <linux-ext4@vger.kernel.org>; Sat, 08 Oct 2022 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdW6SI+F//3ow98Dn1jIQAGi/75CSKnKNV1GE6u8D6o=;
        b=PWsZb7oW7k3dgneuk5CWf4kfr9emxM3gxWb7fXihQJkniTHJ4DvMW4j4HjpvCmjBlC
         RmPHMiHZFaopaXPMKKY/hbSML1YKU6/ILgyCjwlC0YlwoNNSjBmCGCGnLnAQdgHhRJQq
         S7jeQIdttkqUzym5OgGmpUs0flmnZhOQRxY6+Au58W1h7CMGnrP23BU3NrT3LDBSdQxn
         x65zpabVjuhdUQl3aKwzAPxHd5vrZsxKensChNQZkx4xzah2gT64amzwJUK/6+idW2Ml
         BLZNy8+UwXZYPZ0ep5gc3H8QPav1K8aMZN59YEK7mF1iPTYxoRSuEFHZxsiVKoajGaaB
         TDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdW6SI+F//3ow98Dn1jIQAGi/75CSKnKNV1GE6u8D6o=;
        b=PBu25VwpjV2K6bPcBkCywMHmBTZkCK49WDbuxYrUiS33Z7oqowoVyc3yubtYbTcbNd
         mYB5N3Q2rQWjMyW8qQ8hhUr0cqEndVlOXP1RzQuUB+qn4zTyGcMdj5kdax9KlPeBZMGP
         AfJ9/voKwBunNLK3awzx3/oyhxeOsU4MJbBZnR7SbttOAD1ljI2HNlBtNGDQjzpbw6i+
         HAeQwWVFFOTnRV+XukOQ+RBpgX7vfgrkWkuVrgQ+NJ6pMa1K4bxoUSOWd8af7aDGYjT4
         87fk9k+kjApSVbIt1vlKQcKsXglM0ahM9owUSATJAAUdaX1lXePDYm4+ZptdhRWrhH3d
         lRxw==
X-Gm-Message-State: ACrzQf1xEj9DpzRbhmf2oQE3YISGV6CorZXYdloJ0VaotN12WCi0wGBB
        gtAj6Z6gotMAxxvYbt/4W0W+uw==
X-Google-Smtp-Source: AMsMyM4t+zUAHKDKxmzWn9W3HzD1o1VcPu46MmgloYTtEQp1dyvb4sbn58OCunnAA3VLnPR2Dn1nyg==
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id g7-20020a056a001a0700b005416060705dmr10201443pfv.61.1665230734700;
        Sat, 08 Oct 2022 05:05:34 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id u2-20020a62d442000000b0056272195028sm3322499pfl.84.2022.10.08.05.05.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Oct 2022 05:05:34 -0700 (PDT)
From:   changfengnan <changfengnan@bytedance.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        changfengnan <changfengnan@bytedance.com>
Subject: [PATCH] ext4: split ext4_journal_start trace for debug
Date:   Sat,  8 Oct 2022 20:05:18 +0800
Message-Id: <20221008120518.74870-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

we might want to know why jbd2 thread using high io for detail,
split ext4_journal_start trace to ext4_journal_start_sb and
ext4_journal_start_inode, show ino and handle type when possible.

Signed-off-by: changfengnan <changfengnan@bytedance.com>
---
 fs/ext4/ext4_jbd2.c         | 14 ++++++---
 fs/ext4/ext4_jbd2.h         | 10 +++----
 fs/ext4/ialloc.c            |  4 +--
 include/trace/events/ext4.h | 57 ++++++++++++++++++++++++++++++-------
 4 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0fd0c42a4f7d..50651aad988b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -86,15 +86,21 @@ static int ext4_journal_check_start(struct super_block *sb)
 	return 0;
 }
 
-handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
+handle_t *__ext4_journal_start_sb(struct inode *inode,
+				  struct super_block *sb, unsigned int line,
 				  int type, int blocks, int rsv_blocks,
 				  int revoke_creds)
 {
 	journal_t *journal;
 	int err;
-
-	trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
-				 _RET_IP_);
+	if (inode)
+		trace_ext4_journal_start_inode(inode, blocks, rsv_blocks,
+					revoke_creds, type,
+					_RET_IP_);
+	else
+		trace_ext4_journal_start_sb(sb, blocks, rsv_blocks,
+					revoke_creds, type,
+					_RET_IP_);
 	err = ext4_journal_check_start(sb);
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 00dc668e052b..5693f1edd63c 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -263,9 +263,9 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 #define ext4_handle_dirty_super(handle, sb) \
 	__ext4_handle_dirty_super(__func__, __LINE__, (handle), (sb))
 
-handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
-				  int type, int blocks, int rsv_blocks,
-				  int revoke_creds);
+handle_t *__ext4_journal_start_sb(struct inode *inode, struct super_block *sb,
+				  unsigned int line, int type, int blocks,
+				  int rsv_blocks, int revoke_creds);
 int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle);
 
 #define EXT4_NOJOURNAL_MAX_REF_COUNT ((unsigned long) 4096)
@@ -305,7 +305,7 @@ static inline int ext4_trans_default_revoke_credits(struct super_block *sb)
 }
 
 #define ext4_journal_start_sb(sb, type, nblocks)			\
-	__ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0,	\
+	__ext4_journal_start_sb(NULL, (sb), __LINE__, (type), (nblocks), 0,\
 				ext4_trans_default_revoke_credits(sb))
 
 #define ext4_journal_start(inode, type, nblocks)			\
@@ -325,7 +325,7 @@ static inline handle_t *__ext4_journal_start(struct inode *inode,
 					     int blocks, int rsv_blocks,
 					     int revoke_creds)
 {
-	return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
+	return __ext4_journal_start_sb(inode, inode->i_sb, line, type, blocks,
 				       rsv_blocks, revoke_creds);
 }
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b215c564bc31..5951899fd7ec 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1073,8 +1073,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 
 		if ((!(sbi->s_mount_state & EXT4_FC_REPLAY)) && !handle) {
 			BUG_ON(nblocks <= 0);
-			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
-				 handle_type, nblocks, 0,
+			handle = __ext4_journal_start_sb(NULL, dir->i_sb,
+				 line_no, handle_type, nblocks, 0,
 				 ext4_trans_default_revoke_credits(sb));
 			if (IS_ERR(handle)) {
 				err = PTR_ERR(handle);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index b14314fcf732..33e36c4c58e4 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1795,18 +1795,19 @@ TRACE_EVENT(ext4_load_inode,
 		  (unsigned long) __entry->ino)
 );
 
-TRACE_EVENT(ext4_journal_start,
+TRACE_EVENT(ext4_journal_start_sb,
 	TP_PROTO(struct super_block *sb, int blocks, int rsv_blocks,
-		 int revoke_creds, unsigned long IP),
+		 int revoke_creds, int type, unsigned long IP),
 
-	TP_ARGS(sb, blocks, rsv_blocks, revoke_creds, IP),
+	TP_ARGS(sb, blocks, rsv_blocks, revoke_creds, type, IP),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
-		__field(unsigned long,	ip			)
-		__field(	  int,	blocks			)
-		__field(	  int,	rsv_blocks		)
-		__field(	  int,	revoke_creds		)
+		__field(	dev_t,		dev		)
+		__field(	unsigned long,	ip		)
+		__field(	int,		blocks		)
+		__field(	int,		rsv_blocks	)
+		__field(	int,		revoke_creds	)
+		__field(	int,		type		)
 	),
 
 	TP_fast_assign(
@@ -1815,11 +1816,45 @@ TRACE_EVENT(ext4_journal_start,
 		__entry->blocks		 = blocks;
 		__entry->rsv_blocks	 = rsv_blocks;
 		__entry->revoke_creds	 = revoke_creds;
+		__entry->type		 = type;
+	),
+
+	TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d,"
+		  " type %d, caller %pS", MAJOR(__entry->dev),
+		  MINOR(__entry->dev), __entry->blocks, __entry->rsv_blocks,
+		  __entry->revoke_creds, __entry->type, (void *)__entry->ip)
+);
+
+TRACE_EVENT(ext4_journal_start_inode,
+	TP_PROTO(struct inode *inode, int blocks, int rsv_blocks,
+		 int revoke_creds, int type, unsigned long IP),
+
+	TP_ARGS(inode, blocks, rsv_blocks, revoke_creds, type, IP),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	ino		)
+		__field(	dev_t,		dev		)
+		__field(	unsigned long,	ip		)
+		__field(	int,		blocks		)
+		__field(	int,		rsv_blocks	)
+		__field(	int,		revoke_creds	)
+		__field(	int,		type		)
+	),
+
+	TP_fast_assign(
+		__entry->dev		 = inode->i_sb->s_dev;
+		__entry->ip		 = IP;
+		__entry->blocks		 = blocks;
+		__entry->rsv_blocks	 = rsv_blocks;
+		__entry->revoke_creds	 = revoke_creds;
+		__entry->type		 = type;
+		__entry->ino		 = inode->i_ino;
 	),
 
-	TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d, "
-		  "caller %pS", MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->blocks, __entry->rsv_blocks, __entry->revoke_creds,
+	TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d,"
+		  " type %d, ino %lu, caller %pS", MAJOR(__entry->dev),
+		  MINOR(__entry->dev), __entry->blocks, __entry->rsv_blocks,
+		  __entry->revoke_creds, __entry->type, __entry->ino,
 		  (void *)__entry->ip)
 );
 
-- 
2.32.1 (Apple Git-133)

