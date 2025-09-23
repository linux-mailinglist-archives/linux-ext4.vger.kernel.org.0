Return-Path: <linux-ext4+bounces-10365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC50B953CD
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F54616DE1E
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513CA31BCA3;
	Tue, 23 Sep 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5f62Dcp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9930F545
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619522; cv=none; b=BqF+1UZte5aO6oiUG11JRaoZmwubsNTrOTaC6Ijm1/tsuxGBAL9ciUXjbSEYzm31PPN/Phm1Nw03y8O07HpR7PMdHUspWaM49GaUQaI1aoL0CVZNzlYJUEpogzsf+AizjNIDb33msBI5aafd+XK7oohYjnaPRKvR27+lfmxuTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619522; c=relaxed/simple;
	bh=PHiv/oFqAssT7C2vXwJaDcIHi9lPA2xHzt6CUrRq4Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFwnY4/NkCYsmJShb18rtPJIHu4rXxGxZzuTmMSadEx7zeMxUSu7uQ4CkHJ/+osEU08pARz46obFGqERqTJ61rGsUUMSR1yP6wWe3PmyJ2paC2lEZVv060AROvdBIfPezpJdjmx6yc/SKC26inIqKA4YOS9kMt5OFBBxFyjX2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5f62Dcp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27c369f8986so9403595ad.3
        for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619520; x=1759224320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0zopWVobPuDweXBkACHWGSxHrDh+qcAB4VX8MwOBTo=;
        b=S5f62DcpiUUsYU+Ygi1dc+PaUmAsV7QQrvqx6TAuPpF1a8XC6lRzCnqdXUwcWoReKF
         4ZVTI38f11Ip5gB07Rz15OKyVjvYPAnfS3tHcrVGdl6+Zsj7ctSTxzteLZn3tft4OJyX
         FnJkysEXoSRUthXpvcpB0lzGv1i12LCbgJRXz/cd2L9dxrVQKV63I3tAogl66DcBzffY
         UeK76IS8eI4GW8qga6ItrqJs+KcuhApPDpLcQ3Rmgj1J13QCFpux6rHvyUo8gFeC8bO5
         A1v/90ffd8WsBCaRvXEXkaZy/ZTLVsWeZzrYSAqMrErbEm4lMNpXNixeUA7Xjh7DctpB
         At3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619520; x=1759224320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0zopWVobPuDweXBkACHWGSxHrDh+qcAB4VX8MwOBTo=;
        b=KZC2LewfXKEUEe79F0SHYH801eOuvKQJ8WP+laR0TKyoQKPZ4jCBVka8RPnBHAFntz
         KbHtz1tmBMUSjZBfpgYDKUfwhYKI5ayw5LRBqVV0ZIusQLlA+up2Qa5e9p3UK3vIT8hg
         +OZ16V/dBARM9C4dQzfTiEgI0AcWyq/booqq1RoqTCl1ktlt0F5Q+eigKrjLe1R1KFJt
         Oq3Wxhz0niNdtP/HLV60wo0Kgrv0wf1J5t/Bx8mwF8gdnnsc3UVIl17x5FeX7/+qX6wj
         1ZPkV9SPFDkUjvGG/lLBmPGuEJ2m4NmEi80MNw7jA5ZDgPeZI5lF+p7C7Au/R9nvWFRC
         1IcA==
X-Forwarded-Encrypted: i=1; AJvYcCVlHVCDeYOlAmAoh5PBSWSSXTdq3IthslG75WsmxO3rZEmBWcEQ6d3FzZE8N2vtVYaSNAn096y6F6mX@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMqQuBhbhzmeAqRZ3Da2OtnjDrXybCKyafNqTxwMGuaH0Yusx
	laeJGWBtUyN7IpJcMsLqSJejdiLhZjaEgFwzTv4LbgMqMAZQLtgPYRjJ
X-Gm-Gg: ASbGnculhDPggdUIwdegwORMpg/mCi++qClf8ziYtjp1sIoNI2E50Q+tZXfA0fIqm9g
	7P2RdkctwdsY0uKoSB0w1sUeaWYc5inxqi41tJ5AuGu/U4qANR090PJG3EZBs7s1NVn4bAEAMeX
	Gkd7AKaqA0U5DJGZ7Cu+IPrzXmvzoZIeN86DnMun+nEGrGT0mwgXJeK2yHnLqr3hvZIKkrEmQ+b
	vNgmwEqzsALU79WExLhxS6GV+XXiqFLLx8uTg0SRp9DhgyHCtss1ohtnEDW8oWQt+DC1vuIqoWY
	FMu6D92gbdD1fzGjzX2nywi8V2CWf6sQEOThw25yuk829ApudaQc0LOSi1T5giWzpAXKfUUfGKQ
	xQBuU/xEVZlqRKHv/nXpV1RmAJAku6RlF4p9tzW+pIuavHLXbrs7qLjUN0w/mIkKzMNhG1h07JA
	GA
X-Google-Smtp-Source: AGHT+IGn7aSKodmfL9W3POGby8TbXXLOzrsHEIGZd2B2OQ1QB9XffdinzZ+NDU0Z9FIqeA8PqUP8VA==
X-Received: by 2002:a17:902:e5c5:b0:273:31fb:a86d with SMTP id d9443c01a7336-27cc8654955mr20149525ad.48.1758619519808;
        Tue, 23 Sep 2025 02:25:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:5a:8db4:4ddc:e3c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df74asm156690375ad.94.2025.09.23.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:25:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: [PATCH] ext4: validate xattr entries in ext4_xattr_move_to_block
Date: Tue, 23 Sep 2025 14:55:12 +0530
Message-ID: <20250923092512.1088241-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During inode expansion, ext4_xattr_move_to_block() processes xattr entries
from on-disk structures without validating their integrity. Corrupted
filesystems may contain xattr entries where e_value_size is zero but
e_value_inum is non-zero, indicating the entry claims to store its value
in a separate inode but has no actual value.

This corruption pattern leads to a WARNING in ext4_xattr_block_set() when
it encounters i->value_len of zero while i->in_inode is set, violating
the function's invariant that in-inode xattrs must have non-zero length.

Add validation in ext4_xattr_move_to_block() to detect this specific
corruption pattern and return -EFSCORRUPTED, preventing the invalid
data from propagating to downstream functions and causing warnings.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..60e224c622b4 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2607,7 +2607,10 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
 	int needs_kvfree = 0;
 	int error;
-
+	if (value_size == 0 && entry->e_value_inum != 0) {
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
 	bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
 	b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
-- 
2.43.0


