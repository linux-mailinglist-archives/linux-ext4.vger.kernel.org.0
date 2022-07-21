Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1AB57C40F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiGUGDG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiGUGDD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:03:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1E7A539
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so4210343pjq.4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNljEoovjwlVcxzjjsT9XVt70W1NHTNB2v0mAFC2T40=;
        b=q5MOXOfAO1VDPfxXwVeEi9RorbFccWyUjIWyA/dogeiQC2k9pxWXEPSaeJtw8Jy6Gb
         JhkpVBQoxyModQVz4aIsV/g3Be2mehlkqwUWKw6/FNJpg6+rqsjqV5oQYsDU9PLSHZdh
         Ngw2NXCMFH5edBycmFQt5dSjpe7nLXf8e7mxdEPUxXPYBYLgyiNmTRFSG3Wf8nqGjGHs
         9/msype5n6eVJOnx5XEHVc4IYds7FYvRW5C6APa960mEIXP4AEeCJSXBWu+w17ExQ/l5
         xYbEkyC+4dCS3BKzuyuXBfrj/idNsVsd1PNnCzkc28sqxQFIdcLtdLMPgv6FI49apV44
         2Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNljEoovjwlVcxzjjsT9XVt70W1NHTNB2v0mAFC2T40=;
        b=ptg+wlRWJm7byzhAaf9b2SbW/7AYuApUxn2bTpEa7TxIUA1Nh6E0DUFqVXCFrer4Pn
         o0x1OXvzzh3+1B7fxr/c8vM3suG2jxujEEGq4RNr0lMx54eEEbPC0StlGH+gQIlHd7j6
         ihq/UQ/7ezMCLezpWjzlCqARhDSiUEp6QvSkkfyPsGd9EpNrMfJ2CmKMGrugNOLdgBKk
         1BJi2LGbZdPCrrk+mof1c7D47tYSQ0PVgATJrV9qSypeJL0aCdTSNLZIJegyhlfdJaHZ
         gGQK+dcRtr7r246JCb/eiYM+p3X8F+7/GoAhLDh6uVRnCWwbXD4cVEuM4dOHUTt5m/Jo
         URYg==
X-Gm-Message-State: AJIora/TMBADMiJKsBOtATBxdJvQhyhl9bhzQqyJuaBJo6F8ZY0Vc5X3
        E5OFn47/TLmyehzxu0nUMV3wkpXwwm/xjqaj
X-Google-Smtp-Source: AGRyM1u7e8n4dKE6BXK/TbheJ4mDSIMYeZrQ1oEIIUwDxoClx+wyFiYVOh1swMklrSTizdFZJmGxOg==
X-Received: by 2002:a17:902:ce0e:b0:16c:7977:9d74 with SMTP id k14-20020a170902ce0e00b0016c79779d74mr42761036plg.92.1658383379052;
        Wed, 20 Jul 2022 23:02:59 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:58 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v4 5/8] ext4: ext4_fc_track_inode() bug fix
Date:   Thu, 21 Jul 2022 06:02:43 +0000
Message-Id: <20220721060246.1696852-6-harshadshirwadkar@gmail.com>
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

This patch fixes a bug in ext4_fc_track_inode() where we should not
immediately return from ext4_fc_track_inode() if the inode is on fast
commit list. It is possible that the inode is on fast commit list and
then somebody calls ext4_fc_track_inode(). If we immediately return if
the inode is on fc list, we will let the caller modify the inode while
it is being committed.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 608ae16afcd6..0307e21e5b29 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -611,8 +611,7 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 
 	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
 	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) ||
-		ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE) ||
-		!list_empty(&ei->i_fc_list))
+	    ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-- 
2.37.0.170.g444d1eabd0-goog

