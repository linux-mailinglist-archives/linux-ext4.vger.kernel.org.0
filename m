Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4AF13A2
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfKFKPd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfKFKPc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/S46Aq7RwDNMLQse/ztL7kKg00K7Bw66zzujNQlLFA=;
        b=JIbMmvYbM5W/YNAkqo0qm7ilzeqF84KS4HdOwAgJ+anOpy4tfHJhg+aL5MAyyCUT6jGzzY
        XnuxZGZAyPgMSsTn6L9uKdIKAdwDOYzDi44DNT0xlz2wOylONmKLDhxs3jDIq2QoGC3kZG
        NIrd839MKd9qaSSEpc6EqNyF3j37574=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-k2mxN6PrPYqp7VaLl48oZg-1; Wed, 06 Nov 2019 05:15:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA028017E0;
        Wed,  6 Nov 2019 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F51719756;
        Wed,  6 Nov 2019 10:15:25 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 08/17] ext4: get rid of super block and sbi from handle_mount_ops()
Date:   Wed,  6 Nov 2019 11:14:48 +0100
Message-Id: <20191106101457.11237-9-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: k2mxN6PrPYqp7VaLl48oZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
 fs/ext4/super.c | 371 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 266 insertions(+), 105 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d515506d18a0..f3dd82fef453 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -91,8 +91,7 @@ static struct inode *ext4_get_journal_inode(struct super_=
block *sb,
 static int ext4_validate_options(struct fs_context *fc);
 static int ext4_check_opt_consistency(struct fs_context *fc,
 =09=09=09=09      struct super_block *sb);
-static void ext4_apply_quota_options(struct fs_context *fc,
-=09=09=09=09     struct super_block *sb);
+static void ext4_apply_options(struct fs_context *fc, struct super_block *=
sb);
=20
 /*
  * Lock ordering
@@ -1839,13 +1838,49 @@ static int ext4_sb_read_encoding(const struct ext4_=
super_block *es,
 }
 #endif
=20
+#define EXT4_SPEC_JQUOTA=09=09=09(1 <<  0)
+#define EXT4_SPEC_JQFMT=09=09=09=09(1 <<  1)
+#define EXT4_SPEC_DATAJ=09=09=09=09(1 <<  2)
+#define EXT4_SPEC_SB_BLOCK=09=09=09(1 <<  3)
+#define EXT4_SPEC_JOURNAL_DEV=09=09=09(1 <<  4)
+#define EXT4_SPEC_JOURNAL_IOPRIO=09=09(1 <<  5)
+#define EXT4_SPEC_s_want_extra_isize=09=09(1 <<  6)
+#define EXT4_SPEC_s_max_batch_time=09=09(1 <<  7)
+#define EXT4_SPEC_s_min_batch_time=09=09(1 <<  8)
+#define EXT4_SPEC_s_inode_readahead_blks=09(1 <<  9)
+#define EXT4_SPEC_s_li_wait_mult=09=09(1 << 10)
+#define EXT4_SPEC_s_max_dir_size_kb=09=09(1 << 11)
+#define EXT4_SPEC_s_stripe=09=09=09(1 << 12)
+#define EXT4_SPEC_s_resuid=09=09=09(1 << 13)
+#define EXT4_SPEC_s_resgid=09=09=09(1 << 14)
+#define EXT4_SPEC_s_commit_interval=09=09(1 << 15)
+
 struct ext4_fs_context {
 =09char=09=09*s_qf_names[EXT4_MAXQUOTAS];
 =09int=09=09s_jquota_fmt;=09/* Format of quota to use */
 =09unsigned short=09qname_spec;
+=09unsigned long=09vals_s_flags;=09/* Bits to set in s_flags */
+=09unsigned long=09mask_s_flags;=09/* Bits changed in s_flags */
 =09unsigned long=09journal_devnum;
+=09unsigned long=09s_commit_interval;
+=09unsigned long=09s_stripe;
+=09unsigned int=09s_inode_readahead_blks;
+=09unsigned int=09s_want_extra_isize;
+=09unsigned int=09s_li_wait_mult;
+=09unsigned int=09s_max_dir_size_kb;
 =09unsigned int=09journal_ioprio;
+=09unsigned int=09vals_s_mount_opt;
+=09unsigned int=09mask_s_mount_opt;
+=09unsigned int=09vals_s_mount_opt2;
+=09unsigned int=09mask_s_mount_opt2;
+=09unsigned int=09vals_s_mount_flags;
+=09unsigned int=09mask_s_mount_flags;
 =09unsigned int=09opt_flags;=09/* MOPT flags */
+=09unsigned int=09spec;
+=09u32=09=09s_max_batch_time;
+=09u32=09=09s_min_batch_time;
+=09kuid_t=09=09s_resuid;
+=09kgid_t=09=09s_resgid;
 };
