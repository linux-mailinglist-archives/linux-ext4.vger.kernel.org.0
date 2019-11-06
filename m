Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4500EF13A1
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfKFKP3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728610AbfKFKP2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMxdZA0Pok5f12oPeNInpVSVb0W4qCNLWDBATbgy9QQ=;
        b=LQ200f/fs3QnxyB5+92sN0RAba6t1c5F6NrAenWV9R28vArBV5IPQYxosvXVcx0hD/Rss3
        YXXelyyzFC8w7DWGt57aAQvDP5w3TcaFbX/8tzIrGUU9ODquXiwljSJESluvmr+ZHmq4ML
        U0dfApdazicSfcDccl4P64EarKCviEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-hOy7vS07NieCTlc0Znaiwg-1; Wed, 06 Nov 2019 05:15:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D7C1005500;
        Wed,  6 Nov 2019 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9C2F1A7E2;
        Wed,  6 Nov 2019 10:15:22 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 06/17] ext4: move quota configuration out of handle_mount_opt()
Date:   Wed,  6 Nov 2019 11:14:46 +0100
Message-Id: <20191106101457.11237-7-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hOy7vS07NieCTlc0Znaiwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
 fs/ext4/super.c | 249 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 160 insertions(+), 89 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 12483f3b1f78..affcdaf63b6e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -89,6 +89,10 @@ static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 =09=09=09=09=09    unsigned int journal_inum);
 static int ext4_validate_options(struct fs_context *fc);
+static int ext4_check_quota_consistency(struct fs_context *fc,
+=09=09=09=09=09struct super_block *sb);
+static void ext4_apply_quota_options(struct fs_context *fc,
+=09=09=09=09     struct super_block *sb);
=20
 /*
  * Lock ordering
@@ -1692,71 +1696,6 @@ static const char deprecated_msg[] =3D
 =09"Mount option \"%s\" will be removed by %s\n"
 =09"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
=20
-#ifdef CONFIG_QUOTA
-static int set_qf_name(struct super_block *sb, int qtype,
-=09=09       struct fs_parameter *param)
-{
-=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-=09char *qname, *old_qname =3D get_qf_name(sb, sbi, qtype);
-=09int ret =3D -1;
-
-=09if (sb_any_quota_loaded(sb) && !old_qname) {
-=09=09ext4_msg(sb, KERN_ERR,
-=09=09=09"Cannot change journaled "
-=09=09=09"quota options when quota turned on");
-=09=09return -1;
-=09}
-=09if (ext4_has_feature_quota(sb)) {
-=09=09ext4_msg(sb, KERN_INFO, "Journaled quota options "
-=09=09=09 "ignored when QUOTA feature is enabled");
-=09=09return 1;
-=09}
-=09qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);
-=09if (!qname) {
-=09=09ext4_msg(sb, KERN_ERR,
-=09=09=09"Not enough memory for storing quotafile name");
-=09=09return -1;
-=09}
-=09if (old_qname) {
-=09=09if (strcmp(old_qname, qname) =3D=3D 0)
-=09=09=09ret =3D 1;
-=09=09else
-=09=09=09ext4_msg(sb, KERN_ERR,
-=09=09=09=09 "%s quota file already specified",
-=09=09=09=09 QTYPE2NAME(qtype));
-=09=09goto errout;
-=09}
-=09if (strchr(qname, '/')) {
-=09=09ext4_msg(sb, KERN_ERR,
-=09=09=09"quotafile must be on filesystem root");
-=09=09goto errout;
-=09}
-=09rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
-=09set_opt(sb, QUOTA);
-=09return 1;
-errout:
-=09kfree(qname);
-=09return ret;
-}
-
-static int clear_qf_name(struct super_block *sb, int qtype)
-{
-
-=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-=09char *old_qname =3D get_qf_name(sb, sbi, qtype);
-
-=09if (sb_any_quota_loaded(sb) && old_qname) {
-=09=09ext4_msg(sb, KERN_ERR, "Cannot change journaled quota options"
-=09=09=09" when quota turned on");
-=09=09return -1;
-=09}
-=09rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
-=09synchronize_rcu();
-=09kfree(old_qname);
-=09return 1;
-}
-#endif
-
 #define MOPT_SET=090x0001
 #define MOPT_CLEAR=090x0002
 #define MOPT_NOSUPPORT=090x0004
@@ -1901,10 +1840,69 @@ static int ext4_sb_read_encoding(const struct ext4_=
super_block *es,
 #endif
=20
 struct ext4_fs_context {
-=09unsigned long journal_devnum;
-=09unsigned int journal_ioprio;
+=09char=09=09*s_qf_names[EXT4_MAXQUOTAS];
+=09int=09=09s_jquota_fmt;=09/* Format of quota to use */
+=09unsigned short=09qname_spec;
+=09unsigned long=09journal_devnum;
+=09unsigned int=09journal_ioprio;
 };
