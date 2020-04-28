Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1731D1BC59A
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgD1Qpz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728352AbgD1Qpz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUT/OS8kzSv96VBmywIhZfBWVItqa8J4eDUCluxvb3c=;
        b=VmPxp0m2DxDvpaVg2BEYIkFEAVPwXLI1b2SBRfj9NJ+2h6YgIas+z3FL4LTeooZOiH3AdT
        iPVzVSUZssQUseBxfRrF03aLvxar2SgAQSjl4hOrKO3BQu9uywN82rTVlhEyx6HZxmoGU+
        ilowRs+MMSAw7rSlBThjPJuc3w58VOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-VxIOzi2NN9qszx2uLbBV3g-1; Tue, 28 Apr 2020 12:45:50 -0400
X-MC-Unique: VxIOzi2NN9qszx2uLbBV3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F15721895A28;
        Tue, 28 Apr 2020 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D4511010403;
        Tue, 28 Apr 2020 16:45:48 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 04/17] ext4: Change handle_mount_opt() to use fs_parameter
Date:   Tue, 28 Apr 2020 18:45:23 +0200
Message-Id: <20200428164536.462-5-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 236 +++++++++++++++++++++++++++++-------------------
 1 file changed, 141 insertions(+), 95 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5f8d21568c8d..2c6fea451d7d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1778,7 +1778,8 @@ static const char deprecated_msg[] =3D
 	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
=20
 #ifdef CONFIG_QUOTA
-static int set_qf_name(struct super_block *sb, int qtype, substring_t *a=
rgs)
+static int set_qf_name(struct super_block *sb, int qtype,
+		       struct fs_parameter *param)
 {
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	char *qname, *old_qname =3D get_qf_name(sb, sbi, qtype);
@@ -1795,7 +1796,7 @@ static int set_qf_name(struct super_block *sb, int =
qtype, substring_t *args)
 			 "ignored when QUOTA feature is enabled");
 		return 1;
 	}
-	qname =3D match_strdup(args);
+	qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);
 	if (!qname) {
 		ext4_msg(sb, KERN_ERR,
 			"Not enough memory for storing quotafile name");
@@ -1984,35 +1985,49 @@ static int ext4_sb_read_encoding(const struct ext=
4_super_block *es,
 }
 #endif
=20
-static int handle_mount_opt(struct super_block *sb, char *opt, int token=
,
-			    substring_t *args, unsigned long *journal_devnum,
-			    unsigned int *journal_ioprio, int is_remount)
+struct ext4_fs_context {
+	unsigned long journal_devnum;
+	unsigned int journal_ioprio;
+};
+
+static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *=
param)
 {
-	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+	struct ext4_sb_info *sbi =3D fc->s_fs_info;
+	struct super_block *sb =3D sbi->s_sb;
 	const struct mount_opts *m;
+	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-	int arg =3D 0;
+	int token;
+
+	token =3D fs_parse(fc, ext4_param_specs, param, &result);
+	if (token < 0)
+		return token;
=20
 #ifdef CONFIG_QUOTA
-	if (token =3D=3D Opt_usrjquota)
-		return set_qf_name(sb, USRQUOTA, &args[0]);
-	else if (token =3D=3D Opt_grpjquota)
-		return set_qf_name(sb, GRPQUOTA, &args[0]);
-	else if (token =3D=3D Opt_offusrjquota)
-		return clear_qf_name(sb, USRQUOTA);
-	else if (token =3D=3D Opt_offgrpjquota)
-		return clear_qf_name(sb, GRPQUOTA);
+	if (token =3D=3D Opt_usrjquota) {
+		if (!*param->string)
+			return clear_qf_name(sb, USRQUOTA);
+		else
+			return set_qf_name(sb, USRQUOTA, param);
+	} else if (token =3D=3D Opt_grpjquota) {
+		if (!*param->string)
+			return clear_qf_name(sb, GRPQUOTA);
+		else
+			return set_qf_name(sb, GRPQUOTA, param);
+	}
 #endif
 	switch (token) {
 	case Opt_noacl:
 	case Opt_nouser_xattr:
-		ext4_msg(sb, KERN_WARNING, deprecated_msg, opt, "3.5");
+		ext4_msg(sb, KERN_WARNING, deprecated_msg, param->key, "3.5");
 		break;
 	case Opt_sb:
 		return 1;	/* handled by get_sb_block() */
 	case Opt_removed:
-		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option", opt);
+		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option",
+			 param->key);
 		return 1;
 	case Opt_abort:
 		sbi->s_mount_flags |=3D EXT4_MF_FS_ABORTED;
@@ -2026,6 +2041,11 @@ static int handle_mount_opt(struct super_block *sb=
, char *opt, int token,
 	case Opt_nolazytime:
 		sb->s_flags &=3D ~SB_LAZYTIME;
 		return 1;
+	case Opt_errors:
+	case Opt_data:
+	case Opt_data_err:
+	case Opt_jqfmt:
+		token =3D result.uint_32;
 	}
=20
 	for (m =3D ext4_mount_opts; m->token !=3D Opt_err; m++)
@@ -2034,25 +2054,23 @@ static int handle_mount_opt(struct super_block *s=
b, char *opt, int token,
=20
 	if (m->token =3D=3D Opt_err) {
 		ext4_msg(sb, KERN_ERR, "Unrecognized mount option \"%s\" "
-			 "or missing value", opt);
+			 "or missing value", param->key);
 		return -1;
 	}
=20
 	if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
 		ext4_msg(sb, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext2", opt);
+			 "Mount option \"%s\" incompatible with ext2",
+			 param->string);
 		return -1;
 	}
 	if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
 		ext4_msg(sb, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext3", opt);
+			 "Mount option \"%s\" incompatible with ext3",
+			 param->string);
 		return -1;
 	}
