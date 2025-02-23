Return-Path: <linux-ext4+bounces-6532-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD6A41178
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2025 21:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63062189714D
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2025 20:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130422DF9C;
	Sun, 23 Feb 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6ZoEd6E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92F22A7F1
	for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2025 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341428; cv=none; b=rZKGjQwuY3sn7aihFzpkOJbijpKYHvjPJuQRktG6igZKnyGwt0wGF62pHL/ks6gddlnfCd8OyBZL4uLh+e/DSwCZUUXw++ZCBrWNZW/higwi35azbytZrgRHMUq2pY2P+oKa7MoIDb5WL6n8MY01HAnHtetWZFatDTpuVQ+ddt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341428; c=relaxed/simple;
	bh=DvMcDGHegQnOD4u6+08HnLDnZjbzCWWOLlmpM1dAVIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHEh75vfy6IGPNXcCkaymvpsADOfo1AVBts4t/6wfx/2PWqhej4fYufaShfAByQ8MSzGOw+WXxAiyIC97c7WHDRbl6HkiZBIxZlGKt778QqjeSg1rTGVc5noCQA0yuefajk5Wi4s6PJ5YzzYANgtb9QH/0s9u9AJc6nkVJBrms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6ZoEd6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740341425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLiYUzzOYUT3H2guwRmuuRfam0Qa5282l3Q8VerdRTo=;
	b=W6ZoEd6EydDFINm/z0h3ck++90uQ0cmW2GhYJC5OZwjdCV1xW9+Ym/CgUQgt3qcVBeLUw9
	AH/6gI6NS3gYO8tOzd6iGGw3sr9rZOq9ziQ/9yp2irJZrh7QeaJAOmVuTeoUeMgctPShOS
	WGdEnvQuM/iG5ShYPDexEusdur7zVOs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-OHvNheQFOkWM4yc61PO_-w-1; Sun, 23 Feb 2025 15:10:23 -0500
X-MC-Unique: OHvNheQFOkWM4yc61PO_-w-1
X-Mimecast-MFC-AGG-ID: OHvNheQFOkWM4yc61PO_-w_1740341423
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8559aa4b853so299303739f.0
        for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2025 12:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740341423; x=1740946223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLiYUzzOYUT3H2guwRmuuRfam0Qa5282l3Q8VerdRTo=;
        b=fYqv7PTnE8UpDQgnzlLu2DNDkVjWYhVktbwsMDnYgW3D8NbvWiTdHd9vK7CshBBBJb
         dNC03jB5A44eHy6Ph9vBOPZaa4PwVTmj445HiqWNC7uLMMFchXX3TOTjYwCjrEPFgluO
         X4vDEwfXiVzMMX+oQ1ThDpnSktw/DDMktXglDTSHAFq336qVfj7ZHiYHAgrN7WcdU8Gl
         xV6JCuMXfCurD5GIkDMJp49bMjBmfN8BP/s507zN3WrchgoH7g5BjK1V0wBoKb1+xkix
         yZ9TldFdE7ZsvB3QFsuRvVyx5NuVKJpAq0nj8N5K7eFlwfj65pjJt5384ZSKtj5zMOuo
         PhjQ==
X-Gm-Message-State: AOJu0YwTHnHNw2ryAW+Qhb/a98gp121JWRHOl1rUjKCaU0xB+eHur97l
	BtXnKv5yZ3GCAxNejDRAomPQ/4Sy+Dw2c8eXes/iYfpNt7LT1eFYFn4h836V0Wg4xt4zcg+s3Yj
	z17kjJAcJ+wJVxVVtM/f4APo7UX88LrR4gRi30fmAOHK792Xqiw2Z+Io5x7mQDwsOYVVwXA==
