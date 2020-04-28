Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA41BC59F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgD1QqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728397AbgD1QqC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yfXYFFEb8eTR0zTQuPZAm1W/9BZ2v/LcdS2ZN9uJ5AE=;
        b=HzGZ34Zd2XL8/74TWV5T+BcT7uIoaZC3mEHI+/bKU17WnokwvNWUCDV0egsKWJpimcbm6k
        c8/pH+npoDGsnKK/WVGZ+YqTR55yHgZ6F/AT+wtyM3tGsAsCeSlJMRUjBWBI4bXRZM0sKV
        7hsddfqUeJZQviphdOyNrlpochf5oLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-TAmZ-MQENZa4HUaUiQkWeg-1; Tue, 28 Apr 2020 12:45:56 -0400
X-MC-Unique: TAmZ-MQENZa4HUaUiQkWeg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31678107ACCA;
        Tue, 28 Apr 2020 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 153781002388;
        Tue, 28 Apr 2020 16:45:53 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 08/17] ext4: get rid of super block and sbi from handle_mount_ops()
Date:   Tue, 28 Apr 2020 18:45:27 +0200
Message-Id: <20200428164536.462-9-lczerner@redhat.com>
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
available. We've already removed some uses of sb and sbi, but now we
need to ged rid of the rest of it.

Use ext4_fs_context to store all of the confiruation specification so
that it can be later applied to the super block and sbi.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 379 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 272 insertions(+), 107 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5317ab324033..3b29069eb633 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -91,8 +91,7 @@ static struct inode *ext4_get_journal_inode(struct supe=
r_block *sb,
 static int ext4_validate_options(struct fs_context *fc);
 static int ext4_check_opt_consistency(struct fs_context *fc,
 				      struct super_block *sb);
-static void ext4_apply_quota_options(struct fs_context *fc,
-				     struct super_block *sb);
+static void ext4_apply_options(struct fs_context *fc, struct super_block=
 *sb);
=20
 /*
  * Lock ordering
@@ -1925,13 +1924,49 @@ static int ext4_sb_read_encoding(const struct ext=
4_super_block *es,
 }
 #endif
=20
+#define EXT4_SPEC_JQUOTA			(1 <<  0)
+#define EXT4_SPEC_JQFMT				(1 <<  1)
+#define EXT4_SPEC_DATAJ				(1 <<  2)
+#define EXT4_SPEC_SB_BLOCK			(1 <<  3)
+#define EXT4_SPEC_JOURNAL_DEV			(1 <<  4)
+#define EXT4_SPEC_JOURNAL_IOPRIO		(1 <<  5)
+#define EXT4_SPEC_s_want_extra_isize		(1 <<  6)
+#define EXT4_SPEC_s_max_batch_time		(1 <<  7)
+#define EXT4_SPEC_s_min_batch_time		(1 <<  8)
+#define EXT4_SPEC_s_inode_readahead_blks	(1 <<  9)
+#define EXT4_SPEC_s_li_wait_mult		(1 << 10)
+#define EXT4_SPEC_s_max_dir_size_kb		(1 << 11)
+#define EXT4_SPEC_s_stripe			(1 << 12)
+#define EXT4_SPEC_s_resuid			(1 << 13)
+#define EXT4_SPEC_s_resgid			(1 << 14)
+#define EXT4_SPEC_s_commit_interval		(1 << 15)
+
 struct ext4_fs_context {
 	char		*s_qf_names[EXT4_MAXQUOTAS];
 	int		s_jquota_fmt;	/* Format of quota to use */
 	unsigned short	qname_spec;
+	unsigned long	vals_s_flags;	/* Bits to set in s_flags */
+	unsigned long	mask_s_flags;	/* Bits changed in s_flags */
 	unsigned long	journal_devnum;
+	unsigned long	s_commit_interval;
+	unsigned long	s_stripe;
+	unsigned int	s_inode_readahead_blks;
+	unsigned int	s_want_extra_isize;
+	unsigned int	s_li_wait_mult;
+	unsigned int	s_max_dir_size_kb;
 	unsigned int	journal_ioprio;
+	unsigned int	vals_s_mount_opt;
+	unsigned int	mask_s_mount_opt;
+	unsigned int	vals_s_mount_opt2;
+	unsigned int	mask_s_mount_opt2;
+	unsigned int	vals_s_mount_flags;
+	unsigned int	mask_s_mount_flags;
 	unsigned int	opt_flags;	/* MOPT flags */
+	unsigned int	spec;
+	u32		s_max_batch_time;
+	u32		s_min_batch_time;
+	kuid_t		s_resuid;
+	kgid_t		s_resgid;
 };
