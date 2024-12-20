Return-Path: <linux-ext4+bounces-5816-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D239F9530
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EE57A2631
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013E218EA6;
	Fri, 20 Dec 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBWVae72"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACC218E87;
	Fri, 20 Dec 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707825; cv=none; b=HqjttSiMBN0subtFcOX/uS9SuZNL+Z1B6VU0o+DaIU6JYh4j6TzuUMUjcHj1rtDFy1VtZjgEB8qPyzo6aNeBsb9o+sWeUYVH9nRnMGNTBuFipHIKnadJG+3kEZmhEyUKq3io1Qvs+T7xV+3/6W95/56mN/3UKdkAwMfkgXwvTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707825; c=relaxed/simple;
	bh=LFGPybYm2V3jVyeVbkh7idpIzCoDSXd9+gy/Nu7TZ5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7uC0zvvmYZzQHhfcMRiwUoFDn1mS575iMVCRl5RgMqB50OE7f+N17JR7b4qIjpYN0Rdd3u316QZFSBufEMaxIlCNNOorJuTYgtYGr09dO7RuT5uVfYcyIBk5wHlVrfxlIntLxtAs0W7t7eaKyAF9Y/veWwAERPzBUxvJ3A95is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBWVae72; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so1843941a12.2;
        Fri, 20 Dec 2024 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707822; x=1735312622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFfluVbnn8slxhL1v/+StR1z4j1VEm6SfObplg+iF7k=;
        b=kBWVae72yoeFbXAXF5PE3Wd3fLF/z9hGwuUN7AQUYtY//stPPZnzEfaMdUp1aJJQa2
         Zil51cdHdpWx0m3XJl6eFZmU5EDc2TVWQ+Zg8k/XVG67m7ohjqCGa/nbUSfFEyihslqX
         i26zEv4cb67dTGxA0TzJUBZaUEqgKYl5OgZcOaq6+nRBhrbVmLvqFU2n25jgDKn+J2kA
         +QeIvbpx80jPaskQHUmDzitAyTEFVi2dpJ1FJX+EBIivwIDVbSAK2jUNDPqUDTqHLoHM
         yzgpLzb9hWLIjJgHiP/qQTPYmy7WZXO7Cceb6q1nZxWH5rSEdtZ9EiG/TojDEJosWRPW
         /jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707822; x=1735312622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFfluVbnn8slxhL1v/+StR1z4j1VEm6SfObplg+iF7k=;
        b=RDFeIDpqkuSIHwnldpFCIvo4Wi5kqwPZxUt4dkwBMoiKiNYhsCpsrJH1+B9wmxY53N
         K7nRRbNo8JHLASwm9pjIW+Wao2Kp0+Ux5q8kdpfc8iOMUmaT6fazLos2OgVwgMjqVytY
         n9/2DLcGtrCVwL6XoWRYncafn4iE3y2/UVW8jTbV77W8y7ahMzG5IYpdRtSmc+7ptD4+
         GE5g/YG1bBZL87gRS4YmSFSEPlGKTwzG7lWZ6zU9e2jf6CoOs3gSYG3q34DWw64qZh1H
         0E+uKzkAa75InxtYltqMWgdCpd36yWVmib2srdkdGCmGicRWq7cH17EGRqCslWZQF7gS
         bPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIw9mD99sH815AYwjTxSeF1GZ2IWJKFBk3rHrmyKfVE51XlLSqEskBc9kbt7aDcBNgW6tBHsFxMEcCj0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqr7mGV6e5A/eCau73QyPGnxnwUy6Lv6Ce3neibo8zHMjJh7cF
	4VUAUo6bW4ZeDJS2aRvUbDHPKD/a7IIP3h4GCebmUVbXZZuI6mmU9fsDOwZj1CW7Mg==
X-Gm-Gg: ASbGncs8qB/IVKvmnZYFPui7h2tJ0697+i8O+ToGn8m4fUvkBMhbtq+flb5Z9egr6Su
	+ec/EI+nyKyNegNQhNt3NQnOSn4FoM+7m1sHJdBP2wX9zoG629t+31lNLqgjBCj2jd0w9wxDVVD
	CXdlvvdkqdggMg/mPvIH9R0IfWWwVBzF/oB1GtV+/pBxLWsi/VWLRxgfKNP3p3F+h1sznqU7PZb
	sg4ghU2pke5ORK0R23JKqupD2tAoRUn8gtDN5+MOA/MU+In+Z0Qavgg/fIGFeA=
X-Google-Smtp-Source: AGHT+IGPULePwkBQH6mX8VmDYU2yUgQe5sktbXvvxha31OhPt7KEoe08vUQzk8U4NlKS3Vfhet5Rgg==
X-Received: by 2002:a05:6a20:c70a:b0:1e0:cc4a:caab with SMTP id adf61e73a8af0-1e5e048151dmr5446050637.19.1734707822554;
        Fri, 20 Dec 2024 07:17:02 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc7ed721sm2975654a12.67.2024.12.20.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:02 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 1/7] ext4: Modify ei->i_flags before calling ext4_mark_iloc_dirty()
Date: Fri, 20 Dec 2024 23:16:19 +0800
Message-Id: <20241220151625.19769-2-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241220151625.19769-1-sunjunchao2870@gmail.com>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify ei->i_flags before calling ext4_mark_iloc_dirty() so that
the modifications to ei->i_flags can be reflected in the raw_inode
during the call to ext4_mark_iloc_dirty()->ext4_do_update_inode()

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/inline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..d479495d03aa 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -465,11 +465,10 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	ext4_clear_inode_flag(inode, EXT4_INODE_INLINE_DATA);
 
 	get_bh(is.iloc.bh);
-	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
-
 	EXT4_I(inode)->i_inline_off = 0;
 	EXT4_I(inode)->i_inline_size = 0;
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
 out:
 	brelse(is.iloc.bh);
 	if (error == -ENODATA)
-- 
2.39.5


