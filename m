Return-Path: <linux-ext4+bounces-12375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDCCC25C2
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC3E305884A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CE343D90;
	Tue, 16 Dec 2025 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUhzeYdp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074EF342500
	for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884912; cv=none; b=In0EQoQ6OfyEihd4xNnqOFiptfERRE8yyKwWsdvoIv6+gnjgporqLW1RDr7/nM5B4fk/davA2hSOLxTROKp9XscatBXb+KTKj2BoRxYagl9tZmJhPjNec+4Gul+ldCLszjEjPw1A8Gael8WkCsuakyaUt4cFASTC33tPNY+YEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884912; c=relaxed/simple;
	bh=7Ng6cOzBWaVAN8sB8ImGFB9WnRkcD7FTemvHnnoD6Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1LSFIuEbYJFZFOfNY5PzpL2lRfXul5GGC9Y/p4hZsXlkEmAuxnkkJ+J5Nsrrc5dX1qYrZhywGEqGk4LAF1DBRf+nDhooyz7s9yOYuu/eEFgMmjOUiS2a9KfsJMqLtusAucNbPPi4RwvLxCl4P2qxZKsu34LbIykbE0EaTTEtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUhzeYdp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0fe77d141so22801995ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 03:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765884910; x=1766489710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNyMQo50MvCPMYMV7kY9HjLSNhtx0TsG7Ml7tk8tygg=;
        b=QUhzeYdpoPq486xWS5CUTiFHOXHXOkrqTQIcA8arCgXoKPn5INapjKdc5DCJQ217Nt
         QCI4Iz7qmG6Hmd/HQEMktlJ+oZKp+wydU3s8Xqp50PIUB1tM8ej+GeLqzfNYlDWIME7w
         VmqY+Lq6XTdJaWlsmbzDW0THHxwI1v4rZj7AtpaV1opN3nOf854IjiF7GpJqk3vPivSF
         9SfErAXmBtJ/s2UoaJyfUfEQRXrXJaGGT7pYfAEmOsn+Bvok3b7LAm0SHGJoGoFEfLTs
         xyFTKVGJU5po1Qtm/obZ5CfYCtuN5sYGCKK2KufClkfezrxowVQzrxCIDMHDMmppkKb3
         7dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884910; x=1766489710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNyMQo50MvCPMYMV7kY9HjLSNhtx0TsG7Ml7tk8tygg=;
        b=Jt00c7IDvvLvfXU35laJQgSn9l3NGCkiXC6mXllW43/R46bsjZVXQuTMYuBU26fwff
         57Zi/pXZ3y7S5QVF/XuRxsdncxGYb3AKzP0/wiIQyWUIH/2FGXJ1Zaq6zoHTpDyQtgP8
         VbB5hghEmuuriUfOIpCIaoXDs4/+Q4G0hWfFPbb/TAK8UPVXJMTz51VySy6Y48SH91CM
         7+/uq3YP+vaKqiKCFqCJ0GEpMGWXZRQQT/BqmefxkU33C5mcmVbqNGPIR4zJ/bt9xKnF
         Lz/ObG3iccFmU6IhcZZyqgi1a+fZnER+ZLmc46MSUvyqp4ylHPid/Q7Hwb5HAM0Rq+bC
         kISQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Jl8Mmv8TFa3xihjFfUdj/bLafZG4ld0u3YFBuVUUiB3qvlEQhv5QyEvvRs2TAlMKv+VEFtZ6M8Cd@vger.kernel.org
X-Gm-Message-State: AOJu0YywbEUsNtJ0krg/ypTJHMtw2q0BAQAJPP7vjkUfuxMAZsGGYlrZ
	1UM1AbTYrx5ICR5gHFs/R8dw2d/7ab42vB1sSjD6+Ef2minXjKdIPrIX
X-Gm-Gg: AY/fxX6ok+g1gDLVbH76JIAWmUcApxUs10AQ24Xayu3+ZD0g+4i4CFid4yyh6coZxGd
	eQaqX1tg/+VoCYfmBpsJzL4ikSXkXxevWW5I1LpUT4AUxAvTb7uiKqS9I5hYEj5aumVovx62UPd
	QVi9izcGN+VXiKbDop1nMIG/dqn+UEa67PU4Sj6adfqN7C8pE4W5qw4sjXvjL8OIkYen94wk+tA
	/GcXAr20r7vDBXRAHJdMtb0gySfeuFcYT2jN/+Yzu5FbGyrrI8FJs0hZxbM2Gz3KGXl5ZK9TZnC
	SRyXmBXVcr/Qvq1zbbefBswchBPVywrQ52hQGh7TQKO3uu9TSEwldpGi1I3nNslysP1ixpVVkmi
	X9JTuTSJ3SEuBlhFUJ8xu8uZmTvjJz6nusSnFtGIjVby4SDQbQ5h0Vx93FhUFLO9v+K25ys4kUU
	hto1rgLpKu6Dz/Ag==
X-Google-Smtp-Source: AGHT+IErTs5c9CgixuwPe66I1GrE+7CrIdKOxcUVXSYOh9APmUqT1anvr8jNO2CVyH2qF3wF65kKhQ==
X-Received: by 2002:a17:902:cecc:b0:2a1:3895:e0d8 with SMTP id d9443c01a7336-2a13895e17dmr20413945ad.60.1765884910053;
        Tue, 16 Dec 2025 03:35:10 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ced60ff4sm73566345ad.76.2025.12.16.03.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:35:09 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	stable@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Date: Tue, 16 Dec 2025 19:34:55 +0800
Message-ID: <20251216113504.297535-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].

When xattr_find_entry() returns -ENODATA, search.here still points to the
position after the last valid entry. ext4_xattr_block_set() clones the xattr
block because the original block maybe shared and must not be modified in
place.

In the clone_block, search.here is recomputed unconditionally from the old
offset, which may place it past search.first. This results in a negative
reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().

Fix this by initializing search.here correctly when search.not_found is set.

[1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1

Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
Cc: stable@vger.kernel.org
Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/ext4/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 2e02efbddaac..cc30abeb7f30 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			goto cleanup;
 		s->first = ENTRY(header(s->base)+1);
 		header(s->base)->h_refcount = cpu_to_le32(1);
-		s->here = ENTRY(s->base + offset);
+		if (s->not_found)
+			s->here = s->first;
+		else
+			s->here = ENTRY(s->base + offset);
 		s->end = s->base + bs->bh->b_size;
 
 		/*
-- 
2.43.0


