Return-Path: <linux-ext4+bounces-2331-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC58BD3F6
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 19:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E415E1C21B3C
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3661157491;
	Mon,  6 May 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvgPgk8j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rSZz9+Ic";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nvA1gd1P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YdlRh5IM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05B15746C
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017298; cv=none; b=d+8K5APFWN1vZDDe46QYmighu7GF2F3Q709r4SCgi3PIN8q2fdiCVRsd3VtE5DyV2l25DONKl59ScO1Dl7hvWcl+cAw4LNkLU0fPt94USgaY5A7poTasWGdrD44ZPcUlnC1YoKSyTSVIDP72PtlylWhadvtelWkYWo/J0AT0yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017298; c=relaxed/simple;
	bh=6bEB4XTmCjYhC+uyZhmEuBHaxX+Rh1fy/JGdAKLhHJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckrmKAOV/qJF2nmounWcfgzyEg90dG5w6J0KXHLPqFJtRnWaSej4Vojy1P5s5aayIC+GlucShPOdMxASfHxLf8qkueQmmU5zQgzShLFjl6n9L5GBZugWJWiGPizI0XZKK2wXwZS3SWM74nL2R8s5WJXYTprk+bGhfnBPvigwJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvgPgk8j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rSZz9+Ic; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nvA1gd1P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YdlRh5IM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC5CE21273;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaF96xQ5fzEaNYswLa4UYDIug8PW+2VHzI9102JVSrk=;
	b=fvgPgk8joF/tQkXUhIJq45I3ErSSA6+2+scdVnEGnZVFa8KdFGp/ixybf0SfHmgA/GQx3f
	13lOqRUYdvydTynBIknSaZg+h9hzIFkky8Tn7fqaTZiXcp1DtMzWFicICfRaCjYbE+xbSQ
	ibWBau+HiSPhcP7TwKgDVqEva++4klg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaF96xQ5fzEaNYswLa4UYDIug8PW+2VHzI9102JVSrk=;
	b=rSZz9+IcDXxmsZIjS2fAeEn/uCaOgGiOAAusR+G6YCh+gakYK/fbvw0U0mwD+eIwGglQXZ
	1mD4xlBkRuGVfsBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nvA1gd1P;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YdlRh5IM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaF96xQ5fzEaNYswLa4UYDIug8PW+2VHzI9102JVSrk=;
	b=nvA1gd1P59ofP3NsVmQCSSNlo6QYGWklvTCClS1vpc0kuFO8ZbTxrNGyphuJpg9VNGcDp7
	W96xyYRLWExMkVCEfqf+T+fPD76ay5VFYthmLWum+FkUIcuvjo02wTWgYJxDKPYbkG+ZgU
	twergq5p2EWIvQVuqWaBfMIbhBI+2P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaF96xQ5fzEaNYswLa4UYDIug8PW+2VHzI9102JVSrk=;
	b=YdlRh5IMTf053ZtT1/7TSq10ysfZKkWTuNxf/6oXY+XQzVFrAC5YtRdfqwrnw2sE5y8yYo
	piPC6B+n/KOgP8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5B0913A25;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fAUqMEwWOWbuMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 May 2024 17:41:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08862A07D6; Mon,  6 May 2024 19:41:32 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] e2fsck: add more checks for ea inode consistency
