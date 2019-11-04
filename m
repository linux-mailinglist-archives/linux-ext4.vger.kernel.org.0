Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B25ED743
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 02:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfKDBq7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Nov 2019 20:46:59 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39852 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729087AbfKDBq6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Nov 2019 20:46:58 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kvjM025967
        for <linux-ext4@vger.kernel.org>; Sun, 3 Nov 2019 20:46:57 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kpWr018175
        for <linux-ext4@vger.kernel.org>; Sun, 3 Nov 2019 20:46:57 -0500
Received: by mail-qt1-f200.google.com with SMTP id h15so6721926qtn.6
        for <linux-ext4@vger.kernel.org>; Sun, 03 Nov 2019 17:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r7c0I8SvMYKpHRjqYv9HI6yFzb55f/VPo02TJ216c5Q=;
        b=YEqSSPprmi+54tcoD5uYxk5VBGlHjNrV6JNFqdMXsj7BweK4Wj1gGLLW5zymbL43Ai
         XP7wx9rEOMmb1z165twsB9W/qfJpIiMr3lDcrLmfostbttas2pSCcTcDnTnfFbrAQ5/s
         cTh/SsLcBrRz9FPP+bExj5HQKBu1dvHelaOhfSDd2ZO6kQYJUkXAqclNt/F0H//lJB0l
         KrRp1Np0pRcTCjiy89yDLCcjT/53YnqKtguifIfIfR5lMSXzUkoLldCvLuI4jgmGprCW
         RI0ubcL5xCeOty6/zYOKa8U0Fm6C6gv36z1gmpydF/ytZLqf+cw32e50jC5KLZYcbVRV
         0MfQ==
X-Gm-Message-State: APjAAAXowdqnlU3cngEMsfVb9d9vO6YOt0K6FarM9I4FsWnGtN/PG0hl
        yhlbOaREMcvrghGhFjtXa1iVKcGdnS5Nh9rE71BtCXImzj1LXYk6tX3fIOJwg7Gwcxi0IY19zE7
        TlSslDXy2bTjvb2a+bqkoFtoTIfHZlZp6
X-Received: by 2002:a05:6214:70f:: with SMTP id b15mr19848522qvz.97.1572832010208;
        Sun, 03 Nov 2019 17:46:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ6TMTqkBpyXQGPAZMIMj5EH3dwBQ8r4Ftf0xofxFI/BWghZasoJHnZlzuhtG3wrll2Arcjw==
X-Received: by 2002:a05:6214:70f:: with SMTP id b15mr19848512qvz.97.1572832009874;
        Sun, 03 Nov 2019 17:46:49 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:49 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
Date:   Sun,  3 Nov 2019 20:45:06 -0500
Message-Id: <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's currently 6 filesystems that have the same #define. Move it
into errno.h so it's defined in just one place.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 drivers/staging/exfat/exfat.h    | 2 --
 fs/erofs/internal.h              | 2 --
 fs/ext4/ext4.h                   | 1 -
 fs/f2fs/f2fs.h                   | 1 -
 fs/xfs/xfs_linux.h               | 1 -
 include/linux/jbd2.h             | 1 -
 include/uapi/asm-generic/errno.h | 1 +
 7 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 72cf40e123de..58b091a077e8 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -30,8 +30,6 @@
 #undef DEBUG
 #endif
 
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
-
 #define DENTRY_SIZE		32	/* dir entry size */
 #define DENTRY_SIZE_BITS	5
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076..3980026a8882 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -425,7 +425,5 @@ static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
-#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..a86c2585457d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3396,6 +3396,5 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _EXT4_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4024790028aa..04ebe77569a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3752,6 +3752,5 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index ca15105681ca..3409d02a7d21 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -123,7 +123,6 @@ typedef __u32			xfs_nlink_t;
 
 #define ENOATTR		ENODATA		/* Attribute not found */
 #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 
 #define SYNCHRONIZE()	barrier()
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 603fbc4e2f70..69411d7e0431 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1657,6 +1657,5 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _LINUX_JBD2_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..1d5ffdf54cb0 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -98,6 +98,7 @@
 #define	EINPROGRESS	115	/* Operation now in progress */
 #define	ESTALE		116	/* Stale file handle */
 #define	EUCLEAN		117	/* Structure needs cleaning */
+#define	EFSCORRUPTED	EUCLEAN
 #define	ENOTNAM		118	/* Not a XENIX named type file */
 #define	ENAVAIL		119	/* No XENIX semaphores available */
 #define	EISNAM		120	/* Is a named type file */
-- 
2.24.0.rc1

