Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30E6F139E
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfKFKPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26987 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728610AbfKFKPZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85l72z3ETwlcNF3fOyLMvKmQwr6LunJ4MXhI0jRq2Xw=;
        b=ESh/ahGtiGFnQVg9W4/9pRYCZnlImry475t+WBuEiGqBMdOsPaydMkhA/qnpQ90JFWQSJh
        obFnvqtAT6f9S+OrNBl6+gbNvRX1rBGed/VrediMPb/xypjIwX/PTuf1o5qHxoj7xcvOZF
        Y97I7UAas1wQMTvw8dukF8JZY8GfCfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-IP8lZhuSMhegmbelNMCMzQ-1; Wed, 06 Nov 2019 05:15:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1467B107ACC3;
        Wed,  6 Nov 2019 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD97C1A7E2;
        Wed,  6 Nov 2019 10:15:19 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 04/17] ext4: Change handle_mount_opt() to use fs_parameter
Date:   Wed,  6 Nov 2019 11:14:44 +0100
Message-Id: <20191106101457.11237-5-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IP8lZhuSMhegmbelNMCMzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 217 +++++++++++++++++++++++++++++-------------------
 1 file changed, 131 insertions(+), 86 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b155257e2a4e..63a06dcb2807 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1692,7 +1692,8 @@ static const char deprecated_msg[] =3D
 =09"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
=20
 #ifdef CONFIG_QUOTA
-static int set_qf_name(struct super_block *sb, int qtype, substring_t *arg=
s)
+static int set_qf_name(struct super_block *sb, int qtype,
+=09=09       struct fs_parameter *param)
 {
 =09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 =09char *qname, *old_qname =3D get_qf_name(sb, sbi, qtype);
@@ -1709,7 +1710,7 @@ static int set_qf_name(struct super_block *sb, int qt=
ype, substring_t *args)
 =09=09=09 "ignored when QUOTA feature is enabled");
 =09=09return 1;
 =09}
-=09qname =3D match_strdup(args);
+=09qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);
 =09if (!qname) {
 =09=09ext4_msg(sb, KERN_ERR,
 =09=09=09"Not enough memory for storing quotafile name");
@@ -1898,35 +1899,49 @@ static int ext4_sb_read_encoding(const struct ext4_=
super_block *es,
 }
 #endif
=20
-static int handle_mount_opt(struct super_block *sb, char *opt, int token,
-=09=09=09    substring_t *args, unsigned long *journal_devnum,
-=09=09=09    unsigned int *journal_ioprio, int is_remount)
+struct ext4_fs_context {
+=09unsigned long journal_devnum;
+=09unsigned int journal_ioprio;
+};
+
+static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *pa=
ram)
 {
-=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09struct ext4_sb_info *sbi =3D fc->s_fs_info;
+=09struct super_block *sb =3D sbi->s_sb;
 =09const struct mount_opts *m;
+=09struct fs_parse_result result;
 =09kuid_t uid;
 =09kgid_t gid;
-=09int arg =3D 0;
+=09int token;
+
+=09token =3D fs_parse(fc, &ext4_fs_parameters, param, &result);
+=09if (token < 0)
+=09=09return token;
=20
 #ifdef CONFIG_QUOTA
-=09if (token =3D=3D Opt_usrjquota)
-=09=09return set_qf_name(sb, USRQUOTA, &args[0]);
-=09else if (token =3D=3D Opt_grpjquota)
-=09=09return set_qf_name(sb, GRPQUOTA, &args[0]);
-=09else if (token =3D=3D Opt_offusrjquota)
-=09=09return clear_qf_name(sb, USRQUOTA);
-=09else if (token =3D=3D Opt_offgrpjquota)
-=09=09return clear_qf_name(sb, GRPQUOTA);
+=09if (token =3D=3D Opt_usrjquota) {
+=09=09if (result.negated)
+=09=09=09return clear_qf_name(sb, USRQUOTA);
+=09=09else
+=09=09=09return set_qf_name(sb, USRQUOTA, param);
+=09} else if (token =3D=3D Opt_grpjquota) {
+=09=09if (result.negated)
+=09=09=09return clear_qf_name(sb, GRPQUOTA);
+=09=09else
+=09=09=09return set_qf_name(sb, GRPQUOTA, param);
+=09}
 #endif
 =09switch (token) {
 =09case Opt_noacl:
 =09case Opt_nouser_xattr:
-=09=09ext4_msg(sb, KERN_WARNING, deprecated_msg, opt, "3.5");
+=09=09ext4_msg(sb, KERN_WARNING, deprecated_msg, param->key, "3.5");
 =09=09break;
 =09case Opt_sb:
 =09=09return 1;=09/* handled by get_sb_block() */
 =09case Opt_removed:
-=09=09ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option", opt);
+=09=09ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option",
+=09=09=09 param->key);
 =09=09return 1;
 =09case Opt_abort:
 =09=09sbi->s_mount_flags |=3D EXT4_MF_FS_ABORTED;
@@ -1940,6 +1955,11 @@ static int handle_mount_opt(struct super_block *sb, =
char *opt, int token,
 =09case Opt_nolazytime:
 =09=09sb->s_flags &=3D ~SB_LAZYTIME;
 =09=09return 1;
+=09case Opt_errors:
+=09case Opt_data:
+=09case Opt_data_err:
+=09case Opt_jqfmt:
+=09=09token =3D result.uint_32;
 =09}
=20
 =09for (m =3D ext4_mount_opts; m->token !=3D Opt_err; m++)
@@ -1948,25 +1968,23 @@ static int handle_mount_opt(struct super_block *sb,=
 char *opt, int token,
=20
 =09if (m->token =3D=3D Opt_err) {
 =09=09ext4_msg(sb, KERN_ERR, "Unrecognized mount option \"%s\" "
-=09=09=09 "or missing value", opt);
+=09=09=09 "or missing value", param->key);
 =09=09return -1;
 =09}
=20
 =09if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
 =09=09ext4_msg(sb, KERN_ERR,
-=09=09=09 "Mount option \"%s\" incompatible with ext2", opt);
+=09=09=09 "Mount option \"%s\" incompatible with ext2",
+=09=09=09 param->string);
 =09=09return -1;
 =09}
 =09if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
 =09=09ext4_msg(sb, KERN_ERR,
-=09=09=09 "Mount option \"%s\" incompatible with ext3", opt);
+=09=09=09 "Mount option \"%s\" incompatible with ext3",
+=09=09=09 param->string);
 =09=09return -1;
 =09}