Date: Mon,  6 May 2024 19:41:17 +0200
Message-Id: <20240506174132.12883-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240506173704.24995-1-jack@suse.cz>
References: <20240506173704.24995-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12263; i=jack@suse.cz; h=from:subject; bh=6bEB4XTmCjYhC+uyZhmEuBHaxX+Rh1fy/JGdAKLhHJY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmORY9HDDTtw/So5RA13vcTgg+aZ4f0e148i5ssZec wT6Y4eaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZjkWPQAKCRCcnaoHP2RA2aJxB/ 9cfzu02HbXTNzq/hmbb8XIH6ZwSpvDWhf3zH6jXeA7yFfxUh+rYnZMbNa44r28z4UPQ094o1emJR26 Ab/HOXWo9j9qwDQJKstToRfnSTB5DZHzj3pZJtjha+KI1MiFDo5GowKPgGlC32N9Q1ySPv9qFfUhmT qgxyGNo7a5+qEPx0LNQCi4HIfyT1zvUPNX14E3RvOOI/TgaImagPXS5MTkia2nedwX25q3E4lm+rXh HEdJaLuWVTdF41N7dsUOzWGSQJHb3sNqYUbqqOhCfTO73VJL0FBOahkCCjcjZRG8S/WxV8I7g8eaF8 dkJjU9hoM80tjaPHWTFwfn4sEcsL8h
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DC5CE21273
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

Currently checking of EA inodes was rather weak. Add several more
consistency checks.

1) Check that EA inode is a regular file.
2) Check that EA_INODE feature is set if the filesystem has EA inodes.
3) Make sure that no EA inode is referenced from directory hierarchy.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 e2fsck/e2fsck.h  |  6 ++++
 e2fsck/pass1.c   | 84 +++++++++++++++++++++++++++++++++++++++++-------
 e2fsck/pass2.c   | 15 +++++++++
 e2fsck/pass4.c   | 53 +++++++++++++++++++-----------
 e2fsck/problem.c | 18 +++++++++++
 e2fsck/problem.h | 12 +++++++
 6 files changed, 158 insertions(+), 30 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 55738fdc1d19..ae1273dc00af 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -533,6 +533,12 @@ extern struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx,
 typedef __u64 ea_key_t;
 typedef __u64 ea_value_t;
 
+/*
+ * Special refcount value we use for inodes which have EA_INODE flag set but we
+ * do not yet know about any references.
+ */
+#define EA_INODE_NO_REFS (~(ea_value_t)0)
+
 extern errcode_t ea_refcount_create(size_t size, ext2_refcount_t *ret);
 extern void ea_refcount_free(ext2_refcount_t refcount);
 extern errcode_t ea_refcount_fetch(ext2_refcount_t refcount, ea_key_t ea_key,
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8b6238e8434c..eb73922d3e2c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -387,34 +387,71 @@ static problem_t check_large_ea_inode(e2fsck_t ctx,
 	return 0;
 }
 
+static int alloc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx)
+{
+	pctx->errcode = ea_refcount_create(0, &ctx->ea_inode_refs);
+	if (pctx->errcode) {
+		pctx->num = 4;
+		fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
+		ctx->flags |= E2F_FLAG_ABORT;
+		return 0;
+	}
+	return 1;
+}
+
 static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 			      struct ext2_ext_attr_entry *first, void *end)
 {
 	struct ext2_ext_attr_entry *entry = first;
 	struct ext2_ext_attr_entry *np = EXT2_EXT_ATTR_NEXT(entry);
+	ea_value_t refs;
 
 	while ((void *) entry < end && (void *) np < end &&
 	       !EXT2_EXT_IS_LAST_ENTRY(entry)) {
 		if (!entry->e_value_inum)
 			goto next;
-		if (!ctx->ea_inode_refs) {
-			pctx->errcode = ea_refcount_create(0,
-							   &ctx->ea_inode_refs);
-			if (pctx->errcode) {
-				pctx->num = 4;
-				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
-				ctx->flags |= E2F_FLAG_ABORT;
-				return;
-			}
-		}
-		ea_refcount_increment(ctx->ea_inode_refs, entry->e_value_inum,
-				      0);
+		if (!ctx->ea_inode_refs && !alloc_ea_inode_refs(ctx, pctx))
+			return;
+		ea_refcount_fetch(ctx->ea_inode_refs, entry->e_value_inum,
+				  &refs);
+		if (refs == EA_INODE_NO_REFS)
+			refs = 1;
+		else
+			refs += 1;
+		ea_refcount_store(ctx->ea_inode_refs, entry->e_value_inum, refs);
 	next:
 		entry = np;
 		np = EXT2_EXT_ATTR_NEXT(entry);
 	}
 }
 
