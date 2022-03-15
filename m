Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5324DA4B8
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 22:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiCOVkl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352000AbiCOVkh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 17:40:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4705BD26
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 14:39:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t2so995485pfj.10
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bgb19ns4uv6kCrQDg8aIIgRvVQ+xaItlKh1vWLuVpNA=;
        b=N7wKk+oL3j1Qd30Y6igSF5SaMyfetrcGPS0hNadBBXPNNCoSf3hcxmgthsV1OnfVzQ
         uVqwkCbQuFOFbCW56qChzN/UTcPEcJ3VJRKKAKIhLCFH8PD3DG0ZcK6opSPrupgvtqlM
         Ru0fucmGfXELPihFvefdtKq7t9bSHDc5Dc6gLzabm4btKw6qe4J003ftYf3vvSY639Qe
         GhOrIy8BOyVOrLZIEUV28wEBYWyBs+iv3QHS4SwTFMxR4HjoN8spJFWbDM1i6TIspz8+
         o3VB3poGctAm71vE/edKZ/hKBgXNanXxgYrhylTBDBcyrPcnA5aQZA1AQaG7Dr0xcvUp
         s6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bgb19ns4uv6kCrQDg8aIIgRvVQ+xaItlKh1vWLuVpNA=;
        b=mSivOE1aW5wv/NKjAeDO6z9GGaEw/imV5GYUNM4x6eA8XmFPgJZtfcoHN9PHlVUxRH
         ZVqgtyhbtvzaHHPFUlV+rGmerln3In//0QO0wp+jgRDkbjphh4ZRHdzLl0bUMln96h0x
         WDU6pl1pQ3TyOUYrn7yBm47q+yz7UHc1beEOYraCJblYB74992cH6JIExjd0deK4e9RS
         qVOMiVghoFcbLgtLMa6n1tQLha1Na62GpLX4gHGeoykd3z2WR5SnOTMy3+Axg/chg5Kc
         BU4TTswmwxcc1DKBIVeKbJrqRvdWL60bkLSdW5u7WFFz90FXKKsQJe+aqoq5w1xMJZKC
         v9EA==
X-Gm-Message-State: AOAM533RZoU3qt41e0f2nSYmU6wNAacbBoljMnKpDae/oBDXraMjfyPD
        2GBI3WoN3+WZHzOn2bI7uxSKHQ==
X-Google-Smtp-Source: ABdhPJzgmlOmmHVk+8gKI6Of7fmek4QmI4275lbxCE411Q5gd4KCFAvJjhgwXOTkm7HxSycxGrNFuA==
X-Received: by 2002:a63:2022:0:b0:349:beed:bfd8 with SMTP id g34-20020a632022000000b00349beedbfd8mr25833177pgg.175.1647380363719;
        Tue, 15 Mar 2022 14:39:23 -0700 (PDT)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm155424pjb.27.2022.03.15.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:39:22 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH v2] ext4: check if offset+length is within valid fallocate
Date:   Tue, 15 Mar 2022 14:38:57 -0700
Message-Id: <20220315213857.268414-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <00000000000042d70e05da43401f@google.com>
References: <00000000000042d70e05da43401f@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

==============================================
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..355384007d11 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3924,7 +3924,8 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t first_block, stop_block;
 	struct address_space *mapping = inode->i_mapping;
-	loff_t first_block_offset, last_block_offset;
+	loff_t first_block_offset, last_block_offset, max_length;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	unsigned int credits;
 	int ret = 0, ret2 = 0;
@@ -3967,6 +3968,16 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 		   offset;
 	}
 
+	/*
+	 * For punch hole the length + offset needs to be at least within
+	 * one block before last
+	 */
+	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
+	if (offset + length >= max_length) {
+		ret = -ENOSPC;
+		goto out_mutex;
+	}
+
 	if (offset & (sb->s_blocksize - 1) ||
 	    (offset + length) & (sb->s_blocksize - 1)) {
 		/*
-- 
2.35.1

