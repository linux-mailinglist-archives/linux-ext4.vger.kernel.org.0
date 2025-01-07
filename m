Return-Path: <linux-ext4+bounces-5946-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BBA0371E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 05:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507077A151C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E7193074;
	Tue,  7 Jan 2025 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0zzo0qz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B822194A67
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225250; cv=none; b=nk5LjTLLxv0AjWKB+T4SJgSqjxal4+qMnuZia48eJvkpQW4EIvZOH1KLxNxgH6J7BHKlgM1RIwkdmlOvcv/tbVXcAAaYl0PZe1sVabtYYZzquRsGRv8LEneXBw6NDR7mk51FryEAk+nlU6wXly1WloEQj1Y9jqyxrUZMvikOfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225250; c=relaxed/simple;
	bh=XFm2FF03H2MEVfAxnutOoSMPw6W63gd6/sPd0zq/Ivo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrfWCFmse1rqjqd639ZvidOz9omSH9myGQuC813YHFUyTVpXgNDO3zrWHcHIWszqKsnYO0Qgl1ErxKwIHqB0c3KsolAizkvKtETadkkqzdwqmZ8CT6JrPMpsogTUReixlDID701Ke7y9/I6eQG84enTwkULb6WtF/U0hd4t9vLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0zzo0qz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so22028557a91.2
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 20:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736225247; x=1736830047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dip4cbAgLBezSCgqx4IxlNSLR+g+OvhEoVIDEaIjl8=;
        b=I0zzo0qzG+DIeLs2/oaigtcGWZ9OpaD4LXai6fvctx2pKZYAvZ++nrxcxTdEPKYtVz
         3rDhDNAcNZR5X5qIqWAfAPJtIfoNqdV7ck9x1plMqSg7AFGN+dA9Oy3AA7WRteBzSbUc
         xa/1hrrXbTJ4GT4/J6kxM2XROImq1qucTot/wBhPqMo+xJrb4wMlK9f2zs3s53iZGqYD
         ftDTghG85IGG9U2aFCnzR4BlrkuYhUPC//PsVZ/6YWkWTG+Y22auIxBFLu55Mqx/Wi6u
         YecoLEkw9u3X21K5AHIQjSBE/d4Y00wMHmxGbGT7YwcyvZPHpTGu+BvwZYUxnl4MbAcz
         /GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225247; x=1736830047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dip4cbAgLBezSCgqx4IxlNSLR+g+OvhEoVIDEaIjl8=;
        b=cUW8M9El5V5yXl9BIp/GeOUeNPXTHQEJSRgD1CXo8iOcHPGCJ/H+SWqG/wevWGhgIE
         J0voZ1ZXwQd4Ce2wHwZH10jsmkexTyhuYiuSqowrGaipQ8EBeRCLXR+jJqc/kA5nZHGm
         9BoqszNtm3lG72eCMGzpDqbzjXVULUY6/fLUcsMF7jSaKOCQv5tieh9G7NR93fFvnnSV
         EZcCuQQGHLscBemLnNTBw8pIcYs4PxypyQEkr97gxEf9MRINKvWjtU97vU+LRzHCIkTd
         0enaomrd41Dz+0P3Sv8fI3ygB5CTrx42vGClRHvRsYRgOMeMtNfO2a1e/arDnGPDwQFf
         2Wzg==
X-Gm-Message-State: AOJu0YwrQ3tT3f4QnP6RGodOp9anqO12w1KCYw9iGhmmL1h9qpVcTHh9
	rJHCuS4io+3wJwdhq/K0CNNHfx5C9UblzfCyE6kE5cuWqiwd6S8+5XPD/16tVkk=
X-Gm-Gg: ASbGncsUtE6Let624cNGlOEZ9X/Tr7PSiD9BrhESoiBX046FkYeJDg5vO7z290jiHsg
	ExlDOnoNwU5pzoRIZR50IJeX6qyB+iPTTaAqfCNl/FyWB2BoAN28ZHoIhBNNv43ITp89tG4z57/
	sL8ZH0EZj9Q3Vp4aI1PrBTNsjy+JQvqYml6DTF3cvyjdLjEMkiBSdspDM6VFT+9ItgYzMVR1XjJ
	xrTqO/B7OzOxRVEAxD8t4Ra1dhqO1rlewZtmQzjlUFehoB4FaFHBqpUEspD7w==
X-Google-Smtp-Source: AGHT+IH8wRdTXSz5I4t0vPRmyozQUjJRPUgp7+wXzXPzWZz1qBO96VWzwDIp+DqHtsy+fgFgtsBEdg==
X-Received: by 2002:a05:6a00:35ca:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-72abde97ec4mr92291737b3a.20.1736225247248;
        Mon, 06 Jan 2025 20:47:27 -0800 (PST)
Received: from localhost ([123.113.100.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb45sm32291639b3a.88.2025.01.06.20.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:47:26 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2 2/5] ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
Date: Tue,  7 Jan 2025 12:46:59 +0800
Message-Id: <20250107044702.1836852-3-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
References: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


