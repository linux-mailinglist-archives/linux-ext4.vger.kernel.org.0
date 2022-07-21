Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6663A57C40C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiGUGDC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiGUGC5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:02:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFD47A536
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so707481pgc.10
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zgv8W9ohloZRX9vqO+xpKxAioSV1XlBjrfd2i4B79U=;
        b=WGm8o0lPCZhvf8pYzYirB8Wyg/NR/KU3v8XmFbMj8D3VInjpq0Ips264ipxlIjCw/n
         9MNSrA7GyT5F68hBvn8n+ujoTuVYxmI0lOQ/DWMYGjatuC2EeicFOJ40YMD58gTIrURS
         OjENq+JG+Nbuq1OkYQhCVRVdhJGYLjFFqYliWvRCWc7TczuW8KTiGgQLE+tSrZKNmJc3
         6APxW36nTJotd1ABSsq6bJ9ygENQOcPFbKXaMTIg8cmER7R0Ca2adWGO1zSf0TRy4hIG
         Cp5WUhOpAEsmM4knmzQIzLI/de0MJxm8m5DNVvILNTUdDUx6MX8FQSZ+SfR33JD9SvxP
         inCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zgv8W9ohloZRX9vqO+xpKxAioSV1XlBjrfd2i4B79U=;
        b=n+ui+kLbpVleS/BH8f+QOboyYXqVfZD8OnzSLrCbJwj81oNpiS41eUhUbuVgLm2wLT
         bl0k5dDonspNqIoLnNXxVkCeoqexwg13bmfqLGv7mh19eDAgHajaJ02P1+Y7s1fjehgl
         BEhppNg1CfjC7oM0blzUZ/9JHJzmjgvJjugIVefcnAXW5kwXLQz/QHWG0Rb2x9hOKQhQ
         YsYjnGD3hBENF8ZMwoK1psCPDLg9v+RbRL+IJgXMa2Hm0Hv1Df/JmzkAy+eqR20qHxq7
         VhdGadqXSrxQOTBt+QqAdsRhop1Tums2zGWW6/UdR7TCHusc3aJoonSeRmAQzLvEdn9m
         UOeQ==
X-Gm-Message-State: AJIora8nVOUKM8MZLxqS7eHutoFLdo8dzevNP+rgdZpVdPyZu6fKCi0x
        noQ+ClV/veBVV7IvvfA+2pQ/xwaCX7ww0A==
X-Google-Smtp-Source: AGRyM1v1KRYf7EuZxHhI9+MWLLyNIFvZCtHWuPvOXpJEc6RUEjubqs1DzfdWPBR4MbPwfWffgvCDqg==
X-Received: by 2002:aa7:8318:0:b0:528:c331:e576 with SMTP id bk24-20020aa78318000000b00528c331e576mr43040947pfb.58.1658383375707;
        Wed, 20 Jul 2022 23:02:55 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:54 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v4 2/8] ext4: for committing inode, make ext4_fc_track_inode wait
Date:   Thu, 21 Jul 2022 06:02:40 +0000
Message-Id: <20220721060246.1696852-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
References: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the inode that's being requested to track using ext4_fc_track_inode
is being committed, then wait until the inode finishes the
commit. Also, add calls to ext4_fc_track_inode at the right places.

With this patch, now calling ext4_reserve_inode_write() results in
inode being tracked for next fast commit. A subtle lock ordering
requirement with i_data_sem (which is documented in the code) requires
that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
this patch also adds explicit ext4_fc_track_inode() calls in places
where i_data_sem grabbed.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 30 ++++++++++++++++++++++++++++++
 fs/ext4/inline.c      |  3 +++
 fs/ext4/inode.c       |  5 ++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8d6d5155a646..4d2384adcbb0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -574,8 +574,14 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
+/*
+ * Track inode as part of the next fast commit. If the inode is being
+ * committed, this function will wait for the commit to finish.
+ */
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	wait_queue_head_t *wq;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 
@@ -595,6 +601,30 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) ||
+		ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE) ||
+		!list_empty(&ei->i_fc_list))
+		return;
+
+	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
+			schedule();
+		finish_wait(wq, &wait.wq_entry);
+	}
+
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(handle, inode, ret);
 }
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index cff52ff6549d..7f5edfb34095 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -586,6 +586,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_destroy_inline_data_nolock(handle, inode);
 	if (ret)
 		goto out;
@@ -686,6 +687,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto convert;
 	}
 
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
 					    EXT4_JTR_NONE);
 	if (ret)
@@ -964,6 +966,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		if (ret < 0)
 			goto out_release_page;
 	}
+	ext4_fc_track_inode(handle, inode);
 	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
 					    EXT4_JTR_NONE);
 	if (ret)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 84c0eb55071d..f3de6748a96b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -627,6 +627,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 */
 	map->m_flags &= ~EXT4_MAP_FLAGS;
 
+	ext4_fc_track_inode(handle, inode);
 	/*
 	 * New blocks allocate and/or writing to unwritten extent
 	 * will possibly result in updating i_data, so we take
@@ -4076,7 +4077,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	/* If there are blocks to remove, do it */
 	if (stop_block > first_block) {
-
+		ext4_fc_track_inode(handle, inode);
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode, 0);
 
@@ -4232,6 +4233,7 @@ int ext4_truncate(struct inode *inode)
 	if (err)
 		goto out_stop;
 
+	ext4_fc_track_inode(handle, inode);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	ext4_discard_preallocations(inode, 0);
@@ -5752,6 +5754,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.37.0.170.g444d1eabd0-goog