=20
+#ifdef CONFIG_QUOTA
+/*
+ * Note the name of the specified quota file.
+ */
+static int note_qf_name(struct fs_context *fc, int qtype,
+=09=09       struct fs_parameter *param)
+{
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09char *qname;
+
+=09if (param->size < 1) {
+=09=09ext4_msg(NULL, KERN_ERR, "EXT4-fs: Missing quota name");
+=09=09return -EINVAL;
+=09}
+=09if (strchr(param->string, '/')) {
+=09=09ext4_msg(NULL, KERN_ERR,
+=09=09=09 "quotafile must be on filesystem root");
+=09=09return -EINVAL;
+=09}
+=09if (ctx->s_qf_names[qtype]) {
+=09=09if (strcmp(ctx->s_qf_names[qtype], param->string) !=3D 0) {
+=09=09=09ext4_msg(NULL, KERN_ERR,
+=09=09=09=09 "EXT4-fs: Quota file already specified");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09return 0;
+=09}
+
+=09qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);
+=09if (!qname) {
+=09=09ext4_msg(NULL, KERN_ERR,
+=09=09=09 "Not enough memory for storing quotafile name");
+=09=09return -ENOMEM;
+=09}
+=09ctx->s_qf_names[qtype] =3D qname;
+=09ctx->qname_spec |=3D 1 << qtype;
+=09return 0;
+}
+
+/*
+ * Clear the name of the specified quota file.
+ */
+static int unnote_qf_name(struct fs_context *fc, int qtype)
+{
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+
+=09if (!ctx->s_qf_names[qtype])
+=09=09return 0;
+
+=09kfree(ctx->s_qf_names[qtype]);
+=09ctx->s_qf_names[qtype] =3D NULL;
+=09ctx->qname_spec |=3D 1 << qtype;
+=09return 0;
+}
+#endif
+
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *pa=
ram)
 {
 =09struct ext4_fs_context *ctx =3D fc->fs_private;
@@ -1923,14 +1921,14 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 #ifdef CONFIG_QUOTA
 =09if (token =3D=3D Opt_usrjquota) {
 =09=09if (result.negated)
-=09=09=09return clear_qf_name(sb, USRQUOTA);
+=09=09=09return unnote_qf_name(fc, USRQUOTA);
 =09=09else
-=09=09=09return set_qf_name(sb, USRQUOTA, param);
+=09=09=09return note_qf_name(fc, USRQUOTA, param);
 =09} else if (token =3D=3D Opt_grpjquota) {
 =09=09if (result.negated)
-=09=09=09return clear_qf_name(sb, GRPQUOTA);
+=09=09=09return unnote_qf_name(fc, GRPQUOTA);
 =09=09else
-=09=09=09return set_qf_name(sb, GRPQUOTA, param);
+=09=09=09return note_qf_name(fc, GRPQUOTA, param);
 =09}
 #endif
 =09switch (token) {
@@ -1996,11 +1994,6 @@ static int handle_mount_opt(struct fs_context *fc, s=
truct fs_parameter *param)
 =09}
 =09if (m->flags & MOPT_CLEAR_ERR)
 =09=09clear_opt(sb, ERRORS_MASK);
-=09if (token =3D=3D Opt_noquota && sb_any_quota_loaded(sb)) {
-=09=09ext4_msg(NULL, KERN_ERR, "Cannot change quota "
-=09=09=09 "options when quota turned on");
-=09=09return -EINVAL;
-=09}
=20
 =09if (m->flags & MOPT_NOSUPPORT) {
 =09=09ext4_msg(NULL, KERN_ERR, "%s option not supported",
@@ -2117,19 +2110,7 @@ static int handle_mount_opt(struct fs_context *fc, s=
truct fs_parameter *param)
 =09=09}
 #ifdef CONFIG_QUOTA
 =09} else if (m->flags & MOPT_QFMT) {
-=09=09if (sb_any_quota_loaded(sb) &&
-=09=09    sbi->s_jquota_fmt !=3D m->mount_opt) {
-=09=09=09ext4_msg(NULL, KERN_ERR, "Cannot change journaled "
-=09=09=09=09 "quota options when quota turned on");
-=09=09=09return -EINVAL;
-=09=09}
-=09=09if (ext4_has_feature_quota(sb)) {
-=09=09=09ext4_msg(NULL, KERN_INFO,
-=09=09=09=09 "Quota format mount options ignored "
-=09=09=09=09 "when QUOTA feature is enabled");
-=09=09=09return -EINVAL;
-=09=09}
-=09=09sbi->s_jquota_fmt =3D m->mount_opt;
+=09=09ctx->s_jquota_fmt =3D m->mount_opt;
 #endif
 =09} else if (token =3D=3D Opt_dax) {
 #ifdef CONFIG_FS_DAX
@@ -2231,9 +2212,99 @@ static int parse_options(char *options, struct super=
_block *sb,
 =09if (ret < 0)
 =09=09return 0;
=20
+=09ret =3D ext4_check_quota_consistency(&fc, sb);
+=09if (ret < 0)
+=09=09return 0;
+
+=09if (ctx.qname_spec)
+=09=09ext4_apply_quota_options(&fc, sb);
+
 =09return 1;
 }
=20
+static void ext4_apply_quota_options(struct fs_context *fc,
+=09=09=09=09     struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+=09char *qname;
+=09int i;
+
+=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+=09=09if (!(ctx->qname_spec & (1 << i)))
+=09=09=09continue;
+=09=09qname =3D ctx->s_qf_names[i]; /* May be NULL */
+=09=09ctx->s_qf_names[i] =3D NULL;
+=09=09kfree(sbi->s_qf_names[i]);
+=09=09rcu_assign_pointer(sbi->s_qf_names[i], qname);
+=09=09set_opt(sb, QUOTA);
+=09}
+#endif
+}
+
+/*
+ * Check quota settings consistency.
+ */
+static int ext4_check_quota_consistency(struct fs_context *fc,
+=09=09=09=09=09struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+=09bool quota_feature =3D ext4_has_feature_quota(sb);
+=09bool quota_loaded =3D sb_any_quota_loaded(sb);
+=09int i;
+
+=09if (ctx->qname_spec && quota_loaded) {
+=09=09if (quota_feature)
+=09=09=09goto err_feature;
+
+=09=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++) {
+=09=09=09if (!(ctx->qname_spec & (1 << i)))
+=09=09=09=09continue;
+
+=09=09=09if (!!sbi->s_qf_names[i] !=3D !!ctx->s_qf_names[i])
+=09=09=09=09goto err_jquota_change;
+
+=09=09=09if (sbi->s_qf_names[i] &&
+=09=09=09    strcmp(sbi->s_qf_names[i],
+=09=09=09=09   ctx->s_qf_names[i]) !=3D 0)
+=09=09=09=09goto err_jquota_specified;
+=09=09}
+=09}
+
+=09if (ctx->s_jquota_fmt) {
+=09=09if (sbi->s_jquota_fmt !=3D ctx->s_jquota_fmt && quota_loaded)
+=09=09=09goto err_quota_change;
+=09=09if (quota_feature) {
+=09=09=09ext4_msg(NULL, KERN_INFO, "Quota format mount options "
+=09=09=09=09 "ignored when QUOTA feature is enabled");
+=09=09=09return 0;
+=09=09}
+=09}
+=09return 0;
+
+err_quota_change:
+=09ext4_msg(NULL, KERN_ERR,
+=09=09 "Ext4: Cannot change quota options when quota turned on");
+=09return -EINVAL;
+err_jquota_change:
+=09ext4_msg(NULL, KERN_ERR, "Ext4: Cannot change journaled quota "
+=09=09 "options when quota turned on");
+=09return -EINVAL;
+err_jquota_specified:
+=09ext4_msg(NULL, KERN_ERR, "Ext4: Quota file already specified");
+=09return -EINVAL;
+err_feature:
+=09ext4_msg(NULL, KERN_ERR, "Ext4: Journaled quota options ignored "
+=09=09 "when QUOTA feature is enabled");
+=09return -EINVAL;
+#else
+=09return 0;
+#endif
+}
+
 static int ext4_validate_options(struct fs_context *fc)
 {
 =09struct ext4_sb_info *sbi =3D fc->s_fs_info;
--=20
2.21.0

