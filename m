Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908C71BC59E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgD1QqB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgD1QqB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFWETDq8l6Z19/pdT+ua0L6KGG92TqQWxuNkZErCcPw=;
        b=AfSjgtsJbLmyJTh3IN47/6EHycy7kElDyje1IHuV+kvBll7i1MlX4nrLucYi1AVt1mxXHB
        41nsu9zYQ5CG7ipkivX8Ai7sZsrGe/KUi4s0fjT8DvNJWR738L0VaLQ9N/DZhMFdFSn7i8
        6605H0/1hgTaruJ9bbW7nzI6twHAK1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-nSrwr0uxNYuu78XGg3uStw-1; Tue, 28 Apr 2020 12:45:57 -0400
X-MC-Unique: nSrwr0uxNYuu78XGg3uStw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F598835B40;
        Tue, 28 Apr 2020 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 825C91000322;
        Tue, 28 Apr 2020 16:45:55 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 09/17] ext4: parse Opt_sb in handle_mount_opt()
Date:   Tue, 28 Apr 2020 18:45:28 +0200
Message-Id: <20200428164536.462-10-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the sb block is parsed from within ext4_fill_super(), however
since the new mount api separates the option parsing and super block setu=
p
into two distinct steps we need to move the parsing of sb block into
handle_mount_opt().

In preparation for the next step we also need to refactor ext4_fill_super
so that we can parse options separately. Unfortunately we still need to
parse options specified in the super block itself and that needs to be
done after we've read the super block from disk. Another complication is
that we really want to apply the options from super block before we
apply user specified mount options.

So with this patch we're going through the following sequence:

- parse user provided options (including sb block)
- initialize sbi and store s_sb_block if provided
- in __ext4_fill_super()
	- read the super block
	- parse and apply options specified in s_mount_opts
	- check and apply user provided options stored in ctx
	- continue with the regular ext4_fill_super operation

It's ugly, but if we still want to support s_mount_opts we have to do it
in this order. __ext4_fill_super would really benefit from some more
refactoring, but that will have to wait until after the mount api
conversion is done.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 291 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 199 insertions(+), 92 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3b29069eb633..ea7c8f7d4c7c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1753,29 +1753,6 @@ static const match_table_t tokens =3D {
 	{Opt_err, NULL},
 };
=20
-static ext4_fsblk_t get_sb_block(void **data)
-{
-	ext4_fsblk_t	sb_block;
-	char		*options =3D (char *) *data;
-
-	if (!options || strncmp(options, "sb=3D", 3) !=3D 0)
-		return 1;	/* Default location */
-
-	options +=3D 3;
-	/* TODO: use simple_strtoll with >32bit ext4 */
-	sb_block =3D simple_strtoul(options, &options, 0);
-	if (*options && *options !=3D ',') {
-		printk(KERN_ERR "EXT4-fs: Invalid sb specification: %s\n",
-		       (char *) *data);
-		return 1;
-	}
-	if (*options =3D=3D ',')
-		options++;
-	*data =3D (void *) options;
-
-	return sb_block;
-}
-
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 static const char deprecated_msg[] =3D
 	"Mount option \"%s\" will be removed by %s\n"
@@ -1852,6 +1829,7 @@ static const struct mount_opts {
 	{Opt_stripe, 0, MOPT_GTE0},
 	{Opt_resuid, 0, MOPT_GTE0},
 	{Opt_resgid, 0, MOPT_GTE0},
+	{Opt_sb, 0, MOPT_GTE0},
 	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0},
 	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING},
 	{Opt_journal_ioprio, 0, MOPT_NO_EXT2 | MOPT_GTE0},