=20
 #ifdef CONFIG_QUOTA
@@ -1884,6 +1919,7 @@ static int note_qf_name(struct fs_context *fc, int qt=
ype,
 =09}
 =09ctx->s_qf_names[qtype] =3D qname;
 =09ctx->qname_spec |=3D 1 << qtype;
+=09ctx->spec |=3D EXT4_SPEC_JQUOTA;
 =09return 0;
 }
=20
@@ -1900,15 +1936,36 @@ static int unnote_qf_name(struct fs_context *fc, in=
t qtype)
 =09kfree(ctx->s_qf_names[qtype]);
 =09ctx->s_qf_names[qtype] =3D NULL;
 =09ctx->qname_spec |=3D 1 << qtype;
+=09ctx->spec |=3D EXT4_SPEC_JQUOTA;
 =09return 0;
 }
 #endif
=20
+#define EXT4_SET_CTX(name)=09=09=09=09=09=09\
+static inline void set_##name(struct ext4_fs_context *ctx, int flag)=09\
+{=09=09=09=09=09=09=09=09=09\
+=09ctx->mask_s_##name |=3D flag;=09=09=09=09=09\
+=09ctx->vals_s_##name |=3D flag;=09=09=09=09=09\
+}=09=09=09=09=09=09=09=09=09\
+static inline void clear_##name(struct ext4_fs_context *ctx, int flag)=09\
+{=09=09=09=09=09=09=09=09=09\
+=09ctx->mask_s_##name |=3D flag;=09=09=09=09=09\
+=09ctx->vals_s_##name &=3D ~flag;=09=09=09=09=09\
+}=09=09=09=09=09=09=09=09=09\
+static inline bool test_##name(struct ext4_fs_context *ctx, int flag)=09\
+{=09=09=09=09=09=09=09=09=09\
+=09return ((ctx->vals_s_##name & flag) !=3D 0);=09=09=09\
+}=09=09=09=09=09=09=09=09=09\
+
+EXT4_SET_CTX(flags);
+EXT4_SET_CTX(mount_opt);
+EXT4_SET_CTX(mount_opt2);
+EXT4_SET_CTX(mount_flags);
+
+
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *pa=
ram)
 {
 =09struct ext4_fs_context *ctx =3D fc->fs_private;
-=09struct ext4_sb_info *sbi =3D fc->s_fs_info;
-=09struct super_block *sb =3D sbi->s_sb;
 =09const struct mount_opts *m;
 =09struct fs_parse_result result;
 =09kuid_t uid;
@@ -1944,16 +2001,16 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09=09 param->key);
 =09=09return 1;
 =09case Opt_abort:
-=09=09sbi->s_mount_flags |=3D EXT4_MF_FS_ABORTED;
+=09=09set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
 =09=09return 1;
 =09case Opt_i_version:
-=09=09sb->s_flags |=3D SB_I_VERSION;
+=09=09set_flags(ctx, SB_I_VERSION);
 =09=09return 1;
 =09case Opt_lazytime:
-=09=09sb->s_flags |=3D SB_LAZYTIME;
+=09=09set_flags(ctx, SB_LAZYTIME);
 =09=09return 1;
 =09case Opt_nolazytime:
-=09=09sb->s_flags &=3D ~SB_LAZYTIME;
+=09=09clear_flags(ctx, SB_LAZYTIME);
 =09=09return 1;
 =09case Opt_errors:
 =09case Opt_data:
@@ -1976,21 +2033,22 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
=20
 =09if (m->flags & MOPT_EXPLICIT) {
 =09=09if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
-=09=09=09set_opt2(sb, EXPLICIT_DELALLOC);
+=09=09=09set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
 =09=09} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
-=09=09=09set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
+=09=09=09set_mount_opt2(ctx,
+=09=09=09=09       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
 =09=09} else
 =09=09=09return -EINVAL;
 =09}
 =09if (m->flags & MOPT_CLEAR_ERR)
