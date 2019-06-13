Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7844464
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404025AbfFMQgh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:36:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38065 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbfFMHaD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jun 2019 03:30:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so11262238pfa.5
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2019 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8nRX+I4nvEqrD6MmwVWlM/J4jxhVM5nU6wkgRdRXxxg=;
        b=ArRXqZVW1D+UbLnknXN9OXsIDawu3+MiOzcE0HL982+wpMebdFKSa7MpmyxPH+55fL
         w8ALPRYSveL7+hP/WjTYfieqwTM3Y03Dl4WZ9qK0ZEMDjwlY2b416SXX02vhv8YoAnLe
         T/KrJaYvSWSktg0R3JoSEvfBgsyVkkdCbd8u5Un+XeebtbSr6Xd/hH9vBWULiGzltorv
         FIY5PLc5u6+oIR06lPJgF/IvszBhW67lDvCQ+XVG9bU3Ldo5y/YTDJz4fVHR71rLhctu
         jA1Xt2tSINfofasWT2yYm9+N4iIZIVS47k7D9RquSgi/RbktfwMtxAMtbk7ln+c6LNAL
         BOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8nRX+I4nvEqrD6MmwVWlM/J4jxhVM5nU6wkgRdRXxxg=;
        b=PJQqSn8ev8HRfFSBd7V5UHwZykmEqffm06n7gXxWAR1cSjb+7amiBS80U9QLKFBmCY
         yhfLFTq6nEBh16XnAvtgapgXVmqvcEanbaW1Z1Hunjps4CVz+e2oYdfduV9orbi+wQP/
         9uedgKgUNh0A6JbbwLBqfxcsf/vVd0uK5T01qPe64NufpXSzYBb6H8VuUs+6lv8NmuDP
         j5S6B/Fl1CPNd2ynUDLRWYuQTL/PTsRpPCmQwBfvTBAqno9MewPz0WLxp3fz8PQWBeNe
         FrPYbYWGhsUIGiRkBX79dFP1q6nFb9Al3a1ky/Ku0z+HdUBmuMLt72Svv8y0UYcX0AvM
         pXmQ==
X-Gm-Message-State: APjAAAVZOPI+eFhJt58TrJZ1uOregzzs0W5slfnfzZ+DJ+TZ/tKJh78I
        XPWOz0xGkMvmdn6IOBCRDOQZf4E/
X-Google-Smtp-Source: APXvYqx9LOyJlN7JCESutjlDMpgZkKe8AL0z9fFbPjyztiBvf8HHIMUoaTqoW6bWdkPL3//MBb18fQ==
X-Received: by 2002:a63:5152:: with SMTP id r18mr5986063pgl.94.1560411002155;
        Thu, 13 Jun 2019 00:30:02 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id y14sm1325013pjr.13.2019.06.13.00.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 00:30:01 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     Wang Shilong <wshilong@ddn.com>, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2] f2fs: only set project inherit bit for directory
Date:   Thu, 13 Jun 2019 16:29:53 +0900
Message-Id: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

It doesn't make any sense to have project inherit bits
for regular files, even though this won't cause any
problem, but it is better fix this.

Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v1->v2:
don't return project inherit flags for regular files
---
 fs/f2fs/f2fs.h  | 3 ++-
 fs/f2fs/inode.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9bd2bf0f559b..ab176a92fa55 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2385,7 +2385,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 			   F2FS_PROJINHERIT_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
+#define F2FS_REG_FLMASK 	(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL |\
+				   F2FS_PROJINHERIT_FL))
 
 /* Flags that are appropriate for non-directories/regular files. */
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ccb02226dd2c..8838e55e7416 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -343,6 +343,8 @@ static int do_read_inode(struct inode *inode)
 					le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
+	if (S_ISREG(inode->i_mode))
+		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
 	fi->flags = 0;
 	fi->i_advise = ri->i_advise;
 	fi->i_pino = le32_to_cpu(ri->i_pino);
-- 
2.21.0