@@ -1940,6 +1918,7 @@ static int ext4_sb_read_encoding(const struct ext4_=
super_block *es,
 #define EXT4_SPEC_s_resuid			(1 << 13)
 #define EXT4_SPEC_s_resgid			(1 << 14)
 #define EXT4_SPEC_s_commit_interval		(1 << 15)
+#define EXT4_SPEC_s_sb_block			(1 << 16)
=20
 struct ext4_fs_context {
 	char		*s_qf_names[EXT4_MAXQUOTAS];
@@ -1967,6 +1946,7 @@ struct ext4_fs_context {
 	u32		s_min_batch_time;
 	kuid_t		s_resuid;
 	kgid_t		s_resgid;
+	ext4_fsblk_t	s_sb_block;
 };
=20
 #ifdef CONFIG_QUOTA
@@ -2079,8 +2059,6 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 	case Opt_nouser_xattr:
 		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
 		break;
-	case Opt_sb:
-		return 1;	/* handled by get_sb_block() */
 	case Opt_removed:
 		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
@@ -2198,6 +2176,14 @@ static int handle_mount_opt(struct fs_context *fc,=
 struct fs_parameter *param)
 		}
 		ctx->s_resgid =3D gid;
 		ctx->spec |=3D EXT4_SPEC_s_resgid;
+	} else if (token =3D=3D Opt_sb) {
+		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Ignoring %s option on remount", param->key);
+		} else {
+			ctx->s_sb_block =3D result.uint_32;
+			ctx->spec |=3D EXT4_SPEC_s_sb_block;
+		}
 	} else if (token =3D=3D Opt_journal_dev) {
 		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 			ext4_msg(NULL, KERN_ERR,
@@ -2292,27 +2278,14 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 	return 1;
 }
=20
-static int parse_options(char *options, struct super_block *sb,
-			 unsigned long *journal_devnum,
-			 unsigned int *journal_ioprio,
-			 int is_remount)
+static int parse_options(struct fs_context *fc, char *options)
 {
-	struct ext4_fs_context ctx;
 	struct fs_parameter param;
-	struct fs_context fc;
 	int ret;
 	char *key;
=20
 	if (!options)
-		return 1;
-
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private =3D &ctx;
-	fc.s_fs_info =3D EXT4_SB(sb);
-
-	if (is_remount)
-		fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+		return 0;
=20
 	while ((key =3D strsep(&options, ",")) !=3D NULL) {
 		if (*key) {
@@ -2331,36 +2304,72 @@ static int parse_options(char *options, struct su=
per_block *sb,
 				param.string =3D kmemdup_nul(value, v_len,
 							   GFP_KERNEL);
 				if (!param.string)
-					return 0;
+					return -ENOMEM;
 				param.type =3D fs_value_is_string;
 			}
=20
 			param.key =3D key;
 			param.size =3D v_len;
=20
-			ret =3D handle_mount_opt(&fc, &param);
+			ret =3D handle_mount_opt(fc, &param);
 			if (param.string)
 				kfree(param.string);
 			if (ret < 0)
-				return 0;
+				return ret;
 		}
 	}
=20
-	ret =3D ext4_validate_options(&fc);
+	ret =3D ext4_validate_options(fc);
 	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int parse_apply_options(char *options, struct super_block *sb,
+			 unsigned long *journal_devnum,
+			 unsigned int *journal_ioprio,
+			 int is_remount)
+{
+	struct ext4_fs_context *ctx;
+	struct fs_context *fc;
+	int ret =3D -ENOMEM;
+
+	if (!options)
 		return 0;
=20
-	ret =3D ext4_check_opt_consistency(&fc, sb);
+	fc =3D kzalloc(sizeof(struct fs_context), GFP_KERNEL);
+	if (!fc)
+		return ret;
+	ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
+	if (!ctx)
+		goto out_free;
+
+	fc->fs_private =3D ctx;
+	fc->s_fs_info =3D EXT4_SB(sb);
+
+	if (is_remount)
+		fc->purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+
+	ret =3D parse_options(fc, options);
 	if (ret < 0)
-		return 0;
+		goto out_free;
=20
-	if (ctx.spec & EXT4_SPEC_JOURNAL_DEV)
-		*journal_devnum =3D ctx.journal_devnum;
-	if (ctx.spec & EXT4_SPEC_JOURNAL_IOPRIO)
-		*journal_ioprio =3D ctx.journal_ioprio;
+	ret =3D ext4_check_opt_consistency(fc, sb);
+	if (ret < 0)
+		goto out_free;
=20
-	ext4_apply_options(&fc, sb);
-	return 1;
+	if (ctx->spec & EXT4_SPEC_JOURNAL_DEV)
+		*journal_devnum =3D ctx->journal_devnum;
+	if (ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+		*journal_ioprio =3D ctx->journal_ioprio;
+
+	ext4_apply_options(fc, sb);
+
+out_free:
+	kfree(ctx);
+	kfree(fc);
+	return ret;
 }
=20
 static void ext4_apply_quota_options(struct fs_context *fc,
@@ -4094,16 +4103,49 @@ static void ext4_set_resv_clusters(struct super_b=
lock *sb)
 	atomic64_set(&sbi->s_resv_clusters, resv_clusters);
 }
=20
-static int ext4_fill_super(struct super_block *sb, void *data, int silen=
t)
+static void ext4_free_sbi(struct ext4_sb_info *sbi)
+{
+	if (!sbi)
+		return;
+
+	kfree(sbi->s_blockgroup_lock);
+	fs_put_dax(sbi->s_daxdev);
+	kfree(sbi);
+}
+
+static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi;
+
+	sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return NULL;
+
+	sbi->s_daxdev =3D fs_dax_get_by_bdev(sb->s_bdev);
+
+	sbi->s_blockgroup_lock =3D
+		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
+
+	if (!sbi->s_blockgroup_lock)
+		goto err_out;
+
+	sb->s_fs_info =3D sbi;
+	sbi->s_sb =3D sb;
+	return sbi;
+err_out:
+	fs_put_dax(sbi->s_daxdev);
+	kfree(sbi);
+	return NULL;
+}
+
+static int __ext4_fill_super(struct fs_context *fc, struct super_block *=
sb,
+			     int silent)
 {
-	struct dax_device *dax_dev =3D fs_dax_get_by_bdev(sb->s_bdev);
-	char *orig_data =3D kstrdup(data, GFP_KERNEL);
 	struct buffer_head *bh, **group_desc;
 	struct ext4_super_block *es =3D NULL;
-	struct ext4_sb_info *sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	struct flex_groups **flex_groups;
 	ext4_fsblk_t block;
-	ext4_fsblk_t sb_block =3D get_sb_block(&data);
 	ext4_fsblk_t logical_sb_block;
 	unsigned long offset =3D 0;
 	unsigned long journal_devnum =3D 0;
@@ -4119,26 +4161,13 @@ static int ext4_fill_super(struct super_block *sb=
, void *data, int silent)
 	int err =3D 0;
 	unsigned int journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
 	ext4_group_t first_not_zeroed;
+	struct ext4_fs_context *ctx =3D fc->fs_private;
=20
-	if ((data && !orig_data) || !sbi)
-		goto out_free_base;
-
-	sbi->s_daxdev =3D dax_dev;
-	sbi->s_blockgroup_lock =3D
-		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
-	if (!sbi->s_blockgroup_lock)
-		goto out_free_base;
-
-	sb->s_fs_info =3D sbi;
-	sbi->s_sb =3D sb;
 	sbi->s_inode_readahead_blks =3D EXT4_DEF_INODE_READAHEAD_BLKS;
-	sbi->s_sb_block =3D sb_block;
 	if (sb->s_bdev->bd_part)
 		sbi->s_sectors_written_start =3D
 			part_stat_read(sb->s_bdev->bd_part, sectors[STAT_WRITE]);
=20
-	/* Cleanup superblock name */
-	strreplace(sb->s_id, '/', '!');
=20
 	/* -EINVAL is default */
 	ret =3D -EINVAL;
@@ -4153,10 +4182,10 @@ static int ext4_fill_super(struct super_block *sb=
, void *data, int silent)
 	 * block sizes.  We need to calculate the offset from buffer start.
 	 */
 	if (blocksize !=3D EXT4_MIN_BLOCK_SIZE) {
-		logical_sb_block =3D sb_block * EXT4_MIN_BLOCK_SIZE;
+		logical_sb_block =3D sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset =3D do_div(logical_sb_block, blocksize);
 	} else {
-		logical_sb_block =3D sb_block;
+		logical_sb_block =3D sbi->s_sb_block;
 	}
=20
 	if (!(bh =3D sb_bread_unmovable(sb, logical_sb_block))) {
@@ -4354,8 +4383,8 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 					      GFP_KERNEL);
 		if (!s_mount_opts)
 			goto failed_mount;
-		if (!parse_options(s_mount_opts, sb, &journal_devnum,
-				   &journal_ioprio, 0)) {
+		if (parse_apply_options(s_mount_opts, sb, &journal_devnum,
+					 &journal_ioprio, 0) < 0) {
 			ext4_msg(sb, KERN_WARNING,
 				 "failed to parse options in superblock: %s",
 				 s_mount_opts);
@@ -4363,10 +4392,19 @@ static int ext4_fill_super(struct super_block *sb=
, void *data, int silent)
 		kfree(s_mount_opts);
 	}
 	sbi->s_def_mount_opt =3D sbi->s_mount_opt;
-	if (!parse_options((char *) data, sb, &journal_devnum,
-			   &journal_ioprio, 0))
+
+	/* Now check and apply options we've got in fs context */
+	err =3D ext4_check_opt_consistency(fc, sb);
+	if (err < 0)
 		goto failed_mount;
=20
+	if (ctx->spec & EXT4_SPEC_JOURNAL_DEV)
+		journal_devnum =3D ctx->journal_devnum;
+	if (ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+		journal_ioprio =3D ctx->journal_ioprio;
+
+	ext4_apply_options(fc, sb);
+
 #ifdef CONFIG_UNICODE
 	if (ext4_has_feature_casefold(sb) && !sbi->s_encoding) {
 		const struct ext4_sb_encodings *encoding_info;
@@ -4555,7 +4593,7 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 		}
=20
 		brelse(bh);
-		logical_sb_block =3D sb_block * EXT4_MIN_BLOCK_SIZE;
+		logical_sb_block =3D sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset =3D do_div(logical_sb_block, blocksize);
 		bh =3D sb_bread_unmovable(sb, logical_sb_block);
 		if (!bh) {
@@ -5126,11 +5164,7 @@ static int ext4_fill_super(struct super_block *sb,=
 void *data, int silent)
 	}
=20
 	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
-		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-			 "Opts: %.*s%s%s", descr,
-			 (int) sizeof(sbi->s_es->s_mount_opts),
-			 sbi->s_es->s_mount_opts,
-			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data);
+		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s.", descr);
=20
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
@@ -5140,7 +5174,6 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 	ratelimit_state_init(&sbi->s_warning_ratelimit_state, 5 * HZ, 10);
 	ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
=20
-	kfree(orig_data);
 	return 0;
=20
 cantfind_ext4:
@@ -5219,14 +5252,89 @@ static int ext4_fill_super(struct super_block *sb=
, void *data, int silent)
 	brelse(bh);
 out_fail:
 	sb->s_fs_info =3D NULL;
-	kfree(sbi->s_blockgroup_lock);
-out_free_base:
-	kfree(sbi);
-	kfree(orig_data);
-	fs_put_dax(dax_dev);
 	return err ? err : ret;
 }
=20
+static void cleanup_ctx(struct ext4_fs_context *ctx)
+{
+	int i;
+
+	if (!ctx)
+		return;
+
+	for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+		kfree(ctx->s_qf_names[i]);
+	}
+}
+
+static int ext4_fill_super(struct super_block *sb, void *data, int silen=
t)
+{
+	struct ext4_fs_context ctx;
+	struct ext4_sb_info *sbi;
+	struct fs_context fc;
+	const char *descr;
+	char *orig_data;
+	int ret =3D -ENOMEM;
+
+	orig_data =3D kstrdup(data, GFP_KERNEL);
+	if (data && !orig_data)
+		return -ENOMEM;
+
+	/* Cleanup superblock name */
+	strreplace(sb->s_id, '/', '!');
+
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private =3D &ctx;
+
+	ret =3D parse_options(&fc, (char *) data);
+	if (ret < 0)
+		goto free_data;
+
+	sbi =3D ext4_alloc_sbi(sb);
+	if (!sbi) {
+		ret =3D -ENOMEM;
+		goto free_data;
+	}
+
+	fc.s_fs_info =3D sbi;
+
+	sbi->s_sb_block =3D 1;	/* Default super block location */
+	if (ctx.spec & EXT4_SPEC_s_sb_block)
+		sbi->s_sb_block =3D ctx.s_sb_block;
+
+	ret =3D __ext4_fill_super(&fc, sb, silent);
+	if (ret < 0)
+		goto free_sbi;
+
+	if (EXT4_SB(sb)->s_journal) {
+		if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_JOURNAL_DATA)
+			descr =3D " journalled data mode";
+		else if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_ORDERED_DATA)
+			descr =3D " ordered data mode";
+		else
+			descr =3D " writeback data mode";
+	} else
+		descr =3D "out journal";
+
+	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
+		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
+			 "Opts: %.*s%s%s", descr,
+			 (int) sizeof(sbi->s_es->s_mount_opts),
+			 sbi->s_es->s_mount_opts,
+			 *sbi->s_es->s_mount_opts ? "; " : "", (char *)orig_data);
+
+	kfree(orig_data);
+	cleanup_ctx(&ctx);
+	return 0;
+free_sbi:
+	ext4_free_sbi(sbi);
+free_data:
+	kfree(orig_data);
+	cleanup_ctx(&ctx);
+	return ret;
+}
+
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
@@ -5822,10 +5930,9 @@ static int ext4_remount(struct super_block *sb, in=
t *flags, char *data)
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 		journal_ioprio =3D sbi->s_journal->j_task->io_context->ioprio;
=20
-	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
-		err =3D -EINVAL;
+	err =3D parse_apply_options(data, sb, NULL, &journal_ioprio, 1);
+	if (err < 0)
 		goto restore_opts;
-	}
=20
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
 	    test_opt(sb, JOURNAL_CHECKSUM)) {
--=20
2.21.1

