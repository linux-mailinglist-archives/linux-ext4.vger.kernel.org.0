Return-Path: <linux-ext4+bounces-10313-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EE2B8C3BA
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D575C170FB4
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D362773DF;
	Sat, 20 Sep 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELQxNOci"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808072627F9
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758355903; cv=none; b=Atb9vaaF1u8TJW539UV6HAK9tzTGfOfQv1qzd55JNoZYgQsg4gBlKO/h8dWY0HPLMPgwfww/4XHAGjNwbxQmzELFhY0xjhZG1aAFCpEjH57C6DfoRQcumwQsrW6bew92/+S0PXrPDYF5MXzKDhKHHit4Egd/QfnkvWwGakxAJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758355903; c=relaxed/simple;
	bh=DRbaJh8wBu5JSG+sCxnyKWNxj6tX3XuJ3qNCfEngVWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDQqnLIoAmYwW7kUxcI3LRixNBVaFf+HteZgPIbchgS2y9HZFGf+9jH5gdrt72YXQYu63EWKKeVW45KZWYUzWEqoz9/mOH3GVS9zH9lbXp/2CMaGRI+palhzT5iKFOJnZO+yx8n2MjBUsW+/VjE6BTrLQ/VaTfwZbT3VcGjljGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELQxNOci; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-244580523a0so32177265ad.1
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758355901; x=1758960701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQTVpCZAPGVAqzVdT/mgfQTVlJdLJ8/EFRhCTscFAws=;
        b=ELQxNOciU5vjqO6ANeXiBkWINFknVdUL4EflPHe59jSgW2/kqPpNUrQ/0zxH2wVBq+
         UmXq9c+HUXBK9SRaX5tmbECasOwnLF6wjxQVJf2taXshTQEc2dcQi0SUek4h0zoYSj4D
         YzmF+wR/2bpippQsAins0KZyQ5cVFanzFovCOzcjsKoO2Ja54aUNWjbSmcw2f+BLV2fL
         0DCpQc1ge4/ddagu4BqResnA3Vda4m84ZClsuVM6snF/ybZ2iNnVGn2i73FKokSSmIy7
         Z6qCe3GTagzHW8pO0bb03R8DIH0ilEUjnTRHU92jfjYkC7PiQALhMQwZ5jbdPkPFjlaa
         UsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758355901; x=1758960701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQTVpCZAPGVAqzVdT/mgfQTVlJdLJ8/EFRhCTscFAws=;
        b=r35akni/B+wdCzfw2TfuBjsMtZ0M+1n21UQEkcusXQjIIKB4dp7ZMEPM6icsLvg6tF
         GizH8hW8IgiWu0SPnIxeeJXO83RBrVIbbCHTKTI8T7VjmoFs5NPgH2B9qA/GiOPgaeHe
         KGIMv9iKqYiwtw9U5j1pnXr13Gk6iw6FWofzth5y9s01n/6LdhFmVZHqNmkH5A5X/0Su
         ok+ASsxTH0MRZP3omvy54b6biFiKkJLxWkdsCKM1KWUDVafMknuLCugtWa9iTtPCf4iP
         A1gM0PmQEJC1EZq/BE6fwxY6dy0WVIW3MCkhLaqtx7rGkqxFZ4mHwjr4go55JqJfwxEf
         x6ig==
X-Forwarded-Encrypted: i=1; AJvYcCWJf8MZ0Mpp74IfGYAriukVPqeICNG3NzpiUq78M1TEfj9gZTosKVyi6VRbV6AiPPKeaM7vtIj4uUm4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi9/ja7OI+uvlh2RjSd2opnMmFpTgLx7DQ9ni/svWeXMhcv+X
	JjRbV5wp/C5CZsjmft44adEcC2lEnWrDfrwndfs2HCBsXtoes//oCZ9U
X-Gm-Gg: ASbGncuvbfuioo09TvX2C0nZgHcKDSGAreZhhXyXcVHhyZ9F4KMg54EH8PuBfChUoDT
	hAL7vxkjwnUJiyUFPQXGuSbRdKswkmhMmp8Z3HKx6KDLmg5sSKUkR/RFvQEAIvoV4pcdnpBpKMk
	moz0Y817AQAO9qCx758xrN6x4Z+WVbjA8RzHHu7w+zLUAUWeZMN09iFr8UBMj8utfy0rK+McX2g
	zQaqgdTcXEqt9zaAcH6sUKRNBru0MaqVqq2lDkWlJ+0dhtJIgVP/wTBrclQT0n5a7Bnle/Z4Uyb
	OU2CVVm5m5xvt7aSjxTK93dh8oZ1YJZO0IEoKreJIjnx5E/bLzKOhDs5aRqUMHf2YDbCjKSiLih
	NBr2cXqC9eHKuTiWaEWC22KlxcOCV/A/U9jWFRO9xKo6ZxzsK9HLsBJq4XhbtWR0ZBcAxrEIAfe
	Kc5E7euXpOlRM/8g==
X-Google-Smtp-Source: AGHT+IFxGzNnL2Xbwu+bk042Ny/WRz3zymFOkMDFUBwph7gA3Yyd0/6lP1tVyOl8bDcHIDDFpILfVA==
X-Received: by 2002:a17:902:d546:b0:272:1320:121f with SMTP id d9443c01a7336-272132014e2mr12171495ad.27.1758355900738;
        Sat, 20 Sep 2025 01:11:40 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:abf2:ac51:2206:23e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053ef0sm76829545ad.28.2025.09.20.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 01:11:40 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] nsfs: validate file handle type in nsfs_fh_to_dentry()
Date: Sat, 20 Sep 2025 13:41:33 +0530
Message-ID: <20250920081133.778997-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Add early validation of file handle type in nsfs_fh_to_dentry() to
prevent processing of handles with incorrect types. This fixes a
warning triggered when open_by_handle_at() is called with non-nsfs
handle types on nsfs files.

The issue occurs when a user provides a file handle with a type
like FILEID_INO32_GEN_PARENT (0xf1) instead of FILEID_NSFS when
calling open_by_handle_at() on an nsfs file. The generic export
code routes this to nsfs_fh_to_dentry(), which then processes
the incorrectly formatted handle data, leading to validation
warnings.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..050e7db80297 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -461,6 +461,8 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 					int fh_len, int fh_type)
 {
+	if (fh_type != FILEID_NSFS)
+		return ERR_PTR(-EINVAL);
 	struct path path __free(path_put) = {};
 	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
 	struct user_namespace *owning_ns = NULL;
-- 
2.43.0


