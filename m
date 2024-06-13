Return-Path: <linux-ext4+bounces-2875-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBAE90743D
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2024 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4CF1F220AC
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F27144D1F;
	Thu, 13 Jun 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="rmDFM4Bm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF27143895
	for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286515; cv=none; b=kYEIZK0DeHNkmc2t296JoyTqj2vGoSXLeHi+Az5YjsRBxFyOJBn9tIPLUfNzV2dCZ5j+AwGfw2zcKcIDC7+anzlqMsxEnvlSwYoHFiCu5iYjuNgQjZco/XtWV4FMXIdHiE2geCh/wSjmFvEw6m6Um9fsiiwxUTA+AWu5EVs9AoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286515; c=relaxed/simple;
	bh=jEEBdVuKEuJBbrShQff2AKG6F9qOOzWHj9ofq3GOtqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=syz6kTDqECFOqrx/9rr/4qKLtYG0D54NRtHv5qNAWj7K7bhbLcT/rao5pRNB96LqqZwqhg4f9bTyw+ppMIEb+8sO2t791ttgS8MMsAuRKSNYOqCzWgP1dNvpmVSKQkPr+o+1urpX2jmIpT3tLX49moPy/l7mVOvJriLUDzwha3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=rmDFM4Bm; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-57a2529554eso93820a12.0
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2024 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1718286509; x=1718891309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyL394KBw2Z6LA6a/Q2YL4+8+ZukJAmciJ1Xrb3bTfo=;
        b=rmDFM4BmyLdxeVxVYOsNViAX2qRZ4SjFpCFe/g0uNBT8CtBJvnsCXpUs/cF0i+YHSQ
         AwVHBYFrrTqjVoS+WrQTQ9zpqf2v+0US8uDfHq4ysmvPlmDMBBY8I789FHmMACmU9raY
         QneBuDxHbLcoZeMm27+mgw6090/Yhar1dzp8Xc7pKrZPm8rmaQ4AOJ93TOk8xXWfM2PT
         GaQcIv5N6LjPfL8D/+GdhIiVvCAie/JUF6DOrXjEDOEKZCFwxiEm0RzAQ7++TzGtqG+5
         y/acGLgRzJdo+YT3muJhY1RJzWq7/zP8RRzUpjzgn252DVNO9ErfK/SbcpgyYVh0xwyf
         x5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286509; x=1718891309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyL394KBw2Z6LA6a/Q2YL4+8+ZukJAmciJ1Xrb3bTfo=;
        b=vOyebVOiwvgyX30vqGTA50xhTCoMmfyyvE7YcP77Jmt/ZXYWUVDqwGhtMouQJ8IsNi
         8DXzwEC8+h5jrwlSnQeV3uo888FG7ww+IzCi0WyXBHVTjJiniJEXy61ax/7qA9n+xj4+
         hGgIXmWtC4CaLuloCNzi3yBVoWOPsEHdJGZuOpDPIOmcUIgjEwXBsj3jHZzKPAhzsSMq
         i5O5vC4KEMPdCNV5Q6b4D5OUEJ3aajHHP/sFGr0omS77IqNxrT3o8LDKP3LAICVnpDlt
         B/gYzcqx1+mi+qCJdIIEoiRK4VeiyFcv3YvYF6Z1SHxIs1Wq6nT2wUqFQdVKzaFywaEI
         +6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOYK7pBF/Iyf83lrP86/lBUgSZnOXe8a8UEJU6hJWrET4GAhTs2lXk5T8wXsDLUMDFOjH9QmO1OU+aHxeSHUgZYtGqvh4DxzOaLg==
X-Gm-Message-State: AOJu0Yx2yt9rmrbwPTyxG0V8HcyL9Uzkkx2eRyQYUUtpJlFgXpztm2mF
	qM5xTfyt7rfiZgwtJVYo8vz1csu8LxlX938fjXB+bkVOSewZAYOngSwxAo0UuQ8=
X-Google-Smtp-Source: AGHT+IGA4TFp9nPo4T+ZXYozM/JqJdEKNmqRi9Juoezk/ujN31cHheX49nDZoa0iphC59RNJEFmoRA==
X-Received: by 2002:a17:906:d7a6:b0:a67:a2e0:9dd9 with SMTP id a640c23a62f3a-a6f5f2ef325mr27214666b.2.1718286509513;
        Thu, 13 Jun 2024 06:48:29 -0700 (PDT)
