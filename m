Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25C74BC98
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Jul 2023 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGHHaQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 Jul 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjGHHaG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 Jul 2023 03:30:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB926B1
        for <linux-ext4@vger.kernel.org>; Sat,  8 Jul 2023 00:29:56 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QyhfS6fd5ztQTs;
        Sat,  8 Jul 2023 15:26:56 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 8 Jul 2023 15:29:51 +0800
Message-ID: <84a1a21a-be09-f70d-1d1b-234c706ddf14@huawei.com>
Date:   Sat, 8 Jul 2023 15:29:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>,
        Ye Bin <yebin@huaweicloud.com>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
 <20230626021758.GF8954@mit.edu>
 <4e647e9b-4f2f-b89f-6825-838f22c4bf2e@huawei.com>
 <20230704193357.GG1178919@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230704193357.GG1178919@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100024.china.huawei.com (7.185.36.115) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/5 3:33, Theodore Ts'o wrote:

I have written the ioctl for EXT4_IOC_SET_ERROR_BEHAVIOR according to your
instructions and verified that it can indeed modify the data on the disk.

However, I realized some problems. If we use the ioctl method to modify the
data, it would require multiple ioctls in user space to modify the 
superblock.
If one ioctl successfully modifies the superblock data, but another ioctl
fails, the atomicity of the superblock cannot be guaranteed. This is just
within one user space process, not to mention the scenario of multiple user
space processes calling ioctls concurrently. Additionally, multiple ioctls
modifying the superblock may be placed in multiple transactions, which 
further
compromises atomicity.

Writing the entire superblock buffer_head to disk can ensure atomicity.
However, these data need to be converted to ext4_sb_info. Otherwise, during
unmount, the data in memory will overwrite the data on the disk.
(Modifying the values in ext4_sb_info can potentially introduce unexpected
issues, just like the problem thata arises when setting the UUID without
checking ext4_has_feature_csum_seed.)

> So the better approach is to have multiple new ioctl's for each
> superblock field (or set of fields) that you might want modify.  We
> have some of these already --- for example, EXT4_IOC_SETFSUUID and
> FS_IOC_SETFSLABEL.  For tune2fs, all of additional ioctls for making
> configuration changes while the file system is mounted are:
> 
>     * EXT4_IOC_SET_FEATURES
> 	- for tune2fs -O...
>     * EXT4_IOC_CLEAR_FEATURES
> 	- for tune2fs -O^...
>     * EXT4_IOC_SET_ERROR_BEHAVIOR
> 	- for tune2fs -e
>     * EXT4_IOC_SET_DEFAULT_MOUNT_FLAGS
>          - for tune2fs -o
>     * EXT4_IOC_SET_DEFAULT_MOUNT_OPTS
>          - for tune2fs -E mount_opts=XXX
>     * EXT4_IOC_SET_FSCK_POLICY
> 	- for tune2fs -[cCiT]
>     * EXT4_IOC_SET_RESERVED_ALLOC
> 	- for tune2fs -[ugm]

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 331859511f80..d598e1975786 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -51,6 +51,11 @@ static void ext4_sb_setuuid(struct ext4_super_block 
*es, const void *arg)
  	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
  }

+static void ext4_sb_set_error_behavior(struct ext4_super_block *es, 
const void *arg)
+{
+	es->s_errors = cpu_to_le16(*(__u16 *)arg);
+}
+
  static
  int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
  			   ext4_update_sb_callback func,
@@ -1220,6 +1225,32 @@ static int ext4_ioctl_setuuid(struct file *filp,
  	return ret;
  }

+static int ext4_ioctl_set_error_behavior(struct file *filp,
+			const __u16 __user *uerror_behavior)
+{
+	int ret = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
+	__u16 error_behavior;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&error_behavior, uerror_behavior, 
sizeof(error_behavior)))
+		return -EFAULT;
+
+	if (error_behavior < EXT4_ERRORS_CONTINUE || error_behavior > 
EXT4_ERRORS_PANIC)
+		return -EINVAL;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	ret = ext4_update_superblocks_fn(sb, ext4_sb_set_error_behavior, 
&error_behavior);
+	mnt_drop_write_file(filp);
+
+	return ret;
+}
+
  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned 
long arg)
  {
  	struct inode *inode = file_inode(filp);
@@ -1607,6 +1638,8 @@ static long __ext4_ioctl(struct file *filp, 
unsigned int cmd, unsigned long arg)
  		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
  	case EXT4_IOC_SETFSUUID:
  		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
+	case EXT4_IOC_SET_ERROR_BEHAVIOR:
+		return ext4_ioctl_set_error_behavior(filp, (const void __user *)arg);
  	default:
  		return -ENOTTY;
  	}
diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 1c4c2dd29112..68329d51a8a7 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -33,6 +33,7 @@
  #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
  #define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
  #define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
+#define EXT4_IOC_SET_ERROR_BEHAVIOR	_IOW('f', 45, __u16)

  #define EXT4_IOC_SHUTDOWN _IOR('X', 125, __u32)



Thanks,
  - bin.

