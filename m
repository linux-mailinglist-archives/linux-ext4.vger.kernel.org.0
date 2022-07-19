Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE74857AAB2
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 01:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiGSXxO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 19:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiGSXxD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 19:53:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9466B93
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 16:52:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r24so2303942plg.3
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W6bho8WF6DQohU/iLrWdWoEKCGPAMqLCL30KJ0i19C4=;
        b=GPaZLr5qC8BxN3bWDm1VloJ/r6+Q/jhVwOLXByQRAZRziA8vJn6i7gqv9K1HQIq0Bv
         7q0nMb5JULfbQJtMHWr3oc90882xFpohpbuPHYHVUHb8TvYpeyZgEZKyvxYKRZg4ihqc
         FjUOO1Z05HbJo+b3+vtDF+H/fANQupzKOcVR+ngEfP12SEQYm6qysZpnMn4L2IDJjKoT
         GzWCu2r2G/fUHTji8AJH9VvU6igvk+AuhaeDdI7E+NWzHGtg/LWfHK6P9SKR5YmAdaHp
         DoOknLDxnEBG02z8c+ixvfoiaVNm1oKCOfYhWKPxmQRz+VO/7TP9WBwpnA6WhGwoxMhw
         Hc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W6bho8WF6DQohU/iLrWdWoEKCGPAMqLCL30KJ0i19C4=;
        b=we+gzkOg65JIyTXTQ/g8XspLiOE5Zzhe9W3fLF+IP0iZLf450q30bcuJ8OBxtPogFA
         p3CO05WGLZbdPWekqEPFa48E+tvnyDyI7ZtxYtuJFnNxhPr1Z74+BbfVGR7UF63Z94LW
         wwGP7i+HyuHXFIM5Cig9MFfkRdpv5BdRzd9tbHd9pcwwOD7SOA59RkQsQUwEXHCzyN0C
         URzbjOd4qJHr9y8bBduXHasKhL491wrC+O4Vv95rLtPaYLDoDEAvLFoUsyBot5dkPPII
         6hj46bUiRSGF2+0OayNvR52TzqeXDquM69+RQj4q3mz0kH4t/d4a1BbKzIr3Ay/E+I50
         sgcA==
X-Gm-Message-State: AJIora+d7ue+YQSzZ3sIjgR+sIwJiv1wtv4c+Ki0gx0xB193KJK1Hnja
        czeHK5DyLmVwtVDHDAKEJezicZva0HM=
X-Google-Smtp-Source: AGRyM1uA1ndVi7hX3wbJe8c2H+W2TXvCw7d8Ouc4Xtj5LYGddTBCfTZPJyvcfS7TCcUcBdOvwuQsUQ==
X-Received: by 2002:a17:90b:48c2:b0:1f0:fe42:6189 with SMTP id li2-20020a17090b48c200b001f0fe426189mr2137628pjb.40.1658274733108;
        Tue, 19 Jul 2022 16:52:13 -0700 (PDT)
Received: from jbongio9100214.corp.google.com ([2620:0:102f:1:c88e:7520:969d:1265])
        by smtp.googlemail.com with ESMTPSA id m11-20020a170902db0b00b0016c4147e48asm12389536plx.219.2022.07.19.16.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:52:12 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v3] tune2fs: Add support for get/set UUID ioctls.
Date:   Tue, 19 Jul 2022 16:52:04 -0700
Message-Id: <20220719235204.237526-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in V3:

Added modified utility to commit heading.

Simplified return value of handle_fsuuid.

Added get_mounted_fsuuid and set_mounted_fsuuid for clarity.

 misc/tune2fs.c | 113 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 18 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..36863acf 100644
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
@@ -3078,6 +3092,61 @@ int handle_fslabel(int setlabel) {
 	return 0;
 }
 
+/*
+ * Use EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID to get/set file system UUID.
+ * Return:	0 on success
+ *             -1 when the old method should be used
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
+	memcpy(fsuuid->fsu_uuid, uuid, UUID_SIZE);
+	fsuuid->fsu_len = UUID_SIZE;
+	fsuuid->fsu_flags = 0;
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
+	if (get)
+		ret = ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid);
+	else
+		ret = ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid);
+
+	close(fd);
+	if (ret)
+		return -1;
+	return 0;
+}
+
+static inline int get_mounted_fsuuid(__u8 *old_uuid)
+{
+	return handle_fsuuid(old_uuid, true);
+}
+
+static inline int set_mounted_fsuuid(__u8 *new_uuid)
+{
+	return handle_fsuuid(new_uuid, false);
+}
+
+
 #ifndef BUILD_AS_LIB
 int main(int argc, char **argv)
 #else
@@ -3454,6 +3523,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		dgrp_t i;
 		char buf[SUPERBLOCK_SIZE] __attribute__ ((aligned(8)));
 		__u8 old_uuid[UUID_SIZE];
+		uuid_t new_uuid;
 
 		if (ext2fs_has_feature_stable_inodes(fs->super)) {
 			fputs(_("Cannot change the UUID of this filesystem "
@@ -3507,25 +3577,34 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
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
+		rc = get_mounted_fsuuid(old_uuid);
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
+		rc = set_mounted_fsuuid(new_uuid);
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
@@ -3549,8 +3628,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			if ((rc = fs_update_journal_user(sb, old_uuid)))
 				goto closefs;
 		}
-
-		ext2fs_mark_super_dirty(fs);
 	}
 
 	if (I_flag) {
-- 
2.37.0.170.g444d1eabd0-goog

