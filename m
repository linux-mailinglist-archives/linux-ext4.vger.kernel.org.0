Return-Path: <linux-ext4+bounces-10222-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E2B7FFFC
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E737B4413
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCEE2F7461;
	Wed, 17 Sep 2025 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjHSnj39"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8A149E17;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079397; cv=none; b=jIs5UvyM9MbAR8igWPw/1TMvsJJUyBdww1DyWMQgw7L0lm2Lou/Ry5CiuLNu3DOD6BxSdSEVUxosFCMivHcfYYLYqylgiKTih3uPKuo20BT/HASt80gEQ3i3Nva8GzSXH3e0v8S+kLWB1+XD3c9FKF93uVZVQQuvOxxEXJ8zyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079397; c=relaxed/simple;
	bh=Em9j3bhCiPFenVEJinrsdXyI/7gV2Mevt9vg2PwMYaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSr+ybb8LoV4uQ1je7NH6Qf38TXQpwqbLc15MB8K2/jR6VJh14i+7il/P7+IhnMu/q9vBsSfwzjF7XYmdoUEFH4Tqbht8ZI8DsmsnwVGjzzUYHNcwwFyQv+w2skRQORmnqu3+uOP8r04Sm28+5rxaeBfzYnzQMkJ2RZsR+OFEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjHSnj39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B064C4CEFA;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758079397;
	bh=Em9j3bhCiPFenVEJinrsdXyI/7gV2Mevt9vg2PwMYaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZjHSnj399COcIKpui9YSqTgFBppRE/rviOz5BXFxVMkCXBo7D2rBvE9fWZrubpGBT
	 f+prh11tadNS8awtM61oQTVDOxl4GZ6ohvMWi1bRYq27lPLr98SArzEGKO1B9pKp9J
	 JveYesb7uCYHMIntW6cIboFn065Sx0XA12YUtLl3huHJ3kuUUU4MifBLHKjeaZpWn/
	 sojtbCLkvu1h3/LaW26oKgBwOIUyzfYDS9+Sh6r0GmdFf35ymizqOuHaaKWdR3sYNP
	 WCGs17+EdOHTCp8p/O3B2+RB8dmk7Z/1kFv+XA+8osdnUucsOFB+6zfT0scuRgfX++
	 33q4PzExX253A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49256CAC598;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
From: Theodore Ts'o via B4 Relay <devnull+tytso.mit.edu@kernel.org>
Date: Tue, 16 Sep 2025 23:22:47 -0400
Subject: [PATCH v2 1/3] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-tune2fs-v2-1-d594dc7486f0@mit.edu>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
In-Reply-To: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=tytso@mit.edu;
 h=from:subject:message-id;
 bh=Zik1NfPQHpKrfWfZaCNq+zMCfiMzKhxquLerrhs7sjY=;
 b=owEBbQGS/pANAwAIAfL5WVaVDYGjAcsmYgBoyimj5RZcrRoqS+cfvdfvm0LHMTEEiscYuIGLN
 fPLWp6r8K+JATMEAAEIAB0WIQQrablU2/4IeSiBN8ny+VlWlQ2BowUCaMopowAKCRDy+VlWlQ2B
 owvBB/9BJHZ610L/JEl1w3n9Vmz4gQ4lD68ipzubm1Z+9Ya+s8ifOoFaBrIGfQHm589r1Y2Hghh
 sbvmrumDoXmgzvDAH+OdqnoxBCgPcFZxCDvzLHMTnozTANi+M2JrpIMkcbkKvGE+VzbRv2f99j2
 KmVyBoUiNK9LokXIQT8IyYdfoKYdIA1GK73pEHMDMFLtzPBvUZ+AjQmc3AWojqSiHEHRsSBVhov
 O+pO45iq4kcNTnJ/4YIyOAnGLJdhAwMUh09u7dU8/I6gDG8HLTM13ob2wuHq8gJKeOVlWYfgMlh
 +9csVZda7zql9r0G62bUP0e4+c9gTXicAQUIu1V6XqhYIQq9
X-Developer-Key: i=tytso@mit.edu; a=openpgp;
 fpr=3AB057B7E78D945C8C5591FBD36F769BC11804F0
X-Endpoint-Received: by B4 Relay for tytso@mit.edu/default with auth_id=517
X-Original-From: Theodore Ts'o <tytso@mit.edu>
Reply-To: tytso@mit.edu

From: Theodore Ts'o <tytso@mit.edu>

Unlike other strings in the ext4 superblock, we rely on tune2fs to
make sure s_mount_opts is NUL terminated.  Harden
parse_apply_sb_mount_options() by treating s_mount_opts as a potential
__nonstring.

Cc: stable@vger.kernel.org
Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a82f26809bf68533454a242596f0fd..94c98446c84f9a4614971d246ca7f001de610a8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2460,7 +2460,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2468,15 +2468,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2508,11 +2504,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 

-- 
2.51.0



