Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E457939F
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jul 2022 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiGSG4s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jul 2022 02:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiGSG4s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jul 2022 02:56:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4F24F1F
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 23:56:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t15so477831pjo.1
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Gaofz2SsLryolN9aUM5kOQ+B7lUKOwHiqvay7zstoU=;
        b=SMY4e2wQDzMMEWaewtWW9immy53jKoAiUu3HArP295w/im3YtjdQ0YdIAWfAxxkPyI
         9Rh7lO0BegSqQjwWjhGBBGrKEbU7FlYqsyGwPqle0jnM6RJX4G6/FeAEb52AOJeUbmV5
         NSKRuYhVXqr5LbhjtbcsBfFyz1MViU2vR0AFgoATNaiIrRQiEDxS4haPv3PKJi+GZv/e
         kCMWE3dgX4K6n4j6nEmSczzRsUcv1DTo3wJxzFRKp2/sjB84DAL2ycS6usmqGZkKFOJF
         MwrSV96RjWFN6VU8c0JdHRshOdVIQ3HaBO5XVUi3br7mIt39Y3HKJ2FznQgS1xN3pcIR
         XBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Gaofz2SsLryolN9aUM5kOQ+B7lUKOwHiqvay7zstoU=;
        b=Nrv83Jm1/JOBZY+sl/NYz+s8RU7Iz8+bYTvjE3PPNcfBoiSRJ6gQY3tZM0eSe/ExpS
         1H2RbU7Sj3y5v2gHExpxSCb/5sA41SgbYjWESQLnGluFlp6SXJxad98yw+v91cATMeCM
         21M3Vv2ov/AgPnIbWwQe56kUubGKPXOF9MTKi0IzGwTpDT6B5bunLNO4r4o/klzYbtIM
         i5BP3ggspfJT7VNHkhPyxt69+2gHTNl6gSyBChbvFKOZzz4YuV4bs4yDrZSUeXsFz8uf
         SaI5JGM5Bg6939oiaVibbSM2jFGtc/yYPETh45oTQhNbKnPMhichpygiUmtuuvqG4+f2
         N6/Q==
X-Gm-Message-State: AJIora/HC1o/8YWCiEHS0SRYTz2MozCYK1VY8c3U7pmNCYe1YIjBk+0W
        pziSjHONC5e3BCvVDL9KV6bXKIkCxpTMMQ==
X-Google-Smtp-Source: AGRyM1tS1g6RE3JkXi0Zy5La2PhS1uFrHVgEc377Xm9x9juMtIM/bxYfhUG867JKpPSERsSDxjO7wA==
X-Received: by 2002:a17:902:8f87:b0:16c:2c88:39ec with SMTP id z7-20020a1709028f8700b0016c2c8839ecmr32856548plo.52.1658213806321;
        Mon, 18 Jul 2022 23:56:46 -0700 (PDT)
Received: from jbongio9100214.roam.corp.google.com (cpe-104-173-199-31.socal.res.rr.com. [104.173.199.31])
        by smtp.googlemail.com with ESMTPSA id r18-20020a632b12000000b00415d873b7a2sm9231335pgr.11.2022.07.18.23.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 23:56:45 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH v2] Add support for get/set UUID ioctls.
Date:   Mon, 18 Jul 2022 23:56:37 -0700
Message-Id: <20220719065637.154309-1-bongiojp@gmail.com>
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

fu_* fields are now named fsu_*.

Removed EXT4_IOC_SETFSUUID_FLAG_BLOCKING flag.

fsu_flags is initialized to 0.

 misc/tune2fs.c | 104 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 18 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..39399d83 100644
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
@@ -3078,6 +3092,52 @@ int handle_fslabel(int setlabel) {
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
+	if (get) {
+		if (ioctl(fd, EXT4_IOC_GETFSUUID, fsuuid))
+			ret = -1;
+	} else {
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
@@ -3454,6 +3514,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		dgrp_t i;
 		char buf[SUPERBLOCK_SIZE] __attribute__ ((aligned(8)));
 		__u8 old_uuid[UUID_SIZE];
+		uuid_t new_uuid;
 
 		if (ext2fs_has_feature_stable_inodes(fs->super)) {
 			fputs(_("Cannot change the UUID of this filesystem "
@@ -3507,25 +3568,34 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
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
@@ -3549,8 +3619,6 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			if ((rc = fs_update_journal_user(sb, old_uuid)))
 				goto closefs;
 		}
-
-		ext2fs_mark_super_dirty(fs);
 	}
 
 	if (I_flag) {
-- 
2.37.0.170.g444d1eabd0-goog

