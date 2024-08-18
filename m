Return-Path: <linux-ext4+bounces-3762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD6955ABB
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693BE1C20BD9
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3202C2FD;
	Sun, 18 Aug 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8UbmzIH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0D9479
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953860; cv=none; b=s74o3AozoZSixxy+Ie2zX+Z0pMgFJGMdd88ZkRc2ceLx08LotFixl1xKUS09D5ojmtTTUgETd21SZSgTzvUl/1g9oc9QE2xZUxYDCm/akrgv3QzRNE6CId8pr4wbN5lht2PXJeWVNOLxtqW7zQKDauY3FsyXpOGWCFhbgyNvt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953860; c=relaxed/simple;
	bh=IUrQ36vmZRhxhp5V+6AU4GDmzXED01nFCrU3YaZwT78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2LtNvHe2MjkS3548yAH0yELJkJXqer+k7L1JeMO8WBatsUZfaIXrAaKp63INkav/PcJsLT5SFas4v41VrEBf1IATES2Sl5aQg33VjGWyZ+xeV8dKUL/L8s55WVvH3fcA9FeX7FodQ330hANHCXt9+rmo0LhdL13xus1tDJp3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8UbmzIH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a115c427f1so2073829a12.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953858; x=1724558658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KOslz8KYuhhemyu2Ap0BD0dN1NGRX8xQEs5bEuuUsA=;
        b=l8UbmzIHrs33vdZ6+/Up92y8QcUc7VSgyC4goIW4w09nBYZ/AS3bBHBHFAk47+AxIS
         yWjtf+fO1s3wZgEdpLnnsNAG7iZae9ZjEUxTMwbyQ0jU9dNc5zoJj2+ZA39/6i2PnkTb
         ilWCtJTig707Slj+N58EFO1qiyNj3bnMPmUUPkEVJ6jlH2RjHuGD6y2uMwhzRNt3Ahdv
         we36ld7CPZOxoknQghBgyTr6CcCUT9akUXJ1flCmr5r4w1QD88R4WaezB/1dVQYk/jWH
         +o5iE7ngUjzqLX3YS22Snv8pFEoMbkBQdguFvFx8kvTeZh6Y792L2dUQ/4eo/JlhVHIV
         zVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953858; x=1724558658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KOslz8KYuhhemyu2Ap0BD0dN1NGRX8xQEs5bEuuUsA=;
        b=CRvy6XAUtsWanhnYv+LAdIZZfxe0LPrNhrauc2WFn7qBHBLgK1xit8z/ysmzEQYln7
         RS5zrXoMRIv9ir0d9br8uCeduCEqFAB0JvSMOXeVb6kNF4qt5kqY/5BhTEngmNe7i44f
         /kpbVWT1pf00DZTTyqNPmWtL/mxRBIaVLGDkKJ75+M+RYPTHLaLrsSFuC8pW+k3y7S1L
         RAUgoNV6OnZ4yI8xODTlaqCuJ4TtR4aB6HNPVocV6lEkcDHK6iMqFRvtG01WPj2+tz2T
         vVWezCPCNsexjYsGoG/sOcdiBr+lvqy/bL79Qq6Vl+hxxApv2mk6hMrjP4lpjL5wdhsB
         YgZg==
X-Gm-Message-State: AOJu0YyF7ZMpoSQJsaBX6X7ljJVuTmEgG0SJI1bpK7pMnSCZso7ecnNT
	7zToJEkbsPyWMfFxtkxEshXQ3sbXUPa+Zv/CmIv1D5V6vrUoLGZZT3T69uRt5MQ=
X-Google-Smtp-Source: AGHT+IG0Gv7C3zW5KMVaxZHDgqd5TnomNqI9vNCAefb1MeDiPYh8RmuFYVNYhUiFNTVhv2urlHrtjQ==
X-Received: by 2002:a05:6a21:2d84:b0:1c4:a162:502b with SMTP id adf61e73a8af0-1c904f9110dmr7936383637.20.1723953858022;
        Sat, 17 Aug 2024 21:04:18 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:17 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 3/9] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
Date: Sun, 18 Aug 2024 04:03:50 +0000
Message-ID: <20240818040356.241684-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark inode dirty first and then grab i_data_sem in ext4_setattr().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e11f00ff8..c82eba178 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5489,12 +5489,13 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits);
 
-			down_write(&EXT4_I(inode)->i_data_sem);
-			old_disksize = EXT4_I(inode)->i_disksize;
-			EXT4_I(inode)->i_disksize = attr->ia_size;
 			rc = ext4_mark_inode_dirty(handle, inode);
 			if (!error)
 				error = rc;
+			down_write(&EXT4_I(inode)->i_data_sem);
+			old_disksize = EXT4_I(inode)->i_disksize;
+			EXT4_I(inode)->i_disksize = attr->ia_size;
+
 			/*
 			 * We have to update i_size under i_data_sem together
 			 * with i_disksize to avoid races with writeback code
-- 
2.46.0.184.g6999bdac58-goog


