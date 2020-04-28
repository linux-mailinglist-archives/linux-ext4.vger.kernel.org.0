Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760511BC59C
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgD1Qp6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36236 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgD1Qp6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvaF7/nxVLcaKVg0ARrqJT+3u0GhuiH3Dn9YY029b0g=;
        b=Eyw77uPLM1xJ+JY49UfTfxr8QR2XZwo0rzpRTb+VNnsevgXj3z3unzv89Wq8I/7MNTyomN
        lh4ksEzeHOLnfzFlnvJeevymIIVRA6aLFkhIniZYXOGRs/5/bekNSHOv1mjc4wg0bXyQSd
        Z5W5fuOOLjZnnoahoy5w141Ci/XRSy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-aggXCdGSMYei9c5cLkq2QA-1; Tue, 28 Apr 2020 12:45:52 -0400
X-MC-Unique: aggXCdGSMYei9c5cLkq2QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE861895A2B;
        Tue, 28 Apr 2020 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9401002395;
        Tue, 28 Apr 2020 16:45:50 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 05/17] ext4: Allow sb to be NULL in ext4_msg()
Date:   Tue, 28 Apr 2020 18:45:24 +0200
Message-Id: <20200428164536.462-6-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so allow sb to be NULL in ext4_msg and use that in
handle_mount_opt().

