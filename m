Return-Path: <linux-ext4+bounces-2584-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14818C98D3
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A7F1F21767
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED5179BF;
	Mon, 20 May 2024 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEK6/tZx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9212E6A
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184333; cv=none; b=Blx2Bt9frlFHFkhyE0cwcyNJZgFNsTgSLLmv6XIcs0GBg4ZubG++kSBP3NDwZHSYBdF5kGj7uRkuYlto2wzi7OJ4z80QXY9gXQmipGcLLx4o++28EFYcIZgLBICjELCfiQxfCWXQjENWy7J6bSXeoMuwVAgdQG2WnnAZ+VMIABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184333; c=relaxed/simple;
	bh=S7Kx16vJWTK11Wy30u2bkV1EWWSzMSTmIjvmpAVoRzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjqnnaJyyOuMv/LAUqC4PxNgPWlieBplX2+PvzXKHLYI8IN8lsLFocZ+Bp8rXv4Cp/gDTcwOjgy1ii3VJJPjbu3Z3DfNp7CAwJRpMO8iQ2ol+dlAtBdMa4tZqkFZqN48V7/UiN3FObmRm3z377D4RCBTV6GoYM2XGrlfz0ywjs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEK6/tZx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-663d2e6a3d7so1019786a12.0
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184331; x=1716789131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kREIsboAHgcIekf+JgPj2yFaVh4ews3l2jggZLbylqY=;
        b=CEK6/tZx2ChFvUpocraMCPXoMGsLSC6g/ms8ScfTx7DgsiQRFtNB8OxGX671f0Cg1Y
         aUYAHer5RSPcKzXDSjV3twfhECjZ7otSvD9gRR+vg1826OImguTvnXaTr47x/3w3ASn7
         hjtZmkpTID5tyXW57pMRDTjpBpGTy9lXwGw2c4TIg70bAE4+K+7na4rE4D4N+8YNCPYW
         IQ9FINug/+xKZ1KTBcO+hsBG1Y7uZyRzK7HXz5/Qj43FprhBaTcNb7AIHHvCBiBaPcWM
         wr0DAZTCzA6gd8NybLPX1cIxaX94H18MVrY9xTKIZI2MiNtu3lxsd766SsecFTNjiHbn
         oxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184331; x=1716789131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kREIsboAHgcIekf+JgPj2yFaVh4ews3l2jggZLbylqY=;
        b=TH8vXWdhvCB+lyG++ATUgTBBiWvjRYu/RQ0+HmN+vYzgxhqYqnIG0djE9Iuwm/ghyZ
         7o5D4hl/IZ2yhOH7BmBLjbNguUlpoOoiXdnohrFT2iJ/HN9M6uoRBLDriHWTe9lTuzb3
         ER4cTzT0D7brO8gIYsR6Ds9s1JFlAdpA1i06dII6rg8QYw+JhVroN3xC6hwtef+jfK4U
         1FSlaMwj+akMxKQXBbnpXGFeoZBnJ4HUBwjShTPgiA297EfUTfRsVY7aef1Q6l8ySLbY
         voz5V9Q4HIB/ixf0bTdFksxpFM/U7T/0ggDVvzBhnpoSxfD197b4JEGZVHK1tuVo2WFc
         fknQ==
X-Gm-Message-State: AOJu0Yx++zv8FHos4rG3Z5YcYIdoF3wb5ZvaSe0AM8x6MNNxmpO7aPjr
	DAm70EDYPCC7n6blzRYB5nbl5NSYPoTuGjcPBrrjV4Dvt3EaysteKIEKCGTu
X-Google-Smtp-Source: AGHT+IGNi9j5vnMofji82Mz0kEfAQlagODNjeCyLW3jffnEmJrx6j9C6GfDQrVhMqoaTeQZD41yX5Q==
X-Received: by 2002:a05:6a20:7f9b:b0:1af:ceb8:221e with SMTP id adf61e73a8af0-1b1ca4717f3mr6701694637.29.1716184330653;
        Sun, 19 May 2024 22:52:10 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:10 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 03/10] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
Date: Mon, 20 May 2024 05:51:46 +0000
Message-ID: <20240520055153.136091-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
References: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index aa6440992a55..26b9d3076536 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5410,12 +5410,12 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits);
 
-			down_write(&EXT4_I(inode)->i_data_sem);
-			old_disksize = EXT4_I(inode)->i_disksize;
-			EXT4_I(inode)->i_disksize = attr->ia_size;
 			rc = ext4_mark_inode_dirty(handle, inode);
 			if (!error)
 				error = rc;
+			down_write(&EXT4_I(inode)->i_data_sem);
+			EXT4_I(inode)->i_disksize = attr->ia_size;
+
 			/*
 			 * We have to update i_size under i_data_sem together
 			 * with i_disksize to avoid races with writeback code
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


