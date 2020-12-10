Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE56B2D6437
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393015AbgLJR6a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392999AbgLJR5e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:34 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39F6C0611CD
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:53 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g20so2328351plo.2
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsoMrK007vCXVz+5bIHJDilPrz2cJmWYXgUTf1R25O4=;
        b=vAkEXst85ASeNIGAyCJ4DeZhCbD8/YglySWiIW5VMEu+XeO4/7ViEAYQpOVUN5kLov
         /FUUfA4rIZlpCNrq/oRA8Y0ZJfyJ/XJuOHs81T7o0fo9kKKCqG1N2ZX7DRNaI01VfhwY
         Q6+8DoJdhSJI5wlRXJoKA5vc9SrzBDkmyTFzGDrC0FtjMWeqKGa2376CqtDEWvlQqkBm
         TO7QzdmoR5hw8LBGp6ZuCbZtQBKKobEYWYkpURI8gf704lUAcveswZwyF5pMwyIgmaWj
         mgipeg3TGvuKuMgWN/tLKWhYoPxxjQlhNh1/yKnRVGNw31ycuoKxe8+UrgQ6Pcz63Aqi
         SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsoMrK007vCXVz+5bIHJDilPrz2cJmWYXgUTf1R25O4=;
        b=YESBz4FUBv1JHMbkMh7Tp2szfFyP2pHZSKk5DNSpc+oSpkzPY4HnkDaQqZFcod7Qjb
         pFFc28F+nwVdEsJ3L1cTV2syik9HcWYkfDXnleWX7NGhKU173IXuzs+EJI8TryoXibTQ
         tNC3brxJcHhXRK+RqJQjraWM+U6ckqASKRxXc0YwxICQFAzSWTni0LOPTNhjr9LQOqM7
         t+7Mr3V696861AZe6DaTcMUQkGJLDxiYcCbfXhjgo08GSHmGC5NVsHcGguzE+AWAoFWs
         A0lbF8vtcFbg1xLqp8rw+SjIyetsJKwP3kIIX1/4DlgTlE/mifiTL+ZmZ665wjAD2VIG
         rjaw==
X-Gm-Message-State: AOAM5303fI8OxbmwaWxsFjrtSegOynfR6fuZ/khaoDqU5FM19kXhTuMX
        Oh4TwGDCPPUJ2OP8s5M2t0C5/0bWzYc=
X-Google-Smtp-Source: ABdhPJzRB4bWaH4P/QiwjQGzWUKJCUNOL4ABlzjJwB4T0/V9seyES9TvjTEwB5mOWCSYeE2htz3cvw==
X-Received: by 2002:a17:902:8b8b:b029:d9:d098:c42 with SMTP id ay11-20020a1709028b8bb02900d9d0980c42mr7508745plb.41.1607623013121;
        Thu, 10 Dec 2020 09:56:53 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:52 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 13/15] debugfs: add fast commit support to logdump
Date:   Thu, 10 Dec 2020 09:56:06 -0800
Message-Id: <20201210175608.3265541-14-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add fast commit support for debugfs logdump. The debugfs output looks
like this:

debugfs 1.46-WIP (20-Mar-2020)
debugfs:  logdump
Journal starts at block 1, transaction 2
Found expected sequence 2, type 1 (descriptor block) at block 1
Found expected sequence 2, type 2 (commit block) at block 10
No magic number at block 11: end of journal.

*** Fast Commit Area ***
tag HEAD, features 0x0, tid 3
tag INODE, inode 14
tag ADD_RANGE, inode 14, lblk 0, pblk 1091, len 1
tag DEL_RANGE, inode 14, lblk 1, len 1
tag CREAT_DENTRY, parent 12, ino 14, name "new"
tag DEL_ENTRY, parent 12, ino 13, name "old"
tag INODE, inode 13
tag ADD_RANGE, inode 13, lblk 0, pblk 1603, len 16
tag ADD_RANGE, inode 13, lblk 16, pblk 1092, len 240
tag CREAT_DENTRY, parent 12, ino 13, name "data"
tag INODE, inode 14
tag INODE, inode 13
tag TAIL, tid 3

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 debugfs/logdump.c | 122 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 16889954..151be3e2 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -33,6 +33,7 @@ extern char *optarg;
 #include "debugfs.h"
 #include "blkid/blkid.h"
 #include "jfs_user.h"
+#include "ext2fs/fast_commit.h"
 #include <uuid/uuid.h>
 
 enum journal_location {JOURNAL_IS_INTERNAL, JOURNAL_IS_EXTERNAL};
@@ -65,6 +66,9 @@ static void dump_metadata_block(FILE *, struct journal_source *,
 				unsigned int, unsigned int, unsigned int,
 				int, tid_t);
 
+static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
+			  int transaction, int *fc_done, int dump_old);
+
 static void do_hexdump (FILE *, char *, int);
 
 #define WRAP(jsb, blocknr)					\
@@ -353,6 +357,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 	journal_header_t	*header;
 	tid_t			transaction;
 	unsigned int		blocknr = 0;
+	int			fc_done;
 
 	/* First, check to see if there's an ext2 superblock header */
 	retval = read_journal_block(cmdname, source, 0, buf, 2048);
@@ -410,7 +415,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 	if (!blocknr) {
 		/* Empty journal, nothing to do. */
 		if (!dump_old)
-			return;
+			goto fc;
 		else
 			blocknr = 1;
 	}
@@ -420,7 +425,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 				((ext2_loff_t) blocknr) * blocksize,
 				buf, blocksize);
 		if (retval)
-			return;
+			break;
 
 		header = (journal_header_t *) buf;
 