=20
 #ifdef CONFIG_QUOTA
@@ -1970,6 +2005,7 @@ static int note_qf_name(struct fs_context *fc, int =
qtype,
 	}
 	ctx->s_qf_names[qtype] =3D qname;
 	ctx->qname_spec |=3D 1 << qtype;
+	ctx->spec |=3D EXT4_SPEC_JQUOTA;
 	return 0;
 }
=20
@@ -1985,15 +2021,36 @@ static int unnote_qf_name(struct fs_context *fc, =
int qtype)
=20
 	ctx->s_qf_names[qtype] =3D NULL;
 	ctx->qname_spec |=3D 1 << qtype;
+	ctx->spec |=3D EXT4_SPEC_JQUOTA;
 	return 0;
 }
 #endif
=20
+#define EXT4_SET_CTX(name)						\
+static inline void set_##name(struct ext4_fs_context *ctx, int flag)	\
+{									\
+	ctx->mask_s_##name |=3D flag;					\
+	ctx->vals_s_##name |=3D flag;					\
+}									\
+static inline void clear_##name(struct ext4_fs_context *ctx, int flag)	\
+{									\
+	ctx->mask_s_##name |=3D flag;					\
+	ctx->vals_s_##name &=3D ~flag;					\
+}									\
+static inline bool test_##name(struct ext4_fs_context *ctx, int flag)	\
+{									\
+	return ((ctx->vals_s_##name & flag) !=3D 0);			\
+}									\
+
+EXT4_SET_CTX(flags);
+EXT4_SET_CTX(mount_opt);
+EXT4_SET_CTX(mount_opt2);
+EXT4_SET_CTX(mount_flags);
+
+
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *=
param)
 {
 	struct ext4_fs_context *ctx =3D fc->fs_private;
-	struct ext4_sb_info *sbi =3D fc->s_fs_info;
-	struct super_block *sb =3D sbi->s_sb;
 	const struct mount_opts *m;
 	struct fs_parse_result result;
 	kuid_t uid;
@@ -2029,16 +2086,16 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 			 param->key);
 		return 1;
 	case Opt_abort:
-		sbi->s_mount_flags |=3D EXT4_MF_FS_ABORTED;
+		set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
 		return 1;
 	case Opt_i_version:
-		sb->s_flags |=3D SB_I_VERSION;
+		set_flags(ctx, SB_I_VERSION);
 		return 1;
 	case Opt_lazytime:
-		sb->s_flags |=3D SB_LAZYTIME;
+		set_flags(ctx, SB_LAZYTIME);
 		return 1;
 	case Opt_nolazytime:
-		sb->s_flags &=3D ~SB_LAZYTIME;
+		clear_flags(ctx, SB_LAZYTIME);
 		return 1;
 	case Opt_errors:
 	case Opt_data:
@@ -2061,21 +2118,22 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
=20
 	if (m->flags & MOPT_EXPLICIT) {
 		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
-			set_opt2(sb, EXPLICIT_DELALLOC);
+			set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
 		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
-			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
+			set_mount_opt2(ctx,
+				       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
 		} else
 			return -EINVAL;
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
-		clear_opt(sb, ERRORS_MASK);
+		clear_mount_opt(ctx, EXT4_MOUNT_ERRORS_MASK);
=20
 	if (m->flags & MOPT_NOSUPPORT) {
 		ext4_msg(NULL, KERN_ERR, "%s option not supported",
 			 param->key);
 	} else if (token =3D=3D Opt_commit) {
 		if (result.uint_32 =3D=3D 0)
-			sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
+			ctx->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
 		else if (result.uint_32 > INT_MAX / HZ) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Invalid commit interval %d, "
@@ -2083,21 +2141,22 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 				 result.uint_32, INT_MAX / HZ);
 			return -EINVAL;
 		}
-		sbi->s_commit_interval =3D HZ * result.uint_32;
+		ctx->s_commit_interval =3D HZ * result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_commit_interval;
 	} else if (token =3D=3D Opt_debug_want_extra_isize) {
-		if ((result.uint_32 & 1) ||
-		    (result.uint_32 < 4) ||
-		    (result.uint_32 >
-		     (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
+		if ((result.uint_32 & 1) || (result.uint_32 < 4)) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Invalid want_extra_isize %d", result.uint_32);
 			return -EINVAL;
 		}
-		sbi->s_want_extra_isize =3D result.uint_32;
+		ctx->s_want_extra_isize =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_want_extra_isize;
 	} else if (token =3D=3D Opt_max_batch_time) {
-		sbi->s_max_batch_time =3D result.uint_32;
+		ctx->s_max_batch_time =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_max_batch_time;
 	} else if (token =3D=3D Opt_min_batch_time) {
-		sbi->s_min_batch_time =3D result.uint_32;
+		ctx->s_min_batch_time =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_min_batch_time;
 	} else if (token =3D=3D Opt_inode_readahead_blks) {
 		if (result.uint_32 &&
 		    (result.uint_32 > (1 << 30) ||
@@ -2107,16 +2166,20 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 				 "0 or a power of 2 smaller than 2^31");
 			return -EINVAL;
 		}
-		sbi->s_inode_readahead_blks =3D result.uint_32;
+		ctx->s_inode_readahead_blks =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_inode_readahead_blks;
 	} else if (token =3D=3D Opt_init_itable) {
-		set_opt(sb, INIT_INODE_TABLE);
-		sbi->s_li_wait_mult =3D EXT4_DEF_LI_WAIT_MULT;
+		set_mount_opt(ctx, EXT4_MOUNT_INIT_INODE_TABLE);
+		ctx->s_li_wait_mult =3D EXT4_DEF_LI_WAIT_MULT;
 		if (param->type =3D=3D fs_value_is_string)
-			sbi->s_li_wait_mult =3D result.uint_32;
+			ctx->s_li_wait_mult =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_li_wait_mult;
 	} else if (token =3D=3D Opt_max_dir_size_kb) {
-		sbi->s_max_dir_size_kb =3D result.uint_32;
+		ctx->s_max_dir_size_kb =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_max_dir_size_kb;
 	} else if (token =3D=3D Opt_stripe) {
-		sbi->s_stripe =3D result.uint_32;
+		ctx->s_stripe =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_s_stripe;
 	} else if (token =3D=3D Opt_resuid) {
 		uid =3D make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
@@ -2124,7 +2187,8 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 				 result.uint_32);
 			return -EINVAL;
 		}
-		sbi->s_resuid =3D uid;
+		ctx->s_resuid =3D uid;
+		ctx->spec |=3D EXT4_SPEC_s_resuid;
 	} else if (token =3D=3D Opt_resgid) {
 		gid =3D make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
@@ -2132,7 +2196,8 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 				 result.uint_32);
 			return -EINVAL;
 		}
