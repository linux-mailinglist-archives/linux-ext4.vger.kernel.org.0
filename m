Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53314563B19
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Jul 2022 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGAURm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Jul 2022 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiGAUR3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Jul 2022 16:17:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A0326E5
        for <linux-ext4@vger.kernel.org>; Fri,  1 Jul 2022 13:17:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x138so3428769pfc.3
        for <linux-ext4@vger.kernel.org>; Fri, 01 Jul 2022 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVLj4f7/RnpLNNgXK3qYBoDfqEqSXG+l0ft2b/X+YXY=;
        b=gHEhM5CeEW6M/Bg0+CwUfHiERpRz9hP+GpJyrTH0IvLl8MumkUl+3prVH4TemPg5Hp
         mAKX6jsMzBJVpZ6cbQZtsEVcBObgfZefR0vC/BAbJXd4u/YI1UD1yoSJJJPXGfJFx4WE
         6T3A3iO+CT/SYxiCQ9s4BelkthGy308mrUE7cCbAIyok9/vX09U6jPz3Nctpr6luleX7
         2scSshfJx8KKaDBr4bdsMwcDcTNWskCukWF1UFPzQtKfjLQuv+Ja6HrNe+dRq4xrQW0T
         GycZOkW6cIu54DcjnBQBXCrUd4JQtljjktNtMDuQe5WPlXvVyruMqJEwuOE/bAnxyx/k
         9OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVLj4f7/RnpLNNgXK3qYBoDfqEqSXG+l0ft2b/X+YXY=;
        b=v0Gn9UVg1sbSrEE2eZ9IcCqTb47B8Ng4T5KbKLrIZblVbcWqU9ytYls62uo90RIIsO
         QKiN4ptx96/v6eAnmjxai8fcfnVDz4tuExEYXqZvJH7jKJJeboxxqYOo0ze0iMcOnJng
         dzzs91LAuQ59OYSabUl5aubKxIzF40y/M30/nAQzxC3khVFG7oczQmsHSYtbFI5BPzcr
         iBvfJEfA7qn1MMXIemaMMkH0GsHsWhvVdlc8B0tX9uhvxPE/prDWlzr2uo/f6TOROLWh
         JjURWio+uX2MkjFjg2oX7gk5OJyjWdRTNKg0bbQToDgo/OHzFbN1XfPCb/0cgWQ0BgJT
         JefA==
X-Gm-Message-State: AJIora940n4/p5HbZs58aJBijKPnbKxD1OZtpj3t+sqeqo6OhIWsYpNV
        Y4wy19NbWUux2GCwogbA8SU=
X-Google-Smtp-Source: AGRyM1sGAFamEqXSuiYDGIKoIcmAcCVRiAUNNDTc6wbvkvEfeaXKEx0lTb+YFgLWmCZKBoHsOfsblQ==
X-Received: by 2002:a63:751c:0:b0:40c:f042:5686 with SMTP id q28-20020a63751c000000b0040cf0425686mr13526652pgc.462.1656706648507;
        Fri, 01 Jul 2022 13:17:28 -0700 (PDT)
Received: from jbongio9100214.corp.google.com ([2620:0:102f:1:443b:ca33:8b9a:ccba])
        by smtp.googlemail.com with ESMTPSA id p10-20020a170902bd0a00b00161ac982b9esm15972080pls.185.2022.07.01.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:17:28 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH] Add support for get/set UUID ioctls.
Date:   Fri,  1 Jul 2022 13:17:24 -0700
Message-Id: <20220701201724.184234-1-bongiojp@gmail.com>
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

When mounted, there is a race condition between changing the filesystem
UUID and changing other aspects of the filesystem, like mounting, resizing,
changing features, etc. Using these ioctls to get/set the UUID ensures the
filesystem is not being resized.

Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
---
 misc/tune2fs.c | 106 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 18 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..6e65cdf9 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -82,11 +82,27 @@ extern int optind;
 #define FS_IOC_GETFSLABEL	_IOR(0x94, 49, char[FSLABEL_MAX])
 #endif
 
+struct fsuuid {
+	__u32   fu_len;
+	__u32   fu_flags;
+	__u8    fu_uuid[];
+};
+
+#define EXT4_IOC_SETFSUUID_FLAG_BLOCKING 0x1
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
@@ -2102,7 +2118,7 @@ static void parse_tune2fs_options(int argc, char **argv)
 				open_flag = EXT2_FLAG_RW;
 				break;
 		case 'U':
-			new_UUID = optarg;
+			requested_uuid = optarg;
 			U_flag = 1;
 			open_flag = EXT2_FLAG_RW |
 				EXT2_FLAG_JOURNAL_DEV_OK;
@@ -3078,6 +3094,52 @@ int handle_fslabel(int setlabel) {
 	return 0;
 }
 
+/*
+ * Use EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID to get/set file system UUID.
+ * Return:	0 on success
+ *		1 on error
+ *		-1 when the old method should be used
+ */
+int handle_fsuuid(__u8 *uuid, bool get)
+{
+	errcode_t ret;
+	int mnt_flags, fd;
+	char label[FSLABEL_MAX];
+	int maxlen = FSLABEL_MAX - 1;
+	char mntpt[PATH_MAX + 1];
+	struct fsuuid *fsuuid = NULL;
+
+	fsuuid = malloc(sizeof(*fsuuid) + UUID_SIZE);
+	if (!fsuuid)
+		return -1;
+
+	memcpy(fsuuid->fu_uuid, uuid, UUID_SIZE);
+	fsuuid->fu_len = UUID_SIZE;
+
+	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
+					  mntpt, sizeof(mntpt));
+	if (ret || !(mnt_flags & EXT2_MF_MOUNTED) ||
+		(!get && (mnt_flags & EXT2_MF_READONLY)) ||
+		!mntpt[0])
+		return -1;
+
+	fd = open(mntpt, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	if (get) {
+		if (ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid))
+			ret = -1;
+	} else {
+		fsuuid->fu_flags  = EXT4_IOC_SETFSUUID_FLAG_BLOCKING;
+		if (ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid))
+			ret = -1;
+	}
+	close(fd);
+	return ret;
+}
+
+
 #ifndef BUILD_AS_LIB
 int main(int argc, char **argv)
 #else
@@ -3454,6 +3516,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		dgrp_t i;
 		char buf[SUPERBLOCK_SIZE] __attribute__ ((aligned(8)));
 		__u8 old_uuid[UUID_SIZE];
+		uuid_t new_uuid;
 
 		if (ext2fs_has_feature_stable_inodes(fs->super)) {
 			fputs(_("Cannot change the UUID of this filesystem "
@@ -3507,25 +3570,34 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
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
+		rc = handle_fsuuid(old_uuid, true);
+		if (rc == -1)
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
+		rc = handle_fsuuid(new_uuid, false);
+		if (rc == -1) {
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
@@ -3549,8 +3621,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			if ((rc = fs_update_journal_user(sb, old_uuid)))
 				goto closefs;
 		}
-
-		ext2fs_mark_super_dirty(fs);
 	}
 
 	if (I_flag) {
-- 
2.37.0.rc0.161.g10f37bed90-goog

