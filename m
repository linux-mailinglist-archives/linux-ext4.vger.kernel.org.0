Return-Path: <linux-ext4+bounces-4218-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18F97C5C6
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 10:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1647A1F24327
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5B19923F;
	Thu, 19 Sep 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBK2fn+6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11E199223;
	Thu, 19 Sep 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734348; cv=none; b=gDzwa00QqqRPtCmyHEkxvXDvBYjgfg5BXhZrMLwSY3ccri7GFjcyzIwYNsnKHofh2CSW1cezF75RCDj4n9LcmGVSzVUeOl/021r9VmODAjgTyW2Gzevauc7vX25lit+sKgu9M8aQxw9AD1pSXB6kpAftjO618Uw5ZzigIh2wa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734348; c=relaxed/simple;
	bh=pJLzHbGey2wajYaQwdYTTafgeKW358VfY/+QLVXTi7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwue6WMlle2C61D1h6AtP/rTcMluymhi/BcWvvbZ0oXmzuy7y1x61Zf81NlIBxbbKNbO5/ByDSfcm5ucYZ8phxH2LJmrK7K0C22ge/6klZ0NIjjg+jsXV9AUS4Sy5ggB/Y6cXXjb1QGa5TxfQDVnXbRmnyFLrynZlmf08mo7JV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBK2fn+6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2054e22ce3fso6295305ad.2;
        Thu, 19 Sep 2024 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726734345; x=1727339145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4vSHyFJN/tvOyn7bBGWcl+/ehJwuhtTY3A1hZAQWpU=;
        b=RBK2fn+6onaIASkRUwSfd54rxd9vyKCEV5iIocJgphN6V1MwdY65XxrLC4xArPurtL
         Iopp8z+JJ8mKA1EqBWAWHbnAHa4E2N1qa/CU6YWYcf1VZ1Gp9YfmERIrDQv1ekOI4vOi
         UisEDMJtexA3WpAh2pSN8FT1EyH1xqslq0yq2gCLXFvxW6CVPU+8t125YVUd8EIGY/WU
         2xGIpDU/fFp9b6+ZY8wKMRmGW2CrG4uzaMvfIDXjUgk3syJO5Bmhd9jJFDXcoUCzyxIU
         3pgZh12+obyiX74RUB3D2pSn93a40FY08BMLw9/73JBSc3Dh6it4DDrJJEuUpt3Z2kP2
         ulWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734345; x=1727339145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4vSHyFJN/tvOyn7bBGWcl+/ehJwuhtTY3A1hZAQWpU=;
        b=EjuxI1+ycGW+hfmjtyiLkTgWrWy2wL6NMYbyEd9NrLWvsuZx88AYi5FVHAx3KLZVmv
         2YaqdVHt5MoCqWxQON3pvi/KsX6KxkreGpOn+WB8Gf9sIqMBQzS/mqp/2Nzx2Tk+cnIc
         4z8zYV7SvzDo5Avt1NrvVTNA0kNgvCr5lCg+o1d2lXLbunEpQiZBTNQ4lHZd2HVEZLYm
         uXqlillL626h6k27XNam37D0z+5EH6jSjBWxmbwTj35rlqO/6d44dOAICCEDl2Rm3una
         eey7ZWKBjRUnt0tkjqpbrOMNjS+GnmahSbGKSS/AGzYcTOl7e1HeuAl1oRO+CBDwb81F
         /KxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZZNgR5ZsfEHA18spZKQJ2MqKTh9GOk8XmGgJ3Ju1m/6MTBYL1Tx5oZIxc/ezWe4gwXUauEfZ1NfGSZWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXc9VSiDDVZl/n14kjCX0Bys/cAWMEHnBRnSUtU7nnUR9Q122D
	PLTrxuyKzjgG7PYOxrJETaqhADVEETjbByNaWMx6W6uDxUYWRGZ2
X-Google-Smtp-Source: AGHT+IEJFzE4HikLscBMVTi1UgGaI5/msXrVKiQeiL6A66XqjuQ11J9IS9hxsf2DRk9B/olqGqN3Zg==
X-Received: by 2002:a17:902:e5c8:b0:1fc:2e38:d3de with SMTP id d9443c01a7336-2076e315577mr401430965ad.7.1726734344960;
        Thu, 19 Sep 2024 01:25:44 -0700 (PDT)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d167bsm75750615ad.154.2024.09.19.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:25:44 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [RESEND PATCH] ext4: disambiguate the return value of ext4_dio_write_end_io()
Date: Thu, 19 Sep 2024 16:25:39 +0800
Message-ID: <20240919082539.381626-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
direct IO") causes confusion about the meaning of the return value of
ext4_dio_write_end_io().

Specifically, when the ext4_handle_inode_extension() operation succeeds,
ext4_dio_write_end_io() directly returns count instead of 0.

This does not cause a bug in the current kernel, but the semantics of the
return value of the ext4_dio_write_end_io() function are wrong, which is
likely to introduce bugs in the future code evolution.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
Changelog: Just RESEND

v1: https://lore.kernel.org/linux-ext4/20240815112746.18570-1-alexjlzheng@tencent.com/
---
 fs/ext4/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..6df5a92cec2b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	 */
 	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
 	    pos + size <= i_size_read(inode))
-		return size;
-	return ext4_handle_inode_extension(inode, pos, size);
+		return 0;
+	error = ext4_handle_inode_extension(inode, pos, size);
+	return error < 0 ? error : 0;
 }
 
 static const struct iomap_dio_ops ext4_dio_write_ops = {
-- 
2.41.1


