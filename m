Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68172596405
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Aug 2022 22:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiHPUwf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Aug 2022 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiHPUwe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Aug 2022 16:52:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8895489CDF
        for <linux-ext4@vger.kernel.org>; Tue, 16 Aug 2022 13:52:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u133so10336389pfc.10
        for <linux-ext4@vger.kernel.org>; Tue, 16 Aug 2022 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RhVQdkHeTt1u4gWNsyXG6ACSQ+AOHcxrrVFXSe3q9Fs=;
        b=KHyQoUwu+4/4E01nWPvQnOS1pUvDBdnEKZQamZJI8bGtPEVJDB10uTVuGxJavETzIm
         Te7qDvZVgKi1ZVMM+Lgh8y8BZdNHY3yxCHVGunvFW14U85YZYoDmQO/lgajHy2DWI/fM
         JNNNjJUgzo4/DyVhqsTt719fsj6PQaq+M2NqEuSQIfhdDN245+/Jej5nIxpEWjuLZ1PN
         ESHZX8JYfAc3a8s3ci+TGPW3ibN+fioQkRsfAv9x38WHAA0fGTist3h+oEl3z92br+Ik
         ZdHsxFQhowUhflnJ/OW4zdI6PGLgSGBeiufZRBl5+8+fds8yIvNjwPvVHHQ6O4L+cM0w
         vGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RhVQdkHeTt1u4gWNsyXG6ACSQ+AOHcxrrVFXSe3q9Fs=;
        b=ZJjvXVGyjrF/dcwFTBgtppkI4/aEj4EbxlXbpLY84zAMTUcVmKO2+z75pGgtGwXc1i
         FXyvij+t06CuKCMYOgusGZnUDkxkyuz8b763DkzxGz1NuMreZZp10s8NlAYvtlNOyPL+
         JwPofx9NRTOd5+n3mbRjaR+ANRDzXfh19ufhI6WW6BfM8Ikg7HXlSypBF24Hl9sB06MV
         NmEQbQUMGlVYUGs97vMAnjdZI4BBqJjYByOr8+JU5TJnlxHW/ASIxsqeblCXYqYQ9dnJ
         K3+Z/lpjKNWwUTcW8rrP3Oa9XqOXL+ZHipuA75gbdTRHHEZ3ZSm3cD0MN/G4OG405Uqa
         Z2/w==
X-Gm-Message-State: ACgBeo1VnVqtIGdMlDfhIyG4YlC/mRpYY2eger+r1AiFVBsYwpT8MB6B
        eZNEkqY/RBHoSbiInDMxGbkF8O/5Iow=
X-Google-Smtp-Source: AA6agR66XliqYxrV4DcF70F8LHvgnZszKx9aD/8mWbsdHJ0R4gU9BHc9WYpEFCfJ22TKT6DqS73J9w==
X-Received: by 2002:a05:6a00:a19:b0:535:49ee:da43 with SMTP id p25-20020a056a000a1900b0053549eeda43mr2891377pfh.53.1660683152917;
        Tue, 16 Aug 2022 13:52:32 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id g2-20020aa79dc2000000b0052d27ccea39sm9149318pfq.19.2022.08.16.13.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:52:32 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v4] tune2fs: Add support for get/set UUID ioctls.
Date:   Tue, 16 Aug 2022 13:52:14 -0700
Message-Id: <20220816205214.145632-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
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

When mounted, there is a race condition between changing the filesystem
UUID and changing other aspects of the filesystem, like mounting, resizing,
changing features, etc. Using these ioctls to get/set the UUID ensures the
filesystem is not being resized.

Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---

Changes in v4:

Ioctl calls are now inline. handle_fsuuid() is removed.

Fsuuid is freed.

ext2fs_check_if_mounted() call replaced with ext2fs_check_mount_point()
to avoid redundancy.

I tested mounted and unmounted code paths.


 misc/tune2fs.c | 98 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..d0cb90ae 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -82,11 +82,25 @@ extern int optind;
 #define FS_IOC_GETFSLABEL	_IOR(0x94, 49, char[FSLABEL_MAX])
 #endif
 
+struct fsuuid {
+	__u32   fsu_len;
+	__u32   fsu_flags;
+	__u8    fsu_uuid[];
+};
+
+#ifndef EXT4_IOC_GETFSUUID
+#define EXT4_IOC_GETFSUUID	_IOR('f', 44, struct fsuuid)
+#endif
+
+#ifndef EXT4_IOC_SETFSUUID
+#define EXT4_IOC_SETFSUUID	_IOW('f', 44, struct fsuuid)
+#endif
+
 extern int ask_yn(const char *string, int def);
 
 const char *program_name = "tune2fs";
 char *device_name;
-char *new_label, *new_last_mounted, *new_UUID;
+char *new_label, *new_last_mounted, *requested_uuid;
 char *io_options;
 static int c_flag, C_flag, e_flag, f_flag, g_flag, i_flag, l_flag, L_flag;
 static int m_flag, M_flag, Q_flag, r_flag, s_flag = -1, u_flag, U_flag, T_flag;
@@ -2102,7 +2116,7 @@ static void parse_tune2fs_options(int argc, char **argv)
 				open_flag = EXT2_FLAG_RW;
 				break;
 		case 'U':
