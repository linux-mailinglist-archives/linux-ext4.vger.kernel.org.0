Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8118372E27
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhEDQgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhEDQgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 12:36:49 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CBC061574
        for <linux-ext4@vger.kernel.org>; Tue,  4 May 2021 09:35:54 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id v3so2105859vkn.7
        for <linux-ext4@vger.kernel.org>; Tue, 04 May 2021 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bR2zmBsWO4NHcr0JmEgAd3+t7xyhR8vCrg55q0ZMGao=;
        b=IGuF3aKzoH8EvYd1SjRb9ii/dSDYWa9btZZfVrUa/8IV7vjh/cSYV3UK+/lzJMMzLj
         lsn6bm9Yhg/lnOD8xbe4Nyl1jsZRWUh7zP5cLBvoRICC99EHdpdRrjeScc/nDtLs1jw1
         QAdYKv55eGizbaRr4MhGC1YAquyWCHZGh5+MBCAM1eajLUM4wULhnezlU1PyCmLWYgIG
         /4jBWOxFbEthGctH1IE+BlZWWrtL85spY4IQ5FdzuxAgmQTiKKMn/eHD4vNVYNLqRyrV
         V0xqvw67sx2YPLhDwWXCE4IDjD5lirTEPFrnoeqBnfNorsnEyjATR/EBQFkzvo2x5P9B
         xSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bR2zmBsWO4NHcr0JmEgAd3+t7xyhR8vCrg55q0ZMGao=;
        b=CJAEMAGJbd2TWiI59oKoC5rwbiYNmFrdLLw2R/NnIz4POFg0JbnJq2qUDv/g1qJNpx
         3JtNdiPQrRl0lFKDtWyAknx8GDI5y7+BWfEaYP9ZAg1nIZfALx79aPeFSsk+Zv981OIV
         TgrUvBPgNfhzw3B8+ybS10bnc+HGgo7uaIaCmn7jj+Ozhne/X1wQPhWRm7pJA5S3r1lA
         i3rU/0JIw5HJwd8804jTT3FevRZdzgMn8Qq7J3reYvg826DHsFopwVq2q6htzNem+di+
         3gnaRj5/EjJgsS9GfhnTkEQv41aPnFUow6jDfNI1w9zF87BzyTaXHuRlKGmXshr4CIPp
         o7rg==
X-Gm-Message-State: AOAM533RdJTdEmMOREXmMJsorFH4eCMKVPCwVo76Gncv5bm/7h3IPwJK
        uee3GkkgVQjoDmqVnSA1V5MUMx8ZGr8=
X-Google-Smtp-Source: ABdhPJwkEMO07nl4SrPu2KxZTQMnrOtDd+h1hY9Esp2GF3UrKklfeuh2M0l7nDV40BPW2SGQhJqZhA==
X-Received: by 2002:a1f:9cd0:: with SMTP id f199mr21223301vke.16.1620146153219;
        Tue, 04 May 2021 09:35:53 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id x1sm749879vse.0.2021.05.04.09.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:35:52 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Date:   Tue,  4 May 2021 16:35:49 +0000
Message-Id: <20210504163550.1486337-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210504163550.1486337-1-leah.rumancik@gmail.com>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ioctl EXT4_IOC_CHECKPOINT checkpoints and flushes the journal. This
includes forcing all the transactions to the log, checkpointing the
transactions, and flushing the log to disk. This ioctl takes u64 "flags"
as an argument. With the EXT4_IOC_CHECKPOINT_FLAG_DISCARD flag set, the
journal blocks are also discarded.

Systems that wish to achieve content deletion SLO can set up a daemon
that calls this ioctl at a regular interval such that it matches with the
SLO requirement. Thus, with this patch, the ext4_dir_entry2 wipeout
patch[1], and the Ext4 "-o discard" mount option set, Ext4 can now
guarantee that all data will be erased and discarded on deletion. Note
that this ioctl won't write zeros if the device doesn't support discards.

The __jbd2_journal_issue_discard function could also be used to discard the
journal (if discard is supported) during journal load after recovery. This
would provide a potential solution to a journal replay bug reported earlier
this year[2] for block devices that support discard. After a successful
journal recovery, e2fsck can call this ioctl to discard the journal as
well.

