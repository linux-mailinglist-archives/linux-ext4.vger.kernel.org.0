Return-Path: <linux-ext4+bounces-3036-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EEA91D833
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 08:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B46CB215A2
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B6F2B9C6;
	Mon,  1 Jul 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yb/QoAKz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A88C09
	for <linux-ext4@vger.kernel.org>; Mon,  1 Jul 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816244; cv=none; b=OX32MXG7IXMx82n4Pr9/FSoQ/ZYVZR+0PM0F9iKecF0eOY9wrXBDkSFyI/jnvil+jXgyKjWxrxkRqjQQ6dtbwd/IVxkJVazslAnIPyAEBJaJZi+ExFOP3TQtc/v1I5y7ldBfPQafL0Ak01CPF7xF5VALugj1Q1ssE3xXFc9obCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816244; c=relaxed/simple;
	bh=Y3/10pC/TF/IN+K/QPjvuwOFG65MqYotNsrl440r1/M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mtSb1I65cFE3jrUTPcI+jEQbIshFmiXpSaM5W8A+JkuNgTrLIAcxIgFBtrYm4z9AICnlk34TWEzE4zHWf+ChSgu0COUeEhDDWaOG6w1Hl4aKnTh9GVaSWRcOgEbvyjIDwV1RABUmX/7ye6FPnjODRIOSpYNFNLPvYusd7JBR1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yb/QoAKz; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719816233; h=From:To:Subject:Date:Message-Id;
	bh=NYwjiJ2pA9Du8fkFnIh1qCp7BZqxVlBk1KAhbyr/4Y0=;
	b=yb/QoAKzSrG1N5hmdMp76gzPWWwGEyyjhT404bcf1qn3yCFHHcCwx3wDS2igU4L8quqCzdCMG/5pWNvlLPPasTOyB+bvxSQTO/hZl1KjzLz+5+t6kRhV03T3KRudmdeAc4ELFoQNM7aAzuN4ui17IIn6jZAN8vHCcyVpt6iVb2Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=yao.ly@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W9aH9rU_1719816220;
Received: from localhost(mailfrom:yao.ly@linux.alibaba.com fp:SMTPD_---0W9aH9rU_1719816220)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 14:43:52 +0800
From: "yao.ly" <yao.ly@linux.alibaba.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	"yao.ly" <yao.ly@linux.alibaba.com>
Subject: [PATCH] ext4: Correct dentry name hash when readdir with encrypted and not casefolded
Date: Mon,  1 Jul 2024 14:43:39 +0800
Message-Id: <1719816219-128287-1-git-send-email-yao.ly@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH will access struct
ext4_dir_entry_hash followed ext4_dir_entry. But there is no ext4_dir_entry_hash
followed when inode is encrypted and not casefolded

Signed-off-by: yao.ly <yao.ly@linux.alibaba.com>
---
 fs/ext4/dir.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ff4514e..b8b6b06 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -279,12 +279,20 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					struct fscrypt_str de_name =
 							FSTR_INIT(de->name,
 								de->name_len);
+					u32 hash;
+					u32 minor_hash;
+
+					if (IS_CASEFOLDED(inode)) {
+						hash = EXT4_DIRENT_HASH(de);
+						minor_hash = EXT4_DIRENT_MINOR_HASH(de);
+					} else {
+						hash = 0;
+						minor_hash = 0;
+					}
 
 					/* Directory is encrypted */
 					err = fscrypt_fname_disk_to_usr(inode,
-						EXT4_DIRENT_HASH(de),
-						EXT4_DIRENT_MINOR_HASH(de),
-						&de_name, &fstr);
+						hash, minor_hash, &de_name, &fstr);
 					de_name = fstr;
 					fstr.len = save_len;
 					if (err)
-- 
2.7.4