-		sbi->s_resgid =3D gid;
+		ctx->s_resgid =3D gid;
+		ctx->spec |=3D EXT4_SPEC_s_resgid;
 	} else if (token =3D=3D Opt_journal_dev) {
 		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 			ext4_msg(NULL, KERN_ERR,
@@ -2140,6 +2205,7 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 			return -EINVAL;
 		}
 		ctx->journal_devnum =3D result.uint_32;
+		ctx->spec |=3D EXT4_SPEC_JOURNAL_DEV;
 	} else if (token =3D=3D Opt_journal_path) {
 		struct inode *journal_inode;
 		struct path path;
@@ -2160,6 +2226,7 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
=20
 		journal_inode =3D d_inode(path.dentry);
 		ctx->journal_devnum =3D new_encode_dev(journal_inode->i_rdev);
+		ctx->spec |=3D EXT4_SPEC_JOURNAL_DEV;
 		path_put(&path);
 	} else if (token =3D=3D Opt_journal_ioprio) {
 		if (result.uint_32 > 7) {
@@ -2169,9 +2236,10 @@ static int handle_mount_opt(struct fs_context *fc,=
 struct fs_parameter *param)
 		}
 		ctx->journal_ioprio =3D
 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
+		ctx->spec |=3D EXT4_SPEC_JOURNAL_IOPRIO;
 	} else if (token =3D=3D Opt_test_dummy_encryption) {
 #ifdef CONFIG_FS_ENCRYPTION
-		sbi->s_mount_flags |=3D EXT4_MF_TEST_DUMMY_ENCRYPTION;
+		set_mount_flags(ctx, EXT4_MF_TEST_DUMMY_ENCRYPTION);
 		ext4_msg(NULL, KERN_WARNING,
 			 "Test dummy encryption mode enabled");
 #else
@@ -2179,35 +2247,27 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 			 "Test dummy encryption mount option ignored");
 #endif
 	} else if (m->flags & MOPT_DATAJ) {
-		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
-			if (!sbi->s_journal)
-				ext4_msg(NULL, KERN_WARNING, "Remounting file system with no journal=
 so ignoring journalled data option");
-			else if (test_opt(sb, DATA_FLAGS) !=3D m->mount_opt) {
-				ext4_msg(NULL, KERN_ERR,
-					 "Cannot change data mode on remount");
-				return -EINVAL;
-			}
-		} else {
-			clear_opt(sb, DATA_FLAGS);
-			sbi->s_mount_opt |=3D m->mount_opt;
-		}
+		clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+		set_mount_opt(ctx, m->mount_opt);
+		ctx->spec |=3D EXT4_SPEC_DATAJ;
 #ifdef CONFIG_QUOTA
 	} else if (m->flags & MOPT_QFMT) {
 		ctx->s_jquota_fmt =3D m->mount_opt;
+		ctx->spec |=3D EXT4_SPEC_JQFMT;
 #endif
 	} else if (token =3D=3D Opt_dax) {
 #ifdef CONFIG_FS_DAX
 		ext4_msg(NULL, KERN_WARNING,
 		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		sbi->s_mount_opt |=3D m->mount_opt;
+		set_mount_opt(ctx, m->mount_opt);
 #else
 		ext4_msg(NULL, KERN_INFO, "dax option not supported");
 		return -EINVAL;
 #endif
 	} else if (token =3D=3D Opt_data_err_abort) {
-		sbi->s_mount_opt |=3D m->mount_opt;
+		set_mount_opt(ctx, m->mount_opt);
 	} else if (token =3D=3D Opt_data_err_ignore) {
-		sbi->s_mount_opt &=3D ~m->mount_opt;
+		clear_mount_opt(ctx, m->mount_opt);
 	} else {
 		unsigned int set =3D 0;
=20
@@ -2225,9 +2285,9 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 			return -EINVAL;
 		}
 		if (set !=3D 0)
-			sbi->s_mount_opt |=3D m->mount_opt;
+			set_mount_opt(ctx, m->mount_opt);
 		else
-			sbi->s_mount_opt &=3D ~m->mount_opt;
+			clear_mount_opt(ctx, m->mount_opt);
 	}
 	return 1;
 }