=20
-=09if (args->from && !(m->flags & MOPT_STRING) && match_int(args, &arg))
-=09=09return -1;
-=09if (args->from && (m->flags & MOPT_GTE0) && (arg < 0))
-=09=09return -1;
 =09if (m->flags & MOPT_EXPLICIT) {
 =09=09if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
 =09=09=09set_opt2(sb, EXPLICIT_DELALLOC);
@@ -1984,108 +2002,96 @@ static int handle_mount_opt(struct super_block *sb=
, char *opt, int token,
 =09}
=20
 =09if (m->flags & MOPT_NOSUPPORT) {
-=09=09ext4_msg(sb, KERN_ERR, "%s option not supported", opt);
+=09=09ext4_msg(sb, KERN_ERR, "%s option not supported",
+=09=09=09 param->key);
 =09} else if (token =3D=3D Opt_commit) {
-=09=09if (arg =3D=3D 0)
-=09=09=09arg =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
-=09=09else if (arg > INT_MAX / HZ) {
+=09=09if (result.uint_32 =3D=3D 0)
+=09=09=09sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
+=09=09else if (result.uint_32 > INT_MAX / HZ) {
 =09=09=09ext4_msg(sb, KERN_ERR,
 =09=09=09=09 "Invalid commit interval %d, "
 =09=09=09=09 "must be smaller than %d",
-=09=09=09=09 arg, INT_MAX / HZ);
+=09=09=09=09 result.uint_32, INT_MAX / HZ);
 =09=09=09return -1;
 =09=09}
-=09=09sbi->s_commit_interval =3D HZ * arg;
+=09=09sbi->s_commit_interval =3D HZ * result.uint_32;
 =09} else if (token =3D=3D Opt_debug_want_extra_isize) {
-=09=09sbi->s_want_extra_isize =3D arg;
+=09=09sbi->s_want_extra_isize =3D result.uint_32;
 =09} else if (token =3D=3D Opt_max_batch_time) {
-=09=09sbi->s_max_batch_time =3D arg;
+=09=09sbi->s_max_batch_time =3D result.uint_32;
 =09} else if (token =3D=3D Opt_min_batch_time) {
-=09=09sbi->s_min_batch_time =3D arg;
+=09=09sbi->s_min_batch_time =3D result.uint_32;
 =09} else if (token =3D=3D Opt_inode_readahead_blks) {
-=09=09if (arg && (arg > (1 << 30) || !is_power_of_2(arg))) {
+=09=09if (result.uint_32 &&
+=09=09    (result.uint_32 > (1 << 30) ||
+=09=09     !is_power_of_2(result.uint_32))) {
 =09=09=09ext4_msg(sb, KERN_ERR,
 =09=09=09=09 "EXT4-fs: inode_readahead_blks must be "
 =09=09=09=09 "0 or a power of 2 smaller than 2^31");
 =09=09=09return -1;
 =09=09}
-=09=09sbi->s_inode_readahead_blks =3D arg;
+=09=09sbi->s_inode_readahead_blks =3D result.uint_32;
 =09} else if (token =3D=3D Opt_init_itable) {
 =09=09set_opt(sb, INIT_INODE_TABLE);
-=09=09if (!args->from)
-=09=09=09arg =3D EXT4_DEF_LI_WAIT_MULT;
-=09=09sbi->s_li_wait_mult =3D arg;
+=09=09sbi->s_li_wait_mult =3D EXT4_DEF_LI_WAIT_MULT;
+=09=09if (result.has_value)
+=09=09=09sbi->s_li_wait_mult =3D result.uint_32;
 =09} else if (token =3D=3D Opt_max_dir_size_kb) {
-=09=09sbi->s_max_dir_size_kb =3D arg;
+=09=09sbi->s_max_dir_size_kb =3D result.uint_32;
 =09} else if (token =3D=3D Opt_stripe) {
-=09=09sbi->s_stripe =3D arg;
+=09=09sbi->s_stripe =3D result.uint_32;
 =09} else if (token =3D=3D Opt_resuid) {
-=09=09uid =3D make_kuid(current_user_ns(), arg);
+=09=09uid =3D make_kuid(current_user_ns(), result.uint_32);
 =09=09if (!uid_valid(uid)) {
-=09=09=09ext4_msg(sb, KERN_ERR, "Invalid uid value %d", arg);
+=09=09=09ext4_msg(sb, KERN_ERR, "Invalid uid value %d",
+=09=09=09=09 result.uint_32);
 =09=09=09return -1;
 =09=09}
 =09=09sbi->s_resuid =3D uid;
 =09} else if (token =3D=3D Opt_resgid) {
-=09=09gid =3D make_kgid(current_user_ns(), arg);
+=09=09gid =3D make_kgid(current_user_ns(), result.uint_32);
 =09=09if (!gid_valid(gid)) {
-=09=09=09ext4_msg(sb, KERN_ERR, "Invalid gid value %d", arg);
+=09=09=09ext4_msg(sb, KERN_ERR, "Invalid gid value %d",
+=09=09=09=09 result.uint_32);
 =09=09=09return -1;
 =09=09}
 =09=09sbi->s_resgid =3D gid;
 =09} else if (token =3D=3D Opt_journal_dev) {
-=09=09if (is_remount) {
+=09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 =09=09=09ext4_msg(sb, KERN_ERR,
 =09=09=09=09 "Cannot specify journal on remount");
 =09=09=09return -1;
 =09=09}
-=09=09*journal_devnum =3D arg;
+=09=09ctx->journal_devnum =3D result.uint_32;
 =09} else if (token =3D=3D Opt_journal_path) {
-=09=09char *journal_path;
 =09=09struct inode *journal_inode;
 =09=09struct path path;
 =09=09int error;
=20
-=09=09if (is_remount) {
+=09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 =09=09=09ext4_msg(sb, KERN_ERR,
 =09=09=09=09 "Cannot specify journal on remount");
 =09=09=09return -1;
 =09=09}
-=09=09journal_path =3D match_strdup(&args[0]);
-=09=09if (!journal_path) {
-=09=09=09ext4_msg(sb, KERN_ERR, "error: could not dup "
-=09=09=09=09"journal device string");
-=09=09=09return -1;
-=09=09}
=20
-=09=09error =3D kern_path(journal_path, LOOKUP_FOLLOW, &path);
+=09=09error =3D fs_lookup_param(fc, param, 1, &path);
 =09=09if (error) {
 =09=09=09ext4_msg(sb, KERN_ERR, "error: could not find "
-=09=09=09=09"journal device path: error %d", error);
-=09=09=09kfree(journal_path);
+=09=09=09=09"journal device path");
 =09=09=09return -1;
 =09=09}
=20
 =09=09journal_inode =3D d_inode(path.dentry);
-=09=09if (!S_ISBLK(journal_inode->i_mode)) {
-=09=09=09ext4_msg(sb, KERN_ERR, "error: journal path %s "
-=09=09=09=09"is not a block device", journal_path);
-=09=09=09path_put(&path);
-=09=09=09kfree(journal_path);
-=09=09=09return -1;
-=09=09}
-
-=09=09*journal_devnum =3D new_encode_dev(journal_inode->i_rdev);
+=09=09ctx->journal_devnum =3D new_encode_dev(journal_inode->i_rdev);
 =09=09path_put(&path);
-=09=09kfree(journal_path);
 =09} else if (token =3D=3D Opt_journal_ioprio) {
-=09=09if (arg > 7) {
+=09=09if (result.uint_32 > 7) {
 =09=09=09ext4_msg(sb, KERN_ERR, "Invalid journal IO priority"
 =09=09=09=09 " (must be 0-7)");
 =09=09=09return -1;
 =09=09}
-=09=09*journal_ioprio =3D
-=09=09=09IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, arg);
+=09=09ctx->journal_ioprio =3D
+=09=09=09IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
 =09} else if (token =3D=3D Opt_test_dummy_encryption) {
 #ifdef CONFIG_FS_ENCRYPTION
 =09=09sbi->s_mount_flags |=3D EXT4_MF_TEST_DUMMY_ENCRYPTION;
@@ -2096,7 +2102,7 @@ static int handle_mount_opt(struct super_block *sb, c=
har *opt, int token,
 =09=09=09 "Test dummy encryption mount option ignored");
 #endif
 =09} else if (m->flags & MOPT_DATAJ) {
-=09=09if (is_remount) {
+=09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 =09=09=09if (!sbi->s_journal)
 =09=09=09=09ext4_msg(sb, KERN_WARNING, "Remounting file system with no jou=
rnal so ignoring journalled data option");
 =09=09=09else if (test_opt(sb, DATA_FLAGS) !=3D m->mount_opt) {
@@ -2138,17 +2144,22 @@ static int handle_mount_opt(struct super_block *sb,=
 char *opt, int token,
 =09} else if (token =3D=3D Opt_data_err_ignore) {
 =09=09sbi->s_mount_opt &=3D ~m->mount_opt;
 =09} else {
-=09=09if (!args->from)
-=09=09=09arg =3D 1;
+=09=09bool set;
+
+=09=09if (result.has_value)
+=09=09=09set =3D result.boolean;
+=09=09else
+=09=09=09set =3D true;
 =09=09if (m->flags & MOPT_CLEAR)
-=09=09=09arg =3D !arg;
+=09=09=09set =3D !set;
 =09=09else if (unlikely(!(m->flags & MOPT_SET))) {
 =09=09=09ext4_msg(sb, KERN_WARNING,
-=09=09=09=09 "buggy handling of option %s", opt);
+=09=09=09=09 "buggy handling of option %s",
+=09=09=09=09 param->key);
 =09=09=09WARN_ON(1);
 =09=09=09return -1;
 =09=09}
-=09=09if (arg !=3D 0)
+=09=09if (set)
 =09=09=09sbi->s_mount_opt |=3D m->mount_opt;
 =09=09else
 =09=09=09sbi->s_mount_opt &=3D ~m->mount_opt;
@@ -2161,26 +2172,60 @@ static int parse_options(char *options, struct supe=
r_block *sb,
 =09=09=09 unsigned int *journal_ioprio,
 =09=09=09 int is_remount)
 {
-=09substring_t args[MAX_OPT_ARGS];
-=09int token;
+=09struct ext4_fs_context ctx;
+=09struct fs_parameter param;
+=09struct fs_context fc;
+=09char *value;
+=09int ret;
 =09char *p;
=20
 =09if (!options)
 =09=09return 1;
=20
+=09memset(&fc, 0, sizeof(fc));
+=09memset(&ctx, 0, sizeof(ctx));
+=09fc.fs_private =3D &ctx;
+=09fc.s_fs_info =3D EXT4_SB(sb);
+
+=09if (is_remount)
+=09=09fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+
 =09while ((p =3D strsep(&options, ",")) !=3D NULL) {
+
 =09=09if (!*p)
 =09=09=09continue;
-=09=09/*
-=09=09 * Initialize args struct so we know whether arg was
-=09=09 * found; some options take optional arguments.
-=09=09 */
-=09=09args[0].to =3D args[0].from =3D NULL;
-=09=09token =3D match_token(p, tokens, args);
-=09=09if (handle_mount_opt(sb, p, token, args, journal_devnum,
-=09=09=09=09     journal_ioprio, is_remount) < 0)
+
+=09=09param.key =3D p;
+=09=09param.type =3D fs_value_is_string;
+=09=09param.size =3D 0;
+=09=09param.string =3D NULL;
+
+=09=09value =3D strchr(p, '=3D');
+=09=09if (value) {
+=09=09=09if (value =3D=3D p)
+=09=09=09=09continue;
+=09=09=09*value++ =3D 0;
+=09=09=09param.size =3D strlen(value);
+=09=09=09if (param.size > 0) {
+=09=09=09=09param.string =3D kmemdup_nul(value,
+=09=09=09=09=09=09=09   param.size,
+=09=09=09=09=09=09=09   GFP_KERNEL);
+=09=09=09=09if (!param.string)
+=09=09=09=09=09return -ENOMEM;
+=09=09=09}
+=09=09}
+
+=09=09ret =3D handle_mount_opt(&fc, &param);
+=09=09kfree(param.string);
+=09=09if (ret < 0)
 =09=09=09return 0;
 =09}
+
+=09if (journal_devnum)
+=09=09*journal_devnum =3D ctx.journal_devnum;
+=09if (journal_ioprio)
+=09=09*journal_ioprio =3D ctx.journal_ioprio;
+
 =09return ext4_validate_options(sb);
 }
=20
--=20
2.21.0

