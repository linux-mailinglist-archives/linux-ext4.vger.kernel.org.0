Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A49F13A5
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfKFKPh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731222AbfKFKPh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NR25xssC9mgGmxWw6KgdUMMBfVSOlYelqUGXt37G/K8=;
        b=MnN8gmg8eSEIfKCa8Wl4rLld1ZUqqINWGwCnLcd0kSRKaU9AfUzDKrUMErRs7V+aTj2CRk
        04k79UwZu8G5CragTQ0e6TGOLcO6ufWrVa4v3gt2ifrA+f+TVM4W9eJGFQ5XjjR4EZv5cI
        GMM7mJ4NPZ2qs+z92ifeXQZdVXgIqBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-nNqvtCcoNZO3KzFBT8oBGw-1; Wed, 06 Nov 2019 05:15:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A95DA477;
        Wed,  6 Nov 2019 10:15:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3459FF6E0;
        Wed,  6 Nov 2019 10:15:27 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 09/17] ext4: parse Opt_sb in handle_mount_opt()
Date:   Wed,  6 Nov 2019 11:14:49 +0100
Message-Id: <20191106101457.11237-10-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nNqvtCcoNZO3KzFBT8oBGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the sb block is parsed from within ext4_fill_super(), however
since the new mount api separates the option parsing and super block setup
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
=09- read the super block
=09- parse and apply options specified in s_mount_opts
=09- check and apply user provided options stored in ctx
=09- continue with the regular ext4_fill_super operation

It's ugly, but if we still want to support s_mount_opts we have to do it
in this order. __ext4_fill_super would really benefit from some more
refactoring, but that will have to wait until after the mount api
conversion is done.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 297 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 196 insertions(+), 101 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f3dd82fef453..417a929cb0ab 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1667,29 +1667,6 @@ static const match_table_t tokens =3D {
 =09{Opt_err, NULL},
 };
=20
-static ext4_fsblk_t get_sb_block(void **data)
-{
-=09ext4_fsblk_t=09sb_block;
-=09char=09=09*options =3D (char *) *data;
-
-=09if (!options || strncmp(options, "sb=3D", 3) !=3D 0)
-=09=09return 1;=09/* Default location */
-
-=09options +=3D 3;
-=09/* TODO: use simple_strtoll with >32bit ext4 */
-=09sb_block =3D simple_strtoul(options, &options, 0);
-=09if (*options && *options !=3D ',') {
-=09=09printk(KERN_ERR "EXT4-fs: Invalid sb specification: %s\n",
-=09=09       (char *) *data);
-=09=09return 1;
-=09}
-=09if (*options =3D=3D ',')
-=09=09options++;
-=09*data =3D (void *) options;
-
-=09return sb_block;
-}
-
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 static const char deprecated_msg[] =3D
 =09"Mount option \"%s\" will be removed by %s\n"
