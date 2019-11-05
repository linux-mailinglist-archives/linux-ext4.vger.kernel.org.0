Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791F0EF3A4
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 03:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfKECql (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 21:46:41 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:38192 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729596AbfKECqk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 21:46:40 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA52kbGA027471
        for <linux-ext4@vger.kernel.org>; Mon, 4 Nov 2019 21:46:37 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA52kWav027480
        for <linux-ext4@vger.kernel.org>; Mon, 4 Nov 2019 21:46:37 -0500
Received: by mail-qk1-f199.google.com with SMTP id x186so19888177qke.13
        for <linux-ext4@vger.kernel.org>; Mon, 04 Nov 2019 18:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RZNcm7tJHE7PJ/B2fVNd5i/u7+ifnx25OIt2h3zpLOo=;
        b=gZmH2jkm8i8CNWqf5NxvG3ROo0AqdRro7VnyedtjtqGbteOGWL2zPt30A0qWttXq+c
         v3UoCrmiYbKfvzR4akdLvIr2qBUEotSVU+rXPz2OGqdq7ac9ONC6bSfEYih6jGfv0nkd
         83qFzYUVQirmR8X2qRosm4+o2JQH/h6JIwtjmBqpcJ/plJNacVJN7QY59aKP1Qvju6/Z
         7vjhHGvH7iwv7w6JRQCHxpUllu4S50rECQJoXxpjTl69YerrQanDIVvcYibwX7GUeHZh
         1kIwD+q2cihBNwTUbqEKNT9+2c9FoSPLHLNqENkPkVOqxmt48M/+PpKEdVL7MjxTdy1j
         F67g==
X-Gm-Message-State: APjAAAUl0sk6YzkOTGqs0Oe2cm4y+BBZLmg/l+XSAsvr1Xs376v8Gm8t
        WMyWdNBohnDmbyiefFwX9G1kQLEowZiB0K1l0XHZc48A5Hx0TvbQ9z1figlocMx28/CNG6rFcq4
        QLyXQ/1cq9fyq/er6/DKoeH/4ZY3nUf/i
X-Received: by 2002:ad4:5349:: with SMTP id v9mr23621306qvs.55.1572921992488;
        Mon, 04 Nov 2019 18:46:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXzA6HviTv6QlEgIOFkTmQMi16KNYqK2sd8+KO7QEzhWvkSciXAH9zdUWTp/6s496+Fl8aKA==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr23621285qvs.55.1572921992189;
        Mon, 04 Nov 2019 18:46:32 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id s21sm12156815qtc.12.2019.11.04.18.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:46:30 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Subject: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Date:   Mon,  4 Nov 2019 21:46:14 -0500
Message-Id: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Four filesystems have their own defines for this. Move it
into errno.h so it's defined in just one place.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 fs/ext4/ext4.h                   | 2 --
 fs/f2fs/f2fs.h                   | 2 --
 fs/xfs/xfs_linux.h               | 1 -
 include/linux/jbd2.h             | 2 --
 include/uapi/asm-generic/errno.h | 1 +
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a86c2585457d..79b3fd8291ab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3395,6 +3395,4 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 
 #endif	/* __KERNEL__ */
 
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-
 #endif	/* _EXT4_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 04ebe77569a3..ba23fd18d44a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3751,6 +3751,4 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 	return false;
 }
 
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 3409d02a7d21..abdfc506618d 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -123,7 +123,6 @@ typedef __u32			xfs_nlink_t;
 
 #define ENOATTR		ENODATA		/* Attribute not found */
 #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 
 #define SYNCHRONIZE()	barrier()
 #define __return_address __builtin_return_address(0)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 69411d7e0431..e07692fe6f20 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1656,6 +1656,4 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 
 #endif	/* __KERNEL__ */
 
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-
 #endif	/* _LINUX_JBD2_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 1d5ffdf54cb0..e4cae9a9ae79 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -55,6 +55,7 @@
 #define	EMULTIHOP	72	/* Multihop attempted */
 #define	EDOTDOT		73	/* RFS specific error */
 #define	EBADMSG		74	/* Not a data message */
+#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
 #define	EOVERFLOW	75	/* Value too large for defined data type */
 #define	ENOTUNIQ	76	/* Name not unique on network */
 #define	EBADFD		77	/* File descriptor in bad state */
-- 
2.24.0.rc1

