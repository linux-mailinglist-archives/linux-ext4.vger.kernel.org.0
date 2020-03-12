Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC2183469
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgCLPTs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:19:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgCLPTs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1WjX0mn1tBRm9vLgb9+Ptoj0JCElHfxL2k6mUKvnOic=; b=nqc2U73XtIEKsFUcU3uNPQ5T+n
        7UhZRF+TUgpUoZYGCcMPBh6G5rGtReNkQ+aepck80dty28Do/mmVJLgmMf+ocKTkLh18ZBfC0ga04
        uCzMCMievQ5ge25630ozlQOwBWfXvLMvdCCCshl6AOtcGmk8kmk/+gVQyILae2TaCH+P8bApxEnBb
        4Ca1foZHWoERwEfrUpPgyLWlko6sl0fq+AnGaTxR6FUDuLG+7xaNoD76EUyWTqE8F8MB/EkzmXP7P
        vDNhqn3DAJDH9aeH/knBWHM/MVUFcH4zdJKs29pIJIIDgzyKwcaK9TQO4EIregHgtbqFC3yPE0x0H
        PZb0tVHA==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPch-0006VK-Ar; Thu, 12 Mar 2020 15:19:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 02/21] block: remove __bdevname
Date:   Thu, 12 Mar 2020 16:19:20 +0100
Message-Id: <20200312151939.645254-3-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312151939.645254-1-hch@lst.de>
References: <20200312151939.645254-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is no good reason for __bdevname to exist.  Just open code
printing the string in the callers.  For three of them the format
string can be trivially merged into existing printk statements,
and in init/do_mounts.c we can at least do the scnprintf once at
the start of the function, and unconditional of CONFIG_BLOCK to
make the output for tiny configfs a little more helpful.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partition-generic.c | 14 --------------
 drivers/md/md.c           |  4 ++--
 fs/ext4/super.c           |  6 +++---
 fs/reiserfs/journal.c     |  5 ++---
 include/linux/fs.h        |  1 -
 init/do_mounts.c          | 12 ++----------
 6 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5f06b7a6c119..1d91ea3b4f6b 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -57,20 +57,6 @@ const char *bio_devname(struct bio *bio, char *buf)
 }
 EXPORT_SYMBOL(bio_devname);
 
-/*
- * There's very little reason to use this, you should really
- * have a struct block_device just about everywhere and use
- * bdevname() instead.
- */
-const char *__bdevname(dev_t dev, char *buffer)
-{
-	scnprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
-				MAJOR(dev), MINOR(dev));
-	return buffer;
-}
-
-EXPORT_SYMBOL(__bdevname);
-
 static ssize_t part_partition_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b28f9390608f..11759f9e328e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2491,12 +2491,12 @@ static int lock_rdev(struct md_rdev *rdev, dev_t dev, int shared)
 {
 	int err = 0;
 	struct block_device *bdev;
-	char b[BDEVNAME_SIZE];
 
 	bdev = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
 				 shared ? (struct md_rdev *)lock_rdev : rdev);
 	if (IS_ERR(bdev)) {
-		pr_warn("md: could not open %s.\n", __bdevname(dev, b));
+		pr_warn("md: could not open device unknown-block(%u,%u).\n",
+			MAJOR(dev), MINOR(dev));
 		return PTR_ERR(bdev);
 	}
 	rdev->bdev = bdev;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c7c4adb664e..4cbd1cc34dfa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -927,7 +927,6 @@ void ext4_update_dynamic_rev(struct super_block *sb)
 static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
 	struct block_device *bdev;
-	char b[BDEVNAME_SIZE];
 
 	bdev = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL, sb);
 	if (IS_ERR(bdev))
@@ -935,8 +934,9 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 	return bdev;
 
 fail:
-	ext4_msg(sb, KERN_ERR, "failed to open journal device %s: %ld",
-			__bdevname(dev, b), PTR_ERR(bdev));
+	ext4_msg(sb, KERN_ERR,
+		 "failed to open journal device unknown-block(%u,%u) %ld",
+		 MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
 	return NULL;
 }
 
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 072156c4f895..5c766330e493 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2599,7 +2599,6 @@ static int journal_init_dev(struct super_block *super,
 	int result;
 	dev_t jdev;
 	fmode_t blkdev_mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
-	char b[BDEVNAME_SIZE];
 
 	result = 0;
 
@@ -2621,8 +2620,8 @@ static int journal_init_dev(struct super_block *super,
 			result = PTR_ERR(journal->j_dev_bd);
 			journal->j_dev_bd = NULL;
 			reiserfs_warning(super, "sh-458",
-					 "cannot init journal device '%s': %i",
-					 __bdevname(jdev, b), result);
+					 "cannot init journal device unknown-block(%u,%u): %i",
+					 MAJOR(jdev), MINOR(jdev), result);
 			return result;
 		} else if (jdev != super->s_dev)
 			set_blocksize(journal->j_dev_bd, super->s_blocksize);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..561b35e3b95b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2699,7 +2699,6 @@ static inline void unregister_chrdev(unsigned int major, const char *name)
 
 #ifdef CONFIG_BLOCK
 #define BLKDEV_MAJOR_MAX	512
-extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern void blkdev_show(struct seq_file *,off_t);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 0ae9cc22f2ae..29d326b6c29d 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -429,12 +429,10 @@ void __init mount_block_root(char *name, int flags)
 	struct page *page = alloc_page(GFP_KERNEL);
 	char *fs_names = page_address(page);
 	char *p;
-#ifdef CONFIG_BLOCK
 	char b[BDEVNAME_SIZE];
-#else
-	const char *b = name;
-#endif
 
+	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
+		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	get_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
@@ -451,9 +449,6 @@ void __init mount_block_root(char *name, int flags)
 		 * and bad superblock on root device.
 		 * and give them a list of the available devices
 		 */
-#ifdef CONFIG_BLOCK
-		__bdevname(ROOT_DEV, b);
-#endif
 		printk("VFS: Cannot open root device \"%s\" or %s: error %d\n",
 				root_device_name, b, err);
 		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
@@ -476,9 +471,6 @@ void __init mount_block_root(char *name, int flags)
 	for (p = fs_names; *p; p += strlen(p)+1)
 		printk(" %s", p);
 	printk("\n");
-#ifdef CONFIG_BLOCK
-	__bdevname(ROOT_DEV, b);
-#endif
 	panic("VFS: Unable to mount root fs on %s", b);
 out:
 	put_page(page);
-- 
2.24.1