X-Gm-Gg: ASbGnctty4Y5Cq1j7iBVm6kYPj3eTssW5F74ZsABSY2l4hX4mbN+ZeD7PY2n9MBQdCQ
	dtP3SiD5nP1T4B6259ok99EB4trr7DDbs6HOcHJRi3VBvUWP7Bx1o6SJNHF/JstceqDR6Ctj9ID
	CuQYusrya9NVfkhYSGCyl+yJDGU8Icp61fyCJs8s1q+lVNhYgNFlaAJav7JBb57NAoM3CesEwlE
	T5nMsHCcfWCnjJ1yMlkpRTLkqlIJwhn7NVUXBq1QblZFi+lsuRGIByZ0qiMPNMwvbPzTz/vZZpT
	tfxw2kloj7XVoAvZzTwcpRTYcxNy7IY/jLw17LrjN7MDhdyia6Nwt40FuSfFWLlR
X-Received: by 2002:a05:6602:6014:b0:855:695a:9849 with SMTP id ca18e2360f4ac-855daa50b18mr1062573239f.11.1740341422490;
        Sun, 23 Feb 2025 12:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4zPdu5iGmWGk0PyUCSUimdFIXVv5u/8M5GR9izVY4GiUDMAP77xZ8LN1H7mrd8cVxhmjhUA==
X-Received: by 2002:a05:6602:6014:b0:855:695a:9849 with SMTP id ca18e2360f4ac-855daa50b18mr1062571939f.11.1740341422067;
        Sun, 23 Feb 2025 12:10:22 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855b8cd2ab7sm215692039f.24.2025.02.23.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:10:21 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 1/2] ext2: convert to the new mount API
Date: Sun, 23 Feb 2025 13:57:40 -0600
Message-ID: <20250223201014.7541-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250223201014.7541-1-sandeen@redhat.com>
References: <20250223201014.7541-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ext2 to the new mount API.

Note that this makes the sb= option more accepting than it was before;
previosly, sb= was only accepted if it was the first specified option.
Now it can exist anywhere, and if respecified, the last specified value
is used.

Parse-time messages here are sent to ext2_msg with a NULL sb, and
ext2_msg is adjusted to accept that, as ext4 does today as well.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ext2/ext2.h  |   1 +
 fs/ext2/super.c | 571 ++++++++++++++++++++++++++----------------------
 2 files changed, 310 insertions(+), 262 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index f38bdd46e4f7..4025f875252a 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -368,6 +368,7 @@ struct ext2_inode {
 #define EXT2_MOUNT_ERRORS_CONT		0x000010  /* Continue on errors */
 #define EXT2_MOUNT_ERRORS_RO		0x000020  /* Remount fs ro on errors */
 #define EXT2_MOUNT_ERRORS_PANIC		0x000040  /* Panic on errors */
+#define EXT2_MOUNT_ERRORS_MASK		0x000070
 #define EXT2_MOUNT_MINIX_DF		0x000080  /* Mimics the Minix statfs */
 #define EXT2_MOUNT_NOBH			0x000100  /* No buffer_heads */
 #define EXT2_MOUNT_NO_UID32		0x000200  /* Disable 32-bit UIDs */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 37f7ce56adce..cb6253656eb2 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -23,7 +23,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/random.h>
 #include <linux/buffer_head.h>
 #include <linux/exportfs.h>
@@ -40,7 +41,6 @@
 #include "acl.h"
 
 static void ext2_write_super(struct super_block *sb);
-static int ext2_remount (struct super_block * sb, int * flags, char * data);
 static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf);
 static int ext2_sync_fs(struct super_block *sb, int wait);
 static int ext2_freeze(struct super_block *sb);