-=09=09clear_opt(sb, ERRORS_MASK);
+=09=09clear_mount_opt(ctx, EXT4_MOUNT_ERRORS_MASK);
=20
 =09if (m->flags & MOPT_NOSUPPORT) {
 =09=09ext4_msg(NULL, KERN_ERR, "%s option not supported",
 =09=09=09 param->key);
 =09} else if (token =3D=3D Opt_commit) {
 =09=09if (result.uint_32 =3D=3D 0)
-=09=09=09sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
+=09=09=09ctx->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
 =09=09else if (result.uint_32 > INT_MAX / HZ) {
 =09=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09=09 "Invalid commit interval %d, "
@@ -1998,13 +2056,17 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09=09=09 result.uint_32, INT_MAX / HZ);
 =09=09=09return -EINVAL;
 =09=09}
-=09=09sbi->s_commit_interval =3D HZ * result.uint_32;
+=09=09ctx->s_commit_interval =3D HZ * result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_commit_interval;
 =09} else if (token =3D=3D Opt_debug_want_extra_isize) {
-=09=09sbi->s_want_extra_isize =3D result.uint_32;
+=09=09ctx->s_want_extra_isize =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_want_extra_isize;
 =09} else if (token =3D=3D Opt_max_batch_time) {
-=09=09sbi->s_max_batch_time =3D result.uint_32;
+=09=09ctx->s_max_batch_time =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_max_batch_time;
 =09} else if (token =3D=3D Opt_min_batch_time) {
-=09=09sbi->s_min_batch_time =3D result.uint_32;
+=09=09ctx->s_min_batch_time =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_min_batch_time;
 =09} else if (token =3D=3D Opt_inode_readahead_blks) {
 =09=09if (result.uint_32 &&
 =09=09    (result.uint_32 > (1 << 30) ||
@@ -2014,16 +2076,20 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09=09=09 "0 or a power of 2 smaller than 2^31");
 =09=09=09return -EINVAL;
 =09=09}
-=09=09sbi->s_inode_readahead_blks =3D result.uint_32;
+=09=09ctx->s_inode_readahead_blks =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_inode_readahead_blks;
 =09} else if (token =3D=3D Opt_init_itable) {
-=09=09set_opt(sb, INIT_INODE_TABLE);
-=09=09sbi->s_li_wait_mult =3D EXT4_DEF_LI_WAIT_MULT;
+=09=09set_mount_opt(ctx, EXT4_MOUNT_INIT_INODE_TABLE);
+=09=09ctx->s_li_wait_mult =3D EXT4_DEF_LI_WAIT_MULT;
 =09=09if (result.has_value)
-=09=09=09sbi->s_li_wait_mult =3D result.uint_32;
+=09=09=09ctx->s_li_wait_mult =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_li_wait_mult;
 =09} else if (token =3D=3D Opt_max_dir_size_kb) {
-=09=09sbi->s_max_dir_size_kb =3D result.uint_32;
+=09=09ctx->s_max_dir_size_kb =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_max_dir_size_kb;
 =09} else if (token =3D=3D Opt_stripe) {
-=09=09sbi->s_stripe =3D result.uint_32;
+=09=09ctx->s_stripe =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_s_stripe;
 =09} else if (token =3D=3D Opt_resuid) {
 =09=09uid =3D make_kuid(current_user_ns(), result.uint_32);
 =09=09if (!uid_valid(uid)) {
@@ -2031,7 +2097,8 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
 =09=09=09=09 result.uint_32);
 =09=09=09return -EINVAL;
 =09=09}
