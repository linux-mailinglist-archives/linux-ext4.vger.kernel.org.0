Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11E47D038
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Dec 2021 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbhLVKp2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 05:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240018AbhLVKp2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Dec 2021 05:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640169927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gszH25NrjRBHFOo76ObB6AvioB2IT34MO5pT6R2OYgY=;
        b=XGsJVk/QG7vGZdyq/iu3Z367hAUqxRNDMM+wpdl5K5tmkraoNgSaFYd11MjliekJeaROz7
        y5kcX16/BCYPerOuGeGlreTea5Ep2XY58eu/piLbRCB2oQ7548t5mWTbOW9jbcD5WAioOF
        oYR+uZBjyfJRJ2WE/7EwjDxCGWUi0ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-VTOoIJdoOMWNSJ4ZcIv0NQ-1; Wed, 22 Dec 2021 05:45:26 -0500
X-MC-Unique: VTOoIJdoOMWNSJ4ZcIv0NQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685021808327;
        Wed, 22 Dec 2021 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FFB676613;
        Wed, 22 Dec 2021 10:45:24 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: [PATCH 1/2] ext4: remove lazytime/nolazytime mount options handled by MS_LAZYTIME
Date:   Wed, 22 Dec 2021 11:45:16 +0100
Message-Id: <20211222104517.11187-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The lazytime and nolazytime mount options were added temporarily back in
2015 with commit a26f49926da9 ("ext4: add optimization for the lazytime
mount option"). It think it has been enough time for the util-linux with
lazytime support to get widely used. Remove the mount options.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 71f7f866de58..0fc511d16b6d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1703,8 +1703,7 @@ enum {
 	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
 	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
 	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
-	Opt_nowarn_on_error, Opt_mblk_io_submit,
-	Opt_lazytime, Opt_nolazytime, Opt_debug_want_extra_isize,
+	Opt_nowarn_on_error, Opt_mblk_io_submit, Opt_debug_want_extra_isize,
 	Opt_nomblk_io_submit, Opt_block_validity, Opt_noblock_validity,
 	Opt_inode_readahead_blks, Opt_journal_ioprio,
 	Opt_dioread_nolock, Opt_dioread_lock,
@@ -1818,8 +1817,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("nodelalloc",		Opt_nodelalloc),
 	fsparam_flag	("warn_on_error",	Opt_warn_on_error),
 	fsparam_flag	("nowarn_on_error",	Opt_nowarn_on_error),
-	fsparam_flag	("lazytime",		Opt_lazytime),
-	fsparam_flag	("nolazytime",		Opt_nolazytime),
 	fsparam_u32	("debug_want_extra_isize",
 						Opt_debug_want_extra_isize),
 	fsparam_flag	("mblk_io_submit",	Opt_removed),
@@ -2244,12 +2241,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_i_version:
 		ctx_set_flags(ctx, SB_I_VERSION);
 		return 0;
-	case Opt_lazytime:
-		ctx_set_flags(ctx, SB_LAZYTIME);
-		return 0;
-	case Opt_nolazytime:
-		ctx_clear_flags(ctx, SB_LAZYTIME);
-		return 0;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 		ctx_set_flags(ctx, SB_INLINECRYPT);
@@ -6261,7 +6252,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
 	 * either way we need to make sure it matches in both *flags and
 	 * s_flags. Copy those selected flags from *flags to s_flags
 	 */
-	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
+	vfs_flags = SB_I_VERSION;
 	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
 
 	ext4_apply_options(fc, sb);
-- 
2.31.1