@@ -92,7 +92,10 @@ void ext2_msg(struct super_block *sb, const char *prefix,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	if (sb)
+		printk("%sEXT2-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	else
+		printk("%sEXT2-fs: %pV\n", prefix, &vaf);
 
 	va_end(args);
 }
@@ -346,7 +349,6 @@ static const struct super_operations ext2_sops = {
 	.freeze_fs	= ext2_freeze,
 	.unfreeze_fs	= ext2_unfreeze,
 	.statfs		= ext2_statfs,
-	.remount_fs	= ext2_remount,
 	.show_options	= ext2_show_options,
 #ifdef CONFIG_QUOTA
 	.quota_read	= ext2_quota_read,
@@ -402,230 +404,217 @@ static const struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
 };
 
-static unsigned long get_sb_block(void **data)
-{
-	unsigned long 	sb_block;
-	char 		*options = (char *) *data;
-
-	if (!options || strncmp(options, "sb=", 3) != 0)
-		return 1;	/* Default location */
-	options += 3;
-	sb_block = simple_strtoul(options, &options, 0);
-	if (*options && *options != ',') {
-		printk("EXT2-fs: Invalid sb specification: %s\n",
-		       (char *) *data);
-		return 1;
-	}
-	if (*options == ',')
-		options++;
-	*data = (void *) options;
-	return sb_block;
-}
-
 enum {
-	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
-	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic,
-	Opt_err_ro, Opt_nouid32, Opt_debug,
-	Opt_oldalloc, Opt_orlov, Opt_nobh, Opt_user_xattr, Opt_nouser_xattr,
-	Opt_acl, Opt_noacl, Opt_xip, Opt_dax, Opt_ignore, Opt_err, Opt_quota,
-	Opt_usrquota, Opt_grpquota, Opt_reservation, Opt_noreservation
+	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid, Opt_resgid, Opt_resuid,
+	Opt_sb, Opt_errors, Opt_nouid32, Opt_debug, Opt_oldalloc, Opt_orlov,
+	Opt_nobh, Opt_user_xattr, Opt_acl, Opt_xip, Opt_dax, Opt_ignore,
+	Opt_quota, Opt_usrquota, Opt_grpquota, Opt_reservation,
+};
+
+static const struct constant_table ext2_param_errors[] = {
+	{"continue",	EXT2_MOUNT_ERRORS_CONT},
+	{"panic",	EXT2_MOUNT_ERRORS_PANIC},
+	{"remount-ro",	EXT2_MOUNT_ERRORS_RO},
+	{}
+};
+
+const struct fs_parameter_spec ext2_param_spec[] = {
+	fsparam_flag	("bsddf", Opt_bsd_df),
+	fsparam_flag	("minixdf", Opt_minix_df),
+	fsparam_flag	("grpid", Opt_grpid),
+	fsparam_flag	("bsdgroups", Opt_grpid),
+	fsparam_flag	("nogrpid", Opt_nogrpid),
+	fsparam_flag	("sysvgroups", Opt_nogrpid),
+	fsparam_gid	("resgid", Opt_resgid),
+	fsparam_uid	("resuid", Opt_resuid),
+	fsparam_u32	("sb", Opt_sb),
+	fsparam_enum	("errors", Opt_errors, ext2_param_errors),
+	fsparam_flag	("nouid32", Opt_nouid32),
+	fsparam_flag	("debug", Opt_debug),
+	fsparam_flag	("oldalloc", Opt_oldalloc),
+	fsparam_flag	("orlov", Opt_orlov),
+	fsparam_flag	("nobh", Opt_nobh),
+	fsparam_flag_no	("user_xattr", Opt_user_xattr),
+	fsparam_flag_no	("acl", Opt_acl),
+	fsparam_flag	("xip", Opt_xip),
+	fsparam_flag	("dax", Opt_dax),
+	fsparam_flag	("grpquota", Opt_grpquota),
+	fsparam_flag	("noquota", Opt_ignore),
+	fsparam_flag	("quota", Opt_quota),
+	fsparam_flag	("usrquota", Opt_usrquota),
+	fsparam_flag_no	("reservation", Opt_reservation),
+	{}
 };
 
-static const match_table_t tokens = {
-	{Opt_bsd_df, "bsddf"},
-	{Opt_minix_df, "minixdf"},
-	{Opt_grpid, "grpid"},
-	{Opt_grpid, "bsdgroups"},
-	{Opt_nogrpid, "nogrpid"},
-	{Opt_nogrpid, "sysvgroups"},
-	{Opt_resgid, "resgid=%u"},
-	{Opt_resuid, "resuid=%u"},
-	{Opt_sb, "sb=%u"},
-	{Opt_err_cont, "errors=continue"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_err_ro, "errors=remount-ro"},
-	{Opt_nouid32, "nouid32"},
-	{Opt_debug, "debug"},
-	{Opt_oldalloc, "oldalloc"},
-	{Opt_orlov, "orlov"},
-	{Opt_nobh, "nobh"},
-	{Opt_user_xattr, "user_xattr"},
-	{Opt_nouser_xattr, "nouser_xattr"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_xip, "xip"},
-	{Opt_dax, "dax"},
-	{Opt_grpquota, "grpquota"},
-	{Opt_ignore, "noquota"},
-	{Opt_quota, "quota"},
-	{Opt_usrquota, "usrquota"},
-	{Opt_reservation, "reservation"},
-	{Opt_noreservation, "noreservation"},
-	{Opt_err, NULL}
+#define EXT2_SPEC_s_resuid                      (1 << 0)
+#define EXT2_SPEC_s_resgid                      (1 << 1)
+
+struct ext2_fs_context {
+	unsigned long	vals_s_flags;	/* Bits to set in s_flags */
+	unsigned long	mask_s_flags;	/* Bits changed in s_flags */
+	unsigned int	vals_s_mount_opt;
+	unsigned int	mask_s_mount_opt;
+	kuid_t		s_resuid;
+	kgid_t		s_resgid;
+	unsigned long	s_sb_block;
+	unsigned int	spec;
+
 };
 
-static int parse_options(char *options, struct super_block *sb,
-			 struct ext2_mount_options *opts)
+static inline void ctx_set_mount_opt(struct ext2_fs_context *ctx,
+				  unsigned long flag)
+{
+	ctx->mask_s_mount_opt |= flag;
+	ctx->vals_s_mount_opt |= flag;
+}
+
+static inline void ctx_clear_mount_opt(struct ext2_fs_context *ctx,
+				    unsigned long flag)
+{
+	ctx->mask_s_mount_opt |= flag;
+	ctx->vals_s_mount_opt &= ~flag;
+}
+
+static inline unsigned long
+ctx_test_mount_opt(struct ext2_fs_context *ctx, unsigned long flag)
+{
+	return (ctx->vals_s_mount_opt & flag);
+}
+
+static inline bool
+ctx_parsed_mount_opt(struct ext2_fs_context *ctx, unsigned long flag)
+{
+	return (ctx->mask_s_mount_opt & flag);
+}
+
+static void ext2_free_fc(struct fs_context *fc)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	kuid_t uid;
-	kgid_t gid;
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep (&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_bsd_df:
-			clear_opt (opts->s_mount_opt, MINIX_DF);
-			break;
-		case Opt_minix_df:
-			set_opt (opts->s_mount_opt, MINIX_DF);
-			break;
-		case Opt_grpid:
-			set_opt (opts->s_mount_opt, GRPID);
-			break;
-		case Opt_nogrpid:
-			clear_opt (opts->s_mount_opt, GRPID);
-			break;
-		case Opt_resuid:
-			if (match_int(&args[0], &option))
-				return 0;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid)) {
-				ext2_msg(sb, KERN_ERR, "Invalid uid value %d", option);
-				return 0;
-
-			}
-			opts->s_resuid = uid;
-			break;
-		case Opt_resgid:
-			if (match_int(&args[0], &option))
-				return 0;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid)) {
-				ext2_msg(sb, KERN_ERR, "Invalid gid value %d", option);
-				return 0;
-			}
-			opts->s_resgid = gid;
-			break;
-		case Opt_sb:
-			/* handled by get_sb_block() instead of here */
-			/* *sb_block = match_int(&args[0]); */
-			break;
-		case Opt_err_panic:
-			clear_opt (opts->s_mount_opt, ERRORS_CONT);
-			clear_opt (opts->s_mount_opt, ERRORS_RO);
-			set_opt (opts->s_mount_opt, ERRORS_PANIC);
-			break;
-		case Opt_err_ro:
-			clear_opt (opts->s_mount_opt, ERRORS_CONT);
-			clear_opt (opts->s_mount_opt, ERRORS_PANIC);
-			set_opt (opts->s_mount_opt, ERRORS_RO);
-			break;
-		case Opt_err_cont:
-			clear_opt (opts->s_mount_opt, ERRORS_RO);
-			clear_opt (opts->s_mount_opt, ERRORS_PANIC);
-			set_opt (opts->s_mount_opt, ERRORS_CONT);
-			break;
-		case Opt_nouid32:
-			set_opt (opts->s_mount_opt, NO_UID32);
-			break;
-		case Opt_debug:
-			set_opt (opts->s_mount_opt, DEBUG);
-			break;
-		case Opt_oldalloc:
-			set_opt (opts->s_mount_opt, OLDALLOC);
-			break;
-		case Opt_orlov:
-			clear_opt (opts->s_mount_opt, OLDALLOC);
-			break;
-		case Opt_nobh:
-			ext2_msg(sb, KERN_INFO,
-				"nobh option not supported");
-			break;
+	kfree(fc->fs_private);
+}
+
+static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct ext2_fs_context *ctx = fc->fs_private;
+	int opt;
+	struct fs_parse_result result;
+
+	opt = fs_parse(fc, ext2_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_bsd_df:
+		ctx_clear_mount_opt(ctx, EXT2_MOUNT_MINIX_DF);
+		break;
+	case Opt_minix_df:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_MINIX_DF);
+		break;
+	case Opt_grpid:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_GRPID);
+		break;
+	case Opt_nogrpid:
+		ctx_clear_mount_opt(ctx, EXT2_MOUNT_GRPID);
+		break;
+	case Opt_resuid:
+		ctx->s_resuid = result.uid;
+		ctx->spec |= EXT2_SPEC_s_resuid;
+		break;
+	case Opt_resgid:
+		ctx->s_resgid = result.gid;
+		ctx->spec |= EXT2_SPEC_s_resgid;
+		break;
+	case Opt_sb:
+		/* Note that this is silently ignored on remount */
+		ctx->s_sb_block = result.uint_32;
+		break;
+	case Opt_errors:
+		ctx_clear_mount_opt(ctx, EXT2_MOUNT_ERRORS_MASK);
+		ctx_set_mount_opt(ctx, result.uint_32);
+		break;
+	case Opt_nouid32:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_NO_UID32);
+		break;
+	case Opt_debug:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_DEBUG);
+		break;
+	case Opt_oldalloc:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_OLDALLOC);
+		break;
+	case Opt_orlov:
+		ctx_clear_mount_opt(ctx, EXT2_MOUNT_OLDALLOC);
+		break;
+	case Opt_nobh:
+		ext2_msg(NULL, KERN_INFO, "nobh option not supported\n");
+		break;
 #ifdef CONFIG_EXT2_FS_XATTR
