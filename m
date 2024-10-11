Return-Path: <linux-ext4+bounces-4572-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E37899ACFD
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 21:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97671C2140B
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29B1D0BB9;
	Fri, 11 Oct 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzDSImMX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F21D0DF0
	for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675831; cv=none; b=MhwtlQ79R26VY7KQlE3GmnDfsAyRZ4srg1W4uy9fB8mEs9ngp65N2QpcXW/P4TcQJyHL8cFpJJvmhGQMRKBbKl28l19qRE1G3tN51v2NTOLk+mGkalnlnhx6A+Z9EY/v6z6/YZQ+pi/YKprLiEYqFPcKsAAl6UOuLo/jvAEMWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675831; c=relaxed/simple;
	bh=HiP2jOYwlaN68o8fGVOSlLIUh0g94c1H626IWPYeMaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kM9hJViMmdcIs1ptiY0C8KaeAxS+hq+RTXg8j2qqvWCpVnT86dYLw1h+5NH/RjpXqNBbfPPTfc3hj9ADM6KZeGosnC1SIkiz+YAAZqR3yrLluC+6EQcZxpc+UI0sYqoMhRDsmxw3XhL3JZMwZA8j6v6/NsNpV/6DEdoyncpiN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MzDSImMX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cea34cb57so1447394f8f.0
        for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2024 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675828; x=1729280628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snxiN7FRdAtoQFX+9wj1Js2TBnmcNUFNjqb40Wms3JA=;
        b=MzDSImMXLs6LaRdCpvtEeqnd735C5Go/xkpg+mTtaUjmqjMFMPugGnq2YKPerU2pRb
         buVoZD+42JuYLgbIbHvJ3XQixjS2z+DPmtWC3ZbNSR813efLU3eLdeT/ckwgXOJePJe7
         IKZ0KozpYIN2iYH3C8rRaQTxN2lRXkInYKbh+ibc8bKliCm6FFfRh16+1Q9r58F2rsMI
         FaOBimBwPp+ELhBOsQyQuf3gyFTAh5vpBY2Zv4EP7tzrDZjCreTrGr/gQp4KCyg2C4Sk
         mWj2Jj/BQhsWynTgRV3lglYQUtxTVTMxkIL2h5gm4CRsGcsxy3EkRVtYsgm80ORJTmcr
         bu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675828; x=1729280628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snxiN7FRdAtoQFX+9wj1Js2TBnmcNUFNjqb40Wms3JA=;
        b=sUK0QAE2iRTB2QXvzyrOhFgjE2OHVgnDwtyfjws0p335cJIqMLkb6QAJKq7RuL4SfK
         qDXZBHfTLFpLt0XXs2yEOf10qTuLIFoENDNBw/MljZ+gBDgbJlORdNrgny7tD4+/LyAC
         W8mBoZfexKpvSXAZJn8M6ge4rzUl483li6aiJmjZDYGTgLQg9D4WJz5BrDwVgtiIznBT
         6G7tUe4XKwxB00AL+s34e0iZ9Aa78kXdTkydQU/I/Z7WotfKi88iI/I1xqtFpNbbwUtn
         A4uJYMCv9/boT5tLwHXlMMxlgX8StB01a5mR/2VtgGy+48alHZ8VDKAVGOpPfZzZhq7d
         aUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRMrGIXWmngDdLn9Has1f1LOy9ls3WlLLmhUUJzBJysAEEJoBn2e7aXnbUtuGyvIXT7j+BhA4r1NEL@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIt6VbkEb/tlR2MQNOwEN8qZYaWO3XwAwSVkQ4lp08TKZ9b2Q
	mGKc7+ZW5Mc6LSlMml3N+z7LCWN3IAhXvCyTuPSUg0NIEraHAnUsJiQ/Ey0OUGs=
X-Google-Smtp-Source: AGHT+IGqnlRZZDSw4G70Cr1FwcKYeBF9aBQnwl7GGMEcvuGtDm0ChmM83BRDyWQouKHv719pFKBvZg==
X-Received: by 2002:a05:6000:18a7:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-37d551b9788mr3103211f8f.23.1728675828472;
        Fri, 11 Oct 2024 12:43:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d885sm83769715e9.46.2024.10.11.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:43:47 -0700 (PDT)
Date: Fri, 11 Oct 2024 22:43:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>, Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: cleanup variable name in ext4_fc_del()
Message-ID: <96008557-8ff4-44cc-b5e3-ce242212f1a3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The variables "&EXT4_SB(inode->i_sb)->s_fc_lock" and "&sbi->s_fc_lock"
are the same lock.  This function uses a mix of both, which is a bit
unsightly and confuses Smatch.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ext4/fast_commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b33664f6ce2a..e4cb1356e9b6 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -291,9 +291,9 @@ void ext4_fc_del(struct inode *inode)
 		return;
 
 restart:
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+		spin_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
-- 
2.45.2