@@ -2286,11 +2346,6 @@ static int parse_options(char *options, struct sup=
er_block *sb,
 		}
 	}
=20
-	if (journal_devnum)
-		*journal_devnum =3D ctx.journal_devnum;
-	if (journal_ioprio)
-		*journal_ioprio =3D ctx.journal_ioprio;
-
 	ret =3D ext4_validate_options(&fc);
 	if (ret < 0)
 		return 0;
@@ -2299,9 +2354,12 @@ static int parse_options(char *options, struct sup=
er_block *sb,
 	if (ret < 0)
 		return 0;
=20
-	if (ctx.qname_spec)
-		ext4_apply_quota_options(&fc, sb);
+	if (ctx.spec & EXT4_SPEC_JOURNAL_DEV)
+		*journal_devnum =3D ctx.journal_devnum;
+	if (ctx.spec & EXT4_SPEC_JOURNAL_IOPRIO)
+		*journal_ioprio =3D ctx.journal_ioprio;
=20
+	ext4_apply_options(&fc, sb);
 	return 1;
 }
=20
@@ -2309,20 +2367,30 @@ static void ext4_apply_quota_options(struct fs_co=
ntext *fc,
 				     struct super_block *sb)
 {
 #ifdef CONFIG_QUOTA
+	bool quota_feature =3D ext4_has_feature_quota(sb);
 	struct ext4_fs_context *ctx =3D fc->fs_private;
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	char *qname;
 	int i;
=20
-	for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
-		if (!(ctx->qname_spec & (1 << i)))
-			continue;
-		qname =3D ctx->s_qf_names[i]; /* May be NULL */
-		ctx->s_qf_names[i] =3D NULL;
-		kfree(sbi->s_qf_names[i]);
-		rcu_assign_pointer(sbi->s_qf_names[i], qname);
-		set_opt(sb, QUOTA);
+	if (quota_feature)
+		return;
+
+	if (ctx->spec & EXT4_SPEC_JQUOTA) {
+		for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+			if (!(ctx->qname_spec & (1 << i)))
+				continue;
+
+			qname =3D ctx->s_qf_names[i]; /* May be NULL */
+			ctx->s_qf_names[i] =3D NULL;
+			kfree(sbi->s_qf_names[i]);
+			rcu_assign_pointer(sbi->s_qf_names[i], qname);
+			set_opt(sb, QUOTA);
+		}
 	}
