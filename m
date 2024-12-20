Return-Path: <linux-ext4+bounces-5818-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF69F9534
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DE4167EDE
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630A219A8A;
	Fri, 20 Dec 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBV7fkrh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B35588F;
	Fri, 20 Dec 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707837; cv=none; b=V1tzwbE4CbPkAEKjSK+y3lgmo2H/0/xT0xt7b8b2LKrsAAdokx0fVT+jn6T9tPQrqcBmfm7IYUgWLGUT7Nhlhv48ocN4I1Lw9ZaA4i0EThxcKb+NZi6jkvmLKr5RDKDY9VEzQg01Kabwy/VlPyHYh1RSzG7Pv0you9aEadGhi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707837; c=relaxed/simple;
	bh=YY4hyiOlz1BA4DCi0GOGADeHsxEXQch9rJEsb7t9mdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+jdzW+bjW6lWJvMZKZBIWcKI8l41phaSYkx46LgOC4lsdIFRVohz+kavSr3UVm5i0SKaoocI65hyWA9dy6llp2cxM+cr4qlszxLozKtsv0Jjm9CTxQvZLFWFaUcP23/ZjK5pe8zyzpQAHQeBmXzBsomE23NjdH1Ht81vHumijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBV7fkrh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2165448243fso22054135ad.1;
        Fri, 20 Dec 2024 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707835; x=1735312635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJvSc8+tVm5El//+nrRKhXNHk/rEeYCo3cALRqrz6kg=;
        b=DBV7fkrha4DVF7EgokuHMbXEVORsElU2/8H8ICZurv9MmVy4y40tNOHMkAG/AD240m
         SBfVbIuU/+f7+M2owx6kktepPGi11R1hkHX2Gw/p/x1A5g9CnlS9ud3ZnjzMDLqowljA
         K5hvwFy1ON1Z3X6iv28bULi12AJF5N8rfKBkMgX5ac6XGTkGgYl28IiGGBotet9eScAv
         /ewXdZYtgWinCt/W2Idss1x2MdPwDhBQK0EqqSyNTQYMhvdeJ+vEN3oikxKiz058ALp/
         7DWaSijtfq4XVPqLOHe+8p1pBVN4R40jJsatsbw1V7l1RngFF7YtNUWyS2F2QKn6ixf6
         bc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707835; x=1735312635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJvSc8+tVm5El//+nrRKhXNHk/rEeYCo3cALRqrz6kg=;
        b=bgPr/ruHE1Gzb4/Ngrx2vpOf8X27an5M+4Q2gefjQKc/bxYRmbnyMAQB03jCPbI/NV
         fp2I8hGikZSrw6KDyEGgvEBehI69GOh/jCvEvGV2PvUxE/Tvcu0Pn2/6GQVRDnNpoqz7
         HBuyAlZ3vj0tqeCTBbhdMgek8RsWJl7/IRGL8eDCd243PKuLhr9d9BBErnsW0dbTHiHz
         Kgy85913u2Gv0iIjJba9kXu4poKNbYiGwWpMrImNwwHTb7OvPMJuGOpz16/ZD3rs+Dkb
         FgjljlkXXoH45BSQ+s4FeQlnGybzmWAnaduTVIQIzV6Sia+mN4dhJmxbOcET8CnbvVK4
         0sUw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvMyWZQDm8es8m3nWFZ2/srfIOSmC3LSCD2oKsnRbqB1aCyBUWzR6Hl6yvUF/Xt4L9MewzAdLmmj+FNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlPWDJ9tXQZ54sWp5gEveHg3/P8kmAlfG4gRDhVUBCa+oTziZ
	eUdn1PcBZTc9X21oueiKQS7f6C3qzMBsOiDM14fYJZB+N+S6FiNQgUqemUgsbs548g==
X-Gm-Gg: ASbGncvrc3/Gpksj3lBXco6p0MKM3hfSTVoDQ0Z39TBXwMBlpKb+62+/c97t4O3BOgs
	bdLo4m1IsYedEeZE/iTtI9jIsj19jKKexvEhV+qZrqvMFuJa9vzvxycLx6tW+H684tKs68dYTVl
	bTUO28Iv8obfVbKUnTt6d3PjQDyiNiYl+5PS3VrogevCmvdYdDdAxDbVhmxX55xaFuw3kgYafaA
	UF9qA4jzB3Uum5xPmIl4dHCFwCfEDNYIS+Pbx0L6kIZ+6niT/z9OrO3dOO6txQ=
X-Google-Smtp-Source: AGHT+IHsP0o01pBy+x6FyHqdQMxTlSJpgKmACPUufBCQlJFgsx63ydUsrXW4cDTIWOcG/l+1R1+9/g==
X-Received: by 2002:a17:903:11c5:b0:216:69ca:770b with SMTP id d9443c01a7336-219e6e8bb28mr52376795ad.12.1734707835483;
        Fri, 20 Dec 2024 07:17:15 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6251sm29462445ad.207.2024.12.20.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:15 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 3/7] ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
Date: Fri, 20 Dec 2024 23:16:21 +0800
Message-Id: <20241220151625.19769-4-sunjunchao2870@gmail.com>
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

Setting the EXT4_STATE_MAY_INLINE_DATA flag for ea inodes
is meaningless because ea inodes do not use functions
like ext4_write_begin().

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7f1a5f90dbbd..49b112bfbd93 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1297,7 +1297,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
 	if (ext4_has_feature_inline_data(sb) &&
-	    (!(ei->i_flags & EXT4_DAX_FL) || S_ISDIR(mode)))
+	    (!(ei->i_flags & (EXT4_DAX_FL|EXT4_EA_INODE_FL)) || S_ISDIR(mode)))
 		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	ret = inode;
 	err = dquot_alloc_inode(inode);
-- 
2.39.5