=20
-	if (args->from && !(m->flags & MOPT_STRING) && match_int(args, &arg))
-		return -1;
-	if (args->from && (m->flags & MOPT_GTE0) && (arg < 0))
-		return -1;
 	if (m->flags & MOPT_EXPLICIT) {
 		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
 			set_opt2(sb, EXPLICIT_DELALLOC);
@@ -2070,115 +2088,104 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
 	}
=20
 	if (m->flags & MOPT_NOSUPPORT) {
-		ext4_msg(sb, KERN_ERR, "%s option not supported", opt);
+		ext4_msg(sb, KERN_ERR, "%s option not supported",
+			 param->key);
 	} else if (token =3D=3D Opt_commit) {
-		if (arg =3D=3D 0)
-			arg =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
-		else if (arg > INT_MAX / HZ) {
+		if (result.uint_32 =3D=3D 0)
+			sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
+		else if (result.uint_32 > INT_MAX / HZ) {
 			ext4_msg(sb, KERN_ERR,
 				 "Invalid commit interval %d, "
 				 "must be smaller than %d",
-				 arg, INT_MAX / HZ);
+				 result.uint_32, INT_MAX / HZ);
 			return -1;
 		}
-		sbi->s_commit_interval =3D HZ * arg;
+		sbi->s_commit_interval =3D HZ * result.uint_32;
 	} else if (token =3D=3D Opt_debug_want_extra_isize) {
-		if ((arg & 1) ||
-		    (arg < 4) ||
-		    (arg > (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
+		if ((result.uint_32 & 1) ||
+		    (result.uint_32 < 4) ||
+		    (result.uint_32 >
+		     (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
 			ext4_msg(sb, KERN_ERR,
-				 "Invalid want_extra_isize %d", arg);
+				 "Invalid want_extra_isize %d", result.uint_32);
 			return -1;
 		}
-		sbi->s_want_extra_isize =3D arg;
+		sbi->s_want_extra_isize =3D result.uint_32;
 	} else if (token =3D=3D Opt_max_batch_time) {
-		sbi->s_max_batch_time =3D arg;
+		sbi->s_max_batch_time =3D result.uint_32;
 	} else if (token =3D=3D Opt_min_batch_time) {
-		sbi->s_min_batch_time =3D arg;
+		sbi->s_min_batch_time =3D result.uint_32;
 	} else if (token =3D=3D Opt_inode_readahead_blks) {
-		if (arg && (arg > (1 << 30) || !is_power_of_2(arg))) {
+		if (result.uint_32 &&
+		    (result.uint_32 > (1 << 30) ||
+		     !is_power_of_2(result.uint_32))) {
 			ext4_msg(sb, KERN_ERR,
 				 "EXT4-fs: inode_readahead_blks must be "
 				 "0 or a power of 2 smaller than 2^31");
 			return -1;
 		}
-		sbi->s_inode_readahead_blks =3D arg;
+		sbi->s_inode_readahead_blks =3D result.uint_32;
 	} else if (token =3D=3D Opt_init_itable) {
 		set_opt(sb, INIT_INODE_TABLE);
-		if (!args->from)
-			arg =3D EXT4_DEF_LI_WAIT_MULT;
-		sbi->s_li_wait_mult =3D arg;
+		sbi->s_li_wait_mult =3D EXT4_DEF_LI_WAIT_MULT;
+		if (param->type =3D=3D fs_value_is_string)
+			sbi->s_li_wait_mult =3D result.uint_32;
 	} else if (token =3D=3D Opt_max_dir_size_kb) {
-		sbi->s_max_dir_size_kb =3D arg;
+		sbi->s_max_dir_size_kb =3D result.uint_32;
 	} else if (token =3D=3D Opt_stripe) {
-		sbi->s_stripe =3D arg;
+		sbi->s_stripe =3D result.uint_32;
 	} else if (token =3D=3D Opt_resuid) {
-		uid =3D make_kuid(current_user_ns(), arg);
+		uid =3D make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid uid value %d", arg);
+			ext4_msg(sb, KERN_ERR, "Invalid uid value %d",
+				 result.uint_32);
 			return -1;
 		}
 		sbi->s_resuid =3D uid;
 	} else if (token =3D=3D Opt_resgid) {
-		gid =3D make_kgid(current_user_ns(), arg);
+		gid =3D make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid gid value %d", arg);
+			ext4_msg(sb, KERN_ERR, "Invalid gid value %d",
+				 result.uint_32);
 			return -1;
 		}
 		sbi->s_resgid =3D gid;
 	} else if (token =3D=3D Opt_journal_dev) {
-		if (is_remount) {
+		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 			ext4_msg(sb, KERN_ERR,
 				 "Cannot specify journal on remount");
 			return -1;
 		}
-		*journal_devnum =3D arg;
+		ctx->journal_devnum =3D result.uint_32;
 	} else if (token =3D=3D Opt_journal_path) {
-		char *journal_path;
 		struct inode *journal_inode;
 		struct path path;
 		int error;
=20
-		if (is_remount) {
+		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 			ext4_msg(sb, KERN_ERR,
 				 "Cannot specify journal on remount");
 			return -1;
 		}
-		journal_path =3D match_strdup(&args[0]);
-		if (!journal_path) {
-			ext4_msg(sb, KERN_ERR, "error: could not dup "
-				"journal device string");
-			return -1;
-		}
=20
-		error =3D kern_path(journal_path, LOOKUP_FOLLOW, &path);
+		error =3D fs_lookup_param(fc, param, 1, &path);
 		if (error) {
 			ext4_msg(sb, KERN_ERR, "error: could not find "
-				"journal device path: error %d", error);
-			kfree(journal_path);
+				 "journal device path");
 			return -1;
 		}
=20
 		journal_inode =3D d_inode(path.dentry);
-		if (!S_ISBLK(journal_inode->i_mode)) {
-			ext4_msg(sb, KERN_ERR, "error: journal path %s "
-				"is not a block device", journal_path);
-			path_put(&path);
-			kfree(journal_path);
-			return -1;
-		}
-
-		*journal_devnum =3D new_encode_dev(journal_inode->i_rdev);
+		ctx->journal_devnum =3D new_encode_dev(journal_inode->i_rdev);
 		path_put(&path);
-		kfree(journal_path);
 	} else if (token =3D=3D Opt_journal_ioprio) {
-		if (arg > 7) {
+		if (result.uint_32 > 7) {
 			ext4_msg(sb, KERN_ERR, "Invalid journal IO priority"
 				 " (must be 0-7)");
 			return -1;
 		}
-		*journal_ioprio =3D
-			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, arg);
+		ctx->journal_ioprio =3D
+			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
 	} else if (token =3D=3D Opt_test_dummy_encryption) {
 #ifdef CONFIG_FS_ENCRYPTION
 		sbi->s_mount_flags |=3D EXT4_MF_TEST_DUMMY_ENCRYPTION;
@@ -2189,7 +2196,7 @@ static int handle_mount_opt(struct super_block *sb,=
 char *opt, int token,
 			 "Test dummy encryption mount option ignored");
 #endif
 	} else if (m->flags & MOPT_DATAJ) {
-		if (is_remount) {
+		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 			if (!sbi->s_journal)
 				ext4_msg(sb, KERN_WARNING, "Remounting file system with no journal s=
o ignoring journalled data option");
 			else if (test_opt(sb, DATA_FLAGS) !=3D m->mount_opt) {
@@ -2231,17 +2238,22 @@ static int handle_mount_opt(struct super_block *s=
b, char *opt, int token,
 	} else if (token =3D=3D Opt_data_err_ignore) {
 		sbi->s_mount_opt &=3D ~m->mount_opt;
 	} else {
-		if (!args->from)
-			arg =3D 1;
+		unsigned int set =3D 0;
+
+		if ((param->type =3D=3D fs_value_is_flag) ||
+		    result.uint_32 > 0)
+			set =3D 1;
+
 		if (m->flags & MOPT_CLEAR)
-			arg =3D !arg;
+			set =3D !set;
 		else if (unlikely(!(m->flags & MOPT_SET))) {
 			ext4_msg(sb, KERN_WARNING,
-				 "buggy handling of option %s", opt);
+				 "buggy handling of option %s",
+				 param->key);
 			WARN_ON(1);
 			return -1;
 		}
-		if (arg !=3D 0)
+		if (set !=3D 0)
 			sbi->s_mount_opt |=3D m->mount_opt;
 		else
 			sbi->s_mount_opt &=3D ~m->mount_opt;
@@ -2254,26 +2266,60 @@ static int parse_options(char *options, struct su=
per_block *sb,
 			 unsigned int *journal_ioprio,
 			 int is_remount)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int token;
-	char *p;
+	struct ext4_fs_context ctx;
+	struct fs_parameter param;
+	struct fs_context fc;
+	int ret;
+	char *key;
=20
 	if (!options)
 		return 1;
=20
-	while ((p =3D strsep(&options, ",")) !=3D NULL) {
-		if (!*p)
-			continue;
-		/*
-		 * Initialize args struct so we know whether arg was
-		 * found; some options take optional arguments.
-		 */
-		args[0].to =3D args[0].from =3D NULL;
-		token =3D match_token(p, tokens, args);
-		if (handle_mount_opt(sb, p, token, args, journal_devnum,
-				     journal_ioprio, is_remount) < 0)
-			return 0;
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private =3D &ctx;
+	fc.s_fs_info =3D EXT4_SB(sb);
+
+	if (is_remount)
+		fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+
+	while ((key =3D strsep(&options, ",")) !=3D NULL) {
+		if (*key) {
+			size_t v_len =3D 0;
+			char *value =3D strchr(key, '=3D');
+
+			param.type =3D fs_value_is_flag;
+			param.string =3D NULL;
+
+			if (value) {
+				if (value =3D=3D key)
+					continue;
+
+				*value++ =3D 0;
+				v_len =3D strlen(value);
+				param.string =3D kmemdup_nul(value, v_len,
+							   GFP_KERNEL);
+				if (!param.string)
+					return 0;
+				param.type =3D fs_value_is_string;
+			}
+
+			param.key =3D key;
+			param.size =3D v_len;
+
+			ret =3D handle_mount_opt(&fc, &param);
+			if (param.string)
+				kfree(param.string);
+			if (ret < 0)
+				return 0;
+		}
 	}
+
+	if (journal_devnum)
+		*journal_devnum =3D ctx.journal_devnum;
+	if (journal_ioprio)
+		*journal_ioprio =3D ctx.journal_ioprio;
+
 	return ext4_validate_options(sb);
 }
=20
--=20
2.21.1