+
+	if (ctx->spec & EXT4_SPEC_JQFMT)
+		sbi->s_jquota_fmt =3D ctx->s_jquota_fmt;
 #endif
 }
=20
@@ -2337,17 +2405,43 @@ static int ext4_check_quota_consistency(struct fs=
_context *fc,
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	bool quota_feature =3D ext4_has_feature_quota(sb);
 	bool quota_loaded =3D sb_any_quota_loaded(sb);
-	int i;
+	bool usr_qf_name, grp_qf_name, usrquota, grpquota;
+	int quota_flags, i;
=20
-	if (ctx->qname_spec && quota_loaded) {
-		if (quota_feature)
-			goto err_feature;
+	/*
+	 * We do the test below only for project quotas. 'usrquota' and
+	 * 'grpquota' mount options are allowed even without quota feature
+	 * to support legacy quotas in quota files.
+	 */
+	if (test_mount_opt(ctx, EXT4_MOUNT_PRJQUOTA) &&
+	    !ext4_has_feature_project(sb)) {
+		ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
+			 "Cannot enable project quota enforcement.");
+		return -EINVAL;
+	}
+
+	quota_flags =3D EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA |
+		      EXT4_MOUNT_GRPQUOTA | EXT4_MOUNT_PRJQUOTA;
+	if (quota_loaded &&
+	    ctx->mask_s_mount_opt & quota_flags &&
+	    !test_mount_opt(ctx, quota_flags))
+		goto err_quota_change;
+
+	if (ctx->spec & EXT4_SPEC_JQUOTA) {
+
+		if (quota_feature) {
+			ext4_msg(NULL, KERN_INFO,
+				 "Ext4: Journaled quota options ignored when "
+				 "QUOTA feature is enabled");
+			return 0;
+		}
=20
 		for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
 			if (!(ctx->qname_spec & (1 << i)))
 				continue;
=20
-			if (!!sbi->s_qf_names[i] !=3D !!ctx->s_qf_names[i])
+			if (quota_loaded &&
+			    !!sbi->s_qf_names[i] !=3D !!ctx->s_qf_names[i])
 				goto err_jquota_change;
=20
 			if (sbi->s_qf_names[i] && ctx->s_qf_names[i] &&
@@ -2357,15 +2451,52 @@ static int ext4_check_quota_consistency(struct fs=
_context *fc,
 		}
 	}
=20
-	if (ctx->s_jquota_fmt) {
+	if (ctx->spec & EXT4_SPEC_JQFMT) {
 		if (sbi->s_jquota_fmt !=3D ctx->s_jquota_fmt && quota_loaded)
-			goto err_quota_change;
+			goto err_jquota_change;
 		if (quota_feature) {
 			ext4_msg(NULL, KERN_INFO, "Quota format mount options "
 				 "ignored when QUOTA feature is enabled");
 			return 0;
 		}
 	}
+
+
+	/* Make sure we don't mix old and new quota format */
+	usr_qf_name =3D (get_qf_name(sb, sbi, USRQUOTA) ||
+		       ctx->s_qf_names[USRQUOTA]);
+	grp_qf_name =3D (get_qf_name(sb, sbi, GRPQUOTA) ||
+		       ctx->s_qf_names[GRPQUOTA]);
+
+	usrquota =3D (test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) ||
+		    test_opt(sb, USRQUOTA));
+
+	grpquota =3D (test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA) ||
+		    test_opt(sb, GRPQUOTA));
+
+	if (usr_qf_name) {
+		clear_mount_opt(ctx, EXT4_MOUNT_USRQUOTA);
+		usrquota =3D false;
+	}
+	if (grp_qf_name) {
+		clear_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA);
+		grpquota =3D false;
+	}
+
+	if (usr_qf_name || grp_qf_name) {
+		if (usrquota || grpquota) {
+			ext4_msg(NULL, KERN_ERR, "old and new quota "
+				 "format mixing");
+			return -EINVAL;
+		}
+
+		if (!(ctx->spec & EXT4_SPEC_JQFMT || sbi->s_jquota_fmt)) {
+			ext4_msg(NULL, KERN_ERR, "journaled quota format "
+				 "not specified");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
=20
 err_quota_change:
@@ -2379,10 +2510,6 @@ static int ext4_check_quota_consistency(struct fs_=
context *fc,
 err_jquota_specified:
 	ext4_msg(NULL, KERN_ERR, "Ext4: Quota file already specified");
 	return -EINVAL;
-err_feature:
-	ext4_msg(NULL, KERN_ERR, "Ext4: Journaled quota options ignored "
-		 "when QUOTA feature is enabled");
-	return 0;
 #else
 	return 0;
 #endif
@@ -2392,6 +2519,7 @@ static int ext4_check_opt_consistency(struct fs_con=
text *fc,
 				      struct super_block *sb)
 {
 	struct ext4_fs_context *ctx =3D fc->fs_private;
+	struct ext4_sb_info *sbi =3D fc->s_fs_info;
=20
 	if ((ctx->opt_flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
 		ext4_msg(NULL, KERN_ERR,
@@ -2404,56 +2532,93 @@ static int ext4_check_opt_consistency(struct fs_c=
ontext *fc,
 		return -EINVAL;
 	}
=20
+	if (ctx->s_want_extra_isize >
+	    (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE)) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Invalid want_extra_isize %d",
+			 ctx->s_want_extra_isize);
+		return -EINVAL;
+	}
+
+	if (test_mount_opt(ctx, EXT4_MOUNT_DIOREAD_NOLOCK)) {
+		int blocksize =3D
+			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
+		if (blocksize < PAGE_SIZE)
+			ext4_msg(NULL, KERN_WARNING, "Warning: mounting with an "
+				 "experimental mount option 'dioread_nolock' "
+				 "for blocksize < PAGE_SIZE");
+	}
+
+	if ((ctx->spec & EXT4_SPEC_DATAJ) &&
+	    (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE)) {
+		if (!sbi->s_journal) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Remounting file system with no journal "
+				 "so ignoring journalled data option");
+			clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+		} else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
+			ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
+				 "on remount");
+			return -EINVAL;
+		}
+	}
+
 	return ext4_check_quota_consistency(fc, sb);
 }