+/*
+ * Make sure inode is tracked as EA inode. We use special EA_INODE_NO_REFS
+ * value if we didn't find any xattrs referencing this inode yet.
+ */
+static int track_ea_inode(e2fsck_t ctx, struct problem_context *pctx,
+			  ext2_ino_t ino)
+{
+	ea_value_t refs;
+
+	if (!ctx->ea_inode_refs && !alloc_ea_inode_refs(ctx, pctx))
+		return 0;
+
+	ea_refcount_fetch(ctx->ea_inode_refs, ino, &refs);
+	if (refs > 0)
+		return 1;
+
+	pctx->errcode = ea_refcount_store(ctx->ea_inode_refs, ino,
+					  EA_INODE_NO_REFS);
+	if (pctx->errcode) {
+		pctx->num = 5;
+		fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
+		ctx->flags |= E2F_FLAG_ABORT;
+		return 0;
+	}
+	return 1;
+}
+
 static void check_ea_in_inode(e2fsck_t ctx, struct problem_context *pctx,
 			      struct ea_quota *ea_ibody_quota)
 {
@@ -510,6 +547,12 @@ static void check_ea_in_inode(e2fsck_t ctx, struct problem_context *pctx,
 		} else {
 			blk64_t quota_blocks;
 
+			if (!ext2fs_has_feature_ea_inode(sb) &&
+			    fix_problem(ctx, PR_1_EA_INODE_FEATURE, pctx)) {
+				ext2fs_set_feature_ea_inode(sb);
+				ext2fs_mark_super_dirty(ctx->fs);
+			}
+
 			problem = check_large_ea_inode(ctx, entry, pctx,
 						       &quota_blocks);
 			if (problem != 0)
@@ -1502,6 +1545,17 @@ void e2fsck_pass1(e2fsck_t ctx)
 			e2fsck_write_inode(ctx, ino, inode, "pass1");
 		}
 
+		if (inode->i_flags & EXT4_EA_INODE_FL) {
+			if (!LINUX_S_ISREG(inode->i_mode) &&
+			    fix_problem(ctx, PR_1_EA_INODE_NONREG, &pctx)) {
+				inode->i_flags &= ~EXT4_EA_INODE_FL;
+				e2fsck_write_inode(ctx, ino, inode, "pass1");
+			}
+			if (inode->i_flags & EXT4_EA_INODE_FL)
+				if (!track_ea_inode(ctx, &pctx, ino))
+					continue;
+		}
+
 		/* Conflicting inlinedata/extents inode flags? */
 		if ((inode->i_flags & EXT4_INLINE_DATA_FL) &&
 		    (inode->i_flags & EXT4_EXTENTS_FL)) {
@@ -2622,6 +2676,12 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 			problem_t problem;
 			blk64_t entry_quota_blocks;
 
+			if (!ext2fs_has_feature_ea_inode(fs->super) &&
+			    fix_problem(ctx, PR_1_EA_INODE_FEATURE, pctx)) {
+				ext2fs_set_feature_ea_inode(fs->super);
+				ext2fs_mark_super_dirty(fs);
+			}
+
 			problem = check_large_ea_inode(ctx, entry, pctx,
 						       &entry_quota_blocks);
 			if (problem && fix_problem(ctx, problem, pctx))
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 08ab40fa8ba1..036c0022d38a 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1501,6 +1501,21 @@ skip_checksum:
 			problem = PR_2_NULL_NAME;
 		}
 
+		/*
+		 * Check if inode was tracked as EA inode and has actual
+		 * references from xattrs. In that case dir entry is likely
+		 * bogus and we want to clear it. The case of EA inode without
+		 * references from xattrs will be handled in pass 4.
+		 */
+		if (!problem && ctx->ea_inode_refs) {
+			ea_value_t refs;
+
+			ea_refcount_fetch(ctx->ea_inode_refs, dirent->inode,
+					  &refs);
+			if (refs && refs != EA_INODE_NO_REFS)
+				problem = PR_2_EA_INODE_DIR_LINK;
+		}
+
 		if (problem) {
 			if (fix_problem(ctx, problem, &cd->pctx)) {
 				dirent->inode = 0;
diff --git a/e2fsck/pass4.c b/e2fsck/pass4.c
index d2dda02a94b8..cf0cf7c47582 100644
--- a/e2fsck/pass4.c
+++ b/e2fsck/pass4.c
@@ -96,9 +96,10 @@ static int disconnect_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
  * an xattr inode at all. Return immediately if EA_INODE flag is not set.
  */
 static void check_ea_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
-			   struct ext2_inode_large *inode, __u16 *link_counted)
+			   struct ext2_inode_large *inode, __u16 *link_counted,
+			   ea_value_t actual_refs)
 {
-	__u64 actual_refs = 0;
+	struct problem_context pctx;
 	__u64 ref_count;
 
 	if (*last_ino != i) {
@@ -107,13 +108,26 @@ static void check_ea_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
 				       "pass4: check_ea_inode");
 		*last_ino = i;
 	}
-	if (!(inode->i_flags & EXT4_EA_INODE_FL))
-		return;
 
-	if (ctx->ea_inode_refs)
-		ea_refcount_fetch(ctx->ea_inode_refs, i, &actual_refs);
-	if (!actual_refs)
+	clear_problem_context(&pctx);
+	pctx.ino = i;
+	pctx.inode = EXT2_INODE(inode);
+
+	/* No references to the inode from xattrs? */
+	if (actual_refs == EA_INODE_NO_REFS) {
+		/*
+		 * No references from directory hierarchy either? Inode will
+		 * will get attached to lost+found so clear EA_INODE_FL.
+		 * Otherwise this is likely a spuriously set flag so clear it.
+		 */
+		if (*link_counted == 0 ||
+		    fix_problem(ctx, PR_4_EA_INODE_SPURIOUS_FLAG, &pctx)) {
+			/* Clear EA_INODE_FL (likely a normal file) */
+			inode->i_flags &= ~EXT4_EA_INODE_FL;
+			e2fsck_write_inode(ctx, i, EXT2_INODE(inode), "pass4");
+		}
 		return;
+	}
 
 	/*
 	 * There are some attribute references, link_counted is now considered
@@ -127,10 +141,6 @@ static void check_ea_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
 	 * However, their i_ctime and i_atime should be the same.
 	 */
 	if (ref_count != actual_refs && inode->i_ctime != inode->i_atime) {
-		struct problem_context pctx;
-
-		clear_problem_context(&pctx);
-		pctx.ino = i;
 		pctx.num = ref_count;
 		pctx.num2 = actual_refs;
 		if (fix_problem(ctx, PR_4_EA_INODE_REF_COUNT, &pctx)) {
@@ -188,6 +198,7 @@ void e2fsck_pass4(e2fsck_t ctx)
 	/* Protect loop from wrap-around if s_inodes_count maxed */
 	for (i = 1; i <= fs->super->s_inodes_count && i > 0; i++) {
 		ext2_ino_t last_ino = 0;
+		ea_value_t ea_refs;
 		int isdir;
 
 		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
@@ -211,13 +222,19 @@ void e2fsck_pass4(e2fsck_t ctx)
 		ext2fs_icount_fetch(ctx->inode_link_info, i, &link_count);
 		ext2fs_icount_fetch(ctx->inode_count, i, &link_counted);
 
-		if (link_counted == 0) {
-			/*
-			 * link_counted is expected to be 0 for an ea_inode.
-			 * check_ea_inode() will update link_counted if
-			 * necessary.
-			 */
-			check_ea_inode(ctx, i, &last_ino, inode, &link_counted);
+		if (ctx->ea_inode_refs) {
+			ea_refcount_fetch(ctx->ea_inode_refs, i, &ea_refs);
+			if (ea_refs) {
+				/*
+				 * Final consolidation of EA inodes. We either
+				 * decide the inode is fine and set link_counted
+				 * to one, or we decide this is actually a
+				 * normal file and clear EA_INODE flag, or
+				 * decide the inode should just be deleted.
+				 */
+				check_ea_inode(ctx, i, &last_ino, inode,
+					       &link_counted, ea_refs);
+			}
 		}
 
 		if (link_counted == 0) {
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 207ebbb34ec8..e433281fab4b 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1309,6 +1309,16 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Orphan file @i %i is not in use, but contains data.  "),
 	  PROMPT_CLEAR, PR_PREEN_OK },
 
+	/* EA_INODE flag set on a non-regular file */
+	{ PR_1_EA_INODE_NONREG,
+	  N_("@i %i has the ea_inode flag set but is not a regular file.  "),
+	  PROMPT_CLEAR_FLAG, 0, 0, 0, 0 },
+
+	/* EA_INODE present but the file system is missing the ea_inode feature */
+	{ PR_1_EA_INODE_FEATURE,
+	  N_("@i %i references EA inode but @S is missing EA_INODE feature\n"),
+	  PROMPT_FIX, PR_PREEN_OK, 0, 0, 0 },
+
 	/* Pass 1b errors */
 
 	/* Pass 1B: Rescan for duplicate/bad blocks */
@@ -1860,6 +1870,10 @@ static struct e2fsck_problem problem_table[] = {
 	   N_("Duplicate filename @E found.  "),
 	   PROMPT_CLEAR, 0, 0, 0, 0 },
 
+	/* Directory filename is null */
+	{ PR_2_EA_INODE_DIR_LINK,
+	  N_("@E references EA @i %Di.\n"),
+	  PROMPT_CLEAR, 0, 0, 0, 0 },
 
 	/* Pass 3 errors */
 
@@ -2102,6 +2116,10 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("@d @i %i ref count set to overflow but could be exact value %N.  "),
 	  PROMPT_FIX, PR_PREEN_OK, 0, 0, 0 },
 
+	{ PR_4_EA_INODE_SPURIOUS_FLAG,
+	  N_("Regular @f @i %i has EA_INODE flag set. "),
+	  PROMPT_CLEAR, PR_PREEN_OK, 0, 0, 0 },
+
 	/* Pass 5 errors */
 
 	/* Pass 5: Checking group summary information */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index b47b0c630c67..ef15b8c84358 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -734,6 +734,12 @@ struct problem_context {
 /* Orphan file inode is not in use, but contains data */
 #define PR_1_ORPHAN_FILE_NOT_CLEAR		0x010090
 
+/* Inode has EA_INODE_FL set but is not a regular file */
+#define PR_1_EA_INODE_NONREG			0x010091
+
+/* Inode references EA inode but ea_inode feature is not enabled */
+#define PR_1_EA_INODE_FEATURE			0x010092
+
 /*
  * Pass 1b errors
  */
@@ -1061,6 +1067,9 @@ struct problem_context {
 /* Non-unique filename found, but can't rename */
 #define PR_2_NON_UNIQUE_FILE_NO_RENAME	0x020054
 
+/* EA inode referenced from directory */
+#define PR_2_EA_INODE_DIR_LINK 0x020055
+
 /*
  * Pass 3 errors
  */
@@ -1203,6 +1212,9 @@ struct problem_context {
 /* Directory ref count set to overflow but it doesn't have to be */
 #define PR_4_DIR_OVERFLOW_REF_COUNT	0x040007
 
+/* EA_INODE_FL set on normal file linked from directory hierarchy */
+#define PR_4_EA_INODE_SPURIOUS_FLAG	0x040008
+
 /*
  * Pass 5 errors
  */
-- 
2.35.3