@@ -1766,6 +1743,7 @@ static const struct mount_opts {
 =09{Opt_stripe, 0, MOPT_GTE0},
 =09{Opt_resuid, 0, MOPT_GTE0},
 =09{Opt_resgid, 0, MOPT_GTE0},
+=09{Opt_sb, 0, MOPT_GTE0},
 =09{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0},
 =09{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING},
 =09{Opt_journal_ioprio, 0, MOPT_NO_EXT2 | MOPT_GTE0},
@@ -1854,6 +1832,7 @@ static int ext4_sb_read_encoding(const struct ext4_su=
per_block *es,
 #define EXT4_SPEC_s_resuid=09=09=09(1 << 13)
 #define EXT4_SPEC_s_resgid=09=09=09(1 << 14)
 #define EXT4_SPEC_s_commit_interval=09=09(1 << 15)
+#define EXT4_SPEC_s_sb_block=09=09=09(1 << 16)
=20
 struct ext4_fs_context {
 =09char=09=09*s_qf_names[EXT4_MAXQUOTAS];
@@ -1881,6 +1860,7 @@ struct ext4_fs_context {
 =09u32=09=09s_min_batch_time;
 =09kuid_t=09=09s_resuid;
 =09kgid_t=09=09s_resgid;
+=09ext4_fsblk_t=09s_sb_block;
 };
=20
 #ifdef CONFIG_QUOTA
@@ -1994,8 +1974,6 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
 =09case Opt_nouser_xattr:
 =09=09ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
 =09=09break;
-=09case Opt_sb:
-=09=09return 1;=09/* handled by get_sb_block() */
 =09case Opt_removed:
 =09=09ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 =09=09=09 param->key);
@@ -2108,6 +2086,14 @@ static int handle_mount_opt(struct fs_context *fc, s=
truct fs_parameter *param)
 =09=09}
 =09=09ctx->s_resgid =3D gid;
 =09=09ctx->spec |=3D EXT4_SPEC_s_resgid;
+=09} else if (token =3D=3D Opt_sb) {
+=09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
+=09=09=09ext4_msg(NULL, KERN_WARNING,
+=09=09=09=09 "Ignoring %s option on remount", param->key);
+=09=09} else {
+=09=09=09ctx->s_sb_block =3D result.uint_32;
+=09=09=09ctx->spec |=3D EXT4_SPEC_s_sb_block;
+=09=09}
 =09} else if (token =3D=3D Opt_journal_dev) {
 =09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 =09=09=09ext4_msg(NULL, KERN_ERR,
@@ -2202,28 +2188,15 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09return 1;
 }
=20
-static int parse_options(char *options, struct super_block *sb,
-=09=09=09 unsigned long *journal_devnum,
-=09=09=09 unsigned int *journal_ioprio,
-=09=09=09 int is_remount)
+static int parse_options(struct fs_context *fc, char *options)
 {
-=09struct ext4_fs_context ctx;
 =09struct fs_parameter param;
-=09struct fs_context fc;
 =09char *value;
 =09int ret;
 =09char *p;
=20
 =09if (!options)
-=09=09return 1;
-
-=09memset(&fc, 0, sizeof(fc));
-=09memset(&ctx, 0, sizeof(ctx));
-=09fc.fs_private =3D &ctx;
-=09fc.s_fs_info =3D EXT4_SB(sb);
-
-=09if (is_remount)
-=09=09fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+=09=09return 0;
=20
 =09while ((p =3D strsep(&options, ",")) !=3D NULL) {
=20
@@ -2250,27 +2223,63 @@ static int parse_options(char *options, struct supe=
r_block *sb,
 =09=09=09}
 =09=09}
=20
-=09=09ret =3D handle_mount_opt(&fc, &param);
+=09=09ret =3D handle_mount_opt(fc, &param);
 =09=09kfree(param.string);
 =09=09if (ret < 0)
-=09=09=09return 0;
+=09=09=09return ret;
 =09}
=20
-=09ret =3D ext4_validate_options(&fc);
+=09ret =3D ext4_validate_options(fc);
 =09if (ret < 0)
+=09=09return ret;
+
+=09return 0;
+}
+
+static int parse_apply_options(char *options, struct super_block *sb,
+=09=09=09 unsigned long *journal_devnum,
+=09=09=09 unsigned int *journal_ioprio,
+=09=09=09 int is_remount)
+{
+=09struct ext4_fs_context *ctx;
+=09struct fs_context *fc;
+=09int ret =3D -ENOMEM;
+
+=09if (!options)
 =09=09return 0;
=20
-=09ret =3D ext4_check_opt_consistency(&fc, sb);
+=09fc =3D kzalloc(sizeof(struct fs_context), GFP_KERNEL);
+=09if (!fc)
+=09=09return ret;
+=09ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
+=09if (!ctx)
+=09=09goto out_free;
+
+=09fc->fs_private =3D ctx;
+=09fc->s_fs_info =3D EXT4_SB(sb);
+
+=09if (is_remount)
+=09=09fc->purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+
+=09ret =3D parse_options(fc, options);
 =09if (ret < 0)
-=09=09return 0;
+=09=09goto out_free;
=20
-=09if (ctx.spec & EXT4_SPEC_JOURNAL_DEV)
-=09=09*journal_devnum =3D ctx.journal_devnum;
-=09if (ctx.spec & EXT4_SPEC_JOURNAL_IOPRIO)
-=09=09*journal_ioprio =3D ctx.journal_ioprio;
+=09ret =3D ext4_check_opt_consistency(fc, sb);
+=09if (ret < 0)
+=09=09goto out_free;
=20
-=09ext4_apply_options(&fc, sb);
-=09return 1;
+=09if (ctx->spec & EXT4_SPEC_JOURNAL_DEV)
+=09=09*journal_devnum =3D ctx->journal_devnum;
+=09if (ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+=09=09*journal_ioprio =3D ctx->journal_ioprio;
+
+=09ext4_apply_options(fc, sb);
+
+out_free:
+=09kfree(ctx);
+=09kfree(fc);
+=09return 0;
 }
=20
 static void ext4_apply_quota_options(struct fs_context *fc,
@@ -4020,21 +4029,53 @@ static void ext4_set_resv_clusters(struct super_blo=
ck *sb)
 =09atomic64_set(&sbi->s_resv_clusters, resv_clusters);
 }
=20
-static int ext4_fill_super(struct super_block *sb, void *data, int silent)
+static void ext4_free_sbi(struct ext4_sb_info *sbi)
+{
+=09if (!sbi)
+=09=09return;
+
+=09kfree(sbi->s_blockgroup_lock);
+=09fs_put_dax(sbi->s_daxdev);
+=09kfree(sbi);
+}
+
+static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
+{
+=09struct ext4_sb_info *sbi;
+
+=09sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);
+=09if (!sbi)
+=09=09return NULL;
+
+=09sbi->s_daxdev =3D fs_dax_get_by_bdev(sb->s_bdev);
+
+=09sbi->s_blockgroup_lock =3D
+=09=09kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
+
+=09if (!sbi->s_blockgroup_lock)
+=09=09goto err_out;
+
+=09sb->s_fs_info =3D sbi;
+=09sbi->s_sb =3D sb;
+=09return sbi;
+err_out:
+=09fs_put_dax(sbi->s_daxdev);
+=09kfree(sbi);
+=09return NULL;
+}
+
+static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb=
,
+=09=09=09     int silent)
 {
-=09struct dax_device *dax_dev =3D fs_dax_get_by_bdev(sb->s_bdev);
-=09char *orig_data =3D kstrdup(data, GFP_KERNEL);
 =09struct buffer_head *bh;
 =09struct ext4_super_block *es =3D NULL;
-=09struct ext4_sb_info *sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);
+=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 =09ext4_fsblk_t block;
-=09ext4_fsblk_t sb_block =3D get_sb_block(&data);
 =09ext4_fsblk_t logical_sb_block;
 =09unsigned long offset =3D 0;
 =09unsigned long journal_devnum =3D 0;
 =09unsigned long def_mount_opts;
 =09struct inode *root;
