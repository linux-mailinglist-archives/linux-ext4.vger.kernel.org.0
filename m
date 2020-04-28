Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124951BC59D
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgD1Qp6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50945 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728365AbgD1Qp6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IpHq2U7w3tiPQ36E2Mxct3wrCUwns8UcBxnfbvhgAYA=;
        b=ZEIux/J7/xL+9wmjgEZbHqDZQoAzWWaau9FxSLS/aIkCejEBn2vp6hq9f9ixVdCG2mZDWM
        tGnnkePQNMKKTC+L6qDT5HoSBkNgvXa4wicnNAqtEaHb8JX4QhVH+H4kjv18TRp0643x7d
        yaGizkUC9P9J2AOGZVb7qR+AT40K4Jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-10P4wx0LNVWmVQ73EHniHw-1; Tue, 28 Apr 2020 12:45:53 -0400
X-MC-Unique: 10P4wx0LNVWmVQ73EHniHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79107464;
        Tue, 28 Apr 2020 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5AB1002388;
        Tue, 28 Apr 2020 16:45:51 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 06/17] ext4: move quota configuration out of handle_mount_opt()
Date:   Tue, 28 Apr 2020 18:45:25 +0200
Message-Id: <20200428164536.462-7-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so move quota confiquration out of handle_mount_opt() by
noting the quota file names in the ext4_fs_context structure to be
able to apply it later.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 248 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 159 insertions(+), 89 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2f7e49bfbf71..ae0ef04b3be4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -89,6 +89,10 @@ static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
 static int ext4_validate_options(struct fs_context *fc);
+static int ext4_check_quota_consistency(struct fs_context *fc,
+					struct super_block *sb);
+static void ext4_apply_quota_options(struct fs_context *fc,
+				     struct super_block *sb);
=20
 /*
  * Lock ordering
@@ -1778,71 +1782,6 @@ static const char deprecated_msg[] =3D
 	"Mount option \"%s\" will be removed by %s\n"
 	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
=20
-#ifdef CONFIG_QUOTA
-static int set_qf_name(struct super_block *sb, int qtype,
-		       struct fs_parameter *param)
-{
-	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-	char *qname, *old_qname =3D get_qf_name(sb, sbi, qtype);
-	int ret =3D -1;
-
-	if (sb_any_quota_loaded(sb) && !old_qname) {
-		ext4_msg(sb, KERN_ERR,
-			"Cannot change journaled "
-			"quota options when quota turned on");
-		return -1;
-	}
-	if (ext4_has_feature_quota(sb)) {
-		ext4_msg(sb, KERN_INFO, "Journaled quota options "
-			 "ignored when QUOTA feature is enabled");
-		return 1;
-	}
-	qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);
-	if (!qname) {
-		ext4_msg(sb, KERN_ERR,
-			"Not enough memory for storing quotafile name");
-		return -1;
-	}
-	if (old_qname) {
-		if (strcmp(old_qname, qname) =3D=3D 0)
-			ret =3D 1;
-		else
-			ext4_msg(sb, KERN_ERR,
-				 "%s quota file already specified",
-				 QTYPE2NAME(qtype));
-		goto errout;
-	}
-	if (strchr(qname, '/')) {
-		ext4_msg(sb, KERN_ERR,
-			"quotafile must be on filesystem root");
-		goto errout;
-	}
-	rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
-	set_opt(sb, QUOTA);
-	return 1;
-errout:
-	kfree(qname);
-	return ret;
-}
-
-static int clear_qf_name(struct super_block *sb, int qtype)
-{
-
-	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-	char *old_qname =3D get_qf_name(sb, sbi, qtype);
-
-	if (sb_any_quota_loaded(sb) && old_qname) {
-		ext4_msg(sb, KERN_ERR, "Cannot change journaled quota options"
-			" when quota turned on");
-		return -1;
-	}
-	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
-	synchronize_rcu();
-	kfree(old_qname);
-	return 1;
-}
-#endif
-
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
 #define MOPT_NOSUPPORT	0x0004
@@ -1987,10 +1926,68 @@ static int ext4_sb_read_encoding(const struct ext=
4_super_block *es,
 #endif
=20
 struct ext4_fs_context {
-	unsigned long journal_devnum;
-	unsigned int journal_ioprio;
+	char		*s_qf_names[EXT4_MAXQUOTAS];
+	int		s_jquota_fmt;	/* Format of quota to use */
+	unsigned short	qname_spec;
+	unsigned long	journal_devnum;
+	unsigned int	journal_ioprio;
 };
