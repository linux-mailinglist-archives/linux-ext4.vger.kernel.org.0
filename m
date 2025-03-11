Return-Path: <linux-ext4+bounces-6761-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD1A5B689
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 03:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2295116F243
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45AD1E51E3;
	Tue, 11 Mar 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bhwMc9I7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F51C6F55
	for <linux-ext4@vger.kernel.org>; Tue, 11 Mar 2025 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659201; cv=none; b=ZiQTT54AELqn5lv3tjtgQpvidZ35oiL0C38uhyYk0bwdjkmdtG+C7/2pWA47DVEPsUmP+HOeJFHvkjk63qH45Na/xeFDvOIt1x4ZzGTkg8ebfEewJhSz+q9s3sQXs4uKvKiACduoz7rpH44Mvl08Pu0tqvjqhlfuvO+l/Ritpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659201; c=relaxed/simple;
	bh=udy8jRbGI1xRGhqFWBbV+CYLNO8MxK1GHbq47bU8y3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOAsRsLPxbS2w6XI8aFd8C/dEELFKPTWewJKIoU0CfVjbcX3jIHryp8tyMQHmAa/ELO2KVLMflbsay0RnvrlMK64BTg7XeLbTAl6dnsVvpeZiNk0M3hQIgcBE2qy5OEocttFxmbtsl8D3NQIr44iYA6528oKjszrcvp6WsMEGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bhwMc9I7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22349bb8605so90068885ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 10 Mar 2025 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741659198; x=1742263998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEx1nNscCBpj8PvDfq9jNWOzGRxlbE/gLhvOGDUNIIs=;
        b=bhwMc9I7pKKyC28TA5/PVy9ed3bcLQ1DSTLEolKAnI39CIRIZ5szwnxaWp5qI7TXhb
         IeDd1BplwJVnmgm3DpGuxoqls3Io/Jd0WVA6z7BMWeuVXwODT/1KuNoUtGJa03XK/ba0
         lglqr4X0xiYVD+1/+IOBwC7GeEmC0/odi+Rjf8JDICLbZ/0zGL4E1qe1H8hWgYrPA6Cz
         1K2Ul4NTMaUf9yrIEKsPLRMdIcAcrfQWB/DrDm+hH+6HMxhWZpAkLlRRFNPGaomQvdaR
         v+CEy7iL0q8N8KrXdcNoBRozJjlCmV5cWwkgQNh8x7zriYPZGUMexsA07FBoi+tgmX/6
         BHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741659198; x=1742263998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEx1nNscCBpj8PvDfq9jNWOzGRxlbE/gLhvOGDUNIIs=;
        b=QGa0o2T1Fkc5Wi4gjwXmNPi/HVbUH/QTPJS6QOPE2ZNtyTTJXJvxt0TAP9q28X+cXM
         oAoHJB0avBEJGiWJfkB1xl2dYfYgZaMnS6MguZtlgMjnnNQzrP81m/mJXlCRo3pklUC9
         C7Zig5L6Iv7FlOFByyH8yVhnnlvie8anMTTqP2oVjwXdrph4SzIfFzCIBJUXAn/HLWUP
         JrOy4pTRqPtEWagWofNLWkxWP0YIf330e4punNqer18UY/Ot8/RfnBcSUBRlYTdvcdnd
         TEZHOsOu29HBq7v4IPYnIB41DWVllg5WlwX8kN+UGzg4vhNpJI3j7ZayRze/71uS/CXH
         E1Zg==
X-Gm-Message-State: AOJu0YxFdJtRGElEIIDZBg87IeuQolXyYLa3jt3TyHL6KXS2/76MT1wh
	v3x8c+X3NGfc+cOWNIOvHcWbRWVr4gDBfepKD4o32GN3OTX8lXFW6y+MIcE09/w=
X-Gm-Gg: ASbGnct+SSnQa1ITAnaMDlP8x0fIfUKkFuD9ijVw8DrWwn9a8+zsNffmLg6m3I0pKzO
	2eE2fziHuxQGdr03hmTbxILEtoFHXmwdyYJz7oQK+FQqtkhU8TDNQF1fO8+XgjMF/pukvj/+Imq
	yKlhcrE9CsBfYzyWVZH9zoQIB6zSBg2BVN5Cf+i1nKq5rSnlz6YLOFqA6nMp0mrhPjjNs0+QuiD
	vs/QgDRCPXlzsLyyyTtdOtWoRULgPkyJT1nI6FYE1lry6kj6QRzGPQi1FlMLtccKYq60VFCJWQR
	6yh9wKk9qxQcetlfuG3GY2UvePKAkNAWY5YGkcp5m82vww3WWn+FGw9Gx+hOY4TStQ==
X-Google-Smtp-Source: AGHT+IEAV3kSCGbgGRfNs1o/R+ErPgdvcNrYhYzTSAbHfjdRjgn5bgiqiwCUDib6f5F0APcd1aFqXw==
X-Received: by 2002:aa7:88cd:0:b0:736:621d:fd32 with SMTP id d2e1a72fcca58-736aaae44efmr21428387b3a.22.1741659197793;
        Mon, 10 Mar 2025 19:13:17 -0700 (PDT)
Received: from n13-144-013.byted.org ([36.110.131.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698204fbesm9132193b3a.36.2025.03.10.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 19:13:17 -0700 (PDT)
From: Diangang Li <lidiangang@bytedance.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [PATCH] ext4: clear DISCARD flag if device does not support discard
Date: Tue, 11 Mar 2025 10:13:10 +0800
Message-Id: <20250311021310.669524-1-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 79add3a3f795e ("ext4: notify when discard is not supported")
noted that keeping the DISCARD flag is for possibility that the underlying
device might change in future even without file system remount. However,
this scenario has rarely occurred in practice on the device side. Even if
it does occur, it can be resolved with remount. Clearing the DISCARD flag
not only prevents confusion caused by mount options but also avoids
sending unnecessary discard commands.

Signed-off-by: Diangang Li <lidiangang@bytedance.com>
---
 fs/ext4/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a50e5c31b937..1b4d8475a08c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5616,9 +5616,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount9;
 	}
 
-	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
+	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev)) {
 		ext4_msg(sb, KERN_WARNING,
 			 "mounting with \"discard\" option, but the device does not support discard");
+		clear_opt(sb, DISCARD);
+	}
 
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
-- 
2.20.1