-=09const char *descr;
 =09int ret =3D -ENOMEM;
 =09int blocksize, clustersize;
 =09unsigned int db_count;
@@ -4044,26 +4085,13 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 =09int err =3D 0;
 =09unsigned int journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
 =09ext4_group_t first_not_zeroed;
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
=20
-=09if ((data && !orig_data) || !sbi)
-=09=09goto out_free_base;
-
-=09sbi->s_daxdev =3D dax_dev;
-=09sbi->s_blockgroup_lock =3D
-=09=09kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
-=09if (!sbi->s_blockgroup_lock)
-=09=09goto out_free_base;
-
-=09sb->s_fs_info =3D sbi;
-=09sbi->s_sb =3D sb;
 =09sbi->s_inode_readahead_blks =3D EXT4_DEF_INODE_READAHEAD_BLKS;
-=09sbi->s_sb_block =3D sb_block;
 =09if (sb->s_bdev->bd_part)
 =09=09sbi->s_sectors_written_start =3D
 =09=09=09part_stat_read(sb->s_bdev->bd_part, sectors[STAT_WRITE]);
=20
-=09/* Cleanup superblock name */
-=09strreplace(sb->s_id, '/', '!');
=20
 =09/* -EINVAL is default */
 =09ret =3D -EINVAL;
