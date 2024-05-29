Return-Path: <linux-ext4+bounces-2683-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9108D29D9
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31441282904
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75D15A869;
	Wed, 29 May 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np3GjdMg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45F14269
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945648; cv=none; b=lg16yPCBja3AJcthA18ypKix07yaDn2rpix4t5wdRFp9XxTRV45oJ34iuTXlYNk+C8AJWTfim+76Tzcehe0QJkLHhFGpidCAHg3HAK0Py0loVbsHY1v5XTCFEsFh+Ti5dbEvIB7vJTIBB1/gnwabu2lKv/zMVkAUGgha+VjebOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945648; c=relaxed/simple;
	bh=Z3IiSd1bUpDNnZfJydD8F5PvwmU8QRtMWPI+KSDWo1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBkAltDuBKwhj3AHBApCAI9i3QbC6C4kCDnhE1l5Vbo/Ab+Qi6vTN+sUPojbk/ZTVWdPIBqZqnpe5zKF+ZW3kN+DTSlsaoYM0w+yge5gsISzLR6ycYWpvwemf+cvYb112t43/f5GR8755mpjBd89Wv3vPlGrQlgHJ+2x8yjxoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np3GjdMg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-68187c5534cso983393a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945646; x=1717550446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LezNvFRay6RLhkgYdsCUxGmhEyschzanOjZ4vSGULOM=;
        b=np3GjdMgXx4BwxC0HFtX07NKth7Km00o2r8KSv463hSSCxbnxAYQ0RpqkrDRjRcCLx
         nExLY4WIzEwaBHymswmJSM4L2Zm38jNLm8hpUQ6TGkeyYlaGp4G6ihybh8Pnuf63NtNl
         koP9J6qqkHyY78IbRov6YP5MhqW0Mbcqn+k6xlw8BXHzLIX5NZVnssSs+dM9sS0oXjkq
         V0+vtacnc/qOjPw2hPvIpkshO+Boz/VRq39G47f1yHw410ZzzRLVeOKi9G5yUP4Ck0Fo
         nFw5Ou2lhaEUTXvdv5n/UkKjBInlsMeXZu9VDf9F6KCuA7s39CWggi6DXzYPDkOXQll0
         mJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945646; x=1717550446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LezNvFRay6RLhkgYdsCUxGmhEyschzanOjZ4vSGULOM=;
        b=JPAo/oHYDHGxfHd5RgCIK6kANhReDbF87lmVyPGea6YLkeXcMSDAK4Nvkq2K7j+v+l
         wnxZpcpti3KUno1t43GYmVwkXLHj7ek0V6fRgIXgYxLWxTkAUCvaq85bOMSiEPQDYjem
         yCjSxCbnQOk4MoYWYPAgO40fTpq5ARILtLhqZwmgG2wJ3y5o48i/vv9MvJdaAyH8KFSM
         rXc0cm2TwNo3BCxU6f5TTSnbSw7SmDMNihBOwGtKuYk2ej4JjU4z+1EoGulbT4W/MIb2
         xwaVhSUadQUZf2fM54SZoqsr4dK6Jzt8ojRlPQivxT6GjrEzmdxsJoQdvhanqX6Q+B0Z
         r6PQ==
X-Gm-Message-State: AOJu0YzF8glDJEVH1By29LM+CjXP9BujE3UT9dOnvmD2eWm04g0Yrnh0
	y9Eho0GrBVbg2H39Wr+ybmtQjhcW/LO5F8/enW0vs69zQO5Pr6YK9dbQN8Dq
X-Google-Smtp-Source: AGHT+IGzxsJV7+4T4fRaq6NADGhKyNQQd965SlIbXkVoiXctdqPSvULNmnprZz2lBS9Be4hDAc2kmg==
X-Received: by 2002:a05:6a20:5647:b0:1af:b89b:a7f5 with SMTP id adf61e73a8af0-1b212d2ba8amr14056761637.24.1716945646018;
        Tue, 28 May 2024 18:20:46 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:45 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 03/10] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
Date: Wed, 29 May 2024 01:19:56 +0000
Message-ID: <20240529012003.4006535-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
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
index aa6440992a55..61ffbdc2fb16 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5410,12 +5410,13 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
2.45.1.288.g0e0cd299f1-goog


