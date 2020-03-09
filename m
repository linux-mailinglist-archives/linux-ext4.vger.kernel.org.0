Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8D17D98F
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgCIHGI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35890 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCIHGH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so3611163plo.3
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wno0n3ev2PEDp8o30SDtlC8hla2kVyG2PvuVm0JkSwg=;
        b=AFDkLDYI7oqlrMnbu5PPl6iD3aN5cD8Xd2OHP9HtJsFoTeIk07D2soO/zZ0SLlWrYC
         RYj3Ls3vRO7fR5TP3hQF2f0vO9Z/JIlFXlBPbJpf0V0e2osBfoG9fkc6OBVytkFbLbax
         qay1girq+R3MK0SzIAG36gpvhGRH6cqT8qWZEI0/LuKB5oVRA8J/iJ515Xk4/BI/ul9t
         4jTxMHpYE03Uk6qLJSYusutQDoeQT5iuiGFOirbTXcYIzsA1GAhcTF1xHTLrEA9s4Ms/
         k8xUs2N6ZrY3O58fbDZ5SQp3O/r59bx1cwkgtc3cfPG0I8MystYcNXM6GpVR401xlcGK
         LCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wno0n3ev2PEDp8o30SDtlC8hla2kVyG2PvuVm0JkSwg=;
        b=fJ7fsHnrcKE0h9KEO12En4QmTjYcdr/NWj7ZG4zoYZdfHEKNZ/BV1l3VphQUUbDFAm
         x3wNqpRkZ7bV2IG+oMQkak2fxlGflhAFOc473l2ZE1jwUTFBYRKbcx5yWSCWkjs5myM3
         Xt3OrRe2aaz6oLZ/LkbUcD4jCxG+LXg00pzqDPiJaQ0o7uRIDvesPkXnAIvYSHDKmTUJ
         OOgSWgXinGcTyGGkd9ARgDmhEgwmPoL0pSZX6wuuRhAzyFNFiKlE9Zl91UeSLbWNVlKi
         g6BqUW/3egdm9/uayfENC+8mUdOqdHtpyoN/ph5dx8SLcXToLKcvt3EA3jYYQiT5WeeN
         CDTA==
X-Gm-Message-State: ANhLgQ3v9Nq3OPJWJ7ZsVDsSHJKLm6tIAK11D1GCf4l0hGNPUcSAN55s
        ToWKjuQTuw+gCNk0UHdK1vtAL31V
X-Google-Smtp-Source: ADFU+vuxlN6sFVOBlinduEpfFBkwU4gY6jNPvYRn5GBi1L9yjAzj9GYTphvDmO0GRQUJytGR94Fh3Q==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr15125530plb.171.1583737564558;
        Mon, 09 Mar 2020 00:06:04 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:04 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 12/20] ext4: add fast commit on-disk format structs
Date:   Mon,  9 Mar 2020 00:05:18 -0700
Message-Id: <20200309070526.218202-12-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add structs representing on-disk format of the commit header and
tlvs in the commit header.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c |  1 +
 fs/ext4/ext4_jbd2.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index a29ae83df881..78c5431c7aad 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -4,6 +4,7 @@
  */
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 
 #include <trace/events/ext4.h>
 
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 401f142172e4..761148b99b35 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -526,7 +526,52 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
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
2.25.1.481.gfbce0eb801-goog

