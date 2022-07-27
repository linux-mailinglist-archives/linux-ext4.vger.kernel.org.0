Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D335828CB
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 16:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiG0Ohj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiG0Ohi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 10:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4C23BC9
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 07:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49F8D61864
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 14:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD060C433C1;
        Wed, 27 Jul 2022 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658932656;
        bh=q7w6l9FguXNy6hf2z+TzlsPRBbQy5amuvy2i43X0O7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=c1eLpicwBn/hMLHd0vsjJZAbwNEoS5HCbfBBM+P573LLqUZpVWnyLCqom4dh0EB6h
         c5QwG3Ab85397RJ2WifPbILh4TeZWaB9WfIJkaS0XLM60UtQxiaUhrNVv562/ru7OO
         5gYNyofOZ91j6K8oGp+4Mlua2Kv27XorAdrNSbNdth+sRLldx5YAXJdqTNQR0hclg2
         joLxm5OeSfY0qZfbIdJA0l+HfDDmmYqGp5howXmz2m4JmHsF3j3bX2KzNHm4VRJg8J
         Fr/rAhh5SLOULKW50LdlUOBVL4Tm7ZEEFUqDOxkxPh0UkZXq2HWOkuAvdeJrmiSe1J
         Piz4FGAc0iR+A==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2] ext4: unconditionally enable the i_version counter
Date:   Wed, 27 Jul 2022 10:37:34 -0400
Message-Id: <20220727143734.71612-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The original i_version implementation was pretty expensive, requiring a
log flush on every change. Because of this, it was gated behind a mount
option (implemented via the MS_I_VERSION mountoption flag).

Commit ae5e165d855d (fs: new API for handling inode->i_version) made the
i_version flag much less expensive, so there is no longer a performance
penalty from enabling it. xfs and btrfs already enable it
unconditionally when the on-disk format can support it.

Have ext4 ignore the SB_I_VERSION flag, and just enable it
unconditionally. While we're in here, remove the handling of
Opt_i_version as well, since we're almost to 5.20 anyway.

Ideally, we'd couple this change with a way to disable the i_version
counter (just in case), but the way the iversion mount option was
implemented makes that difficult to do. We'd need to add a new mount
option altogether or do something with tune2fs. That's probably best
left to later patches if it turns out to be needed.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Lukas Czerner <lczerner@redhat.com>
Cc: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/inode.c |  5 ++---
 fs/ext4/super.c | 13 ++++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 84c0eb55071d..c785c0b72116 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5411,7 +5411,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			return -EINVAL;
 		}
 
-		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
+		if (attr->ia_size != inode->i_size)
 			inode_inc_iversion(inode);
 
 		if (shrink) {
@@ -5717,8 +5717,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 	}
 	ext4_fc_track_inode(handle, inode);
 
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
+	inode_inc_iversion(inode);
 
 	/* the do_update_inode consumes one bh->b_count */
 	get_bh(iloc->bh);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..4b06f394d7d1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1585,7 +1585,7 @@ enum {
 	Opt_inlinecrypt,
 	Opt_usrjquota, Opt_grpjquota, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
-	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
+	Opt_usrquota, Opt_grpquota, Opt_prjquota,
 	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
 	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
 	Opt_nowarn_on_error, Opt_mblk_io_submit, Opt_debug_want_extra_isize,
@@ -1694,7 +1694,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("barrier",		Opt_barrier),
 	fsparam_u32	("barrier",		Opt_barrier),
 	fsparam_flag	("nobarrier",		Opt_nobarrier),
-	fsparam_flag	("i_version",		Opt_i_version),
 	fsparam_flag	("dax",			Opt_dax),
 	fsparam_enum	("dax",			Opt_dax_type, ext4_param_dax),
 	fsparam_u32	("stripe",		Opt_stripe),
@@ -2140,11 +2139,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_abort:
 		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
 		return 0;
-	case Opt_i_version:
-		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");
-		ext4_msg(NULL, KERN_WARNING, "Use iversion instead\n");
-		ctx_set_flags(ctx, SB_I_VERSION);
-		return 0;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 		ctx_set_flags(ctx, SB_INLINECRYPT);
@@ -2970,8 +2964,6 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PRINT("min_batch_time=%u", sbi->s_min_batch_time);
 	if (nodefs || sbi->s_max_batch_time != EXT4_DEF_MAX_BATCH_TIME)
 		SEQ_OPTS_PRINT("max_batch_time=%u", sbi->s_max_batch_time);
-	if (sb->s_flags & SB_I_VERSION)
-		SEQ_OPTS_PUTS("i_version");
 	if (nodefs || sbi->s_stripe)
 		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
 	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
@@ -4630,6 +4622,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
+	/* i_version is always enabled now */
+	sb->s_flags |= SB_I_VERSION;
+
 	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV &&
 	    (ext4_has_compat_features(sb) ||
 	     ext4_has_ro_compat_features(sb) ||
-- 
2.37.1