-		case Opt_user_xattr:
-			set_opt (opts->s_mount_opt, XATTR_USER);
-			break;
-		case Opt_nouser_xattr:
-			clear_opt (opts->s_mount_opt, XATTR_USER);
-			break;
+	case Opt_user_xattr:
+		if (!result.negated)
+			ctx_set_mount_opt(ctx, EXT2_MOUNT_XATTR_USER);
+		else
+			ctx_clear_mount_opt(ctx, EXT2_MOUNT_XATTR_USER);
+		break;
 #else
-		case Opt_user_xattr:
-		case Opt_nouser_xattr:
-			ext2_msg(sb, KERN_INFO, "(no)user_xattr options"
-				"not supported");
-			break;
+	case Opt_user_xattr:
+		ext2_msg(NULL, KERN_INFO, "(no)user_xattr options not supported");
+		break;
 #endif
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
-		case Opt_acl:
-			set_opt(opts->s_mount_opt, POSIX_ACL);
-			break;
-		case Opt_noacl:
-			clear_opt(opts->s_mount_opt, POSIX_ACL);
-			break;
+	case Opt_acl:
+		if (!result.negated)
+			ctx_set_mount_opt(ctx, EXT2_MOUNT_POSIX_ACL);
+		else
+			ctx_clear_mount_opt(ctx, EXT2_MOUNT_POSIX_ACL);
+		break;
 #else