-=09=09sbi->s_resuid =3D uid;
+=09=09ctx->s_resuid =3D uid;
+=09=09ctx->spec |=3D EXT4_SPEC_s_resuid;
 =09} else if (token =3D=3D Opt_resgid) {
 =09=09gid =3D make_kgid(current_user_ns(), result.uint_32);
 =09=09if (!gid_valid(gid)) {
@@ -2039,7 +2106,8 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
 =09=09=09=09 result.uint_32);
 =09=09=09return -EINVAL;
 =09=09}
-=09=09sbi->s_resgid =3D gid;
+=09=09ctx->s_resgid =3D gid;
+=09=09ctx->spec |=3D EXT4_SPEC_s_resgid;
 =09} else if (token =3D=3D Opt_journal_dev) {
 =09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 =09=09=09ext4_msg(NULL, KERN_ERR,
@@ -2047,6 +2115,7 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
 =09=09=09return -EINVAL;
 =09=09}
 =09=09ctx->journal_devnum =3D result.uint_32;
+=09=09ctx->spec |=3D EXT4_SPEC_JOURNAL_DEV;
 =09} else if (token =3D=3D Opt_journal_path) {
 =09=09struct inode *journal_inode;
 =09=09struct path path;
@@ -2067,6 +2136,7 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
=20
 =09=09journal_inode =3D d_inode(path.dentry);
 =09=09ctx->journal_devnum =3D new_encode_dev(journal_inode->i_rdev);
+=09=09ctx->spec |=3D EXT4_SPEC_JOURNAL_DEV;
 =09=09path_put(&path);
 =09} else if (token =3D=3D Opt_journal_ioprio) {
 =09=09if (result.uint_32 > 7) {
@@ -2076,9 +2146,10 @@ static int handle_mount_opt(struct fs_context *fc, s=
truct fs_parameter *param)
 =09=09}
 =09=09ctx->journal_ioprio =3D
 =09=09=09IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
+=09=09ctx->spec |=3D EXT4_SPEC_JOURNAL_IOPRIO;
 =09} else if (token =3D=3D Opt_test_dummy_encryption) {
 #ifdef CONFIG_FS_ENCRYPTION
-=09=09sbi->s_mount_flags |=3D EXT4_MF_TEST_DUMMY_ENCRYPTION;
+=09=09set_mount_flags(ctx, EXT4_MF_TEST_DUMMY_ENCRYPTION);
 =09=09ext4_msg(NULL, KERN_WARNING,
 =09=09=09 "Test dummy encryption mode enabled");
 #else
@@ -2086,35 +2157,27 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09=09 "Test dummy encryption mount option ignored");
 #endif
 =09} else if (m->flags & MOPT_DATAJ) {
-=09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
-=09=09=09if (!sbi->s_journal)
-=09=09=09=09ext4_msg(NULL, KERN_WARNING, "Remounting file system with no j=
ournal so ignoring journalled data option");
-=09=09=09else if (test_opt(sb, DATA_FLAGS) !=3D m->mount_opt) {
-=09=09=09=09ext4_msg(NULL, KERN_ERR,
-=09=09=09=09=09 "Cannot change data mode on remount");
-=09=09=09=09return -EINVAL;
-=09=09=09}
-=09=09} else {
-=09=09=09clear_opt(sb, DATA_FLAGS);
-=09=09=09sbi->s_mount_opt |=3D m->mount_opt;
-=09=09}
+=09=09clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+=09=09set_mount_opt(ctx, m->mount_opt);
+=09=09ctx->spec |=3D EXT4_SPEC_DATAJ;
 #ifdef CONFIG_QUOTA
 =09} else if (m->flags & MOPT_QFMT) {
 =09=09ctx->s_jquota_fmt =3D m->mount_opt;
+=09=09ctx->spec |=3D EXT4_SPEC_JQFMT;
 #endif
 =09} else if (token =3D=3D Opt_dax) {
 #ifdef CONFIG_FS_DAX
 =09=09ext4_msg(NULL, KERN_WARNING,
 =09=09"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-=09=09sbi->s_mount_opt |=3D m->mount_opt;
+=09=09set_mount_opt(ctx, m->mount_opt);
 #else
 =09=09ext4_msg(NULL, KERN_INFO, "dax option not supported");
 =09=09return -EINVAL;
 #endif
 =09} else if (token =3D=3D Opt_data_err_abort) {
-=09=09sbi->s_mount_opt |=3D m->mount_opt;
+=09=09set_mount_opt(ctx, m->mount_opt);
 =09} else if (token =3D=3D Opt_data_err_ignore) {
-=09=09sbi->s_mount_opt &=3D ~m->mount_opt;
+=09=09clear_mount_opt(ctx, m->mount_opt);
 =09} else {
 =09=09bool set;
=20
@@ -2132,9 +2195,9 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
 =09=09=09return -EINVAL;
 =09=09}
 =09=09if (set)
-=09=09=09sbi->s_mount_opt |=3D m->mount_opt;
+=09=09=09set_mount_opt(ctx, m->mount_opt);
 =09=09else
-=09=09=09sbi->s_mount_opt &=3D ~m->mount_opt;
+=09=09=09clear_mount_opt(ctx, m->mount_opt);
 =09}
 =09return 1;
 }