=20
+#ifdef CONFIG_QUOTA
+/*
+ * Note the name of the specified quota file.
+ */
+static int note_qf_name(struct fs_context *fc, int qtype,
+		       struct fs_parameter *param)
+{
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+	char *qname;
+
+	if (param->size < 1) {
+		ext4_msg(NULL, KERN_ERR, "EXT4-fs: Missing quota name");
+		return -EINVAL;
+	}
+	if (strchr(param->string, '/')) {
+		ext4_msg(NULL, KERN_ERR,
+			 "quotafile must be on filesystem root");
+		return -EINVAL;
+	}
+	if (ctx->s_qf_names[qtype]) {
+		if (strcmp(ctx->s_qf_names[qtype], param->string) !=3D 0) {
+			ext4_msg(NULL, KERN_ERR,
+				 "EXT4-fs: Quota file already specified");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);
+	if (!qname) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Not enough memory for storing quotafile name");
+		return -ENOMEM;
+	}
+	ctx->s_qf_names[qtype] =3D qname;
+	ctx->qname_spec |=3D 1 << qtype;
+	return 0;
+}
+
+/*
+ * Clear the name of the specified quota file.
+ */
+static int unnote_qf_name(struct fs_context *fc, int qtype)
+{
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+
+	if (ctx->s_qf_names[qtype])
+		kfree(ctx->s_qf_names[qtype]);
+
+	ctx->s_qf_names[qtype] =3D NULL;
+	ctx->qname_spec |=3D 1 << qtype;
+	return 0;
+}
+#endif
+
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *=
param)
 {
 	struct ext4_fs_context *ctx =3D fc->fs_private;
@@ -2009,14 +2006,14 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 #ifdef CONFIG_QUOTA
 	if (token =3D=3D Opt_usrjquota) {
 		if (!*param->string)
-			return clear_qf_name(sb, USRQUOTA);
+			return unnote_qf_name(fc, USRQUOTA);
 		else
-			return set_qf_name(sb, USRQUOTA, param);
+			return note_qf_name(fc, USRQUOTA, param);
 	} else if (token =3D=3D Opt_grpjquota) {
 		if (!*param->string)
-			return clear_qf_name(sb, GRPQUOTA);
+			return unnote_qf_name(fc, GRPQUOTA);
 		else
-			return set_qf_name(sb, GRPQUOTA, param);
+			return note_qf_name(fc, GRPQUOTA, param);
 	}
 #endif
 	switch (token) {
@@ -2082,11 +2079,6 @@ static int handle_mount_opt(struct fs_context *fc,=
 struct fs_parameter *param)
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
 		clear_opt(sb, ERRORS_MASK);
-	if (token =3D=3D Opt_noquota && sb_any_quota_loaded(sb)) {
-		ext4_msg(NULL, KERN_ERR, "Cannot change quota "
-			 "options when quota turned on");
-		return -EINVAL;
-	}
=20
 	if (m->flags & MOPT_NOSUPPORT) {
 		ext4_msg(NULL, KERN_ERR, "%s option not supported",
@@ -2211,19 +2203,7 @@ static int handle_mount_opt(struct fs_context *fc,=
 struct fs_parameter *param)
 		}
 #ifdef CONFIG_QUOTA
 	} else if (m->flags & MOPT_QFMT) {
-		if (sb_any_quota_loaded(sb) &&
-		    sbi->s_jquota_fmt !=3D m->mount_opt) {
-			ext4_msg(NULL, KERN_ERR, "Cannot change journaled "
-				 "quota options when quota turned on");
-			return -EINVAL;
-		}
-		if (ext4_has_feature_quota(sb)) {
-			ext4_msg(NULL, KERN_INFO,
-				 "Quota format mount options ignored "
-				 "when QUOTA feature is enabled");
-			return 1;
-		}
-		sbi->s_jquota_fmt =3D m->mount_opt;
+		ctx->s_jquota_fmt =3D m->mount_opt;
 #endif
 	} else if (token =3D=3D Opt_dax) {
 #ifdef CONFIG_FS_DAX
@@ -2325,9 +2305,99 @@ static int parse_options(char *options, struct sup=
er_block *sb,
 	if (ret < 0)
 		return 0;
=20
+	ret =3D ext4_check_quota_consistency(&fc, sb);
+	if (ret < 0)
+		return 0;
+
+	if (ctx.qname_spec)
+		ext4_apply_quota_options(&fc, sb);
+
 	return 1;
 }
=20
+static void ext4_apply_quota_options(struct fs_context *fc,
+				     struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	char *qname;
+	int i;
+
+	for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+		if (!(ctx->qname_spec & (1 << i)))
+			continue;
+		qname =3D ctx->s_qf_names[i]; /* May be NULL */
+		ctx->s_qf_names[i] =3D NULL;
+		kfree(sbi->s_qf_names[i]);
+		rcu_assign_pointer(sbi->s_qf_names[i], qname);
+		set_opt(sb, QUOTA);
+	}
+#endif
+}
+
+/*
+ * Check quota settings consistency.
+ */
+static int ext4_check_quota_consistency(struct fs_context *fc,
+					struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	bool quota_feature =3D ext4_has_feature_quota(sb);
+	bool quota_loaded =3D sb_any_quota_loaded(sb);
+	int i;
+
+	if (ctx->qname_spec && quota_loaded) {
+		if (quota_feature)
+			goto err_feature;
+
+		for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+			if (!(ctx->qname_spec & (1 << i)))
+				continue;
+
+			if (!!sbi->s_qf_names[i] !=3D !!ctx->s_qf_names[i])
+				goto err_jquota_change;
+
+			if (sbi->s_qf_names[i] && ctx->s_qf_names[i] &&
+			    strcmp(sbi->s_qf_names[i],
+				   ctx->s_qf_names[i]) !=3D 0)
+				goto err_jquota_specified;
+		}
+	}
+
+	if (ctx->s_jquota_fmt) {
+		if (sbi->s_jquota_fmt !=3D ctx->s_jquota_fmt && quota_loaded)
+			goto err_quota_change;
+		if (quota_feature) {
+			ext4_msg(NULL, KERN_INFO, "Quota format mount options "
+				 "ignored when QUOTA feature is enabled");
+			return 0;
+		}
+	}
+	return 0;
+
+err_quota_change:
+	ext4_msg(NULL, KERN_ERR,
+		 "Ext4: Cannot change quota options when quota turned on");
+	return -EINVAL;
+err_jquota_change:
+	ext4_msg(NULL, KERN_ERR, "Ext4: Cannot change journaled quota "
+		 "options when quota turned on");
+	return -EINVAL;
+err_jquota_specified:
+	ext4_msg(NULL, KERN_ERR, "Ext4: Quota file already specified");
+	return -EINVAL;
+err_feature:
+	ext4_msg(NULL, KERN_ERR, "Ext4: Journaled quota options ignored "
+		 "when QUOTA feature is enabled");
+	return 0;
+#else
+	return 0;
+#endif
+}
+
 static int ext4_validate_options(struct fs_context *fc)
 {
 	struct ext4_sb_info *sbi =3D fc->s_fs_info;
--=20
2.21.1