Received: from nkaminski-desktop.lan ([37.31.128.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd79sm74483766b.132.2024.06.13.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:48:29 -0700 (PDT)
From: =?UTF-8?q?Norbert=20Kami=C5=84ski?= <norbert.kaminski@infogain.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Norbert=20Kami=C5=84ski?= <norbert.kaminski@infogain.com>,
	syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com
Subject: [PATCH] fs/ext4: Prevent encryption/decryption of unaligned blocks in aes_encrypt
Date: Thu, 13 Jun 2024 15:48:25 +0200
Message-Id: <20240613134825.53238-1-norbert.kaminski@infogain.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzbot is reporting an uninitialized value in aes_encrypt(). The block
cipher expects the bytes to encrypt or decrypt to be a multiple of the
cipher’s block size. However, when ext4_write_begin() is called and new
folios are allocated, they might not be aligned to the required block
size.

To ensure that padding bytes are automatically initialized in the
ext4_write_begin, this patch adds __GFP_ZERO to the existing GFP masks.
This adjustment is applied only when the CONFIG_FS_ENCRYPTION is
defined.

Syzbot reported:

=====================================================
BUG: KMSAN: uninit-value in subshift lib/crypto/aes.c:149 [inline]
BUG: KMSAN: uninit-value in aes_encrypt+0x15cc/0x1db0 lib/crypto/aes.c:282
 subshift lib/crypto/aes.c:149 [inline]
 aes_encrypt+0x15cc/0x1db0 lib/crypto/aes.c:282
 aesti_encrypt+0x7d/0xf0 crypto/aes_ti.c:31
 crypto_ecb_crypt crypto/ecb.c:23 [inline]
 crypto_ecb_encrypt2+0x18a/0x300 crypto/ecb.c:40
 crypto_lskcipher_crypt_sg+0x36b/0x7f0 crypto/lskcipher.c:228
 crypto_lskcipher_encrypt_sg+0x8a/0xc0 crypto/lskcipher.c:247
 crypto_skcipher_encrypt+0x119/0x1e0 crypto/skcipher.c:669
 xts_encrypt+0x3c4/0x550 crypto/xts.c:269
 crypto_skcipher_encrypt+0x1a0/0x1e0 crypto/skcipher.c:671
 fscrypt_crypt_data_unit+0x4ee/0x8f0 fs/crypto/crypto.c:144
 fscrypt_encrypt_pagecache_blocks+0x422/0x900 fs/crypto/crypto.c:207
 ext4_bio_write_folio+0x13db/0x2e40 fs/ext4/page-io.c:526
 mpage_submit_folio+0x351/0x4a0 fs/ext4/inode.c:1869
 mpage_process_page_bufs+0xb92/0xe30 fs/ext4/inode.c:1982
 mpage_prepare_extent_to_map+0x1702/0x22c0 fs/ext4/inode.c:2490
 ext4_do_writepages+0x1117/0x62e0 fs/ext4/inode.c:2632
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x1bf/0x370 mm/filemap.c:788
 generic_buffers_fsync_noflush+0x84/0x3e0 fs/buffer.c:602
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x5ba/0x13a0 fs/ext4/fsync.c:151
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2795 [inline]
 ext4_buffered_write_iter+0x9ad/0xaa0 fs/ext4/file.c:305
 ext4_file_write_iter+0x208/0x3450
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages mm/mempolicy.c:2335 [inline]
 folio_alloc+0x1d0/0x230 mm/mempolicy.c:2342
 filemap_alloc_folio+0xa6/0x440 mm/filemap.c:984
 __filemap_get_folio+0xa10/0x14b0 mm/filemap.c:1926
 ext4_write_begin+0x3e5/0x2230 fs/ext4/inode.c:1159
 generic_perform_write+0x400/0xc60 mm/filemap.c:3974
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x208/0x3450
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
=====================================================

Reported-by: syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
Signed-off-by: Norbert Kamiński <norbert.kaminski@infogain.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9ccf5fe0..965f790a9d36 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1156,6 +1156,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * the folio (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
+	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
+		mapping_set_gfp_mask(mapping,
+				     mapping_gfp_mask(mapping) | __GFP_ZERO);
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
@@ -2882,6 +2885,9 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 retry:
+	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
+		mapping_set_gfp_mask(mapping,
+				     mapping_gfp_mask(mapping) | __GFP_ZERO);
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
-- 
2.34.1


