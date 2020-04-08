Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66F1A2B88
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgDHVz4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDHVzy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so3077449pfo.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6c2L16Ujn3w/lMWA3ilafaxiWdDboTeYgqDIA6qCREs=;
        b=Gt5rbZdntMswGmqfECpMJid05gBHuMHWxD1VUaPztneu7hNfsbFF/lRX61har3IxeT
         7x+A4f7FopiG6XqW5PFvmh0qUAFY6KEsAbYtWgQbdETbyoL3+URepNKDsRqLmdHvOT4g
         bpg8WHE0BXuSu5J4PCHT6i2/aOcMYj847daZuPHmompFj/aPkG4TMUBoR8Mb5sHuwYXG
         RT+o2oSuG+CYk5HvZe5SOmIclCzhR5BfeFlL5U/ohulwwm5v8zI8zlFNC1hfHea0ruCF
         HifDa5KAJx8/TrsZ0qxh78zLxX1T3rfAtnxsAyx6pRWJQEubj260gcRYHrfjcEhPa0Ff
         yq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6c2L16Ujn3w/lMWA3ilafaxiWdDboTeYgqDIA6qCREs=;
        b=izFlU1foo+mUCv6cSB3AKWy6aEc2sqf0KTQRYHxp2uS5LcHrvzF6mpNP3zarMYEWAI
         efGOL4oxDNI25+HiHinkpsRf2ijwtc+LuKLVII1qyGdXKuR7W2mnIa99+zXeMQPkNbo6
         zlaADsOKoJys3uXsRE2gxrFsV7gMqzSD9hggLjLsATO4g635bWo/8yzZIiT2J74hOXVR
         kghgpJMsGcEiWQOm8sjPYvmNFC2VgReCQtX3Kry1K2+HTufbufbPLuT68ys8+K+pOUSM
         X/K8gaVjdBr+M7Y4T6qJLIwRceQDzMZnXDVbglIY2rYg8OotcMzlqG0aRBU9rFIFrY0m
         w07g==
X-Gm-Message-State: AGi0PubOQKdbng3VeIp31/rZNcIu5x0SFX+EpCoAVHd0xTZGPFdePt7z
        lnF2m1wnVKWJUZa8WzTUpomuaWgv
X-Google-Smtp-Source: APiQypLkTNNfYzDW2P9+XNbKFZxuIEkhJeQo8e1xSRrZQszPzqdyEG9iSilFY5/+CTiJutXOva7PUA==
X-Received: by 2002:a63:717:: with SMTP id 23mr9217407pgh.61.1586382953105;
        Wed, 08 Apr 2020 14:55:53 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:52 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 12/20] ext4: add fast commit on-disk format structs
Date:   Wed,  8 Apr 2020 14:55:22 -0700
Message-Id: <20200408215530.25649-12-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add structs representing on-disk format of the commit header and
tlvs in the commit header.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c |  1 +
 fs/ext4/ext4_jbd2.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 4bef01f9814a..fca478a3b7e9 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -4,6 +4,7 @@
  */
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 
 #include <trace/events/ext4.h>
 
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index b1239d6be713..b8ac3f29949d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -529,7 +529,52 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+/* Ext4 fast commit related info */
+
+/* Magic of fast commit header */
+#define EXT4_FC_MAGIC			0xE2540090
+
 #define EXT4_NUM_FC_BLKS		128
+
+struct ext4_fc_commit_hdr {
+	/* Fast commit magic, should be EXT4_FC_MAGIC */
+	__le32 fc_magic;
+	/* Features used by this fast commit block */
+	__u8 fc_features;
+	/* Number of TLVs in this fast commmit block */
+	__le16 fc_num_tlvs;
+	/* Inode number */
+	__le32 fc_ino;
+	/* Csum(hdr+contents) */
+	__le32 fc_csum;
+};
+
+/* Fast commit on disk tag length structure */
+struct ext4_fc_tl {
+	__le16 fc_tag;
+	__le16 fc_len;
+};
+
+/* On disk fast commit tlv value structure for dirent tags:
+ *  - EXT4_FC_TAG_CREATE_DENTRY
+ *  - EXT4_FC_TAG_ADD_DENTRY
+ *  - EXT4_FC_TAG_DEL_DENTRY
+ */
+struct ext4_fc_dentry_info {
+	__le32 fc_parent_ino;
+	__le32 fc_ino;
+	u8 fc_dname[0];
+};
+
+/*
+ * On disk fast commit tlv value structure for tag
+ * EXT4_FC_TAG_HOLE.
+ */
+struct ext4_fc_lrange {
+	__le32 fc_lblk;
+	__le32 fc_len;
+};
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 void ext4_init_inode_fc_info(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
-- 
2.26.0.110.g2183baf09c-goog

