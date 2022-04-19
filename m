Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DE507696
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiDSRe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiDSRet (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759E37BE0
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 12so16427355pll.12
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrFQNoDyiiuKSi6r3LGKku8tZtuWdJQnnIG7aGpTqWA=;
        b=DPsTEbge6ocQJQVJ91U4aGNrdqtfXn7/v2A3lf8gWLsWd/Z03/9XSlj1+H40YpAhht
         WrC1N89+mL+1KHe3kiU1PsS1hF+68T7G/L+3gcixqERstr07Nwg2rI/WveUdf7Mtba2f
         VqHCpGhXiWwVIdmBFYgAKgFwfZ+TZ0oorrpFKfm/3DrVyBESmsqy8m1TqydLnwo0xM6P
         1/CQJE7AsKU4CRgS8ZAYj2f3uTSZunBHsYUnNGv+qYDnwvxAbCdb4XHYZF8uQyY+SODt
         46oVYjFPuMFKyVZysvij5V7yXeSM/rHUEIE5pTwUZ7+n2rQF6udOFp1KPenEf68gDKeo
         SSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrFQNoDyiiuKSi6r3LGKku8tZtuWdJQnnIG7aGpTqWA=;
        b=t8wFRtEaoR/xq09gQLjomo9nJ2XbPjIijeIkAObAbRjO+XLkxCJyWGSOB0NtgstBcD
         RxtGE75OfqQ79JJ53J6rJCRwud4cP9VwqGpxgG0z7xxbIYEKa0Vjwl5ip040UQoaAgaC
         jT8BksU2QG6xmt0jHM2OqLKpU9CR6ZglHTY6OIa3CHzfJ5vrgbT4WoN+ugfmaU4UuyWy
         93SeOrUrI5aked4DH7wp6GEsdtdugKmmOTRxyyRzULDU8pIqXkmp7mbaJZWqOlOXNy8v
         +32QSpsMExiL5fYIw+aacR3wN5gM+gtvachPdI1hoP5mqRadCFjPjWi6dFsQnj/corXI
         ii2g==
X-Gm-Message-State: AOAM533wVte0H0jI41iBpB+TMBwGC6kkgEL3LcyOEMaBrXkeKOBU4nxF
        WZcpWeeoAUXBX4IAg38nsv20lhykd0GrUA==
X-Google-Smtp-Source: ABdhPJxu4LzM5npHveQH09wAS77U9vdM7neiz/H342L2of4zii3wPJdfc1znBTW7b437yINPimm1qQ==
X-Received: by 2002:a17:902:f64c:b0:156:7ceb:b579 with SMTP id m12-20020a170902f64c00b001567cebb579mr16371066plg.73.1650389526148;
        Tue, 19 Apr 2022 10:32:06 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:32:05 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 3/6] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
Date:   Tue, 19 Apr 2022 10:31:40 -0700
Message-Id: <20220419173143.3564144-4-harshads@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220419173143.3564144-1-harshads@google.com>
References: <20220419173143.3564144-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Mark inode dirty first and then grab i_data_sem in ext4_setattr().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e88940251afd..6eae0804c6fd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5455,11 +5455,12 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits);
 
-			down_write(&EXT4_I(inode)->i_data_sem);
-			EXT4_I(inode)->i_disksize = attr->ia_size;
 			rc = ext4_mark_inode_dirty(handle, inode);
 			if (!error)
 				error = rc;
+			down_write(&EXT4_I(inode)->i_data_sem);
+			EXT4_I(inode)->i_disksize = attr->ia_size;
+
 			/*
 			 * We have to update i_size under i_data_sem together
 			 * with i_disksize to avoid races with writeback code
-- 
2.36.0.rc0.470.gd361397f0d-goog