Also change return value to appropriate -EINVAL where needed.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 120 +++++++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 57 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2c6fea451d7d..2f7e49bfbf71 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -88,7 +88,7 @@ static void ext4_unregister_li_request(struct super_blo=
ck *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
-static int ext4_validate_options(struct super_block *sb);
+static int ext4_validate_options(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -754,13 +754,14 @@ void __ext4_msg(struct super_block *sb,
 	struct va_format vaf;
 	va_list args;
=20
-	if (!___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
+	if (sb &&
+	    !___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
 		return;
=20
 	va_start(args, fmt);
 	vaf.fmt =3D fmt;
 	vaf.va =3D &args;
-	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	printk("%sEXT4-fs (%s): %pV\n", prefix, sb ? sb->s_id : "n/a", &vaf);
 	va_end(args);
 }
=20
@@ -2021,12 +2022,12 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 	switch (token) {
 	case Opt_noacl:
 	case Opt_nouser_xattr:
-		ext4_msg(sb, KERN_WARNING, deprecated_msg, param->key, "3.5");
+		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
 		break;
 	case Opt_sb:
 		return 1;	/* handled by get_sb_block() */
 	case Opt_removed:
-		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option",
+		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
 		return 1;
 	case Opt_abort:
@@ -2053,22 +2054,22 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 			break;
=20
 	if (m->token =3D=3D Opt_err) {
-		ext4_msg(sb, KERN_ERR, "Unrecognized mount option \"%s\" "
+		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
 			 "or missing value", param->key);
-		return -1;
+		return -EINVAL;
 	}
=20
 	if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
-		ext4_msg(sb, KERN_ERR,
+		ext4_msg(NULL, KERN_ERR,
 			 "Mount option \"%s\" incompatible with ext2",
 			 param->string);
-		return -1;
+		return -EINVAL;
 	}
 	if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
-		ext4_msg(sb, KERN_ERR,
+		ext4_msg(NULL, KERN_ERR,
 			 "Mount option \"%s\" incompatible with ext3",
 			 param->string);
-		return -1;
+		return -EINVAL;
 	}
=20
 	if (m->flags & MOPT_EXPLICIT) {
@@ -2077,28 +2078,28 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
 			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
 		} else
-			return -1;
+			return -EINVAL;
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
 		clear_opt(sb, ERRORS_MASK);
 	if (token =3D=3D Opt_noquota && sb_any_quota_loaded(sb)) {
-		ext4_msg(sb, KERN_ERR, "Cannot change quota "
+		ext4_msg(NULL, KERN_ERR, "Cannot change quota "
 			 "options when quota turned on");
-		return -1;
+		return -EINVAL;
 	}
=20
 	if (m->flags & MOPT_NOSUPPORT) {
-		ext4_msg(sb, KERN_ERR, "%s option not supported",
+		ext4_msg(NULL, KERN_ERR, "%s option not supported",
 			 param->key);
 	} else if (token =3D=3D Opt_commit) {
 		if (result.uint_32 =3D=3D 0)
 			sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
 		else if (result.uint_32 > INT_MAX / HZ) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Invalid commit interval %d, "
 				 "must be smaller than %d",
 				 result.uint_32, INT_MAX / HZ);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_commit_interval =3D HZ * result.uint_32;
 	} else if (token =3D=3D Opt_debug_want_extra_isize) {
@@ -2106,9 +2107,9 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 		    (result.uint_32 < 4) ||
 		    (result.uint_32 >
 		     (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Invalid want_extra_isize %d", result.uint_32);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_want_extra_isize =3D result.uint_32;
 	} else if (token =3D=3D Opt_max_batch_time) {
@@ -2119,10 +2120,10 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 		if (result.uint_32 &&
 		    (result.uint_32 > (1 << 30) ||
 		     !is_power_of_2(result.uint_32))) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "EXT4-fs: inode_readahead_blks must be "
 				 "0 or a power of 2 smaller than 2^31");
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_inode_readahead_blks =3D result.uint_32;
 	} else if (token =3D=3D Opt_init_itable) {
@@ -2137,24 +2138,24 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 	} else if (token =3D=3D Opt_resuid) {
 		uid =3D make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid uid value %d",
+			ext4_msg(NULL, KERN_ERR, "Invalid uid value %d",
 				 result.uint_32);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_resuid =3D uid;
 	} else if (token =3D=3D Opt_resgid) {
 		gid =3D make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid gid value %d",
+			ext4_msg(NULL, KERN_ERR, "Invalid gid value %d",
 				 result.uint_32);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_resgid =3D gid;
 	} else if (token =3D=3D Opt_journal_dev) {
 		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Cannot specify journal on remount");
-			return -1;
+			return -EINVAL;
 		}
 		ctx->journal_devnum =3D result.uint_32;
 	} else if (token =3D=3D Opt_journal_path) {
@@ -2163,16 +2164,16 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 		int error;
=20
 		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Cannot specify journal on remount");
-			return -1;
+			return -EINVAL;
 		}
=20
 		error =3D fs_lookup_param(fc, param, 1, &path);
 		if (error) {
-			ext4_msg(sb, KERN_ERR, "error: could not find "
+			ext4_msg(NULL, KERN_ERR, "error: could not find "
 				 "journal device path");
-			return -1;
+			return -EINVAL;
 		}
=20
 		journal_inode =3D d_inode(path.dentry);
@@ -2180,29 +2181,29 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 		path_put(&path);
 	} else if (token =3D=3D Opt_journal_ioprio) {
 		if (result.uint_32 > 7) {
-			ext4_msg(sb, KERN_ERR, "Invalid journal IO priority"
+			ext4_msg(NULL, KERN_ERR, "Invalid journal IO priority"
 				 " (must be 0-7)");
-			return -1;
+			return -EINVAL;
 		}
 		ctx->journal_ioprio =3D
 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
 	} else if (token =3D=3D Opt_test_dummy_encryption) {
 #ifdef CONFIG_FS_ENCRYPTION
 		sbi->s_mount_flags |=3D EXT4_MF_TEST_DUMMY_ENCRYPTION;
-		ext4_msg(sb, KERN_WARNING,
+		ext4_msg(NULL, KERN_WARNING,
 			 "Test dummy encryption mode enabled");
 #else
-		ext4_msg(sb, KERN_WARNING,
+		ext4_msg(NULL, KERN_WARNING,
 			 "Test dummy encryption mount option ignored");
 #endif
 	} else if (m->flags & MOPT_DATAJ) {
 		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 			if (!sbi->s_journal)
-				ext4_msg(sb, KERN_WARNING, "Remounting file system with no journal s=
o ignoring journalled data option");
+				ext4_msg(NULL, KERN_WARNING, "Remounting file system with no journal=
 so ignoring journalled data option");
 			else if (test_opt(sb, DATA_FLAGS) !=3D m->mount_opt) {
-				ext4_msg(sb, KERN_ERR,
+				ext4_msg(NULL, KERN_ERR,
 					 "Cannot change data mode on remount");
-				return -1;
+				return -EINVAL;
 			}
 		} else {
 			clear_opt(sb, DATA_FLAGS);
@@ -2212,12 +2213,12 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 	} else if (m->flags & MOPT_QFMT) {
 		if (sb_any_quota_loaded(sb) &&
 		    sbi->s_jquota_fmt !=3D m->mount_opt) {
-			ext4_msg(sb, KERN_ERR, "Cannot change journaled "
+			ext4_msg(NULL, KERN_ERR, "Cannot change journaled "
 				 "quota options when quota turned on");
-			return -1;
+			return -EINVAL;
 		}
 		if (ext4_has_feature_quota(sb)) {
-			ext4_msg(sb, KERN_INFO,
+			ext4_msg(NULL, KERN_INFO,
 				 "Quota format mount options ignored "
 				 "when QUOTA feature is enabled");
 			return 1;
@@ -2226,12 +2227,12 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 #endif
 	} else if (token =3D=3D Opt_dax) {
 #ifdef CONFIG_FS_DAX
-		ext4_msg(sb, KERN_WARNING,
+		ext4_msg(NULL, KERN_WARNING,
 		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 		sbi->s_mount_opt |=3D m->mount_opt;
 #else
-		ext4_msg(sb, KERN_INFO, "dax option not supported");
-		return -1;
+		ext4_msg(NULL, KERN_INFO, "dax option not supported");
+		return -EINVAL;
 #endif
 	} else if (token =3D=3D Opt_data_err_abort) {
 		sbi->s_mount_opt |=3D m->mount_opt;
@@ -2247,11 +2248,11 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 		if (m->flags & MOPT_CLEAR)
 			set =3D !set;
 		else if (unlikely(!(m->flags & MOPT_SET))) {
-			ext4_msg(sb, KERN_WARNING,
+			ext4_msg(NULL, KERN_WARNING,
 				 "buggy handling of option %s",
 				 param->key);
 			WARN_ON(1);
-			return -1;
+			return -EINVAL;
 		}
 		if (set !=3D 0)
 			sbi->s_mount_opt |=3D m->mount_opt;
@@ -2320,12 +2321,17 @@ static int parse_options(char *options, struct su=
per_block *sb,
 	if (journal_ioprio)
 		*journal_ioprio =3D ctx.journal_ioprio;
=20
-	return ext4_validate_options(sb);
+	ret =3D ext4_validate_options(&fc);
+	if (ret < 0)
+		return 0;
+
+	return 1;
 }
=20
-static int ext4_validate_options(struct super_block *sb)
+static int ext4_validate_options(struct fs_context *fc)
 {
-	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	struct ext4_sb_info *sbi =3D fc->s_fs_info;
+	struct super_block *sb =3D sbi->s_sb;
 #ifdef CONFIG_QUOTA
 	char *usr_qf_name, *grp_qf_name;
 	/*
@@ -2334,9 +2340,9 @@ static int ext4_validate_options(struct super_block=
 *sb)
 	 * to support legacy quotas in quota files.
 	 */
 	if (test_opt(sb, PRJQUOTA) && !ext4_has_feature_project(sb)) {
-		ext4_msg(sb, KERN_ERR, "Project quota feature not enabled. "
+		ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
 			 "Cannot enable project quota enforcement.");
-		return 0;
+		return -EINVAL;
 	}
 	usr_qf_name =3D get_qf_name(sb, sbi, USRQUOTA);
 	grp_qf_name =3D get_qf_name(sb, sbi, GRPQUOTA);
@@ -2348,15 +2354,15 @@ static int ext4_validate_options(struct super_blo=
ck *sb)
 			clear_opt(sb, GRPQUOTA);
=20
 		if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
-			ext4_msg(sb, KERN_ERR, "old and new quota "
+			ext4_msg(NULL, KERN_ERR, "old and new quota "
 					"format mixing");
-			return 0;
+			return -EINVAL;
 		}
=20
 		if (!sbi->s_jquota_fmt) {
-			ext4_msg(sb, KERN_ERR, "journaled quota format "
+			ext4_msg(NULL, KERN_ERR, "journaled quota format "
 					"not specified");
-			return 0;
+			return -EINVAL;
 		}
 	}
 #endif
@@ -2364,11 +2370,11 @@ static int ext4_validate_options(struct super_blo=
ck *sb)
 		int blocksize =3D
 			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 		if (blocksize < PAGE_SIZE)
-			ext4_msg(sb, KERN_WARNING, "Warning: mounting with an "
+			ext4_msg(NULL, KERN_WARNING, "Warning: mounting with an "
 				 "experimental mount option 'dioread_nolock' "
 				 "for blocksize < PAGE_SIZE");
 	}
-	return 1;
+	return 0;
 }
=20
 static inline void ext4_show_quota_options(struct seq_file *seq,
--=20
2.21.1