-			new_UUID = optarg;
+			requested_uuid = optarg;
 			U_flag = 1;
 			open_flag = EXT2_FLAG_RW |
 				EXT2_FLAG_JOURNAL_DEV_OK;
@@ -3090,6 +3104,7 @@ int tune2fs_main(int argc, char **argv)
 	io_manager io_ptr, io_ptr_orig = NULL;
 	int rc = 0;
 	char default_undo_file[1] = { 0 };
+	char mntpt[PATH_MAX + 1];
 
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -3237,9 +3252,10 @@ retry_open:
 		goto closefs;
 	}
 
-	retval = ext2fs_check_if_mounted(device_name, &mount_flags);
+	retval = ext2fs_check_mount_point(device_name, &mount_flags,
+					mntpt, sizeof(mntpt));
 	if (retval) {
-		com_err("ext2fs_check_if_mount", retval,
+		com_err("ext2fs_check_mount_point", retval,
 			_("while determining whether %s is mounted."),
 			device_name);
 		rc = 1;
@@ -3454,6 +3470,10 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		dgrp_t i;
 		char buf[SUPERBLOCK_SIZE] __attribute__ ((aligned(8)));
 		__u8 old_uuid[UUID_SIZE];
+		uuid_t new_uuid;
+		int fd = -1;
+		struct fsuuid *fsuuid = NULL;
+		errcode_t ret = -1;
 
 		if (ext2fs_has_feature_stable_inodes(fs->super)) {
 			fputs(_("Cannot change the UUID of this filesystem "
@@ -3507,25 +3527,62 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 				set_csum = 1;
 		}
 
-		memcpy(old_uuid, sb->s_uuid, UUID_SIZE);
-		if ((strcasecmp(new_UUID, "null") == 0) ||
-		    (strcasecmp(new_UUID, "clear") == 0)) {
-			uuid_clear(sb->s_uuid);
-		} else if (strcasecmp(new_UUID, "time") == 0) {
-			uuid_generate_time(sb->s_uuid);
-		} else if (strcasecmp(new_UUID, "random") == 0) {
-			uuid_generate(sb->s_uuid);
-		} else if (uuid_parse(new_UUID, sb->s_uuid)) {
+		if ((mount_flags & EXT2_MF_MOUNTED) &&
+			!(mount_flags & EXT2_MF_READONLY) && mntpt) {
+			fd = open(mntpt, O_RDONLY);
+			if (fd >= 0) {
+				fsuuid = malloc(sizeof(*fsuuid) + UUID_SIZE);
+				if (!fsuuid) {
+					close(fd);
+					fd = -1;
+				}
+			}
+		}
+
+		/* Get the filesystem uuid through the ioctl.
+		 * If the filesystem is offline or the ioctl is unavailable or
+		 * fails, fall back to directly modifiying the superblock.
+		 */
+		if (fd >= 0) {
+			fsuuid->fsu_len = UUID_SIZE;
+			fsuuid->fsu_flags = 0;
+			ret = ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid);
+		}
+		if (ret)
+			memcpy(old_uuid, sb->s_uuid, UUID_SIZE);
+
+		if ((strcasecmp(requested_uuid, "null") == 0) ||
+		    (strcasecmp(requested_uuid, "clear") == 0)) {
+			uuid_clear(new_uuid);
+		} else if (strcasecmp(requested_uuid, "time") == 0) {
+			uuid_generate_time(new_uuid);
+		} else if (strcasecmp(requested_uuid, "random") == 0) {
+			uuid_generate(new_uuid);
+		} else if (uuid_parse(requested_uuid, new_uuid)) {
 			com_err(program_name, 0, "%s",
 				_("Invalid UUID format\n"));
 			rc = 1;
 			goto closefs;
 		}
-		ext2fs_init_csum_seed(fs);
-		if (set_csum) {
-			for (i = 0; i < fs->group_desc_count; i++)
-				ext2fs_group_desc_csum_set(fs, i);
-			fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
+
+		/* Set the filesystem uuid through the ioctl or fallback to
+		 * directly modifying superblock.
+		 */
+		if (fd >= 0) {
+			fsuuid->fsu_len - UUID_SIZE;
+			fsuuid->fsu_flags = 0;
+			memcpy(&fsuuid->fsu_uuid, new_uuid, UUID_SIZE);
+			ret = ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid);
+		}
+		if (ret) {
+			memcpy(sb->s_uuid, new_uuid, UUID_SIZE);
+			ext2fs_init_csum_seed(fs);
+			if (set_csum) {
+				for (i = 0; i < fs->group_desc_count; i++)
+					ext2fs_group_desc_csum_set(fs, i);
+				fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
+			}
+			ext2fs_mark_super_dirty(fs);
 		}
 
 		/* If this is a journal dev, we need to copy UUID into jsb */
@@ -3550,7 +3607,10 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 				goto closefs;
 		}
 
-		ext2fs_mark_super_dirty(fs);
+		if (fd >= 0)
+			close(fd);
+		if (fsuuid)
+			free(fsuuid);
 	}
 
 	if (I_flag) {
-- 
2.37.1.595.g718a3a8f04-goog

