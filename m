Return-Path: <linux-ext4+bounces-5822-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC19F953B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6CC165484
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80B21B1A8;
	Fri, 20 Dec 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqP2QCWo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F7218EAD;
	Fri, 20 Dec 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707861; cv=none; b=jsmcphmS0g59Usx9WTahLDjT9bqL/PpywcM6CJ6CYFOrliN2qLLpYo5oov0wgktY9OLOESoNbkE9NKy2ARnJQHX+R9gj0ICWl8Dtm+kVReGTUu99qeyTrC0nm86oMD1/MMEviSEohW/Df0MQmVmCw7LQx1tRsy5lrdM5+C4RgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707861; c=relaxed/simple;
	bh=su8Ua363bEZ70nkNKIIg0EKMqaF81s6s+jj0gTjdL/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VwBN4SrQMNKvvlb9ualtcwtNmbVG3A+sMDzGBvwzINEldEvI7l4kMsvyB8CkuGZAE9el4jppytloUCZAn4k6JsTfb4VkP1VRCVri9vRbyq3UNzormjPiOHgsoewovc96uveLFD1j9zjIyeAuxQj0CKpdgoRU1qn0bwykMWOXyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqP2QCWo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163dc5155fso19075605ad.0;
        Fri, 20 Dec 2024 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707858; x=1735312658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmj9/pTDw2gOBkddLbrIYaTTjqQ+JT2Ti5zDw8H8ULk=;
        b=HqP2QCWofZASl0xHjaj0dJ0e3c5EVAx06yOH73Mm2zPEMei1KqfIvlUPpHarzCgw/K
         PqIv0WF1d3Z3okkoJOtG73EMy+I01tTSmqU8A8nHGhj/4Pj3nI1rL/60AJCupvKyWt+n
         6r0tLynAcJCa69IPKcmNV5qaPJODd/jGo0p/VpzT7pOOzw9pAB+qN4MlJKGyd7HosbkK
         UIv1UB49aCqEE9nRIoHdiUJtGgsMGd/iktYTd5E3oByeobNnuVW4eyEMRzb+Adyw42/3
         2AMmz4HdnEUqrBYWHpI9BPOCq9ZlUB7BmmETNKkUbNEgnaij6pAdmhz2/Vtcq01W7jyK
         WJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707858; x=1735312658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gmj9/pTDw2gOBkddLbrIYaTTjqQ+JT2Ti5zDw8H8ULk=;
        b=ROz2FL2VujNwqbDtOTcDnDGdJ8HVfZJtf2Sx+b8q5u8JavUq4gaK4vFcZJ/uXthYG3
         l96xmdB8mAOYdI/y0N7KhoJcBuJSeE3VZ6GQlbO1p1Lo7ZBviJVB+QbwmvED7XBXmG8v
         oz1Sz5FdSEW5er4ib40L1EiOsYBfAdF6lWPM/UKQl+W9KWxcy9UmQsT+f8H1i9Fzf9ew
         FPG32IGzlF3rhTSWAFNR018EVZiqBtPB1qf0UZpZPZgXhGX49CC7pgCpSUkCt0/yZG54
         i9Vow0G/o8TkqNQlTl2Bf1Cnfu+k2/+k58/N9qSkpP5j1ffq2QkBOnM/Xr31h9VsBRj1
         HKdA==
X-Forwarded-Encrypted: i=1; AJvYcCXTuO5xPNOMsP/zhoU2RbHDQnGisVtQEcCGSXQLb7b9IYWwm4E32DjaG75AS8nRnZroo3zfSHGK3Vr/Fyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zomTBQV1LwoZBw0AEJJ+HpCssaUQM9Wht5D5wBCfkdcCSoGT
	HcMFN1HlNHK0JnoQOcNomye0ikRSgPSP5BJJAPyy6kHGEMpZdkC/1nX2wKqulaiNZQ==
X-Gm-Gg: ASbGnctlceNEi9ifH0pEkC7iVh3+uFAdVPbqb5AtUTp9VnxdDDPsQys2Ym0EFzwl39b
	OHGgMQbvOWZUSQaVLK0fa6TM6KmbTigrmGnI24BMEa+IoUa143ieA8FFhkjl9yei0uF3oGD20KO
	1h+yObXF0Mfrfv+qq3K7Nh9CQ2qEtnpBuJF+BRlB7uYIwLgNpZ1CWLoyDBYjiDS/qtQbbei5fqn
	MZXWqgLXqEe4X4Vsuc4yR+8wghDTmLwj/atGJo2EhjoHakZO0ObduhCe11N/ks=
