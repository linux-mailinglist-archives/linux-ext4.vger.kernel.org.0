Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141F4F13AC
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfKFKPq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731379AbfKFKPq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBeQ/IxvggVy1xGDyVaGEZfmCKKt15+23G8Z2Y9/iGM=;
        b=XRRHYRFQ4TkJhE36l+kDi56b/pW4DNK0LoClbUXfPER2n/s1fax6rsP3HQaKLlrYDCBZBX
        2OU2tVS0x0XZ/2xWr7HSid9ysrUld+hveWjqo1bDRsQCJ5tXXIdkqHIwKRloKyOSYK5sOM
        8S2q5vu+37W5E/4GiVov/7h1d9e90yA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-MQZimjPuMdKt-P8bejtRoA-1; Wed, 06 Nov 2019 05:15:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FEBE1800D63;
        Wed,  6 Nov 2019 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B20A19756;
        Wed,  6 Nov 2019 10:15:42 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 17/17] ext4: Remove unused code from old mount api
Date:   Wed,  6 Nov 2019 11:14:57 +0100
Message-Id: <20191106101457.11237-18-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: MQZimjPuMdKt-P8bejtRoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Additionally rename ext4_fill_super_fc to ext4_fill_super

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 227 +-----------------------------------------------
 1 file changed, 2 insertions(+), 225 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2f3296e81837..ae7ee4a2c9b6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -74,12 +74,9 @@ static void ext4_mark_recovery_complete(struct super_blo=
ck *sb,
 static void ext4_clear_journal_err(struct super_block *sb,
 =09=09=09=09   struct ext4_super_block *es);
 static int ext4_sync_fs(struct super_block *sb, int wait);
-static int ext4_remount(struct super_block *sb, int *flags, char *data);
 static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int ext4_unfreeze(struct super_block *sb);
 static int ext4_freeze(struct super_block *sb);
-static struct dentry *ext4_mount(struct file_system_type *fs_type, int fla=
gs,
-=09=09       const char *dev_name, void *data);
 static inline int ext2_feature_set_ok(struct super_block *sb);
 static inline int ext3_feature_set_ok(struct super_block *sb);
 static int ext4_feature_set_ok(struct super_block *sb, int readonly);
@@ -1589,98 +1586,6 @@ static const struct fs_parameter_description ext4_fs=
_parameters =3D {
 =09.enums=09=09=3D ext4_param_enums,
 };
=20
-static const match_table_t tokens =3D {
-=09{Opt_bsd_df, "bsddf"},
-=09{Opt_minix_df, "minixdf"},
-=09{Opt_grpid, "grpid"},
-=09{Opt_grpid, "bsdgroups"},
-=09{Opt_nogrpid, "nogrpid"},
-=09{Opt_nogrpid, "sysvgroups"},
-=09{Opt_resgid, "resgid=3D%u"},
-=09{Opt_resuid, "resuid=3D%u"},
-=09{Opt_sb, "sb=3D%u"},
-=09{Opt_err_cont, "errors=3Dcontinue"},
-=09{Opt_err_panic, "errors=3Dpanic"},
-=09{Opt_err_ro, "errors=3Dremount-ro"},
-=09{Opt_nouid32, "nouid32"},
-=09{Opt_debug, "debug"},
-=09{Opt_removed, "oldalloc"},
-=09{Opt_removed, "orlov"},
-=09{Opt_user_xattr, "user_xattr"},
-=09{Opt_nouser_xattr, "nouser_xattr"},
-=09{Opt_acl, "acl"},
-=09{Opt_noacl, "noacl"},
-=09{Opt_noload, "norecovery"},
-=09{Opt_noload, "noload"},
-=09{Opt_removed, "nobh"},
-=09{Opt_removed, "bh"},
-=09{Opt_commit, "commit=3D%u"},
-=09{Opt_min_batch_time, "min_batch_time=3D%u"},
-=09{Opt_max_batch_time, "max_batch_time=3D%u"},
-=09{Opt_journal_dev, "journal_dev=3D%u"},
-=09{Opt_journal_path, "journal_path=3D%s"},
-=09{Opt_journal_checksum, "journal_checksum"},
-=09{Opt_nojournal_checksum, "nojournal_checksum"},
-=09{Opt_journal_async_commit, "journal_async_commit"},
-=09{Opt_abort, "abort"},
-=09{Opt_data_journal, "data=3Djournal"},
-=09{Opt_data_ordered, "data=3Dordered"},
-=09{Opt_data_writeback, "data=3Dwriteback"},
-=09{Opt_data_err_abort, "data_err=3Dabort"},
-=09{Opt_data_err_ignore, "data_err=3Dignore"},
-=09{Opt_offusrjquota, "usrjquota=3D"},
-=09{Opt_usrjquota, "usrjquota=3D%s"},
-=09{Opt_offgrpjquota, "grpjquota=3D"},
-=09{Opt_grpjquota, "grpjquota=3D%s"},
-=09{Opt_jqfmt_vfsold, "jqfmt=3Dvfsold"},
-=09{Opt_jqfmt_vfsv0, "jqfmt=3Dvfsv0"},
-=09{Opt_jqfmt_vfsv1, "jqfmt=3Dvfsv1"},
-=09{Opt_grpquota, "grpquota"},
-=09{Opt_noquota, "noquota"},
-=09{Opt_quota, "quota"},
-=09{Opt_usrquota, "usrquota"},
-=09{Opt_prjquota, "prjquota"},
-=09{Opt_barrier, "barrier=3D%u"},
-=09{Opt_barrier, "barrier"},
-=09{Opt_nobarrier, "nobarrier"},
-=09{Opt_i_version, "i_version"},
-=09{Opt_dax, "dax"},
-=09{Opt_stripe, "stripe=3D%u"},
-=09{Opt_delalloc, "delalloc"},
-=09{Opt_warn_on_error, "warn_on_error"},
-=09{Opt_nowarn_on_error, "nowarn_on_error"},
-=09{Opt_lazytime, "lazytime"},
-=09{Opt_nolazytime, "nolazytime"},
-=09{Opt_debug_want_extra_isize, "debug_want_extra_isize=3D%u"},
-=09{Opt_nodelalloc, "nodelalloc"},
-=09{Opt_removed, "mblk_io_submit"},
-=09{Opt_removed, "nomblk_io_submit"},
-=09{Opt_block_validity, "block_validity"},
-=09{Opt_noblock_validity, "noblock_validity"},
-=09{Opt_inode_readahead_blks, "inode_readahead_blks=3D%u"},
-=09{Opt_journal_ioprio, "journal_ioprio=3D%u"},
-=09{Opt_auto_da_alloc, "auto_da_alloc=3D%u"},
-=09{Opt_auto_da_alloc, "auto_da_alloc"},
-=09{Opt_noauto_da_alloc, "noauto_da_alloc"},
-=09{Opt_dioread_nolock, "dioread_nolock"},
-=09{Opt_dioread_lock, "dioread_lock"},
-=09{Opt_discard, "discard"},
-=09{Opt_nodiscard, "nodiscard"},
-=09{Opt_init_itable, "init_itable=3D%u"},
-=09{Opt_init_itable, "init_itable"},
-=09{Opt_noinit_itable, "noinit_itable"},
-=09{Opt_max_dir_size_kb, "max_dir_size_kb=3D%u"},
-=09{Opt_test_dummy_encryption, "test_dummy_encryption"},
-=09{Opt_nombcache, "nombcache"},
-=09{Opt_nombcache, "no_mbcache"},=09/* for backward compatibility */
-=09{Opt_removed, "check=3Dnone"},=09/* mount option from ext2/3 */
-=09{Opt_removed, "nocheck"},=09/* mount option from ext2/3 */
-=09{Opt_removed, "reservation"},=09/* mount option from ext2/3 */
-=09{Opt_removed, "noreservation"}, /* mount option from ext2/3 */
-=09{Opt_removed, "journal=3D%u"},=09/* mount option from ext2/3 */
-=09{Opt_err, NULL},
-};
-
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 static const char deprecated_msg[] =3D
 =09"Mount option \"%s\" will be removed by %s\n"
@@ -5173,87 +5078,7 @@ static int __ext4_fill_super(struct fs_context *fc, =
struct super_block *sb,
 =09return err ? err : ret;
 }
=20
-static void cleanup_ctx(struct ext4_fs_context *ctx)
-{
-=09int i;
-
-=09if (!ctx)
-=09=09return;
-
-=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
-=09=09kfree(ctx->s_qf_names[i]);
-=09}
-}
-
-static int ext4_fill_super(struct super_block *sb, void *data, int silent)
-{
-=09struct ext4_fs_context ctx;
-=09struct ext4_sb_info *sbi;
-=09struct fs_context fc;
-=09const char *descr;
-=09char *orig_data;
-=09int ret =3D -ENOMEM;
-
-=09orig_data =3D kstrdup(data, GFP_KERNEL);
-=09if (data && !orig_data)
-=09=09return -ENOMEM;
-
-=09/* Cleanup superblock name */
-=09strreplace(sb->s_id, '/', '!');
-
-=09memset(&fc, 0, sizeof(fc));
-=09memset(&ctx, 0, sizeof(ctx));
-=09fc.fs_private =3D &ctx;
-
-=09ret =3D parse_options(&fc, (char *) data);
-=09if (ret < 0)
-=09=09goto free_data;
-
-=09sbi =3D ext4_alloc_sbi(sb);
-=09if (!sbi) {
-=09=09ret =3D -ENOMEM;
-=09=09goto free_data;
-=09}
-
-=09fc.s_fs_info =3D sbi;
-
-=09sbi->s_sb_block =3D 1;=09/* Default super block location */
-=09if (ctx.spec & EXT4_SPEC_s_sb_block)
-=09=09sbi->s_sb_block =3D ctx.s_sb_block;
-
-=09ret =3D __ext4_fill_super(&fc, sb, silent);
-=09if (ret < 0)
-=09=09goto free_sbi;
-
-=09if (EXT4_SB(sb)->s_journal) {
-=09=09if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_JOURNAL_DATA)
-=09=09=09descr =3D " journalled data mode";
-=09=09else if (test_opt(sb, DATA_FLAGS) =3D=3D EXT4_MOUNT_ORDERED_DATA)
-=09=09=09descr =3D " ordered data mode";
-=09=09else
-=09=09=09descr =3D " writeback data mode";
-=09} else
-=09=09descr =3D "out journal";
-
-=09if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
-=09=09ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-=09=09=09 "Opts: %.*s%s%s", descr,
-=09=09=09 (int) sizeof(sbi->s_es->s_mount_opts),
-=09=09=09 sbi->s_es->s_mount_opts,
-=09=09=09 *sbi->s_es->s_mount_opts ? "; " : "", (char *)orig_data);
-
-=09kfree(orig_data);
-=09cleanup_ctx(&ctx);
-=09return 0;
-free_sbi:
-=09ext4_free_sbi(sbi);
-free_data:
-=09kfree(orig_data);
-=09cleanup_ctx(&ctx);
-=09return ret;
-}
-
-static int ext4_fill_super_fc(struct super_block *sb, struct fs_context *f=
c)
+static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 =09struct ext4_fs_context *ctx =3D fc->fs_private;
 =09struct ext4_sb_info *sbi;