@@ -4078,10 +4106,10 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 =09 * block sizes.  We need to calculate the offset from buffer start.
 =09 */
 =09if (blocksize !=3D EXT4_MIN_BLOCK_SIZE) {
-=09=09logical_sb_block =3D sb_block * EXT4_MIN_BLOCK_SIZE;
+=09=09logical_sb_block =3D sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
 =09=09offset =3D do_div(logical_sb_block, blocksize);
 =09} else {
-=09=09logical_sb_block =3D sb_block;
+=09=09logical_sb_block =3D sbi->s_sb_block;
 =09}
=20
 =09if (!(bh =3D sb_bread_unmovable(sb, logical_sb_block))) {
@@ -4203,8 +4231,8 @@ static int ext4_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09=09=09=09=09      GFP_KERNEL);
 =09=09if (!s_mount_opts)
 =09=09=09goto failed_mount;
-=09=09if (!parse_options(s_mount_opts, sb, &journal_devnum,
-=09=09=09=09   &journal_ioprio, 0)) {
+=09=09if (!parse_apply_options(s_mount_opts, sb, &journal_devnum,
+=09=09=09=09=09 &journal_ioprio, 0)) {
 =09=09=09ext4_msg(sb, KERN_WARNING,
 =09=09=09=09 "failed to parse options in superblock: %s",
 =09=09=09=09 s_mount_opts);
@@ -4212,10 +4240,19 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 =09=09kfree(s_mount_opts);
 =09}
 =09sbi->s_def_mount_opt =3D sbi->s_mount_opt;
-=09if (!parse_options((char *) data, sb, &journal_devnum,
-=09=09=09   &journal_ioprio, 0))
+
+=09/* Now check and apply options we've got in fs context */
+=09err =3D ext4_check_opt_consistency(fc, sb);
+=09if (err < 0)
 =09=09goto failed_mount;
=20
+=09if (ctx->spec & EXT4_SPEC_JOURNAL_DEV)
+=09=09journal_devnum =3D ctx->journal_devnum;
+=09if (ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+=09=09journal_ioprio =3D ctx->journal_ioprio;
+
+=09ext4_apply_options(fc, sb);
+
 #ifdef CONFIG_UNICODE
 =09if (ext4_has_feature_casefold(sb) && !sbi->s_encoding) {
 =09=09const struct ext4_sb_encodings *encoding_info;
@@ -4413,7 +4450,7 @@ static int ext4_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09=09}
=20
 =09=09brelse(bh);
-=09=09logical_sb_block =3D sb_block * EXT4_MIN_BLOCK_SIZE;
+=09=09logical_sb_block =3D sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
 =09=09offset =3D do_div(logical_sb_block, blocksize);
 =09=09bh =3D sb_bread_unmovable(sb, logical_sb_block);
 =09=09if (!bh) {
@@ -5004,15 +5041,6 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 =09=09ext4_msg(sb, KERN_INFO, "recovery complete");
 =09=09ext4_mark_recovery_complete(sb, es);
 =09}
-=09if (EXT4_SB(sb)->s_journal) {
-=09=09if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_JOURNAL_DATA)
-=09=09=09descr =3D " journalled data mode";
-=09=09else if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_ORDERED_DATA)
-=09=09=09descr =3D " ordered data mode";
-=09=09else
-=09=09=09descr =3D " writeback data mode";
-=09} else
-=09=09descr =3D "out journal";
=20
 =09if (test_opt(sb, DISCARD)) {
 =09=09struct request_queue *q =3D bdev_get_queue(sb->s_bdev);
@@ -5022,13 +5050,6 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 =09=09=09=09 "the device does not support discard");
 =09}
=20
-=09if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
-=09=09ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-=09=09=09 "Opts: %.*s%s%s", descr,
-=09=09=09 (int) sizeof(sbi->s_es->s_mount_opts),
-=09=09=09 sbi->s_es->s_mount_opts,
-=09=09=09 *sbi->s_es->s_mount_opts ? "; " : "", orig_data);
-
 =09if (es->s_error_count)
 =09=09mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