[1] https://lore.kernel.org/linux-ext4/YIHknqxngB1sUdie@mit.edu/
[2] https://lore.kernel.org/linux-ext4/YDZoaacIYStFQT8g@mit.edu/

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/ext4.h    |  4 +++
 fs/ext4/ioctl.c   | 38 +++++++++++++++++++++++
 fs/jbd2/journal.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18f021c988a1..2fe8565706fc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -715,6 +715,7 @@ enum {
 #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
+#define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u64)
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -736,6 +737,9 @@ enum {
 #define EXT4_STATE_FLAG_NEWENTRY	0x00000004
 #define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
 
+/* flag to enable discarding journal blocks through ioctl EXT4_IOC_CHECKPOINT */
+#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	1
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ef809feb7e77..839ffd067357 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -794,6 +794,40 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	return error;
 }
 
+static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
+{
+	int err = 0;
+	unsigned long long flags = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
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
+		return -EINVAL;
+
+	if (copy_from_user(&flags, (__u64 __user *)arg,
+				sizeof(__u64)))
+		return -EFAULT;
+
+	/* flags can only be 0 or EXT4_IOC_CHECKPOINT_FLAG_DISCARD */
+	if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
+		return -EINVAL;
+
+	if (EXT4_SB(sb)->s_journal) {
+		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
+		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal,
+			flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD);
+		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
+	}
+	return err;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1205,6 +1239,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fsverity_ioctl_read_metadata(filp,
 						    (const void __user *)arg);
 
+	case EXT4_IOC_CHECKPOINT:
+		return ext4_ioctl_checkpoint(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -1285,6 +1322,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
+	case EXT4_IOC_CHECKPOINT:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 4b7953934c82..ce33e4817aab 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1686,6 +1686,80 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 	write_unlock(&journal->j_state_lock);
 }
 
+/* discard journal blocks excluding journal superblock */
+static int __jbd2_journal_issue_discard(journal_t *journal)
+{
+	int err = 0;
+	unsigned long block, log_offset; /* logical */
+	unsigned long long phys_block, block_start, block_stop; /* physical */
+	loff_t byte_start, byte_stop, byte_count;
+	struct request_queue *q = bdev_get_queue(journal->j_dev);
+
+	if (!q)
+		return -ENXIO;
+
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	/* lookup block mapping and issue discard for each contiguous region */
+	log_offset = be32_to_cpu(journal->j_superblock->s_first);
+
+	err = jbd2_journal_bmap(journal, log_offset, &block_start);
+	if (err) {
+		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
+		return err;
+	}
+
+	/*
+	 * use block_start - 1 to meet check for contiguous with previous region:
+	 * phys_block == block_stop + 1
+	 */
+	block_stop = block_start - 1;
+
+	for (block = log_offset; block < journal->j_total_len; block++) {
+		err = jbd2_journal_bmap(journal, block, &phys_block);
+		if (err) {
+			printk(KERN_ERR "JBD2: bad block at offset %lu", block);
+			return err;
+		}
+
+		if (block == journal->j_total_len - 1)
+			block_stop = phys_block;
+		else if (phys_block == block_stop + 1) {
+			block_stop++;
+			continue;
+		}
+
+		/*
+		 * not contiguous with prior physical block or this is last
+		 * block of journal, take care of the region
+		 */
+		byte_start = block_start * journal->j_blocksize;
+		byte_stop = block_stop * journal->j_blocksize;
+		byte_count = (block_stop - block_start + 1) *
+			journal->j_blocksize;
+
+		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+			byte_start, byte_stop);
+
+		err = blkdev_issue_discard(journal->j_dev,
+			byte_start >> SECTOR_SHIFT,
+			byte_count >> SECTOR_SHIFT,
+			GFP_NOFS, 0);
+
+		if (unlikely(err != 0)) {
+			printk(KERN_ERR "JBD2: unable to discard "
+				"journal at physical blocks %llu - %llu",
+				block_start, block_stop);
+			return err;
+		}
+
+		block_start = phys_block;
+		block_stop = phys_block;
+	}
+
+	return blkdev_issue_flush(journal->j_dev);
+}
 
 /**
  * jbd2_journal_update_sb_errno() - Update error in the journal.
@@ -2246,6 +2320,7 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
 /**
  * jbd2_journal_flush() - Flush journal
  * @journal: Journal to act on.
+ * @discard: discard the journal blocks
  *
  * Flush all data for a given journal to disk and empty the journal.
  * Filesystems can use this when remounting readonly to ensure that
@@ -2305,6 +2380,10 @@ int jbd2_journal_flush(journal_t *journal, bool discard)
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
 	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+
+	if (discard)
+		err = __jbd2_journal_issue_discard(journal);
+
 	mutex_unlock(&journal->j_checkpoint_mutex);
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(!journal->j_running_transaction);
-- 
2.31.1.527.g47e6f16901-goog