-		case Opt_acl:
-		case Opt_noacl:
-			ext2_msg(sb, KERN_INFO,
-				"(no)acl options not supported");
-			break;
+	case Opt_acl:
+		ext2_msg(NULL, KERN_INFO, "(no)acl options not supported");
+		break;
 #endif
-		case Opt_xip:
-			ext2_msg(sb, KERN_INFO, "use dax instead of xip");
-			set_opt(opts->s_mount_opt, XIP);
-			fallthrough;
-		case Opt_dax:
+	case Opt_xip:
+		ext2_msg(NULL, KERN_INFO, "use dax instead of xip");
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_XIP);
+		fallthrough;
+	case Opt_dax:
 #ifdef CONFIG_FS_DAX
-			ext2_msg(sb, KERN_WARNING,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-			set_opt(opts->s_mount_opt, DAX);
+		ext2_msg(NULL, KERN_WARNING,
+		    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_DAX);
 #else
-			ext2_msg(sb, KERN_INFO, "dax option not supported");
+		ext2_msg(NULL, KERN_INFO, "dax option not supported");
 #endif
-			break;
+		break;
 
 #if defined(CONFIG_QUOTA)
-		case Opt_quota:
-		case Opt_usrquota:
-			set_opt(opts->s_mount_opt, USRQUOTA);
-			break;
-
-		case Opt_grpquota:
-			set_opt(opts->s_mount_opt, GRPQUOTA);
-			break;
+	case Opt_quota:
+	case Opt_usrquota:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_USRQUOTA);
+		break;
+
+	case Opt_grpquota:
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_GRPQUOTA);
+		break;
 #else
