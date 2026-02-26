Return-Path: <linux-ext4+bounces-14036-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEW5E+gdoGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14036-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:18:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EE1A4219
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56CED301C567
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5523A0E85;
	Thu, 26 Feb 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="i5e07uBO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE42F7478;
	Thu, 26 Feb 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101093; cv=pass; b=FDTPlnGUa4ILZDJLRstTFq9qpUeebFQdjPu/0u43rjS6tUTGT2cJE3fRuvNgLXqALS7KNJhitwy9mnhW1Ivft5Pw7zEdILcJNDAWA2rwDEW7eGhVtHSleqriRX7W7w7bWhkI5WQffVBoIAfLXA5nsSd78OURE7KxLZ94fIXP04A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101093; c=relaxed/simple;
	bh=FWFSzWyUz0H+83E5yNlUDk3PdKTV8IEvTJrHvmKb6tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUDwIoeMjFvOVktf1a7bjShAnaE7xyycMC6A5j/Jy8+U/SvpXN5R50E4TMEAlXQT9uNJd5N5hQH697sum+cVgWKAtpdlEZUfTyokUC8tgulhetuwnFEvJoydDXw5GdkxYCncbnouFNc1UWw8690DbbYRPf5dwxMN+s1/kHzt0ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=i5e07uBO; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772101083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I4bl4u/otnJPzvYLEuWbBWvXchGxqFdv0owTbR9VByh6R3moL2nvWEEWoMFMmcIDC9Y9U5ZErUThg/YXtmTkg61PFxzN//8a8NaIfIhpf2QjOKO34maVltVhENjJWu19BfWOBftPcSgfuAplJaUZqXhqFIwuwHJQy0+NoFr2NA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772101083; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qyse1IS9Q6qz5bThx9u3W/bTyOdCiWCl40LcA4VrhHc=; 
	b=W1hrPjKvmb0lzyTaKF2ew6gMTeMvF8iYr0IPkZJuIpSVNVwLLsvmH+ON2dxtCfJWMiBEpV85yQTfAGB7oiRCAPNxwV6AtP9TjXwAU9u9sihN/QODPOyuUA1enRR6rQ85VPEBj3LvMg1KCHUctyYXFViNp31nk071QxorEQ4LNLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772101083;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Qyse1IS9Q6qz5bThx9u3W/bTyOdCiWCl40LcA4VrhHc=;
	b=i5e07uBODMV23QJ6rg8H2NXdGkCpgOBGdRB6eSAUMqtVzJcyufG0KpYHf4nbaaUE
	V1MdKCHbOId+GxdoXRycnplpvri2eQAS07wGpQQ9mcM2vHzHx9gxWWO4kfJTIdnIX3P
	CxTi8heJMnYoqD/uirIyhUiBvzU0jiNbg2LUBTos=
Received: by mx.zohomail.com with SMTPS id 177210108066263.684691457057966;
	Thu, 26 Feb 2026 02:18:00 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: linux-ext4@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH 2/4] ext4: add dax_fc_bytelog mount option
Date: Thu, 26 Feb 2026 18:17:30 +0800
Message-ID: <20260226101736.2271952-3-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226101736.2271952-1-me@linux.beauty>
References: <20260226101736.2271952-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.beauty];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14036-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: E50EE1A4219
X-Rspamd-Action: no action

Add dax_fc_bytelog={off,on,force} to control the DAX ByteLog fast commit
backend.
Initialize the ByteLog ring before fast commit replay and release it on
unmount.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/super.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 504148b2142b..3645456a61dd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1368,6 +1368,7 @@ static void ext4_put_super(struct super_block *sb)
 	sbi->s_ea_block_cache = NULL;
 
 	ext4_stop_mmpd(sbi);
+	ext4_fc_bytelog_release(sb);
 
 	brelse(sbi->s_sbh);
 	sb->s_fs_info = NULL;