@@ -2193,11 +2256,6 @@ static int parse_options(char *options, struct super=
_block *sb,
 =09=09=09return 0;
 =09}
=20
-=09if (journal_devnum)
-=09=09*journal_devnum =3D ctx.journal_devnum;
-=09if (journal_ioprio)
-=09=09*journal_ioprio =3D ctx.journal_ioprio;
-
 =09ret =3D ext4_validate_options(&fc);
 =09if (ret < 0)
 =09=09return 0;
@@ -2206,9 +2264,12 @@ static int parse_options(char *options, struct super=
_block *sb,
 =09if (ret < 0)
 =09=09return 0;
=20
-=09if (ctx.qname_spec)
-=09=09ext4_apply_quota_options(&fc, sb);
+=09if (ctx.spec & EXT4_SPEC_JOURNAL_DEV)
+=09=09*journal_devnum =3D ctx.journal_devnum;
+=09if (ctx.spec & EXT4_SPEC_JOURNAL_IOPRIO)
+=09=09*journal_ioprio =3D ctx.journal_ioprio;
=20
+=09ext4_apply_options(&fc, sb);
 =09return 1;
 }
=20
@@ -2216,20 +2277,30 @@ static void ext4_apply_quota_options(struct fs_cont=
ext *fc,
 =09=09=09=09     struct super_block *sb)
 {
 #ifdef CONFIG_QUOTA
+=09bool quota_feature =3D ext4_has_feature_quota(sb);
 =09struct ext4_fs_context *ctx =3D fc->fs_private;
 =09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 =09char *qname;
 =09int i;
=20
-=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
-=09=09if (!(ctx->qname_spec & (1 << i)))
-=09=09=09continue;
-=09=09qname =3D ctx->s_qf_names[i]; /* May be NULL */
-=09=09ctx->s_qf_names[i] =3D NULL;
-=09=09kfree(sbi->s_qf_names[i]);
-=09=09rcu_assign_pointer(sbi->s_qf_names[i], qname);
-=09=09set_opt(sb, QUOTA);
+=09if (quota_feature)
+=09=09return;
+
+=09if (ctx->spec & EXT4_SPEC_JQUOTA) {
+=09=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+=09=09=09if (!(ctx->qname_spec & (1 << i)))
+=09=09=09=09continue;
+
+=09=09=09qname =3D ctx->s_qf_names[i]; /* May be NULL */
+=09=09=09ctx->s_qf_names[i] =3D NULL;
+=09=09=09kfree(sbi->s_qf_names[i]);
+=09=09=09rcu_assign_pointer(sbi->s_qf_names[i], qname);
+=09=09=09set_opt(sb, QUOTA);
+=09=09}
 =09}