-		case Opt_quota:
-		case Opt_usrquota:
-		case Opt_grpquota:
-			ext2_msg(sb, KERN_INFO,
-				"quota operations not supported");
-			break;
+	case Opt_quota:
+	case Opt_usrquota:
+	case Opt_grpquota:
+		ext2_msg(NULL, KERN_INFO, "quota operations not supported");
+		break;
 #endif
-
-		case Opt_reservation:
-			set_opt(opts->s_mount_opt, RESERVATION);
-			ext2_msg(sb, KERN_INFO, "reservations ON");
-			break;
-		case Opt_noreservation:
-			clear_opt(opts->s_mount_opt, RESERVATION);
-			ext2_msg(sb, KERN_INFO, "reservations OFF");
-			break;
-		case Opt_ignore:
-			break;
-		default:
-			return 0;
+	case Opt_reservation:
+		if (!result.negated) {
+			ctx_set_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
+			ext2_msg(NULL, KERN_INFO, "reservations ON");
+		} else {
+			ctx_clear_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
+			ext2_msg(NULL, KERN_INFO, "reservations OFF");
 		}
+		break;
+	case Opt_ignore:
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 static int ext2_setup_super (struct super_block * sb,
@@ -801,24 +790,83 @@ static unsigned long descriptor_loc(struct super_block *sb,
 	return ext2_group_first_block_no(sb, bg) + ext2_bg_has_super(sb, bg);
 }
 
-static int ext2_fill_super(struct super_block *sb, void *data, int silent)
+/*
+ * Set all mount options either from defaults on disk, or from parsed
+ * options. Parsed/specified options override on-disk defaults.
+ */
+static void ext2_set_options(struct fs_context *fc, struct ext2_sb_info *sbi)
 {
+	struct ext2_fs_context *ctx = fc->fs_private;
+	struct ext2_super_block *es = sbi->s_es;
+	unsigned long def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
+
+	/* Copy parsed mount options to sbi */
+	sbi->s_mount_opt = ctx->vals_s_mount_opt;
+
+	/* Use in-superblock defaults only if not specified during parsing */
+	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_DEBUG) &&
+	    def_mount_opts & EXT2_DEFM_DEBUG)
+		set_opt(sbi->s_mount_opt, DEBUG);
+
+	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_GRPID) &&
+	    def_mount_opts & EXT2_DEFM_BSDGROUPS)
+		set_opt(sbi->s_mount_opt, GRPID);
+
+	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_NO_UID32) &&
+	    def_mount_opts & EXT2_DEFM_UID16)
+		set_opt(sbi->s_mount_opt, NO_UID32);
+
+#ifdef CONFIG_EXT2_FS_XATTR
+	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_XATTR_USER) &&
+	    def_mount_opts & EXT2_DEFM_XATTR_USER)
+		set_opt(sbi->s_mount_opt, XATTR_USER);
+#endif
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_POSIX_ACL) &&
+	    def_mount_opts & EXT2_DEFM_ACL)
+		set_opt(sbi->s_mount_opt, POSIX_ACL);
+#endif
+
+	if (!ctx_parsed_mount_opt(ctx, EXT2_MOUNT_ERRORS_MASK)) {
+		if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
+			set_opt(sbi->s_mount_opt, ERRORS_PANIC);
+		else if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_CONTINUE)
+			set_opt(sbi->s_mount_opt, ERRORS_CONT);
+		else
+			set_opt(sbi->s_mount_opt, ERRORS_RO);
+	}
+
+	if (ctx->spec & EXT2_SPEC_s_resuid)
+		sbi->s_resuid = ctx->s_resuid;
+	else
+		sbi->s_resuid = make_kuid(&init_user_ns,
+					   le16_to_cpu(es->s_def_resuid));
+
+	if (ctx->spec & EXT2_SPEC_s_resgid)
+		sbi->s_resgid = ctx->s_resgid;
+	else
+		sbi->s_resgid = make_kgid(&init_user_ns,
+					   le16_to_cpu(es->s_def_resgid));
+}
+
+static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct ext2_fs_context *ctx = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 	struct buffer_head * bh;
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
 	struct inode *root;
 	unsigned long block;