X-Google-Smtp-Source: AGHT+IFXENev6IbTXgpUxqsy19jG6O9t1svzbpqwBvn/CFq9By2c11IHTF+rljpappZVyxsw9blo8Q==
X-Received: by 2002:a17:903:1c2:b0:216:2c3b:61ba with SMTP id d9443c01a7336-219e6f3320dmr34844205ad.56.1734707858546;
        Fri, 20 Dec 2024 07:17:38 -0800 (PST)
Received: from localhost ([240e:404:6e10:2b36:20a1:a4d1:f531:7695])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca029ccsm30080935ad.260.2024.12.20.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:17:38 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 7/7] ext4: Store truncated large files as inline data.
Date: Fri, 20 Dec 2024 23:16:25 +0800
Message-Id: <20241220151625.19769-8-sunjunchao2870@gmail.com>
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

Ext4 provides the flexibility to store file data inline, directly
within the inode, and also supports automatic conversion from inline
to extent data when necessary. However, it lacks a mechanism to convert
extent-based data to inline data, even if the file size permits.

This patch fills the gap by automatically converting truncated files
to inline data when possible, resulting in improved disk space efficiency.
Below is a comparison of results before and after applying the patch set.

Before:
root@q:linux# dd if=/dev/urandom bs=1M count=10 of=/mnt/ext4/test
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.0770325 s, 136 MB/s
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
File size of /mnt/ext4/test is 10485760 (2560 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    2559:          0..         0:      0:             last,unknown_loc,delalloc,eof
/mnt/ext4/test: 1 extent found
root@q:linux# echo a > /mnt/ext4/test
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
File size of /mnt/ext4/test is 2 (1 block of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:      34304..     34304:      1:             last,eof
/mnt/ext4/test: 1 extent found

After:
root@q:linux# dd if=/dev/urandom bs=1M count=10 of=/mnt/ext4/test
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.0883107 s, 119 MB/s
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
File size of /mnt/ext4/test is 10485760 (2560 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    2559:      38912..     41471:   2560:             last,unknown_loc,delalloc,eof
/mnt/ext4/test: 1 extent found
root@q:linux# echo a > /mnt/ext4/test
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
Filesystem cylinder groups approximately 78
File size of /mnt/ext4/test is 2 (1 block of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       1:    4340520..   4340521:      2:             last,not_aligned,inline,eof
/mnt/ext4/test: 1 extent found

Using filefrag, we can see that after applying this patch,
large truncated files also utilize the inline data feature.

This patch has been tested with xfstests' check -g and has not
introduced any additional failures.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/inline.c | 24 +++++++++++++++++++++++-
 fs/ext4/inode.c  |  5 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2abb35f1555d..ff107f7ab936 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -667,13 +667,22 @@ static int ext4_generic_write_inline_data(struct address_space *mapping,
 	struct folio *folio;
 	struct ext4_iloc iloc;
 	int retries = 0;
+	bool none_inline_data = inode->i_blocks != 0;
+	int credits;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
 		return ret;
 
 retry_journal:
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
+	if (none_inline_data)
+		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+			credits = ext4_writepage_trans_blocks(inode);
+		else
+			credits = ext4_blocks_for_truncate(inode);
+	else
+		credits = 1;
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		goto out_release_bh;
@@ -698,6 +707,19 @@ static int ext4_generic_write_inline_data(struct address_space *mapping,
 		goto out_release_bh;
 	}
 
+	if (none_inline_data) {
+		down_write(&EXT4_I(inode)->i_data_sem);
+		ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+
+		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+			ret = ext4_ext_remove_space(inode, 0,
+						    EXT_MAX_BLOCKS - 1);
+		else
+			ret = ext4_ind_remove_space(handle, inode, 0,
+						    EXT_MAX_BLOCKS);
+		up_write(&EXT4_I(inode)->i_data_sem);
+	}
+
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..fb1e4caa37b0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4164,6 +4164,11 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
 		ext4_block_truncate_page(handle, mapping, inode->i_size);
 
+	if (ext4_has_feature_inline_data(inode->i_sb) &&
+	    !(ei->i_flags & (EXT4_EA_INODE_FL|EXT4_DAX_FL)) &&
+	    inode->i_size < ext4_get_max_inline_size(inode))
+		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+
 	/*
 	 * We add the inode to the orphan list, so that if this
 	 * truncate spans multiple transactions, and we crash, we will
-- 
2.39.5


