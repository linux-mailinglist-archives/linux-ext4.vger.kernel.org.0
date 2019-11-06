Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD57F139F
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfKFKP1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731035AbfKFKP1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ByLDw2aPuIyRwneSWqxCqx2cLgBVoqq30ML9FfTL4I=;
        b=Iibmf3zee6MXxp5P9V7w5Me4KfyRzsnveETy5doUYOTSAdrcHS8X6XSWNcRfFv0OU/fUzD
        5+rNiLXghYoeUY+l7DEzeTn99ReMmkhx5c3atwdFw9I/aEGMojeC90U1cXS7Ii4oDHHnOT
        yZlTNhWcvnBT2w5M1WqI+3oCS5Savms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-4xb_O0yNM7yq_WC4Tw2MqQ-1; Wed, 06 Nov 2019 05:15:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F6EE107ACC4;
        Wed,  6 Nov 2019 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5991F19756;
        Wed,  6 Nov 2019 10:15:21 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 05/17] ext4: Allow sb to be NULL in ext4_msg()
Date:   Wed,  6 Nov 2019 11:14:45 +0100
Message-Id: <20191106101457.11237-6-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4xb_O0yNM7yq_WC4Tw2MqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so allow sb to be NULL in ext4_msg and use that in
handle_mount_opt().

Also return -EINVAL instead of -1

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 120 +++++++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 57 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 63a06dcb2807..12483f3b1f78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -88,7 +88,7 @@ static void ext4_unregister_li_request(struct super_block=
 *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 =09=09=09=09=09    unsigned int journal_inum);