-	unsigned long sb_block = get_sb_block(&data);
+	unsigned long sb_block = ctx->s_sb_block;
 	unsigned long logic_sb_block;
 	unsigned long offset = 0;
-	unsigned long def_mount_opts;
 	long ret = -ENOMEM;
 	int blocksize = BLOCK_SIZE;
 	int db_count;
 	int i, j;
 	__le32 features;
 	int err;
-	struct ext2_mount_options opts;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -877,42 +925,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
 		goto cantfind_ext2;
 
-	opts.s_mount_opt = 0;
-	/* Set defaults before we parse the mount options */
-	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
-	if (def_mount_opts & EXT2_DEFM_DEBUG)
-		set_opt(opts.s_mount_opt, DEBUG);
-	if (def_mount_opts & EXT2_DEFM_BSDGROUPS)
-		set_opt(opts.s_mount_opt, GRPID);
-	if (def_mount_opts & EXT2_DEFM_UID16)
-		set_opt(opts.s_mount_opt, NO_UID32);
-#ifdef CONFIG_EXT2_FS_XATTR
-	if (def_mount_opts & EXT2_DEFM_XATTR_USER)
-		set_opt(opts.s_mount_opt, XATTR_USER);
-#endif
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	if (def_mount_opts & EXT2_DEFM_ACL)
-		set_opt(opts.s_mount_opt, POSIX_ACL);
-#endif
-	
-	if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
-		set_opt(opts.s_mount_opt, ERRORS_PANIC);
-	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_CONTINUE)
-		set_opt(opts.s_mount_opt, ERRORS_CONT);
-	else
-		set_opt(opts.s_mount_opt, ERRORS_RO);
-
-	opts.s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
-	opts.s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
-	
-	set_opt(opts.s_mount_opt, RESERVATION);
-
-	if (!parse_options((char *) data, sb, &opts))
-		goto failed_mount;
-
-	sbi->s_mount_opt = opts.s_mount_opt;
-	sbi->s_resuid = opts.s_resuid;
-	sbi->s_resgid = opts.s_resgid;
+	ext2_set_options(fc, sbi);
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
@@ -1324,23 +1337,21 @@ static void ext2_write_super(struct super_block *sb)
 		ext2_sync_fs(sb, 1);
 }
 
