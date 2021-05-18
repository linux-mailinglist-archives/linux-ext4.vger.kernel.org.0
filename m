Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07745387C2C
	for <lists+linux-ext4@lfdr.de>; Tue, 18 May 2021 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbhERPOv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 May 2021 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbhERPOu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 May 2021 11:14:50 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3720C061756
        for <linux-ext4@vger.kernel.org>; Tue, 18 May 2021 08:13:31 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id d30so3329902uae.13
        for <linux-ext4@vger.kernel.org>; Tue, 18 May 2021 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XCNPu2m9b0eZ+5yFiGFpPcrrlvxtaV2zPV9ChH3c/4=;
        b=vVD9Xhu363k7pnZT1PK2C0x3R85gaqiR0yuHtPiM/4EVj2LGkOwhf6FrddGhBmcg4f
         GjGGDFuJFxU82qZ8gllCHAwDvAzMDl5vn99G1Z6hS5pg058K9RJiGWIXW5PvmDKrfmCJ
         dyaZrcNjtL/wHh4GT/wadzatKNtYi/ntLUXVmMiLoby8k4IOmjJ1hTKv6tenfrwMzfHP
         pjDlP1t83EgioPEK9yFnpDNYBl9Ipf12Gf9s3XR/rY8cIlsNL89wEYMUr3QAO0Nq7llZ
         4Fso0DoOC0DxQyruOjIkBgDBX0diVpKYXkTGzJne/Dad4j0LgyzEOOWPA9yTIBktTQiQ
         3CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XCNPu2m9b0eZ+5yFiGFpPcrrlvxtaV2zPV9ChH3c/4=;
        b=lrs7BL2mjqA7bQWjzEwG3r5Bsgj60G9pMAM8gzP1ysk8sfEcRE+L2x6yJcALT0H+X7
         l/9ejrdCsOjYH9NY/g+Y7V1xkSInLjZGg+ZbKlPZnvRzf+6XSvPAQP3U6BbQO0XI7RS+
         0QGep4m4xg7coP+lL53+Q67ICX8lj/f6zHQMsPdsQ1QtjPu0JvsFHboHz83kYgTl4OcS
         iaU5Jx3WGF4fIxnTw1C+R4VOml8/CmxoBDW6a32rT5NjeFmJqwNtjoeaZGFYE2yjCDuH
         5fEx6Ew6epyafGyr0/3OK7o/v/vX+QWhCfb9Hu6QNgpc2x5Q1qTz2KM22b4ry7b4/See
         LW9Q==
X-Gm-Message-State: AOAM533uuKYvEfnCE4OgQp7+a4HkNCWOEEjoVtX5EF5GI7L4dmFnwunL
        Ys1mj6d7N90BZSm1Hy+uHGi36fxkx6DMTQ==
X-Google-Smtp-Source: ABdhPJwkyr0g84U2OkkxMoehnUpvIX9I6X6D2piFZUZGk3vyHBY++Wj7vV983nEIgYlpwDV4+pG3bQ==
X-Received: by 2002:ab0:3256:: with SMTP id r22mr6886699uan.47.1621350810667;
        Tue, 18 May 2021 08:13:30 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id o63sm2765340vsc.22.2021.05.18.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:13:30 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v5 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Date:   Tue, 18 May 2021 15:13:26 +0000
Message-Id: <20210518151327.130198-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518151327.130198-1-leah.rumancik@gmail.com>
References: <20210518151327.130198-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ioctl EXT4_IOC_CHECKPOINT checkpoints and flushes the journal. This
includes forcing all the transactions to the log, checkpointing the
transactions, and flushing the log to disk. This ioctl takes u32 "flags"
as an argument. Three flags are supported. EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
can be used to verify input to the ioctl. It returns error if there is any
invalid input, otherwise it returns success without performing
any checkpointing. The other two flags, EXT4_IOC_CHECKPOINT_FLAG_DISCARD
and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT, can be used to issue requests to
discard or zeroout the journal logs blocks, respectively. At this
point, EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT is primarily added to enable
testing of this codepath on devices that don't support discard.
EXT4_IOC_CHECKPOINT_FLAG_DISCARD and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT
cannot both be set.

Systems that wish to achieve content deletion SLO can set up a daemon
that calls this ioctl at a regular interval such that it matches with the
SLO requirement. Thus, with this patch, the ext4_dir_entry2 wipeout
patch[1], and the Ext4 "-o discard" mount option set, Ext4 can now
guarantee that all file contents, file metatdata, and filenames will not
be accessible through the filesystem and will have had discard or
zeroout requests issued for corresponding device blocks.

The __jbd2_journal_erase function could also be used to discard or
zero-fill the journal during journal load after recovery. This would
provide a potential solution to a journal replay bug reported earlier this
year[2]. After a successful journal recovery, e2fsck can call this ioctl to
discard the journal as well.

[1] https://lore.kernel.org/linux-ext4/YIHknqxngB1sUdie@mit.edu/
[2] https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Changes in v4:
- update commit description
- update error codes
- update code formatting
- add flag EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
- add flag EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT

Changes in v5:
- update error checking
- make DRY_RUN include checks on input
- added info about DRY_RUN in commit
- added explicit conversion from ioctl flags to jbd2 flags
---
 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/ioctl.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a29660db86ac..5aa203534997 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -729,6 +729,7 @@ enum {
 #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
+#define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -750,6 +751,14 @@ enum {
 #define EXT4_STATE_FLAG_NEWENTRY	0x00000004
 #define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
 
+/* flags for ioctl EXT4_IOC_CHECKPOINT */
+#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	0x1
+#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT	0x2
+#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN	0x4
+#define EXT4_IOC_CHECKPOINT_FLAG_VALID		(EXT4_IOC_CHECKPOINT_FLAG_DISCARD | \
+						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
+						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index d5512e17a13f..d25eaec1afdc 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -818,6 +818,47 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
+{
+	int err = 0;
+	__u32 flags = 0;
+	unsigned int flush_flags = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
+
+	if (copy_from_user(&flags, (__u32 __user *)arg,
+				sizeof(__u32)))
+		return -EFAULT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* check for invalid bits set */
+	if ((flags & ~EXT4_IOC_CHECKPOINT_FLAG_VALID) ||
+				((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
+				(flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
+		return -EINVAL;
+
+	if (!EXT4_SB(sb)->s_journal)
+		return -ENODEV;
+
+	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
+		return 0;
+
+	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
+		flush_flags |= JBD2_JOURNAL_FLUSH_DISCARD;
+
+	if (flags & EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT) {
+		flush_flags |= JBD2_JOURNAL_FLUSH_ZEROOUT;
+		pr_info_ratelimited("warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow");
+	}
+
+	jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
+	err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, flush_flags);
+	jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
+
+	return err;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1325,6 +1366,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fsverity_ioctl_read_metadata(filp,
 						    (const void __user *)arg);
 
+	case EXT4_IOC_CHECKPOINT:
+		return ext4_ioctl_checkpoint(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -1413,6 +1457,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_GET_ES_CACHE:
 	case FS_IOC_FSGETXATTR:
 	case FS_IOC_FSSETXATTR:
+	case EXT4_IOC_CHECKPOINT:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.31.1.751.gd2f1c929bd-goog