+
+=09if (ctx->spec & EXT4_SPEC_JQFMT)
+=09=09sbi->s_jquota_fmt =3D ctx->s_jquota_fmt;
 #endif
 }
=20
@@ -2244,17 +2315,43 @@ static int ext4_check_quota_consistency(struct fs_c=
ontext *fc,
 =09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 =09bool quota_feature =3D ext4_has_feature_quota(sb);
 =09bool quota_loaded =3D sb_any_quota_loaded(sb);
-=09int i;
+=09bool usr_qf_name, grp_qf_name, usrquota, grpquota;
+=09int quota_flags, i;
=20
-=09if (ctx->qname_spec && quota_loaded) {
-=09=09if (quota_feature)
-=09=09=09goto err_feature;
+=09/*
+=09 * We do the test below only for project quotas. 'usrquota' and
+=09 * 'grpquota' mount options are allowed even without quota feature
+=09 * to support legacy quotas in quota files.
+=09 */
+=09if (test_mount_opt(ctx, EXT4_MOUNT_PRJQUOTA) &&
+=09    !ext4_has_feature_project(sb)) {
+=09=09ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
+=09=09=09 "Cannot enable project quota enforcement.");
+=09=09return -EINVAL;
+=09}
+
+=09quota_flags =3D EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA |
+=09=09      EXT4_MOUNT_GRPQUOTA | EXT4_MOUNT_PRJQUOTA;
+=09if (quota_loaded &&
+=09    ctx->mask_s_mount_opt & quota_flags &&
+=09    !test_mount_opt( ctx, quota_flags))
+=09=09goto err_quota_change;
+
+=09if (ctx->spec & EXT4_SPEC_JQUOTA) {
+
+=09=09if (quota_feature) {
+=09=09=09ext4_msg(NULL, KERN_INFO,
+=09=09=09=09 "Ext4: Journaled quota options ignored when "
+=09=09=09=09 "QUOTA feature is enabled");
+=09=09=09return 0;
+=09=09}
=20
 =09=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
 =09=09=09if (!(ctx->qname_spec & (1 << i)))
 =09=09=09=09continue;
=20
-=09=09=09if (!!sbi->s_qf_names[i] !=3D !!ctx->s_qf_names[i])
+=09=09=09if (quota_loaded &&
+=09=09=09    !!sbi->s_qf_names[i] !=3D !!ctx->s_qf_names[i])
 =09=09=09=09goto err_jquota_change;
=20
 =09=09=09if (sbi->s_qf_names[i] &&
@@ -2264,15 +2361,52 @@ static int ext4_check_quota_consistency(struct fs_c=
ontext *fc,
 =09=09}
 =09}
=20
-=09if (ctx->s_jquota_fmt) {
+=09if (ctx->spec & EXT4_SPEC_JQFMT) {
 =09=09if (sbi->s_jquota_fmt !=3D ctx->s_jquota_fmt && quota_loaded)
-=09=09=09goto err_quota_change;
+=09=09=09goto err_jquota_change;
 =09=09if (quota_feature) {
 =09=09=09ext4_msg(NULL, KERN_INFO, "Quota format mount options "
 =09=09=09=09 "ignored when QUOTA feature is enabled");
 =09=09=09return 0;
 =09=09}
 =09}
+
+
+=09/* Make sure we don't mix old and new quota format */
+=09usr_qf_name =3D (get_qf_name(sb, sbi, USRQUOTA) ||
+=09=09       ctx->s_qf_names[USRQUOTA]);
+=09grp_qf_name =3D (get_qf_name(sb, sbi, GRPQUOTA) ||
+=09=09       ctx->s_qf_names[GRPQUOTA]);
+
+=09usrquota =3D (test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) ||
+=09=09    test_opt(sb, USRQUOTA));
+
+=09grpquota =3D (test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA) ||
+=09=09    test_opt(sb, GRPQUOTA));
+
+=09if (usr_qf_name) {
+=09=09clear_mount_opt(ctx, EXT4_MOUNT_USRQUOTA);
+=09=09usrquota =3D false;
+=09}
+=09if (grp_qf_name) {
+=09=09clear_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA);
+=09=09grpquota =3D false;
+=09}
+
+=09if (usr_qf_name || grp_qf_name) {
+=09=09if (usrquota || grpquota) {
+=09=09=09ext4_msg(NULL, KERN_ERR, "old and new quota "
+=09=09=09=09 "format mixing");
+=09=09=09return -EINVAL;
+=09=09}
+
+=09=09if (!(ctx->spec & EXT4_SPEC_JQFMT || sbi->s_jquota_fmt)) {
+=09=09=09ext4_msg(NULL, KERN_ERR, "journaled quota format "
+=09=09=09=09 "not specified");
+=09=09=09return -EINVAL;
+=09=09}
+=09}
+
 =09return 0;
