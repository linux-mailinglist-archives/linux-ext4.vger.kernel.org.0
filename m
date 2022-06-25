Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9593755A80B
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jun 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiFYIWc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jun 2022 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiFYIWb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jun 2022 04:22:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E2C1C135
        for <linux-ext4@vger.kernel.org>; Sat, 25 Jun 2022 01:22:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7744162pjl.5
        for <linux-ext4@vger.kernel.org>; Sat, 25 Jun 2022 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fd5EYg5LyHjrq7BExH6ikYvSMbBlJ9Ih7Xl+ikP8zBQ=;
        b=nWlcowM6tp0iA1tZ5razt4nSXndi1PxsFNxwr4pMfKOX4pPJTjEs3nCrEC9s5hyTzd
         P10eN/T/PiSO7xkRtSty1fSgzabvNOLIWSjX86Zc+nII9AGwRBQN5Ct6TarQZZuC+TN0
         6WUo2yb1vMFgbGY9At5rNAoejKGe54MBtXzN1lxwPW2NzcFkuONC6vClBh9VHNzJssnp
         nJNZUJXG3oCyKdT0IFdJENkyyeu0TZjH3FH2+lI4EWViC5rNYOlRwDgbZlX7aL6zT5RA
         pt3GPXEI//8ZHwe+QzcfUKzQQ51c0eWc/KjS+03PuMz6vyZ7srFKh1CMqxpbgq/TaXeh
         +0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fd5EYg5LyHjrq7BExH6ikYvSMbBlJ9Ih7Xl+ikP8zBQ=;
        b=hjezNFjWATvsW0TqPWADcHMe4BzVsP88i4GdTAvr5yLY9gDihJvbGgDrObthacvTkJ
         sOgJfFrVpcQim4P6zco6Wrl++qxGuzZq8MhOi0P4i3HiYSYcuLWPukiOhRq+VWG/bHSU
         Vxdjniug8NEDk+lR3xlQ+R4a7RTIedk4YF8/MobFXAIQZZmMXLmF7f7/apADKqaJN+Qm
         pN8yaiiuExWB+D7aKhEx9Nq/pT2P4HFl/ApWyH5nZP2AnMRnFU1PrSm22xrRiUodtLNK
         b13lu0KamaG00+hUq2YmOHAZU/K9f0bbksDq0NjqZA86Z2vEvGA0L15xiQ0g09DhrPlW
         SEkg==
X-Gm-Message-State: AJIora+2PUzTRaS7tU0JWiHMulOIVvuU4V4ZZynmy+wnnZkU40LWXwhK
        LHKtSyJQJVoePw6AlMkD6e4=
X-Google-Smtp-Source: AGRyM1si0eHCyE5VtT+2O1dDofgVKv0prJPiuWkJNKKLIfnRiladWnftxGhPp7JJKWTeHzj8zfHvOg==
X-Received: by 2002:a17:902:b193:b0:16a:2c23:37d0 with SMTP id s19-20020a170902b19300b0016a2c2337d0mr3218558plr.35.1656145350425;
        Sat, 25 Jun 2022 01:22:30 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id d21-20020a63d715000000b00408a81ea6basm2942491pgg.21.2022.06.25.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 01:22:29 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH] Add ioctls to get/set the ext4 superblock uuid.
Date:   Sat, 25 Jun 2022 01:22:25 -0700
Message-Id: <20220625082225.103574-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This fixes a race between changing the ext4 superblock uuid and operations
like mounting, resizing, changing features, etc.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---
 fs/ext4/ext4.h  | 10 ++++++
 fs/ext4/ioctl.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..00747532cc4a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -724,6 +724,8 @@ enum {
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
 #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
+#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
+#define EXT4_IOC_SETFSUUID		_IOW('f', 45, struct fsuuid)
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -753,6 +755,14 @@ enum {
 						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
 						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
 
+/*
+ * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
+ */
+struct fsuuid {
+	size_t len;
+	__u8 __user *b;
+};
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index cb01c1da0f9d..a47e24fc8c67 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/iversion.h>
 #include <linux/fileattr.h>
+#include <linux/uuid.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include <linux/fsmap.h>
@@ -41,6 +42,15 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
 	memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
 }
 
+/*
+ * Superblock modification callback function for changing file system
+ * UUID.
+ */
+static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
+{
+	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
+}
+
 static
 int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
 			   ext4_update_sb_callback func,
@@ -1131,6 +1141,74 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
 	return 0;
 }
 
+static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
+			struct fsuuid __user *ufsuuid)
+{
+	int ret = 0;
+	__u8 uuid[UUID_SIZE];
+	struct fsuuid fsuuid;
+
+	/* read uuid from userspace*/
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	/* If invalid, return EINVAL */
+	if (fsuuid.len != UUID_SIZE)
+		return -EINVAL;
+
+
+	lock_buffer(sbi->s_sbh);
+	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
+	unlock_buffer(sbi->s_sbh);
+
+	if (copy_to_user(fsuuid.b, uuid, UUID_SIZE))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static int ext4_ioctl_setuuid(struct file *filp,
+			const struct fsuuid __user *ufsuuid)
+{
+	int ret = 0;
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct fsuuid fsuuid;
+	__u8 uuid[UUID_SIZE];
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/*
+	 * If any checksums (group descriptors or metadata) are being used
+	 * then the checksum seed feature is required to change the UUID.
+	 */
+	if (((ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb))
+			&& !ext4_has_feature_csum_seed(sb))
+		|| ext4_has_feature_stable_inodes(sb))
+		return -EOPNOTSUPP;
+
+	/* Read the length uuid and userspace pointer to uuid from userspace. */
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	/* If invalid, return EINVAL */
+	if (fsuuid.len != UUID_SIZE)
+		return -EINVAL;
+
+	/* Read uuid from userspace*/
+	if (copy_from_user(uuid, fsuuid.b, UUID_SIZE))
+		return -EFAULT;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	ret = ext4_update_superblocks_fn(sb, ext4_sb_setuuid, &uuid);
+	mnt_drop_write_file(filp);
+
+	return ret;
+}
+
 static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1509,6 +1587,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioctl_setlabel(filp,
 					   (const void __user *)arg);
 
+	case EXT4_IOC_GETFSUUID:
+		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
+	case EXT4_IOC_SETFSUUID:
+		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -1586,6 +1668,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_CHECKPOINT:
 	case FS_IOC_GETFSLABEL:
 	case FS_IOC_SETFSLABEL:
+	case EXT4_IOC_GETFSUUID:
+	case EXT4_IOC_SETFSUUID:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.37.0.rc0.161.g10f37bed90-goog

