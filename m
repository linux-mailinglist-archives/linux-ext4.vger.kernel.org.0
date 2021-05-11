Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3313B37ADB9
	for <lists+linux-ext4@lfdr.de>; Tue, 11 May 2021 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEKSFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 May 2021 14:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhEKSFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 May 2021 14:05:40 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65452C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 11:04:32 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id s2so2421148vkf.13
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BH2bRA0/F6yVOVfHrYKc2L2nSURa+QssjSTuMfGTzqU=;
        b=FXUPyqzFiWcqj2GXxMnTxoe3Hqx4Kv8xG216uvFql2dLKcqWNihM7PbBMw85JqgebW
         PQZTE48GFh9VAeKPMzMHhPNTOJuA1lYJEMRqnay8MYxQC1dYfQ/UznBYJPirtkpa5ZOn
         zKIO6IwNLOMP/jHP9cy17AB7eI1I5G9v8t70V2HbLbRe7jBeZN2tJlEjKzc2GWJjpt2b
         JIGRdNDvSL7009dP69Lbnz4WQYZnXKrc5h8fN3e53S9o+GrnDUVS3LMPGINaXcnUyBH4
         1wT6TBuzxBcjrPcOOPdsn8np1a2dFUjnv/iSHsI7WpjnQhT5ADkIoncaZeKEbPsVA5aj
         klDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH2bRA0/F6yVOVfHrYKc2L2nSURa+QssjSTuMfGTzqU=;
        b=OcqpSEbXqroieoMsxO+ijPTl+355nrNFW3AK4ZuPw1dTQ5phJq0JKe51lKsIm//esz
         QcC6WGuOT2Is6FdbbI+qq7KgT0EthyhpY387HFx1X+7MOJn9IXCTy+nsAeiJO2vnuqht
         9GKSst3C/mrulzc3rO3Fdq15Isxk2maito/yBy6yGbN9gWvOcb9Otsd2uFhZmYXg+d/7
         ugcR2EfP4woCw9KPTKHyWhUXOQXNSkBHPeVz0hYvzZ6KFDBRYTcYE0JdxFprDz6+qu3C
         LAS4G6O+qC4M0AszGWsd0JDNyyrYk+47La4/OidQ64wQFvSpi3x84P5gfBkWWu8hRpEe
         A0jg==
X-Gm-Message-State: AOAM533Lj/k407KljIhCEiOUiICbO+Usgv/Qzop+49hSuCL8RcxxarIr
        DRK5mlVxLdg0qNkjWPbEl93+xAvxuoQ=
X-Google-Smtp-Source: ABdhPJxjvEKgD1/rfuF9o4CS2m5u7vNOJNpeBCLcLeCBhGLdgxqCHp0ava6LsPEVY3qCuVIRiTt2pA==
X-Received: by 2002:a1f:a010:: with SMTP id j16mr24234184vke.18.1620756271333;
        Tue, 11 May 2021 11:04:31 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id o35sm2166110uae.3.2021.05.11.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:04:31 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v4 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Date:   Tue, 11 May 2021 18:04:27 +0000
Message-Id: <20210511180428.3358267-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511180428.3358267-1-leah.rumancik@gmail.com>
References: <20210511180428.3358267-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ioctl EXT4_IOC_CHECKPOINT checkpoints and flushes the journal. This
includes forcing all the transactions to the log, checkpointing the
transactions, and flushing the log to disk. This ioctl takes u64 "flags"
as an argument. Three flags are supported. EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
returns success immediately upon entering the ioctl, without performing
any checkpointing. This can be used to check whether the ioctl exists on a
system. The other two flags, EXT4_IOC_CHECKPOINT_FLAG_DISCARD and
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT, can be used to issue requests to
discard and zeroout the journal logs blocks, respectively. At this
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
---
 fs/ext4/ext4.h  |  6 ++++++
 fs/ext4/ioctl.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 37002663d521..41a5c6a83586 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -720,6 +720,7 @@ enum {
 #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
+#define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u64)
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -741,6 +742,11 @@ enum {
 #define EXT4_STATE_FLAG_NEWENTRY	0x00000004
 #define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
 
+/* flags for ioctl EXT4_IOC_CHECKPOINT */
+#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	0x1
+#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT	0x2
+#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN	0x4
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 898705fc8d36..fa79abd0415c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -800,6 +800,53 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
+{
+	int err = 0;
+	unsigned long long flags = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
+
+	if (copy_from_user(&flags, (__u64 __user *)arg,
+				sizeof(__u64)))
+		return -EFAULT;
+
+	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
+		return 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* file argument is not the mount point */
+	if (file_dentry(filp) != sb->s_root)
+		return -EINVAL;
+
+	/* filesystem is not backed by block device */
+	if (sb->s_bdev == NULL)
+		return -ENODEV;
+
+	/* check for invalid bits set */
+	if (flags & ~(EXT4_IOC_CHECKPOINT_FLAG_DISCARD |
+				EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT))
+		return -EINVAL;
+
+	/* both discard and zeroout cannot be set */
+	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD &
+				EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT)
+		return -EINVAL;
+
+	if (flags & EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT)
+		pr_info_ratelimited("warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow");
+
+	if (!EXT4_SB(sb)->s_journal)
+		return -ENODEV;
+
+	jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
+	err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, flags);
+	jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
+
+	return err;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1211,6 +1258,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fsverity_ioctl_read_metadata(filp,
 						    (const void __user *)arg);
 
+	case EXT4_IOC_CHECKPOINT:
+		return ext4_ioctl_checkpoint(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -1291,6 +1341,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
+	case EXT4_IOC_CHECKPOINT:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.31.1.607.g51e8a6a459-goog

