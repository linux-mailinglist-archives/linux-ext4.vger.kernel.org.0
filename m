Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8E76C86B
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjHBIhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHBIhP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 04:37:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F5171D
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 01:37:13 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RG4y534K2ztRk9;
        Wed,  2 Aug 2023 16:33:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 16:37:10 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [RFC PATCH 1/2] ext4: ioctl adds a framework for modifying superblock parameters
Date:   Wed, 2 Aug 2023 16:34:01 +0800
Message-ID: <20230802083402.515570-2-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230802083402.515570-1-zhanchengbin1@huawei.com>
References: <20230802083402.515570-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A framework for modifying attrs in the super block is added here, including
the check and set of attrs in the super block, and it will be very
convenient to add new parameter modifications later.

When in use, pass in ext4_sbattrs to the kernel mode, and
ext4_sbattrs->sba_attrs contains attrs that need to be modified one by
one. It is guaranteed that all variables in one call are modified
atomically.

Link: https://lore.kernel.org/linux-ext4/29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com/
Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 fs/ext4/ext4.h            |  12 ++++
 fs/ext4/ioctl.c           | 127 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ext4.h |  26 ++++++++
 3 files changed, 165 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..461d8bbe1e70 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3823,6 +3823,18 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
+struct ext4_ksbattrs {
+	__u32				sba_count;
+	struct ext4_sbattr		*sba_attrs[];
+};
+
+struct ext4_sbattr_operation {
+	int sb_attr_key;
+	int (*sb_attr_check)(struct ext4_sbattr *p_sbattr);
+	void (*sb_attr_set)(struct ext4_super_block *es, const void *arg);
+};
+
+
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 331859511f80..76653d855073 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -30,6 +30,13 @@
 typedef void ext4_update_sb_callback(struct ext4_super_block *es,
 				       const void *arg);
 
+/*
+ * Check and modify functions for each superblock variable
+ */
+struct ext4_sbattr_operation ext4_sbattr_ops[] = {
+	{EXT4_IOC_SUPERBLOCK_KEY_MAX, NULL, NULL},
+};
+
 /*
  * Superblock modification callback function for changing file system
  * label
@@ -51,6 +58,18 @@ static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
 	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
 }
 
+static void ext4_sb_set_superblock_attr(struct ext4_super_block *es, const void *arg)
+{
+	struct ext4_ksbattrs *p_sbattrs = (struct ext4_ksbattrs *)arg;
+	struct ext4_sbattr *p_sbattr;
+	int count;
+
+	for (count = 0; count < p_sbattrs->sba_count; count++) {
+		p_sbattr = p_sbattrs->sba_attrs[count];
+		ext4_sbattr_ops[p_sbattr->sba_key].sb_attr_set(es, p_sbattr);
+	}
+}
+
 static
 int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
 			   ext4_update_sb_callback func,
@@ -1220,6 +1239,112 @@ static int ext4_ioctl_setuuid(struct file *filp,
 	return ret;
 }
 
+/*
+ * Check the key-value pairs passed in from the user mode and assign it
+ * to the super block
+ */
+static int ext4_ioctl_set_superblock_attr(struct file *filp,
+			const struct ext4_sbattrs __user *usbattrs)
+{
+	int ret = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct ext4_sbattrs sbattrs, *p_sbattrs = NULL;
+	struct ext4_ksbattrs *p_ksbattrs = NULL;
+	struct ext4_sbattr sbattr, *p_sbattr = NULL;
+	size_t size;
+	int count = 0;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		ret = -EPERM;
+		goto failed;
+	}
+
+	if (copy_from_user(&sbattrs, usbattrs, sizeof(sbattrs))) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (sbattrs.sba_count > EXT4_SBATTR_MAX_COUNT) {
+		ret = -EINVAL;
+		goto failed;
+	}
+	size = sizeof(sbattrs) + sbattrs.sba_count * sizeof(struct ext4_sbarrt *);
+
+	p_sbattrs = kmalloc(size, GFP_KERNEL);
+	if (p_sbattrs == NULL) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	if (copy_from_user(p_sbattrs, usbattrs, size)) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	p_ksbattrs = kzalloc(size, GFP_KERNEL);
+	if (p_ksbattrs == NULL) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+	p_ksbattrs->sba_count = p_sbattrs->sba_count;
+
+	while (count < p_sbattrs->sba_count) {
+		if (copy_from_user(&sbattr, p_sbattrs->sba_attrs[count], sizeof(sbattr))) {
+			ret = -EFAULT;
+			goto failed;
+		}
+
+		size = sizeof(sbattr) + sbattr.sba_len * sizeof(char);
+		if (size > PAGE_SIZE) {
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (sbattr.sba_key >= EXT4_IOC_SUPERBLOCK_KEY_MAX) {
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		p_sbattr = kmalloc(size, GFP_KERNEL);
+		if (p_sbattr == NULL) {
+			ret = -ENOMEM;
+			goto failed;
+		}
+
+		p_ksbattrs->sba_attrs[count] = p_sbattr;
+
+		if (copy_from_user(p_sbattr, p_sbattrs->sba_attrs[count], size)) {
+			ret = -EFAULT;
+			goto failed;
+		}
+
+		/* Check the validity of key-value pairs */
+		ret = ext4_sbattr_ops[sbattr.sba_key].sb_attr_check(p_sbattr);
+		if (ret)
+			goto failed;
+
+		count++;
+	}
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		goto failed;
+
+	ret = ext4_update_superblocks_fn(sb, ext4_sb_set_superblock_attr, p_ksbattrs);
+	mnt_drop_write_file(filp);
+
+failed:
+	kfree(p_sbattrs);
+
+	if (p_ksbattrs) {
+		for (count = 0; count < p_ksbattrs->sba_count; count++)
+			kfree(p_ksbattrs->sba_attrs[count]);
+		kfree(p_ksbattrs);
+	}
+
+	return ret;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1607,6 +1732,8 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
 	case EXT4_IOC_SETFSUUID:
 		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
+	case EXT4_IOC_SET_SUPERBLOCK_ATTR:
+		return ext4_ioctl_set_superblock_attr(filp, (const void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 1c4c2dd29112..a9f33a0399e8 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -33,6 +33,7 @@
 #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
 #define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
 #define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
+#define EXT4_IOC_SET_SUPERBLOCK_ATTR	_IOW('f', 45, struct ext4_sbattrs)
 
 #define EXT4_IOC_SHUTDOWN _IOR('X', 125, __u32)
 
@@ -69,6 +70,31 @@
 						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
 						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
 
+/*
+ * Structure for EXT4_IOC_SET_SUPERBLOCK_ATTR
+ */
+struct ext4_sbattrs {
+	__u32				sba_count; // attrs number
+	struct ext4_sbattr __user	*sba_attrs[];
+};
+
+/*
+ * key for attr's magic in superblock
+ * len for attr's size in superblock
+ * value for attr's value in superblock
+ */
+struct ext4_sbattr {
+	__u32		sba_key;
+	__u32		sba_len;
+	char		sba_value[];
+};
+
+enum ext4_ioc_superblock_key {
+	EXT4_IOC_SUPERBLOCK_KEY_MAX = 0,
+};
+
+#define EXT4_SBATTR_MAX_COUNT	20
+
 /*
  * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
  */
-- 
2.31.1