@@ -5286,7 +5111,7 @@ static int ext4_fill_super_fc(struct super_block *sb,=
 struct fs_context *fc)
=20
 static int ext4_get_tree(struct fs_context *fc)
 {
-=09return get_tree_bdev(fc, ext4_fill_super_fc);
+=09return get_tree_bdev(fc, ext4_fill_super);
 }
=20
 /*
@@ -6107,48 +5932,6 @@ static int __ext4_remount(struct fs_context *fc, str=
uct super_block *sb,
 =09return err;
 }
=20
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
-{
-=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-=09struct ext4_fs_context ctx;
-=09struct fs_context fc;
-=09char *orig_data;
-=09int ret;
-
-=09orig_data =3D kstrdup(data, GFP_KERNEL);
-=09if (data && !orig_data)
-=09=09return -ENOMEM;
-
-=09memset(&fc, 0, sizeof(fc));
-=09memset(&ctx, 0, sizeof(ctx));
-
-=09fc.fs_private =3D &ctx;
-=09fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
-=09fc.s_fs_info =3D sbi;
-
-=09ret =3D parse_options(&fc, (char *) data);
-=09if (ret < 0)
-=09=09goto err_out;
-
-=09ret =3D ext4_check_opt_consistency(&fc, sb);
-=09if (ret < 0)
-=09=09goto err_out;
-
-=09ret =3D __ext4_remount(&fc, sb, flags);
-=09if (ret < 0)
-=09=09goto err_out;
-
-=09ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
-=09cleanup_ctx(&ctx);
-=09kfree(orig_data);
-=09return 0;
-
-err_out:
-=09cleanup_ctx(&ctx);
-=09kfree(orig_data);
-=09return ret;
-}
-
 static int ext4_reconfigure(struct fs_context *fc)
 {
 =09struct super_block *sb =3D fc->root->d_sb;
@@ -6670,12 +6453,6 @@ static int ext4_get_next_id(struct super_block *sb, =
struct kqid *qid)
 }
 #endif
=20
-static struct dentry *ext4_mount(struct file_system_type *fs_type, int fla=
gs,
-=09=09       const char *dev_name, void *data)
-{
-=09return mount_bdev(fs_type, flags, dev_name, data, ext4_fill_super);
-}
-
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined=
(CONFIG_EXT4_USE_FOR_EXT2)
 static inline void register_as_ext2(void)
 {
--=20
2.21.0