@@ -431,7 +436,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 		if (magic != JBD2_MAGIC_NUMBER) {
 			fprintf (out_file, "No magic number at block %u: "
 				 "end of journal.\n", blocknr);
-			return;
+			break;
 		}
 
 		if (sequence != transaction) {
@@ -439,7 +444,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 				 "block %u: end of journal.\n",
 				 sequence, transaction, blocknr);
 			if (!dump_old)
-				return;
+				break;
 		}
 
 		if (dump_descriptors) {
@@ -473,9 +478,25 @@ static void dump_journal(char *cmdname, FILE *out_file,
 		default:
 			fprintf (out_file, "Unexpected block type %u at "
 				 "block %u.\n", blocktype, blocknr);
-			return;
+			break;
 		}
 	}
+
+fc:
+	blocknr = be32_to_cpu(jsb->s_maxlen) - jbd2_journal_get_num_fc_blks(jsb) + 1;
+	while (blocknr <= be32_to_cpu(jsb->s_maxlen)) {
+		retval = read_journal_block(cmdname, source,
+				((ext2_loff_t) blocknr) * blocksize,
+				buf, blocksize);
+		if (retval)
+			return;
+
+		dump_fc_block(out_file, buf, blocksize, transaction, &fc_done,
+			dump_old);
+		if (!dump_old && fc_done)
+			break;
+		blocknr++;
+	}
 }
 
 static inline size_t journal_super_tag_bytes(journal_superblock_t *jsb)
@@ -496,6 +517,97 @@ static inline size_t journal_super_tag_bytes(journal_superblock_t *jsb)
 	return sz - sizeof(__u32);
 }
 
+static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
+	int transaction, int *fc_done, int dump_old)
+{
+	struct ext4_fc_tl	*tl;
+	struct ext4_fc_head	*head;
+	struct ext4_fc_add_range	*add_range;
+	struct ext4_fc_del_range	*del_range;
+	struct ext4_fc_dentry_info	*dentry_info;
+	struct ext4_fc_tail		*tail;
+	struct ext3_extent	*ex;
+
+	*fc_done = 0;
+	fc_for_each_tl(buf, buf + blocksize, tl) {
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_ADD_RANGE:
+			add_range =
+				(struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
+			ex = (struct ext3_extent *)add_range->fc_ex;
+			fprintf(out_file,
+				"tag %s, inode %d, lblk %d, pblk %ld, len %d\n",
+				tag2str(tl->fc_tag),
+				le32_to_cpu(add_range->fc_ino),
+				le32_to_cpu(ex->ee_block),
+				le32_to_cpu(ex->ee_start) +
+				(((__u64) le16_to_cpu(ex->ee_start_hi)) << 32),
+				le16_to_cpu(ex->ee_len) > EXT_INIT_MAX_LEN ?
+				le16_to_cpu(ex->ee_len) - EXT_INIT_MAX_LEN :
+				le16_to_cpu(ex->ee_len));
+			break;
+		case EXT4_FC_TAG_DEL_RANGE:
+			del_range =
+				(struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
+			fprintf(out_file, "tag %s, inode %d, lblk %d, len %d\n",
+				tag2str(tl->fc_tag),
+				le32_to_cpu(del_range->fc_ino),
+				le32_to_cpu(del_range->fc_lblk),
+				le32_to_cpu(del_range->fc_len));
+			break;
+		case EXT4_FC_TAG_LINK:
+		case EXT4_FC_TAG_UNLINK:
+		case EXT4_FC_TAG_CREAT:
+			dentry_info =
+				(struct ext4_fc_dentry_info *)
+					ext4_fc_tag_val(tl);
+			fprintf(out_file,
+				"tag %s, parent %d, ino %d, name \"%s\"\n",
+				tag2str(tl->fc_tag),
+				le32_to_cpu(dentry_info->fc_parent_ino),
+				le32_to_cpu(dentry_info->fc_ino),
+				dentry_info->fc_dname);
+			break;
+		case EXT4_FC_TAG_INODE:
+			fprintf(out_file, "tag %s, inode %d\n",
+				tag2str(tl->fc_tag),
+				le32_to_cpu(((struct ext4_fc_inode *)
+					ext4_fc_tag_val(tl))->fc_ino));
+			break;
+		case EXT4_FC_TAG_PAD:
+			fprintf(out_file, "tag %s\n", tag2str(tl->fc_tag));
+			break;
+		case EXT4_FC_TAG_TAIL:
+			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
+			fprintf(out_file, "tag %s, tid %d\n",
+				tag2str(tl->fc_tag),
+				le32_to_cpu(tail->fc_tid));
+			if (!dump_old &&
+				le32_to_cpu(tail->fc_tid) < transaction) {
+				*fc_done = 1;
+				return;
+			}
+			break;
+		case EXT4_FC_TAG_HEAD:
+			fprintf(out_file, "\n*** Fast Commit Area ***\n");
+			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
+			fprintf(out_file, "tag %s, features 0x%x, tid %d\n",
+				tag2str(tl->fc_tag),
+				le32_to_cpu(head->fc_features),
+				le32_to_cpu(head->fc_tid));
+			if (!dump_old &&
+				le32_to_cpu(head->fc_tid) < transaction) {
+				*fc_done = 1;
+				return;
+			}
+			break;
+		default:
+			*fc_done = 1;
+			break;
+		}
+	}
+}
+
 static void dump_descriptor_block(FILE *out_file,
 				  struct journal_source *source,
 				  char *buf,
-- 
2.29.2.576.ga3fc446d84-goog