=20
-static int ext4_validate_options(struct fs_context *fc)
+static void ext4_apply_options(struct fs_context *fc, struct super_block=
 *sb)
 {
+	struct ext4_fs_context *ctx =3D fc->fs_private;
 	struct ext4_sb_info *sbi =3D fc->s_fs_info;
-	struct super_block *sb =3D sbi->s_sb;
+
+	sbi->s_mount_opt &=3D ~ctx->mask_s_mount_opt;
+	sbi->s_mount_opt |=3D ctx->vals_s_mount_opt;
+	sbi->s_mount_opt2 &=3D ~ctx->mask_s_mount_opt2;
+	sbi->s_mount_opt2 |=3D ctx->vals_s_mount_opt2;
+	sbi->s_mount_flags &=3D ~ctx->mask_s_mount_flags;
+	sbi->s_mount_flags |=3D ctx->vals_s_mount_flags;
+	sb->s_flags &=3D ~ctx->mask_s_flags;
+	sb->s_flags |=3D ctx->vals_s_flags;
+
+#define APPLY(X) ({ if (ctx->spec & EXT4_SPEC_##X) sbi->X =3D ctx->X; })
+	APPLY(s_commit_interval);
+	APPLY(s_stripe);
+	APPLY(s_max_batch_time);
+	APPLY(s_min_batch_time);
+	APPLY(s_want_extra_isize);
+	APPLY(s_inode_readahead_blks);
+	APPLY(s_max_dir_size_kb);
+	APPLY(s_li_wait_mult);
+	APPLY(s_resgid);
+	APPLY(s_resuid);
+
+	ext4_apply_quota_options(fc, sb);
+}
+
+static int ext4_validate_options(struct fs_context *fc)
+{
+	struct ext4_fs_context *ctx =3D fc->fs_private;
 #ifdef CONFIG_QUOTA
 	char *usr_qf_name, *grp_qf_name;
-	/*
-	 * We do the test below only for project quotas. 'usrquota' and
-	 * 'grpquota' mount options are allowed even without quota feature
-	 * to support legacy quotas in quota files.
-	 */
-	if (test_opt(sb, PRJQUOTA) && !ext4_has_feature_project(sb)) {
-		ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
-			 "Cannot enable project quota enforcement.");
-		return -EINVAL;
-	}
-	usr_qf_name =3D get_qf_name(sb, sbi, USRQUOTA);
-	grp_qf_name =3D get_qf_name(sb, sbi, GRPQUOTA);
+
+	usr_qf_name =3D ctx->s_qf_names[USRQUOTA];
+	grp_qf_name =3D ctx->s_qf_names[GRPQUOTA];
 	if (usr_qf_name || grp_qf_name) {
-		if (test_opt(sb, USRQUOTA) && usr_qf_name)
-			clear_opt(sb, USRQUOTA);
+		if (test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) && usr_qf_name)
+			clear_mount_opt(ctx, EXT4_MOUNT_USRQUOTA);
=20
-		if (test_opt(sb, GRPQUOTA) && grp_qf_name)
-			clear_opt(sb, GRPQUOTA);
+		if (test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA) && grp_qf_name)
+			clear_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA);
=20
-		if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
+		if (test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) ||
+		    test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA)) {
 			ext4_msg(NULL, KERN_ERR, "old and new quota "
-					"format mixing");
-			return -EINVAL;
-		}
-
-		if (!sbi->s_jquota_fmt) {
-			ext4_msg(NULL, KERN_ERR, "journaled quota format "
-					"not specified");
+				 "format mixing");
 			return -EINVAL;
 		}
 	}
 #endif
-	if (test_opt(sb, DIOREAD_NOLOCK)) {
-		int blocksize =3D
-			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
-		if (blocksize < PAGE_SIZE)
-			ext4_msg(NULL, KERN_WARNING, "Warning: mounting with an "
-				 "experimental mount option 'dioread_nolock' "
-				 "for blocksize < PAGE_SIZE");
-	}
-	return 0;
+	return 1;
 }
=20
 static inline void ext4_show_quota_options(struct seq_file *seq,
--=20
2.21.1

