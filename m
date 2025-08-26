Return-Path: <linux-ext4+bounces-9634-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8FB36E25
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C984603C3
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E14931AF13;
	Tue, 26 Aug 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZOPAyxj3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEC35208B
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222866; cv=none; b=K/eWKHLvHm451c9f8/liPwptRLSI17PgEaAM/9t0soiQijteOLEnhE/hsNaeCD1pJ6+asSDPy1XJgwyRKoc0RgzyupKbr16HUmNTmmYEnzXUbqlmsDY30Cn3zI3c+kveg9bwvQuk/pLVplGnPmevdibs3HeclPOnnv+xLo+cqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222866; c=relaxed/simple;
	bh=i08d7EU1qtP0hre72cGWsXMuWQRhkvfGuBLQ0ClvHDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgL9++IgYDsEutEzLk5MuCHFRV5L5ThMXdWcGdtEb72Lcz4/LpqYS0E4FzLnWHav2AyB8GfUoeHrI1qMx4Tx6dKgRD9ZHm0uLBDxNofyDzApKV1UKNjQzwUCbvawGl4JACHAHg2fBrhX8wRLaBN9Nk00zYELGCFEbOY+t3rkDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZOPAyxj3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e95380515bbso14638276.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222862; x=1756827662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUdrFFBfeSCCz5BvIAzgXKAAiu4bIaqDFMnpkxh49FM=;
        b=ZOPAyxj3H6QKMxpdjneOBvd604BCzKSOqEUrDEkuibQqucMKP9vI+RiEEaloB+3yLn
         fFKIqefV7NLTDgVp2+i3z9YuuuiDn+PGaaWHEuntkNyBfFTtVxPR8oamlwxAuBixwbaI
         If7vDO/qk6QMlqy1nZ93vsC9msRnfg8STQqshr4RT30PcIduDPSX/fMBctVY+qMDdr2n
         QrHZlIcec4ejDB3gGcXYNDc3G1UqUttm9obOa0wg6ptVYkJhu4LAK9/YYKu/yPphSAEP
         aP2gVldwYel/jg72OwRShcEd3qJgz/8VLBEB0wg9G86Syr6QkkxIt8/koPtlRoyxpeCH
         R/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222862; x=1756827662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUdrFFBfeSCCz5BvIAzgXKAAiu4bIaqDFMnpkxh49FM=;
        b=MnfNwAwepdcaWg1adZJBdJ8zV5OHXkQGU6SR/LXpKADRUM4JUpjSl+H6vAnu51O3D6
         k/Ei8+pxgkhadPxs0b/OipTFUvny+DJhjz5i8z75AnoLtw0KkVYxeXOSAriCuMs1v4DQ
         ed1pf/nLMlAxjfc63TBR7v1tyS8CnmZyCFDZCKMdZ2ixxxI9RsqI+j0eXCmhH/ZN/6O+
         rRZSxnImzQBX9GTEz/0C25gx5kzKVEhGMUqf/VOVH+QhZc2SIJKg7ucDRfVv+d5PYTGD
         /z85YP6n96+xjDfLRp5gX1u1r4MMlx+ZMc5ZP8h5dF4gIr+ivHInbgpOjTk9PCNQ6sY5
         uaNg==
X-Forwarded-Encrypted: i=1; AJvYcCXpTvavaBrz5y4NQe/UBC/8bMJhcSLA6sHqwbW2tdrJhj4ZAq2wVkg4m180FiPxS5o9faRZiSfOeu+6@vger.kernel.org
X-Gm-Message-State: AOJu0YyTy4+p4/Cg3X2of0HzN/STg0yyO3wMCzTBid8lyzXJjVcyu0Fd
	j0ROWkjAupeoARdPwZ3AKQ1VVP9G8QuBChnF4WInRMFpigvW+1N0W8VPnP8EYueM51w=
X-Gm-Gg: ASbGncvK7kU25qPOJ4KcLjyxT8hT6tJp5pRljMdfLwfwMBb1e2UdmMoL3hGbI1xifCo
	1lxdfwjyc3Zwk/YaoyJk8Z333ZuqnjE4Ghe92eJ5r+tqgAxs8KLyyWOT5Gsd3LuglIGIYYGV+42
	7R1Mte8UjhqClkwueAs3zH/cz07nxEcf4fMZe+Kp3x6npJXX9FFmjNgTIAMHa4RUku4s5gFQjyL
	HHj+C+ZDBHB3C91oruhWTE6YoNgneQ5akOjk0P+Jh+BSnvVY6Fxwn3q3nkKtyyqwX011pPg9WQm
	OQcewj93OCsZNRyXF4yvxnVmiycicrnXG2dFAKVKQ6x/1mrhIVedtVLIMQWPZAoUpLverNsJ0lS
	HLCza2gUexUYhP3H1Q+rzYSa9LUiZQ/KNxUJ2hGkS37pMkVFX3vl/WfhvSBM=
X-Google-Smtp-Source: AGHT+IF7RynrrWFe9fbQoevH3erjAdy+diX1JnF6ZTRRIvx21HIrszb+j08T7FJ+0UEw8lO9Zl2Jew==
X-Received: by 2002:a05:6902:1004:b0:e93:4b37:f0a5 with SMTP id 3f1490d57ef6-e96e4792411mr2039154276.7.1756222861630;
        Tue, 26 Aug 2025 08:41:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e0567840sm603896276.4.2025.08.26.08.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 09/54] fs: hold an i_obj_count reference while on the hashtable
Date: Tue, 26 Aug 2025 11:39:09 -0400
Message-ID: <89e15be97f804cb135ff942eff556d1f271f2f16.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the inode is on the hashtable we need to hold a reference to the
object itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index d426f54c05d9..0c063227d355 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -667,6 +667,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	hlist_add_head_rcu(&inode->i_hash, b);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
@@ -681,11 +682,16 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
+	bool putref;
+
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	putref = !hlist_unhashed(&inode->i_hash) && !hlist_fake(&inode->i_hash);
 	hlist_del_init_rcu(&inode->i_hash);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
+	if (putref)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -1314,6 +1320,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
@@ -1451,6 +1458,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state = I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
@@ -1803,6 +1811,7 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state |= I_NEW | I_CREATING;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
-- 
2.49.0


