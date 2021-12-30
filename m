Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8B4819EC
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Dec 2021 07:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhL3G3N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Dec 2021 01:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhL3G3N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Dec 2021 01:29:13 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C97C061574;
        Wed, 29 Dec 2021 22:29:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l17so20896553qtk.7;
        Wed, 29 Dec 2021 22:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mDyE6Q3MJt1F1uCkGnY5FT/Ms45/3O3O+eHjtEvjrQ=;
        b=CmdnOb49xfkjqnerc2Fd4Si4/QWT+BvdQElqrYW4VaNqg9VlET49S2eyi2LP+M7uLX
         m3RJnDo+ay6s5ljyGI24jIDyPF6lKHIqcw2DqOYOO9RAhCpIVVtVBfGYFyf1c07W1bSk
         mlsfw3tPQ5pKfUUorfGRLjiMODEMPr87/ngugTAhbvvhC5e7YuPEbCVeahoxjieQmVB0
         fEFMt6C/F2tVCGee7NwcAP5HLqFLvbUxeh/EJ4ptyI9xD32WOdsXLWUymyehPQMxAkmM
         Ke/Ha5PM8iRpgX/dlYvFkYHdHLGeDrwQ1fOMcwgL+91WEF672zk6L0Moq+LFUZpNEBm4
         f7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mDyE6Q3MJt1F1uCkGnY5FT/Ms45/3O3O+eHjtEvjrQ=;
        b=F1teZbZONum+qf3ilFzkqkXpzc+ctMz5T269bsvLGJR/5qlR1tkDcAV6wCKJwgsS6t
         kKq1KMg5dCvxgCBlxm0C4pFsU7hPHHbzES3oup6s8NHy2QcmeqrJGtZEiIclfRh53EN9
         G/gg2nS6uryHrYqXSwYuOvnDGKyCxxKoezJsMkjhbbu1Yq+OFzddyJZ9HcxveZApLUyw
         eVNyHKIK8OI1lfMXpAsVs+nO6gqMt8L6XVkdTIgUJ1QooK97KmYZ/a6S5/mhji1Hdj/M
         1SonXq2dqDziGNXDNK2rfdKNeE1uj8LMld28W2u7vnnV/7W7wAgy+zcODjG3QNJDkOjs
         cbSQ==
X-Gm-Message-State: AOAM531byp6TDW0AO1a1WQb+0wWyY11/vSmSnZHpkRfo8wpmlFgTylg0
        E6/SC4rRV7wZ09EiCM6Oqtg=
X-Google-Smtp-Source: ABdhPJwSz1ZN9Xc9zpRXXlqg2l+/vKbieX1kJmwEB2UBu+9RlmTM5Rcm7wLIFkgra2qqotrPvNvrIQ==
X-Received: by 2002:ac8:5743:: with SMTP id 3mr25373222qtx.440.1640845751313;
        Wed, 29 Dec 2021 22:29:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f141sm17386165qke.92.2021.12.29.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 22:29:11 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux] ext4: Delete useless ret assignment
Date:   Thu, 30 Dec 2021 06:29:05 +0000
Message-Id: <20211230062905.586150-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

The assignments in these two places will be overwritten by new
assignments later, so they should be deleted.

The clang_analyzer complains as follows:

fs/ext4/fast_commit.c

Value stored to 'ret' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/ext4/fast_commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8ea5a81..8d5d044 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1660,7 +1660,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		return 0;
 	}
 
-	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
+	ext4_fc_record_modified_inode(sb, inode->i_ino);
 
 	start = le32_to_cpu(ex->ee_block);
 	start_pblk = ext4_ext_pblock(ex);
@@ -1785,7 +1785,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 		return 0;
 	}
 
-	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
+	ext4_fc_record_modified_inode(sb, inode->i_ino);
 
 	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
 			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
-- 
2.15.2