=20
 err_quota_change:
@@ -2286,10 +2420,6 @@ static int ext4_check_quota_consistency(struct fs_co=
ntext *fc,
 err_jquota_specified:
 =09ext4_msg(NULL, KERN_ERR, "Ext4: Quota file already specified");
 =09return -EINVAL;
-err_feature:
-=09ext4_msg(NULL, KERN_ERR, "Ext4: Journaled quota options ignored "
-=09=09 "when QUOTA feature is enabled");
-=09return -EINVAL;
 #else
 =09return 0;
 #endif
@@ -2299,6 +2429,7 @@ static int ext4_check_opt_consistency(struct fs_conte=
xt *fc,
 =09=09=09=09      struct super_block *sb)
 {
 =09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09struct ext4_sb_info *sbi =3D fc->s_fs_info;
=20
 =09if ((ctx->opt_flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
 =09=09ext4_msg(NULL, KERN_ERR,
@@ -2311,58 +2442,88 @@ static int ext4_check_opt_consistency(struct fs_con=
text *fc,
 =09=09return -EINVAL;
 =09}
=20
+=09if (test_mount_opt(ctx, EXT4_MOUNT_DIOREAD_NOLOCK)) {
+=09=09int blocksize =3D
+=09=09=09BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
+
+=09=09if (blocksize < PAGE_SIZE) {
+=09=09=09ext4_msg(NULL, KERN_ERR,
+=09=09=09=09 "can't mount with dioread_nolock "
+=09=09=09=09 "if block size !=3D PAGE_SIZE");
+=09=09=09return -EINVAL;
+=09=09}
+=09}
+
+=09if ((ctx->spec & EXT4_SPEC_DATAJ) &&
+=09    (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE)) {
+=09=09if (!sbi->s_journal) {
+=09=09=09ext4_msg(NULL, KERN_WARNING,
+=09=09=09=09 "Remounting file system with no journal "
+=09=09=09=09 "so ignoring journalled data option");
+=09=09=09clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+=09=09} else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
+=09=09=09ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
+=09=09=09=09 "on remount");
+=09=09=09return -EINVAL;
+=09=09}
+=09}
+
 =09return ext4_check_quota_consistency(fc, sb);
 }
=20
-static int ext4_validate_options(struct fs_context *fc)
+static void ext4_apply_options(struct fs_context *fc, struct super_block *=
sb)
 {
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
 =09struct ext4_sb_info *sbi =3D fc->s_fs_info;
-=09struct super_block *sb =3D sbi->s_sb;
+
+=09sbi->s_mount_opt &=3D ~ctx->mask_s_mount_opt;
+=09sbi->s_mount_opt |=3D ctx->vals_s_mount_opt;
+=09sbi->s_mount_opt2 &=3D ~ctx->mask_s_mount_opt2;
+=09sbi->s_mount_opt2 |=3D ctx->vals_s_mount_opt2;
+=09sbi->s_mount_flags &=3D ~ctx->mask_s_mount_flags;
+=09sbi->s_mount_flags |=3D ctx->vals_s_mount_flags;
+=09sb->s_flags &=3D ~ctx->mask_s_flags;
+=09sb->s_flags |=3D ctx->vals_s_flags;
+
+#define APPLY(X) if (ctx->spec & EXT4_SPEC_##X) sbi->X =3D ctx->X
+=09APPLY(s_commit_interval);
+=09APPLY(s_stripe);
+=09APPLY(s_max_batch_time);
+=09APPLY(s_min_batch_time);
+=09APPLY(s_want_extra_isize);
+=09APPLY(s_inode_readahead_blks);
+=09APPLY(s_max_dir_size_kb);
+=09APPLY(s_li_wait_mult);
+=09APPLY(s_resgid);
+=09APPLY(s_resuid);
+
+=09ext4_apply_quota_options(fc, sb);
+}
+
+static int ext4_validate_options(struct fs_context *fc)
+{
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
 #ifdef CONFIG_QUOTA
 =09char *usr_qf_name, *grp_qf_name;
-=09/*
-=09 * We do the test below only for project quotas. 'usrquota' and
-=09 * 'grpquota' mount options are allowed even without quota feature
-=09 * to support legacy quotas in quota files.
-=09 */
-=09if (test_opt(sb, PRJQUOTA) && !ext4_has_feature_project(sb)) {
-=09=09ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
-=09=09=09 "Cannot enable project quota enforcement.");
-=09=09return -EINVAL;
-=09}
-=09usr_qf_name =3D get_qf_name(sb, sbi, USRQUOTA);
-=09grp_qf_name =3D get_qf_name(sb, sbi, GRPQUOTA);
+
+=09usr_qf_name =3D ctx->s_qf_names[USRQUOTA];
+=09grp_qf_name =3D ctx->s_qf_names[GRPQUOTA];
 =09if (usr_qf_name || grp_qf_name) {
-=09=09if (test_opt(sb, USRQUOTA) && usr_qf_name)
-=09=09=09clear_opt(sb, USRQUOTA);
+=09=09if (test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) && usr_qf_name)
+=09=09=09clear_mount_opt(ctx, EXT4_MOUNT_USRQUOTA);
=20
-=09=09if (test_opt(sb, GRPQUOTA) && grp_qf_name)
-=09=09=09clear_opt(sb, GRPQUOTA);
+=09=09if (test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA) && grp_qf_name)
+=09=09=09clear_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA);
=20
-=09=09if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
+=09=09if (test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) ||
+=09=09    test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA)) {
 =09=09=09ext4_msg(NULL, KERN_ERR, "old and new quota "
-=09=09=09=09=09"format mixing");
-=09=09=09return -EINVAL;
-=09=09}
-
-=09=09if (!sbi->s_jquota_fmt) {
-=09=09=09ext4_msg(NULL, KERN_ERR, "journaled quota format "
-=09=09=09=09=09"not specified");
+=09=09=09=09 "format mixing");
 =09=09=09return -EINVAL;
 =09=09}
 =09}
 #endif
-=09if (test_opt(sb, DIOREAD_NOLOCK)) {
-=09=09int blocksize =3D
-=09=09=09BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
-
-=09=09if (blocksize < PAGE_SIZE) {
-=09=09=09ext4_msg(NULL, KERN_ERR, "can't mount with "
-=09=09=09=09 "dioread_nolock if block size !=3D PAGE_SIZE");
-=09=09=09return -EINVAL;
-=09=09}
-=09}
-=09return 0;
+=09return 1;
 }
=20
 static inline void ext4_show_quota_options(struct seq_file *seq,
--=20
2.21.0