@@ -1685,6 +1686,8 @@ enum {
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
+	Opt_dax_fc_bytelog, Opt_dax_fc_bytelog_off, Opt_dax_fc_bytelog_on,
+	Opt_dax_fc_bytelog_force,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1724,6 +1727,13 @@ static const struct constant_table ext4_param_dax[] = {
 	{}
 };
 
+static const struct constant_table ext4_param_dax_fc_bytelog[] = {
+	{"off",		Opt_dax_fc_bytelog_off},
+	{"on",		Opt_dax_fc_bytelog_on},
+	{"force",	Opt_dax_fc_bytelog_force},
+	{}
+};
+
 /*
  * Mount option specification
  * We don't use fsparam_flag_no because of the way we set the
@@ -1780,6 +1790,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("i_version",		Opt_removed),
 	fsparam_flag	("dax",			Opt_dax),
 	fsparam_enum	("dax",			Opt_dax_type, ext4_param_dax),
+	fsparam_enum("dax_fc_bytelog", Opt_dax_fc_bytelog,
+		     ext4_param_dax_fc_bytelog),
 	fsparam_u32	("stripe",		Opt_stripe),
 	fsparam_flag	("delalloc",		Opt_delalloc),
 	fsparam_flag	("nodelalloc",		Opt_nodelalloc),
@@ -1965,6 +1977,7 @@ ext4_sb_read_encoding(const struct ext4_super_block *es)
 #define EXT4_SPEC_s_fc_debug_max_replay		(1 << 17)
 #define EXT4_SPEC_s_sb_block			(1 << 18)
 #define EXT4_SPEC_mb_optimize_scan		(1 << 19)
+#define EXT4_SPEC_s_dax_fc_bytelog		BIT(20)
 
 struct ext4_fs_context {
 	char		*s_qf_names[EXT4_MAXQUOTAS];
@@ -2370,6 +2383,26 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ext4_msg(NULL, KERN_INFO, "dax option not supported");
 		return -EINVAL;
 #endif
+	case Opt_dax_fc_bytelog:
+		switch (result.uint_32) {
+		case Opt_dax_fc_bytelog_off:
+			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_FC_BYTELOG);
+			ctx_clear_mount_opt2(ctx,
+					     EXT4_MOUNT2_DAX_FC_BYTELOG_FORCE);
+			break;
+		case Opt_dax_fc_bytelog_on:
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_FC_BYTELOG);
+			ctx_clear_mount_opt2(ctx,
+					     EXT4_MOUNT2_DAX_FC_BYTELOG_FORCE);
+			break;
+		case Opt_dax_fc_bytelog_force:
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_FC_BYTELOG);
+			ctx_set_mount_opt2(ctx,
+					   EXT4_MOUNT2_DAX_FC_BYTELOG_FORCE);
+			break;
+		}
+		ctx->spec |= EXT4_SPEC_s_dax_fc_bytelog;
+		return 0;
 	case Opt_data_err:
 		if (result.uint_32 == Opt_data_err_abort)
 			ctx_set_mount_opt(ctx, m->mount_opt);
@@ -2819,7 +2852,22 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 			    !(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_INODE))) {
 			goto fail_dax_change_remount;
 		}
-	}
+
+		if (ctx->spec & EXT4_SPEC_s_dax_fc_bytelog) {
+			bool new_on = ctx_test_mount_opt2(ctx,
+					EXT4_MOUNT2_DAX_FC_BYTELOG);
+			bool new_force = ctx_test_mount_opt2(ctx,
+					EXT4_MOUNT2_DAX_FC_BYTELOG_FORCE);
+			bool cur_on = test_opt2(sb, DAX_FC_BYTELOG);
+			bool cur_force = test_opt2(sb, DAX_FC_BYTELOG_FORCE);
+
+				if (new_on != cur_on || new_force != cur_force) {
+					ext4_msg(NULL, KERN_ERR,
+						 "can't change dax_fc_bytelog mount option while remounting");
+					return -EINVAL;
+				}
+			}
+		}
 
 	return ext4_check_quota_consistency(fc, sb);
 }
@@ -3038,6 +3086,12 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	} else if (test_opt2(sb, DAX_INODE)) {
 		SEQ_OPTS_PUTS("dax=inode");
 	}
+	if (test_opt2(sb, DAX_FC_BYTELOG)) {
+		if (test_opt2(sb, DAX_FC_BYTELOG_FORCE))
+			SEQ_OPTS_PUTS("dax_fc_bytelog=force");
+		else
+			SEQ_OPTS_PUTS("dax_fc_bytelog=on");
+	}
 
 	if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
 			!test_opt2(sb, MB_OPTIMIZE_SCAN)) {
@@ -4950,6 +5004,8 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 			"Failed to set fast commit journal feature");
 		goto out;
 	}
+	if (test_opt2(sb, JOURNAL_FAST_COMMIT))
+		ext4_fc_bytelog_init(sb, sbi->s_journal);
 
 	/* We have now updated the journal if required, so we can
 	 * validate the data journaling mode. */
@@ -6124,10 +6180,29 @@ static int ext4_load_journal(struct super_block *sb,
 		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
 		__le16 orig_state;
 		bool changed = false;
+		int fc_err;
 
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
+
+		/*
+		 * Map the ByteLog ring before fast-commit replay so that
+		 * EXT4_FC_TAG_DAX_BYTELOG_ANCHOR records can be processed
+		 * during jbd2_journal_load().
+		 *
+		 * For filesystems with the INCOMPAT_DAX_FC_BYTELOG feature
+		 * bit set, failing to initialize the ByteLog ring must be
+		 * treated as fatal.
+		 */
+		if (test_opt2(sb, JOURNAL_FAST_COMMIT)) {
+			fc_err = ext4_fc_bytelog_init(sb, journal);
+			if (fc_err && ext4_has_feature_dax_fc_bytelog(sb)) {
+				kfree(save);
+				err = fc_err;
+				goto err_out;
+			}
+		}
 		err = jbd2_journal_load(journal);
 		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
 				   save, EXT4_S_ERR_LEN)) {
-- 
2.52.0