-static int ext2_remount (struct super_block * sb, int * flags, char * data)
+static int ext2_reconfigure(struct fs_context *fc)
 {
+	struct ext2_fs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
 	struct ext2_mount_options new_opts;
+	int flags = fc->sb_flags;
 	int err;
 
 	sync_filesystem(sb);
 
-	spin_lock(&sbi->s_lock);
-	new_opts.s_mount_opt = sbi->s_mount_opt;
-	new_opts.s_resuid = sbi->s_resuid;
-	new_opts.s_resgid = sbi->s_resgid;
-	spin_unlock(&sbi->s_lock);
-
-	if (!parse_options(data, sb, &new_opts))
-		return -EINVAL;
+	new_opts.s_mount_opt = ctx->vals_s_mount_opt;
+	new_opts.s_resuid = ctx->s_resuid;
+	new_opts.s_resgid = ctx->s_resgid;
 
 	spin_lock(&sbi->s_lock);
 	es = sbi->s_es;
@@ -1349,9 +1360,9 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
 			 "dax flag with busy inodes while remounting");
 		new_opts.s_mount_opt ^= EXT2_MOUNT_DAX;
 	}
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out_set;
-	if (*flags & SB_RDONLY) {
+	if (flags & SB_RDONLY) {
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS ||
 		    !(sbi->s_mount_state & EXT2_VALID_FS))
 			goto out_set;
@@ -1470,10 +1481,9 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 	return 0;
 }
 
-static struct dentry *ext2_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int ext2_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
+	return get_tree_bdev(fc, ext2_fill_super);
 }
 
 #ifdef CONFIG_QUOTA
@@ -1624,12 +1634,49 @@ static int ext2_quota_off(struct super_block *sb, int type)
 
 #endif
 
+static const struct fs_context_operations ext2_context_ops = {
+	.parse_param	= ext2_parse_param,
+	.get_tree	= ext2_get_tree,
+	.reconfigure	= ext2_reconfigure,
+	.free		= ext2_free_fc,
+};
+
+static int ext2_init_fs_context(struct fs_context *fc)
+{
+	struct ext2_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct ext2_sb_info *sbi = EXT2_SB(sb);
+
+		spin_lock(&sbi->s_lock);
+		ctx->vals_s_mount_opt = sbi->s_mount_opt;
+		ctx->vals_s_flags = sb->s_flags;
+		ctx->s_resuid = sbi->s_resuid;
+		ctx->s_resgid = sbi->s_resgid;
+		spin_unlock(&sbi->s_lock);
+	} else {
+		ctx->s_sb_block = 1;
+		ctx_set_mount_opt(ctx, EXT2_MOUNT_RESERVATION);
+	}
+
+	fc->fs_private = ctx;
+	fc->ops = &ext2_context_ops;
+
+	return 0;
+}
+
 static struct file_system_type ext2_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ext2",
-	.mount		= ext2_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = ext2_init_fs_context,
+	.parameters	= ext2_param_spec,
 };
 MODULE_ALIAS_FS("ext2");
 
-- 
2.48.0


