Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB57336A4
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjFPQwT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbjFPQv0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128BB3AB1
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C04C1F8D4;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d22D1YQKRs5vF98OC1dT9k0P2nhfA4PW+E4J5qNBQ2U=;
        b=3Ac1HRncZlshq5551rCCl2wXdglSZQLmrFyyV/RQGpZWqMFxM91FmFXbKh52ntiw13ofpn
        T+NoRnSgHwnwDphgB2eereM5OLqkcioYHZaYV0rBLI4lPc3R8URVamiGdR1E8gixRdPoyr
        +3XtKOiEInmj2BUdLZ6f+rG9ONryFN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d22D1YQKRs5vF98OC1dT9k0P2nhfA4PW+E4J5qNBQ2U=;
        b=ZRYsVhUQJ3mbRhsMPFX9SbNgwHDt/+Um2r6ZHPjIqqH5We/blPbNwE5lztKciU8zX4X2rk
        lEZq5ar2t7QeWfAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2505113A74;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id csAJCf6SjGQuIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 81CD0A0763; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/11] ext4: Make 'abort' mount option handling standard
Date:   Fri, 16 Jun 2023 18:50:50 +0200
Message-Id: <20230616165109.21695-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3229; i=jack@suse.cz; h=from:subject; bh=6PQFT+6FwtVEHQ/skFJ/Pull9WIBZnDXdy0ZyPut6sU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLq8ejWG5UbD7xzbpDGpk87kVMlDOmFoevQt7Jr DUe/yV6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS6gAKCRCcnaoHP2RA2YH2CA CsIWAxK8NNfW3lEknq+0AS5KkFucjsHLAlnixA+PN6HYA2iurvhbBBgiR40SMfqwIKleoMGIDAHves GEKx0MOrZqI+9/y6yoWwaoTDogijC3BummydzbWxbnVBrq/YFUCnLzNRuMZeiWvU+kNQJRlGnrnfi8 rKTKlsQLakCiLaf//LywrmBfbq5+jmZsJFC364gH1WzPyasiDKWPTMcVKjEwnjuDOyaCujxdR0xr9h imhyNd8YLseFzEO/W++zQNzdsRkhzSnlLScjNygLWg54rEvz9GjZpA/aD1VdqRDUYuhKF90z8MH1Db bvxm9noy5oUt9amp94xAz8tFsl1+jD
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

'abort' mount option is the only mount option that has special handling
and sets a bit in sbi->s_mount_flags. There is not strong reason for
that so just simplify the code and make 'abort' set a bit in
sbi->s_mount_opt2 as any other mount option. This simplifies the code
and will allow us to drop EXT4_MF_FS_ABORTED completely in the following
patch.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 16 ++--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f0b6aa79dcc4..ae0c3a148c7b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1180,6 +1180,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
 						    * scanning in mballoc
 						    */
+#define EXT4_MOUNT2_ABORT		0x00000100 /* Abort filesystem */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d4978e705718..d57b135c8e54 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1886,6 +1886,7 @@ static const struct mount_opts {
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 #endif
+	{Opt_abort, EXT4_MOUNT2_ABORT, MOPT_SET | MOPT_2},
 	{Opt_err, 0, 0}
 };
 
@@ -1954,8 +1955,6 @@ struct ext4_fs_context {
 	unsigned int	mask_s_mount_opt;
 	unsigned int	vals_s_mount_opt2;
 	unsigned int	mask_s_mount_opt2;
-	unsigned long	vals_s_mount_flags;
-	unsigned long	mask_s_mount_flags;
 	unsigned int	opt_flags;	/* MOPT flags */
 	unsigned int	spec;
 	u32		s_max_batch_time;
@@ -2106,12 +2105,6 @@ EXT4_SET_CTX(mount_opt2);
 EXT4_CLEAR_CTX(mount_opt2);
 EXT4_TEST_CTX(mount_opt2);
 
-static inline void ctx_set_mount_flag(struct ext4_fs_context *ctx, int bit)
-{
-	set_bit(bit, &ctx->mask_s_mount_flags);
-	set_bit(bit, &ctx->vals_s_mount_flags);
-}
-
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
@@ -2175,9 +2168,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
 		return 0;
-	case Opt_abort:
-		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
-		return 0;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 		ctx_set_flags(ctx, SB_INLINECRYPT);
@@ -2831,8 +2821,6 @@ static void ext4_apply_options(struct fs_context *fc, struct super_block *sb)
 	sbi->s_mount_opt |= ctx->vals_s_mount_opt;
 	sbi->s_mount_opt2 &= ~ctx->mask_s_mount_opt2;
 	sbi->s_mount_opt2 |= ctx->vals_s_mount_opt2;
-	sbi->s_mount_flags &= ~ctx->mask_s_mount_flags;
-	sbi->s_mount_flags |= ctx->vals_s_mount_flags;
 	sb->s_flags &= ~ctx->mask_s_flags;
 	sb->s_flags |= ctx->vals_s_flags;
 
@@ -6460,7 +6448,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 		goto restore_opts;
 	}
 
-	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
+	if (test_opt2(sb, ABORT))
 		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
-- 
2.35.3

