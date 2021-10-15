Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BAD42FAED
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhJOS1h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbhJOS1d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 14:27:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0BC061570
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 11:25:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gn3so2238737pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSViEy3eFcyxQ5IJwI4bvvDTv8dgwN2jD7Tp4pBQcW0=;
        b=KV7UtXkCRNNyLAAYjOWnG28hPe7uFCq6FX9JnvwE26MtAtZuECUe4NJVF8IqQ59Ayp
         b5I8n6LrdE9Pd5KNVuu5oXBGk9BvNEqXhjyRuBGc19bLg61gRzuaX8aeJAP5xRtywpNF
         DN/r4PtisWK+JPT1/DVuJmgRvIZAEl5vSsSTDV8UaimjNytKv2CNmYL4VDVfAHhhTxAe
         BKUYqCHkx0lpOdb6/JdfUREIE0GfarFTx1Sh3DP3PW3ozyxq6cvB5c7a2j5OUhKo+p4P
         jI2iJLub9hHmhQnPtXPKLhauc1cqfXqcnar+1A6m5N4d6Hdj34tkoUgNfvHAlNy7Ii6x
         OQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSViEy3eFcyxQ5IJwI4bvvDTv8dgwN2jD7Tp4pBQcW0=;
        b=DxQ6+HHwRAUzzXwpmsBNeP3Ng+utkXq6hdUY1PpONX0O/zkV23aRzxGUae+oFRANBK
         /nDzUzgwL2ZzUKDZL8h9ND/smopieE570ZTnl1KTJR3NbK5UOr+0O4vvr+HLD6AypZol
         XIomQiUErY7snDG/yQBsZRWetCHnrUIKG/qFEmjjisDK4+rhMcwDn/9+GsFIaqI9uN3J
         rGRjNpiinAH2RN4P72ebGtQVkq3PRn3B4IuJtn3P/n97WEGIPdR7O1jDUwm6RPKaEajj
         8kAVR2rc1WysyG5Vdh6Widsf9MWGGTFXluIDYIyqQzGpPsgi93i3+HCPpIonf/xU5yok
         ZNxA==
X-Gm-Message-State: AOAM531Amv/wU55aK4ankBU98AlhiWBXJTkoueF9M1lNIfozQ0J4lNRq
        IyN+4QcwfIAWg9tZUYa4xwqe+80I3Bo=
X-Google-Smtp-Source: ABdhPJwVetrMWd7UPN1P10KZH20u2gSMsN+bgKQL7bLeD2zJl2q4VulVZ1LpykLuEKV7ryCz4gs0Mg==
X-Received: by 2002:a17:90a:b382:: with SMTP id e2mr15552050pjr.119.1634322326039;
        Fri, 15 Oct 2021 11:25:26 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:908e:77f9:869:b859])
        by smtp.googlemail.com with ESMTPSA id n14sm5215574pgd.68.2021.10.15.11.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:25:25 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/2] ext4: commit inline data during fast commit
Date:   Fri, 15 Oct 2021 11:25:12 -0700
Message-Id: <20211015182513.395917-1-harshads@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

During the commit phase in fast commits if an inode with inline data
is being committed, also commit the inline data along with
inode. Since recovery code just blindly copies entire content found in
inode TLV, there is no change needed on the recovery path. Thus, this
change is backward compatiable.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8ea5a81e6554..744b000d9756 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -819,7 +819,9 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
 	if (ret)
 		return ret;
 
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA))
+		inode_len = EXT4_INODE_SIZE(inode->i_sb);
+	else if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
 		inode_len += ei->i_extra_isize;
 
 	fc_inode.fc_ino = cpu_to_le32(inode->i_ino);
-- 
2.33.0.882.g93a45727a2-goog

