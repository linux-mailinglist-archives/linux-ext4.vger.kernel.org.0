Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11F11BC5A7
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgD1QqS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23463 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728500AbgD1QqS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJKjeme0Kq2Ax2PSkLsT4+Ro7QzJoN9gxUnRYu5Osok=;
        b=cK7eX885FiEhgQbHanXiZck87hYInLPMcbTSGwBm7jryoEhDhSYsgh+k41aCdUOJVSw+Uo
        tbBvve/f8fiKBq77LGdPPDhfJ+8VbsO2mKOsxuWCkaDPAz3HDFJHCuk76GWHPzH+n6Zg+i
        lu1QeneKxMp/6Y8K1Rk2TJMuSBA+C5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-MDfeLic1M22dRMWpe6OEDg-1; Tue, 28 Apr 2020 12:46:11 -0400
X-MC-Unique: MDfeLic1M22dRMWpe6OEDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0071835B41;
        Tue, 28 Apr 2020 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0DE01002388;
        Tue, 28 Apr 2020 16:46:09 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 17/17] ext4: Remove unused code from old mount api
Date:   Tue, 28 Apr 2020 18:45:36 +0200
Message-Id: <20200428164536.462-18-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Additionally rename ext4_fill_super_fc to ext4_fill_super

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 232 +-----------------------------------------------
 1 file changed, 3 insertions(+), 229 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d52abb87ff80..0f8ef3423e3a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -74,12 +74,9 @@ static void ext4_mark_recovery_complete(struct super_b=
lock *sb,
 static void ext4_clear_journal_err(struct super_block *sb,
 				   struct ext4_super_block *es);
 static int ext4_sync_fs(struct super_block *sb, int wait);
-static int ext4_remount(struct super_block *sb, int *flags, char *data);
 static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int ext4_unfreeze(struct super_block *sb);
 static int ext4_freeze(struct super_block *sb);
-static struct dentry *ext4_mount(struct file_system_type *fs_type, int f=
lags,
-		       const char *dev_name, void *data);
 static inline int ext2_feature_set_ok(struct super_block *sb);
 static inline int ext3_feature_set_ok(struct super_block *sb);
 static int ext4_feature_set_ok(struct super_block *sb, int readonly);
@@ -1531,7 +1528,7 @@ enum {
 	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
-	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
+	Opt_usrjquota, Opt_grpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
 	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version, Opt_dax,
@@ -1674,99 +1671,6 @@ static const struct fs_parameter_spec ext4_param_s=
pecs[] =3D {
 	{}
 };
=20
-static const match_table_t tokens =3D {
-	{Opt_bsd_df, "bsddf"},
-	{Opt_minix_df, "minixdf"},
-	{Opt_grpid, "grpid"},
-	{Opt_grpid, "bsdgroups"},
-	{Opt_nogrpid, "nogrpid"},
-	{Opt_nogrpid, "sysvgroups"},
-	{Opt_resgid, "resgid=3D%u"},
-	{Opt_resuid, "resuid=3D%u"},
-	{Opt_sb, "sb=3D%u"},
-	{Opt_err_cont, "errors=3Dcontinue"},
-	{Opt_err_panic, "errors=3Dpanic"},
-	{Opt_err_ro, "errors=3Dremount-ro"},
-	{Opt_nouid32, "nouid32"},
-	{Opt_debug, "debug"},
-	{Opt_removed, "oldalloc"},
-	{Opt_removed, "orlov"},
-	{Opt_user_xattr, "user_xattr"},
-	{Opt_nouser_xattr, "nouser_xattr"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_noload, "norecovery"},
-	{Opt_noload, "noload"},
-	{Opt_removed, "nobh"},
-	{Opt_removed, "bh"},
-	{Opt_commit, "commit=3D%u"},
-	{Opt_min_batch_time, "min_batch_time=3D%u"},
-	{Opt_max_batch_time, "max_batch_time=3D%u"},
-	{Opt_journal_dev, "journal_dev=3D%u"},
-	{Opt_journal_path, "journal_path=3D%s"},
-	{Opt_journal_checksum, "journal_checksum"},
-	{Opt_nojournal_checksum, "nojournal_checksum"},
-	{Opt_journal_async_commit, "journal_async_commit"},
-	{Opt_abort, "abort"},
-	{Opt_data_journal, "data=3Djournal"},
-	{Opt_data_ordered, "data=3Dordered"},
-	{Opt_data_writeback, "data=3Dwriteback"},
-	{Opt_data_err_abort, "data_err=3Dabort"},
-	{Opt_data_err_ignore, "data_err=3Dignore"},
-	{Opt_offusrjquota, "usrjquota=3D"},
-	{Opt_usrjquota, "usrjquota=3D%s"},
-	{Opt_offgrpjquota, "grpjquota=3D"},
-	{Opt_grpjquota, "grpjquota=3D%s"},
-	{Opt_jqfmt_vfsold, "jqfmt=3Dvfsold"},
-	{Opt_jqfmt_vfsv0, "jqfmt=3Dvfsv0"},
-	{Opt_jqfmt_vfsv1, "jqfmt=3Dvfsv1"},
-	{Opt_grpquota, "grpquota"},
-	{Opt_noquota, "noquota"},
-	{Opt_quota, "quota"},
-	{Opt_usrquota, "usrquota"},
-	{Opt_prjquota, "prjquota"},
-	{Opt_barrier, "barrier=3D%u"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_i_version, "i_version"},
-	{Opt_dax, "dax"},
-	{Opt_stripe, "stripe=3D%u"},
-	{Opt_delalloc, "delalloc"},
-	{Opt_warn_on_error, "warn_on_error"},
-	{Opt_nowarn_on_error, "nowarn_on_error"},
-	{Opt_lazytime, "lazytime"},
-	{Opt_nolazytime, "nolazytime"},
-	{Opt_debug_want_extra_isize, "debug_want_extra_isize=3D%u"},
-	{Opt_nodelalloc, "nodelalloc"},
-	{Opt_removed, "mblk_io_submit"},
-	{Opt_removed, "nomblk_io_submit"},
-	{Opt_block_validity, "block_validity"},
-	{Opt_noblock_validity, "noblock_validity"},
-	{Opt_inode_readahead_blks, "inode_readahead_blks=3D%u"},
-	{Opt_journal_ioprio, "journal_ioprio=3D%u"},
-	{Opt_auto_da_alloc, "auto_da_alloc=3D%u"},
-	{Opt_auto_da_alloc, "auto_da_alloc"},
-	{Opt_noauto_da_alloc, "noauto_da_alloc"},
-	{Opt_dioread_nolock, "dioread_nolock"},
-	{Opt_dioread_lock, "nodioread_nolock"},
-	{Opt_dioread_lock, "dioread_lock"},
-	{Opt_discard, "discard"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_init_itable, "init_itable=3D%u"},
-	{Opt_init_itable, "init_itable"},
-	{Opt_noinit_itable, "noinit_itable"},
-	{Opt_max_dir_size_kb, "max_dir_size_kb=3D%u"},
-	{Opt_test_dummy_encryption, "test_dummy_encryption"},
-	{Opt_nombcache, "nombcache"},
-	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
-	{Opt_removed, "check=3Dnone"},	/* mount option from ext2/3 */
-	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
-	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
-	{Opt_removed, "noreservation"}, /* mount option from ext2/3 */
-	{Opt_removed, "journal=3D%u"},	/* mount option from ext2/3 */
-	{Opt_err, NULL},
-};
-
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 static const char deprecated_msg[] =3D
 	"Mount option \"%s\" will be removed by %s\n"
@@ -1875,8 +1779,6 @@ static const struct mount_opts {
 							MOPT_CLEAR | MOPT_Q},
 	{Opt_usrjquota, 0, MOPT_Q},
 	{Opt_grpjquota, 0, MOPT_Q},
-	{Opt_offusrjquota, 0, MOPT_Q},
-	{Opt_offgrpjquota, 0, MOPT_Q},
 	{Opt_jqfmt_vfsold, QFMT_VFS_OLD, MOPT_QFMT},
 	{Opt_jqfmt_vfsv0, QFMT_VFS_V0, MOPT_QFMT},
 	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
@@ -5296,87 +5198,7 @@ static int __ext4_fill_super(struct fs_context *fc=
, struct super_block *sb,
 	return err ? err : ret;
 }
=20
-static void cleanup_ctx(struct ext4_fs_context *ctx)
-{
-	int i;
-
-	if (!ctx)
-		return;
-
-	for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
-		kfree(ctx->s_qf_names[i]);
-	}
-}
-
-static int ext4_fill_super(struct super_block *sb, void *data, int silen=
t)
-{
-	struct ext4_fs_context ctx;
-	struct ext4_sb_info *sbi;
-	struct fs_context fc;
-	const char *descr;
-	char *orig_data;
-	int ret =3D -ENOMEM;
-
-	orig_data =3D kstrdup(data, GFP_KERNEL);
-	if (data && !orig_data)
-		return -ENOMEM;
-
-	/* Cleanup superblock name */
-	strreplace(sb->s_id, '/', '!');
-
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-	fc.fs_private =3D &ctx;
-
-	ret =3D parse_options(&fc, (char *) data);
-	if (ret < 0)
-		goto free_data;
-
-	sbi =3D ext4_alloc_sbi(sb);
-	if (!sbi) {
-		ret =3D -ENOMEM;
-		goto free_data;
-	}
-
-	fc.s_fs_info =3D sbi;
-
-	sbi->s_sb_block =3D 1;	/* Default super block location */
-	if (ctx.spec & EXT4_SPEC_s_sb_block)
-		sbi->s_sb_block =3D ctx.s_sb_block;
-
-	ret =3D __ext4_fill_super(&fc, sb, silent);
-	if (ret < 0)
-		goto free_sbi;
-
-	if (EXT4_SB(sb)->s_journal) {
-		if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_JOURNAL_DATA)
-			descr =3D " journalled data mode";
-		else if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_ORDERED_DATA)
-			descr =3D " ordered data mode";
-		else
-			descr =3D " writeback data mode";
-	} else
-		descr =3D "out journal";
-
-	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
-		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-			 "Opts: %.*s%s%s", descr,
-			 (int) sizeof(sbi->s_es->s_mount_opts),
-			 sbi->s_es->s_mount_opts,
-			 *sbi->s_es->s_mount_opts ? "; " : "", (char *)orig_data);
-
-	kfree(orig_data);
-	cleanup_ctx(&ctx);
-	return 0;
-free_sbi:
-	ext4_free_sbi(sbi);
-free_data:
-	kfree(orig_data);
-	cleanup_ctx(&ctx);
-	return ret;
-}
-
-static int ext4_fill_super_fc(struct super_block *sb, struct fs_context =
*fc)
+static int ext4_fill_super(struct super_block *sb, struct fs_context *fc=
)
 {
 	struct ext4_fs_context *ctx =3D fc->fs_private;
 	struct ext4_sb_info *sbi;
@@ -5409,7 +5231,7 @@ static int ext4_fill_super_fc(struct super_block *s=
b, struct fs_context *fc)
=20
 static int ext4_get_tree(struct fs_context *fc)
 {
-	return get_tree_bdev(fc, ext4_fill_super_fc);
+	return get_tree_bdev(fc, ext4_fill_super);
 }
=20
 /*
@@ -6229,48 +6051,6 @@ static int __ext4_remount(struct fs_context *fc, s=
truct super_block *sb,
 	return err;
 }
=20
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
-{
-	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-	struct ext4_fs_context ctx;
-	struct fs_context fc;
-	char *orig_data;
-	int ret;
-
-	orig_data =3D kstrdup(data, GFP_KERNEL);
-	if (data && !orig_data)
-		return -ENOMEM;
-
-	memset(&fc, 0, sizeof(fc));
-	memset(&ctx, 0, sizeof(ctx));
-
-	fc.fs_private =3D &ctx;
-	fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
-	fc.s_fs_info =3D sbi;
-
-	ret =3D parse_options(&fc, (char *) data);
-	if (ret < 0)
-		goto err_out;
-
-	ret =3D ext4_check_opt_consistency(&fc, sb);
-	if (ret < 0)
-		goto err_out;
-
-	ret =3D __ext4_remount(&fc, sb, flags);
-	if (ret < 0)
-		goto err_out;
-
-	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
-	cleanup_ctx(&ctx);
-	kfree(orig_data);
-	return 0;
-
-err_out:
-	cleanup_ctx(&ctx);
-	kfree(orig_data);
-	return ret;
-}
-
 static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb =3D fc->root->d_sb;
@@ -6780,12 +6560,6 @@ static ssize_t ext4_quota_write(struct super_block=
 *sb, int type,
 }
 #endif
=20
-static struct dentry *ext4_mount(struct file_system_type *fs_type, int f=
lags,
-		       const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, ext4_fill_super);
-}
-
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defin=
ed(CONFIG_EXT4_USE_FOR_EXT2)
 static inline void register_as_ext2(void)
 {
--=20
2.21.1

