Return-Path: <linux-ext4+bounces-5817-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B19F9533
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774AD16CCAE
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4382165EF;
	Fri, 20 Dec 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnhiGxn3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290ED5588F;
	Fri, 20 Dec 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707832; cv=none; b=Wew04HWCBEaf2HJJd3Sx04LNfTUYdJjZSsbB8pBIkwhOHQZ4ik5QDYt4/dEcHoty5pMe79xomyE2SATTkYXnUN76t12U3SPa9LaO3kL4VyRsJe1hLoVngJB1etxI0TH+s8cn9h0moyJ7jMddkNmqWrY0kdDI7j6dmFMtg10Vfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707832; c=relaxed/simple;
	bh=RQ3opgir1PEFzPmZf2rLrAHVbdRVZYzBf2fOeqLLhUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jn8gZVT7a35cRbF8qP9YNP+U5sazphwKJQPcGzOdiv0qZ8H5UuYpnW2CjKxtx2MOMhjc1ROGsnwtEQSvZ+j/Ay6oWg5ylThyPA5aIJMiLKeo1ommecxmtfB+xfQu/EectnHs2juOUaI+aQCso1fJ5kLCbeyTR1CbDJo8PI4tgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnhiGxn3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216395e151bso13772125ad.0;
        Fri, 20 Dec 2024 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707830; x=1735312630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZHfdAZCZo7YK46Du/lwICXtoFhzm0RAbRFQCRrRc/w=;
        b=TnhiGxn3cpu+x0GwgLQu58GdeernUc1Vw07MdxcDjtE1T+5waKN2pD40NwiZ4fz5Gd
         3w3d/8wP4WVAxeSAkfArgTLJeFgQOHYuMr858DppPc4vtw3O7ja5Qy+s97Os5kc6JdV/
         3u7w7CAx+DkwRHdkhFK2gIRIOtiJbCKBgb6X9M7W6Z198QdJeax+eLw76pFcJ3u0fK5K
         Sb2V8W+MwfxNb1Gt3Llxk7tcmFWA1F++0+aLPKY+c9lTClDTauD5Y8HIc6VI/9TP/f/p
         qDNkUmJP/35tGXlJX0ch/8b8/ArBMOL4WVCDulGyb2B7kidWyHkrf3nr7BWSMibc3dDm
         lVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707830; x=1735312630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZHfdAZCZo7YK46Du/lwICXtoFhzm0RAbRFQCRrRc/w=;
        b=XeXRDdjbcCgRfB0S7Yi+gAR2x08ReJtauXNw5RcjkLdTXkgpQ+CvxHssNTmpewNcMl
         vFUgt2GgEKne25/1mfLs3IBqzsGhTqhPsH7NiVeHoDw6cFCASKn0IjcvYgufautXHTas
         pED04keRFQXg8o3jdKp4CVyVvFoy1+KpZF1+S/0hcTIkpSl2jj1bCqsrLXtschvYY+KR
         J4tPzMTNCfxFaYLNHunvKoRs2lpBd6wv1dGxlE6tur3V9+Nw+KZSsQ7GUhd0wWi2Bk9V
         pN8ECdu53jx0kGVrNi3zl5VZhQk//w2WtHnLFd8S22WfCkRL7dsj3lu0qffOKl4chbDE
         Ezfw==
X-Forwarded-Encrypted: i=1; AJvYcCWSjPUqIwfgnRqd2NTiBAV1kg+r0QirQA3MqPe9pjUy3eVebwV3LikNXnihKIC3RcjKYGmTvegKoMrRT6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoN7CmpGHlnF6160aVlyJa+ojros5A+iX9uGi9HYce6tZwv4Ot
	GxkqrWj0NvAeb4yDfToZZhEJ9cekMqHIm7SlKr/G2khIuJC9699ImEIVjnOUNaV8kA==
X-Gm-Gg: ASbGncsKBKzaazlO3EpNHn+3pr0OJbY/15Qz5e5MCkXQo891RNulHKG7ZHfvitolbY5
	JnUUUkDmDOsBHaIE5Rt28RgTkWpr8cuYAYhsvS0exyQlgS9YMUpzg9al63jzSMpO8LNL60K+XlY
	GOHOKhjTxK4eVYyiM1lL4rVYEDfaVFCfmxtvbsnnLBBTjtOGSh1zPX4fDUYENdMukr8BGpj980o
	/PM3H5iCtWYQrrEX7ymSyS3OKVr6fYkFuzD/slgYzUm9znlAEK3FkrbklV8u/c=
X-Google-Smtp-Source: AGHT+IFO44EiAM+QNUCjz1t/r+eXLqqfQaDheZzbbvGTUKBSIvH8vGw9UsNqe197/anSXmbX6B8QWQ==
X-Received: by 2002:a17:902:da8f:b0:215:98e7:9b1 with SMTP id d9443c01a7336-219e6ca6e4amr43688205ad.5.1734707829995;
        Fri, 20 Dec 2024 07:17:09 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d9468sm29470625ad.120.2024.12.20.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:09 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 2/7] ext4: Remove a redundant return statement
Date: Fri, 20 Dec 2024 23:16:20 +0800
Message-Id: <20241220151625.19769-3-sunjunchao2870@gmail.com>
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

Remove a redundant return statements in the
ext4_es_remove_extent() function.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/extents_status.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index c786691dabd3..c56fb682a27e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1551,7 +1551,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
-- 
2.39.5