-static int ext4_validate_options(struct super_block *sb);
+static int ext4_validate_options(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -717,13 +717,14 @@ void __ext4_msg(struct super_block *sb,
 =09struct va_format vaf;
 =09va_list args;
=20
-=09if (!___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
+=09if (sb &&
+=09    !___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
 =09=09return;
=20
 =09va_start(args, fmt);
 =09vaf.fmt =3D fmt;
 =09vaf.va =3D &args;
-=09printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+=09printk("%sEXT4-fs (%s): %pV\n", prefix, sb ? sb->s_id : "n/a", &vaf);
 =09va_end(args);
 }
=20
@@ -1935,12 +1936,12 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09switch (token) {
 =09case Opt_noacl:
 =09case Opt_nouser_xattr:
-=09=09ext4_msg(sb, KERN_WARNING, deprecated_msg, param->key, "3.5");
+=09=09ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
 =09=09break;
 =09case Opt_sb:
 =09=09return 1;=09/* handled by get_sb_block() */
 =09case Opt_removed:
-=09=09ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option",
+=09=09ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 =09=09=09 param->key);
 =09=09return 1;
 =09case Opt_abort:
@@ -1967,22 +1968,22 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09=09break;
=20
 =09if (m->token =3D=3D Opt_err) {
-=09=09ext4_msg(sb, KERN_ERR, "Unrecognized mount option \"%s\" "
+=09=09ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
 =09=09=09 "or missing value", param->key);
-=09=09return -1;
+=09=09return -EINVAL;
 =09}
=20
 =09if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
-=09=09ext4_msg(sb, KERN_ERR,
+=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09 "Mount option \"%s\" incompatible with ext2",
 =09=09=09 param->string);
-=09=09return -1;
+=09=09return -EINVAL;
 =09}
 =09if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
-=09=09ext4_msg(sb, KERN_ERR,
+=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09 "Mount option \"%s\" incompatible with ext3",
 =09=09=09 param->string);
-=09=09return -1;
+=09=09return -EINVAL;
 =09}
=20
 =09if (m->flags & MOPT_EXPLICIT) {
@@ -1991,28 +1992,28 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
 =09=09=09set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
 =09=09} else
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09}
 =09if (m->flags & MOPT_CLEAR_ERR)
 =09=09clear_opt(sb, ERRORS_MASK);
 =09if (token =3D=3D Opt_noquota && sb_any_quota_loaded(sb)) {
-=09=09ext4_msg(sb, KERN_ERR, "Cannot change quota "
+=09=09ext4_msg(NULL, KERN_ERR, "Cannot change quota "
 =09=09=09 "options when quota turned on");
-=09=09return -1;
+=09=09return -EINVAL;
 =09}
=20
 =09if (m->flags & MOPT_NOSUPPORT) {
-=09=09ext4_msg(sb, KERN_ERR, "%s option not supported",
+=09=09ext4_msg(NULL, KERN_ERR, "%s option not supported",
 =09=09=09 param->key);
 =09} else if (token =3D=3D Opt_commit) {
 =09=09if (result.uint_32 =3D=3D 0)
 =09=09=09sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
 =09=09else if (result.uint_32 > INT_MAX / HZ) {
-=09=09=09ext4_msg(sb, KERN_ERR,
+=09=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09=09 "Invalid commit interval %d, "
 =09=09=09=09 "must be smaller than %d",
 =09=09=09=09 result.uint_32, INT_MAX / HZ);
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09sbi->s_commit_interval =3D HZ * result.uint_32;
 =09} else if (token =3D=3D Opt_debug_want_extra_isize) {
@@ -2025,10 +2026,10 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09if (result.uint_32 &&
 =09=09    (result.uint_32 > (1 << 30) ||
 =09=09     !is_power_of_2(result.uint_32))) {
-=09=09=09ext4_msg(sb, KERN_ERR,
+=09=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09=09 "EXT4-fs: inode_readahead_blks must be "
 =09=09=09=09 "0 or a power of 2 smaller than 2^31");
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09sbi->s_inode_readahead_blks =3D result.uint_32;
 =09} else if (token =3D=3D Opt_init_itable) {
@@ -2043,24 +2044,24 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09} else if (token =3D=3D Opt_resuid) {
 =09=09uid =3D make_kuid(current_user_ns(), result.uint_32);
 =09=09if (!uid_valid(uid)) {
-=09=09=09ext4_msg(sb, KERN_ERR, "Invalid uid value %d",
+=09=09=09ext4_msg(NULL, KERN_ERR, "Invalid uid value %d",
 =09=09=09=09 result.uint_32);
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09sbi->s_resuid =3D uid;
 =09} else if (token =3D=3D Opt_resgid) {
 =09=09gid =3D make_kgid(current_user_ns(), result.uint_32);
 =09=09if (!gid_valid(gid)) {
-=09=09=09ext4_msg(sb, KERN_ERR, "Invalid gid value %d",
+=09=09=09ext4_msg(NULL, KERN_ERR, "Invalid gid value %d",
 =09=09=09=09 result.uint_32);
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09sbi->s_resgid =3D gid;
 =09} else if (token =3D=3D Opt_journal_dev) {
 =09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
-=09=09=09ext4_msg(sb, KERN_ERR,
+=09=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09=09 "Cannot specify journal on remount");
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09ctx->journal_devnum =3D result.uint_32;
 =09} else if (token =3D=3D Opt_journal_path) {
@@ -2069,16 +2070,16 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09int error;
=20
 =09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
-=09=09=09ext4_msg(sb, KERN_ERR,
+=09=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09=09 "Cannot specify journal on remount");
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
=20
 =09=09error =3D fs_lookup_param(fc, param, 1, &path);
 =09=09if (error) {
-=09=09=09ext4_msg(sb, KERN_ERR, "error: could not find "
+=09=09=09ext4_msg(NULL, KERN_ERR, "error: could not find "
 =09=09=09=09"journal device path");
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
=20
 =09=09journal_inode =3D d_inode(path.dentry);
@@ -2086,29 +2087,29 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09path_put(&path);
 =09} else if (token =3D=3D Opt_journal_ioprio) {
 =09=09if (result.uint_32 > 7) {
-=09=09=09ext4_msg(sb, KERN_ERR, "Invalid journal IO priority"
+=09=09=09ext4_msg(NULL, KERN_ERR, "Invalid journal IO priority"
 =09=09=09=09 " (must be 0-7)");
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09ctx->journal_ioprio =3D
 =09=09=09IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
 =09} else if (token =3D=3D Opt_test_dummy_encryption) {
 #ifdef CONFIG_FS_ENCRYPTION
 =09=09sbi->s_mount_flags |=3D EXT4_MF_TEST_DUMMY_ENCRYPTION;
-=09=09ext4_msg(sb, KERN_WARNING,
+=09=09ext4_msg(NULL, KERN_WARNING,
 =09=09=09 "Test dummy encryption mode enabled");
 #else
-=09=09ext4_msg(sb, KERN_WARNING,
+=09=09ext4_msg(NULL, KERN_WARNING,
 =09=09=09 "Test dummy encryption mount option ignored");
 #endif
 =09} else if (m->flags & MOPT_DATAJ) {
 =09=09if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
 =09=09=09if (!sbi->s_journal)
-=09=09=09=09ext4_msg(sb, KERN_WARNING, "Remounting file system with no jou=
rnal so ignoring journalled data option");
+=09=09=09=09ext4_msg(NULL, KERN_WARNING, "Remounting file system with no j=
ournal so ignoring journalled data option");
 =09=09=09else if (test_opt(sb, DATA_FLAGS) !=3D m->mount_opt) {
-=09=09=09=09ext4_msg(sb, KERN_ERR,
+=09=09=09=09ext4_msg(NULL, KERN_ERR,
 =09=09=09=09=09 "Cannot change data mode on remount");
-=09=09=09=09return -1;
+=09=09=09=09return -EINVAL;
 =09=09=09}
 =09=09} else {
 =09=09=09clear_opt(sb, DATA_FLAGS);
@@ -2118,26 +2119,26 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09} else if (m->flags & MOPT_QFMT) {
 =09=09if (sb_any_quota_loaded(sb) &&
 =09=09    sbi->s_jquota_fmt !=3D m->mount_opt) {
-=09=09=09ext4_msg(sb, KERN_ERR, "Cannot change journaled "
+=09=09=09ext4_msg(NULL, KERN_ERR, "Cannot change journaled "
 =09=09=09=09 "quota options when quota turned on");
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09if (ext4_has_feature_quota(sb)) {
-=09=09=09ext4_msg(sb, KERN_INFO,
+=09=09=09ext4_msg(NULL, KERN_INFO,
 =09=09=09=09 "Quota format mount options ignored "
 =09=09=09=09 "when QUOTA feature is enabled");
-=09=09=09return 1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09sbi->s_jquota_fmt =3D m->mount_opt;
 #endif
 =09} else if (token =3D=3D Opt_dax) {
 #ifdef CONFIG_FS_DAX
-=09=09ext4_msg(sb, KERN_WARNING,
+=09=09ext4_msg(NULL, KERN_WARNING,
 =09=09"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 =09=09sbi->s_mount_opt |=3D m->mount_opt;
 #else
-=09=09ext4_msg(sb, KERN_INFO, "dax option not supported");
-=09=09return -1;
+=09=09ext4_msg(NULL, KERN_INFO, "dax option not supported");
+=09=09return -EINVAL;
 #endif
 =09} else if (token =3D=3D Opt_data_err_abort) {
 =09=09sbi->s_mount_opt |=3D m->mount_opt;
@@ -2153,11 +2154,11 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09=09if (m->flags & MOPT_CLEAR)
 =09=09=09set =3D !set;
 =09=09else if (unlikely(!(m->flags & MOPT_SET))) {
-=09=09=09ext4_msg(sb, KERN_WARNING,
+=09=09=09ext4_msg(NULL, KERN_WARNING,
 =09=09=09=09 "buggy handling of option %s",
 =09=09=09=09 param->key);
 =09=09=09WARN_ON(1);
-=09=09=09return -1;
+=09=09=09return -EINVAL;
 =09=09}
 =09=09if (set)
 =09=09=09sbi->s_mount_opt |=3D m->mount_opt;
@@ -2226,12 +2227,17 @@ static int parse_options(char *options, struct supe=
r_block *sb,
 =09if (journal_ioprio)
 =09=09*journal_ioprio =3D ctx.journal_ioprio;
=20
-=09return ext4_validate_options(sb);
+=09ret =3D ext4_validate_options(&fc);
+=09if (ret < 0)
+=09=09return 0;
+
+=09return 1;
 }
=20
-static int ext4_validate_options(struct super_block *sb)
+static int ext4_validate_options(struct fs_context *fc)
 {
-=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+=09struct ext4_sb_info *sbi =3D fc->s_fs_info;
+=09struct super_block *sb =3D sbi->s_sb;
 #ifdef CONFIG_QUOTA
 =09char *usr_qf_name, *grp_qf_name;
 =09/*
@@ -2240,9 +2246,9 @@ static int ext4_validate_options(struct super_block *=
sb)
 =09 * to support legacy quotas in quota files.
 =09 */
 =09if (test_opt(sb, PRJQUOTA) && !ext4_has_feature_project(sb)) {
-=09=09ext4_msg(sb, KERN_ERR, "Project quota feature not enabled. "
+=09=09ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
 =09=09=09 "Cannot enable project quota enforcement.");
-=09=09return 0;
+=09=09return -EINVAL;
 =09}
 =09usr_qf_name =3D get_qf_name(sb, sbi, USRQUOTA);
 =09grp_qf_name =3D get_qf_name(sb, sbi, GRPQUOTA);
@@ -2254,15 +2260,15 @@ static int ext4_validate_options(struct super_block=
 *sb)
 =09=09=09clear_opt(sb, GRPQUOTA);
=20
 =09=09if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
-=09=09=09ext4_msg(sb, KERN_ERR, "old and new quota "
+=09=09=09ext4_msg(NULL, KERN_ERR, "old and new quota "
 =09=09=09=09=09"format mixing");
-=09=09=09return 0;
+=09=09=09return -EINVAL;
 =09=09}
=20
 =09=09if (!sbi->s_jquota_fmt) {
-=09=09=09ext4_msg(sb, KERN_ERR, "journaled quota format "
+=09=09=09ext4_msg(NULL, KERN_ERR, "journaled quota format "
 =09=09=09=09=09"not specified");
-=09=09=09return 0;
+=09=09=09return -EINVAL;
 =09=09}
 =09}
 #endif
@@ -2271,12 +2277,12 @@ static int ext4_validate_options(struct super_block=
 *sb)
 =09=09=09BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
=20
 =09=09if (blocksize < PAGE_SIZE) {
-=09=09=09ext4_msg(sb, KERN_ERR, "can't mount with "
+=09=09=09ext4_msg(NULL, KERN_ERR, "can't mount with "
 =09=09=09=09 "dioread_nolock if block size !=3D PAGE_SIZE");
-=09=09=09return 0;
+=09=09=09return -EINVAL;
 =09=09}
 =09}
-=09return 1;
+=09return 0;
 }
=20
 static inline void ext4_show_quota_options(struct seq_file *seq,
--=20
2.21.0

