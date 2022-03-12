Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57BB4D768F
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Mar 2022 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiCMPtv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Mar 2022 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiCMPtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Mar 2022 11:49:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0404BBA0
        for <linux-ext4@vger.kernel.org>; Sun, 13 Mar 2022 08:48:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d10so28986297eje.10
        for <linux-ext4@vger.kernel.org>; Sun, 13 Mar 2022 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOhmsfv5/7rdIGzZBwkQf+FcN+y7TSes3yf6FW+1h1o=;
        b=Cfp9gzjsJnClPeoPJGZODweLm5HmctNOFQVkKX+0LJcFMKWBfINAUb4ZD4mjOcrJ31
         JSoXskRPylptVV+KlAktcotvzJzqX3EAuDmM5Xeoe71Nr9kaPEfvyRodt1BcguYS+sSU
         H6M15Jo6XFWQN4LVNHfQzAzfUjVtOlntKyWfhU3MNHNfvqGeW5AHff0kToe0/klOuvxL
         FJZTK7K3RL4fvFEBRehgYGHjrKb29kznvD+2JYRgb3NyIBehCr7NN5O/EfwbFk8HSD3s
         +EhxazBNJ7/w1LNnl6bpH4OxL3SQsXSFoLpKNGluEBiu3T2snpw8FetssIRo5eHDzVnw
         CmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOhmsfv5/7rdIGzZBwkQf+FcN+y7TSes3yf6FW+1h1o=;
        b=3ZOE/z8+REwikdad8BIPaJJhJ+6YRUKCs8uL9k3tjjUKP+xNEubEDubE49i51dNase
         MTJpPoZcFYv3JPjE0WffwuomOE1XpWS+R1a4KjftgAxgRbmOyGC78r5ZCfHepcv+ijGo
         Mjb90vzLNf1rY6436tAS83uVpgOZ78jfukGsPvvjWnY0pbwl53KuqpjvfGEaAn4JAI2F
         JjU4PN/vD4pn7OkaMoyby0xnReod6xNxDbU6AeQZPkDmqGf73ObWhI1q36YxJ7k3Neev
         QWx4RTMxLEbnak1iNz+wYMpGoooRlEpf6qCRDQffSAg+zs3R4Kkcyb7DeKfuxS3AO+a6
         8ikQ==
X-Gm-Message-State: AOAM531lQBqY4QF/AfnJNc7GqM84btqtUX5bJ6fPayF9LPhD3RTdasiW
        3gCxME9/WA1aJiX+RpUJSP4bF1YQ0znOjg==
X-Google-Smtp-Source: ABdhPJzzLv7BkeuvmzwPZIuDMGFmHiHFIkHIRE7m4kXAD1/PJ4OAcuoTdULNTCXBsWDH7ZvDa/3Wtw==
X-Received: by 2002:a17:907:7845:b0:6cd:f2f4:cf00 with SMTP id lb5-20020a170907784500b006cdf2f4cf00mr15331569ejc.388.1647186521080;
        Sun, 13 Mar 2022 08:48:41 -0700 (PDT)
Received: from localhost.localdomain ([46.162.205.125])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm6334644edb.47.2022.03.13.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 08:48:40 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: [PATCH v2] ext4: truncate during setxattr leads to kernel panic
Date:   Sat, 12 Mar 2022 18:18:30 -0500
Message-Id: <20220312231830.103920-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andrew Perepechko <andrew.perepechko@hpe.com>

When changing a large xattr value to a different large xattr value,
the old xattr inode is freed. Truncate during the final iput causes
current transaction restart. Eventually, parent inode bh is marked
dirty and kernel panic happens when jbd2 figures out that this bh
belongs to the committed transaction.

A possible fix is to call this final iput in a separate thread.
This way, setxattr transactions will never be split into two.
Since the setxattr code adds xattr inodes with nlink=0 into the
orphan list, old xattr inodes will be properly cleaned up in
any case.

Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>
HPE-bug-id: LUS-10534

Changes since v1:
- fixed bug added during the porting

---
 fs/ext4/super.c |  1 +
 fs/ext4/xattr.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5021ca0a28a..8c04c19fa4b8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1199,6 +1199,7 @@ static void ext4_put_super(struct super_block *sb)
 	int aborted = 0;
 	int i, err;
 
+	flush_scheduled_work();
 	ext4_unregister_li_request(sb);
 	ext4_quota_off_umount(sb);
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 042325349098..13c396e354c8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1544,6 +1544,31 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 	return 0;
 }
 
+struct delayed_iput_work {
+	struct work_struct work;
+	struct inode *inode;
+};
+
+static void delayed_iput_fn(struct work_struct *work)
+{
+	struct delayed_iput_work *diwork;
+
+	diwork = container_of(work, struct delayed_iput_work, work);
+	iput(diwork->inode);
+	kfree(diwork);
+}
+
+static void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
+{
+	if (!work) {
+		iput(inode);
+	} else {
+		INIT_WORK(&work->work, delayed_iput_fn);
+		work->inode = inode;
+		schedule_work(&work->work);
+	}
+}
+
 /*
  * Reserve min(block_size/8, 1024) bytes for xattr entries/names if ea_inode
  * feature is enabled.
@@ -1561,6 +1586,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
 	struct inode *new_ea_inode = NULL;
+	struct delayed_iput_work *diwork = NULL;
 	size_t old_size, new_size;
 	int ret;
 
@@ -1637,7 +1663,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	 * Finish that work before doing any modifications to the xattr data.
 	 */
 	if (!s->not_found && here->e_value_inum) {
-		ret = ext4_xattr_inode_iget(inode,
+		diwork = kmalloc(sizeof(*diwork), GFP_NOFS);
+		if (!diwork)
+			ret = -ENOMEM;
+		else
+			ret = ext4_xattr_inode_iget(inode,
 					    le32_to_cpu(here->e_value_inum),
 					    le32_to_cpu(here->e_hash),
 					    &old_ea_inode);
@@ -1790,7 +1820,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 
 	ret = 0;
 out:
-	iput(old_ea_inode);
+	delayed_iput(old_ea_inode, diwork);
 	iput(new_ea_inode);
 	return ret;
 }
-- 
2.31.1