=20
@@ -5037,7 +5058,6 @@ static int ext4_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09ratelimit_state_init(&sbi->s_warning_ratelimit_state, 5 * HZ, 10);
 =09ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
=20
-=09kfree(orig_data);
 =09return 0;
=20
 cantfind_ext4:
@@ -5107,14 +5127,89 @@ static int ext4_fill_super(struct super_block *sb, =
void *data, int silent)
 =09brelse(bh);
 out_fail:
 =09sb->s_fs_info =3D NULL;
-=09kfree(sbi->s_blockgroup_lock);
-out_free_base:
-=09kfree(sbi);
-=09kfree(orig_data);
-=09fs_put_dax(dax_dev);
 =09return err ? err : ret;
 }
=20
+static void cleanup_ctx(struct ext4_fs_context *ctx)
+{
+=09int i;
+
+=09if (!ctx)
+=09=09return;
+
+=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+=09=09kfree(ctx->s_qf_names[i]);
+=09}
+}
+
+static int ext4_fill_super(struct super_block *sb, void *data, int silent)
+{
+=09struct ext4_fs_context ctx;
+=09struct ext4_sb_info *sbi;
+=09struct fs_context fc;
+=09const char *descr;
+=09char *orig_data;
+=09int ret =3D -ENOMEM;
+
+=09orig_data =3D kstrdup(data, GFP_KERNEL);
+=09if (data && !orig_data)
+=09=09return -ENOMEM;
+
+=09/* Cleanup superblock name */
+=09strreplace(sb->s_id, '/', '!');
+
+=09memset(&fc, 0, sizeof(fc));
+=09memset(&ctx, 0, sizeof(ctx));
+=09fc.fs_private =3D &ctx;
+
+=09ret =3D parse_options(&fc, (char *) data);
+=09if (ret < 0)
+=09=09goto free_data;
+
+=09sbi =3D ext4_alloc_sbi(sb);
+=09if (!sbi) {
+=09=09ret =3D -ENOMEM;
+=09=09goto free_data;
+=09}
+
+=09fc.s_fs_info =3D sbi;
+
+=09sbi->s_sb_block =3D 1;=09/* Default super block location */
+=09if (ctx.spec & EXT4_SPEC_s_sb_block)
+=09=09sbi->s_sb_block =3D ctx.s_sb_block;
+
+=09ret =3D __ext4_fill_super(&fc, sb, silent);
+=09if (ret < 0)
+=09=09goto free_sbi;
+
+=09if (EXT4_SB(sb)->s_journal) {
+=09=09if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_JOURNAL_DATA)
+=09=09=09descr =3D " journalled data mode";
+=09=09else if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_ORDERED_DATA)
+=09=09=09descr =3D " ordered data mode";
+=09=09else
+=09=09=09descr =3D " writeback data mode";
+=09} else
+=09=09descr =3D "out journal";
+
+=09if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
+=09=09ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
+=09=09=09 "Opts: %.*s%s%s", descr,
+=09=09=09 (int) sizeof(sbi->s_es->s_mount_opts),
+=09=09=09 sbi->s_es->s_mount_opts,
+=09=09=09 *sbi->s_es->s_mount_opts ? "; " : "", (char *)orig_data);
+
+=09kfree(orig_data);
+=09cleanup_ctx(&ctx);
+=09return 0;
+free_sbi:
+=09ext4_free_sbi(sbi);
+free_data:
+=09kfree(orig_data);
+=09cleanup_ctx(&ctx);
+=09return ret;
+}
+
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
@@ -5710,7 +5805,7 @@ static int ext4_remount(struct super_block *sb, int *=
flags, char *data)
 =09if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 =09=09journal_ioprio =3D sbi->s_journal->j_task->io_context->ioprio;
=20
-=09if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
+=09if (!parse_apply_options(data, sb, NULL, &journal_ioprio, 1)) {
 =09=09err =3D -EINVAL;
 =09=09goto restore_opts;
 =09}
--=20
2.21.0

