Return-Path: <linux-ext4+bounces-3977-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C879656FF
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CF11F23385
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307D1531F3;
	Fri, 30 Aug 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Von9vg47"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B153136351;
	Fri, 30 Aug 2024 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996276; cv=none; b=r6X9IPWGD58/aJTHsy+meXs+IpmBNQ0766mvpRGhG5gDYPcXARCEo8xwSITmGsuv95d2ic1wSiuyFgFR+k7jN63Lf6dQsrpycLOPZayBbzK/7MnWBJN0StEHK4a2CHiT8iwAtNeTC/+oRVnNpZqajm7iKt4I6ic4eESwUTxWYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996276; c=relaxed/simple;
	bh=o8Y5ytUvlYj85U4LvQ9BLdLnfjD/2YlafDawCcihM3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6cm9b1DVhVAZ50KYUZP+/YMXBOC6OVZCbf2xcC2R2AjZgk3NiV5E28YebHKKAvhqVJqQDpMZFgwBl5eIFhP1SRDLcNfw404t6vLmY6xV7UXIfUkJcTEsZJ+nB8hje+pYrE+CGvAkclk5fb3GWOemE1FzHBtKumwA9hJeqeLXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Von9vg47; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso901284a12.0;
        Thu, 29 Aug 2024 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724996274; x=1725601074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZE3w5xcdYxq7R8uMMW9Ui1xfRyk6LmkP5wh78+WNYQ=;
        b=Von9vg47207v0yRvoBMaShqnSsF7t/XBUswnD3W4Rhpgzr1YVOAiZW8Wtlsl5Zzt/t
         4nO6dKCXGwVmAESvKLmiGUCbI0jEELG7YSYABSi/hTsJedc/rJCwJm2ZaQw3L+lSUM56
         pE+P/7DzkF1Ac1Evg9BD9omcOg2OuMrVg/SNYB94vHfeanGY9og2Hw2iabNWcVqMH727
         CDGS2o0RuLsFdknXLuWF7AtS2ar9tG53p8AzmHXpj20mj/QVPtC7WW4KkC01n1Y5I9UL
         xXCJ3rAH8xpYkPz68gP2dnn4Pp347NSJC7x9Q0v0vCkey+qB5Esd+995IGXcpQHe5ZCX
         IBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996274; x=1725601074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZE3w5xcdYxq7R8uMMW9Ui1xfRyk6LmkP5wh78+WNYQ=;
        b=hekHJofCGHzWNIZ8LhjH6arLLBmTxfD2GfMIb69iIpDpP3tVdFaiB+GuQ3S57zUt+Q
         KTwmX8T38U1oASpjAiUiBBz01HUSllaPFTMXsdGyJYdjjiaVAZrfvLX+8zOpucOfmEQd
         MiSuLlGsNe3Vnz0TJXic73ju7nFs7gO3z3UHaMS7qO99zS5dYqR/jvQD+f3WEW6AvWvh
         HdnN1/OHG/Cd+f/Nz1oA4fOF3cgESynYK6im8PIX+DAz7QDcj4azCYq5vd3LSL3CF9vp
         ASQoomkJIFVbn/vFuzv4ZHfsHHEUkod9+fABab8sV7eS4wgt4EMwF8pf/Zx5Q4rzIVRd
         sAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtcfRrIb2e2nM/Ox47GRnNN3jhxF7/z4LfoTbTPU4wsMfk/dJgBnT2I3AtP3zAqumi8lnWZHAtWVec85M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtlziKP/icT6DhfUCZcIc/L4sZmVoUn8Ac/TdozCLJB92DUDC
	rN00Wn9XZBz/GZ0zNna/6OSP3TJ7xU3smqI6wGw7b/8YCs2GWxL+
X-Google-Smtp-Source: AGHT+IHcu1RYo4NUt6URZZToo91Zs42//QbIp7vnbmPJflLz8ldH2Soc3QNHxeom6HV60lcDXqzpEg==
X-Received: by 2002:a05:6a21:6f83:b0:1c2:8af6:31d3 with SMTP id adf61e73a8af0-1cce0ff185cmr5486770637.10.1724996273515;
        Thu, 29 Aug 2024 22:37:53 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534801sm19784075ad.154.2024.08.29.22.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:37:53 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	ebiggers@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/4] ext4: fix a potential assertion failure due to improperly dirtied buffer
Date: Fri, 30 Aug 2024 13:37:38 +0800
Message-Id: <20240830053739.3588573-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830053739.3588573-1-zhangshida@kylinos.cn>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

On an old kernel version(4.19, ext3, data=journal, pagesize=64k),
an assertion failure will occasionally be triggered by the line below:
-----------
jbd2_journal_commit_transaction
{
...
J_ASSERT_BH(bh, !buffer_dirty(bh));
/*
* The buffer on BJ_Forget list and not jbddirty means
...
}
-----------

The same condition may also be applied to the lattest kernel version.

When blocksize < pagesize and we truncate a file, there can be buffers in
the mapping tail page beyond i_size. These buffers will be filed to
transaction's BJ_Forget list by ext4_journalled_invalidatepage() during
truncation. When the transaction doing truncate starts committing, we can
grow the file again. This calls __block_write_begin() which allocates new
blocks under these buffers in the tail page we go through the branch:

                        if (buffer_new(bh)) {
                                clean_bdev_bh_alias(bh);
                                if (folio_test_uptodate(folio)) {
                                        clear_buffer_new(bh);
                                        set_buffer_uptodate(bh);
                                        mark_buffer_dirty(bh);
                                        continue;
                                }
                                ...
                        }

Hence buffers on BJ_Forget list of the committing transaction get marked
dirty and this triggers the jbd2 assertion.

Teach ext4_block_write_begin() to properly handle files with data
journalling by avoiding dirtying them directly. Instead of
folio_zero_new_buffers() we use ext4_journalled_zero_new_buffers() which
takes care of handling journalling. We also don't need to mark new uptodate
buffers as dirty in ext4_block_write_begin(). That will be either done
either by block_commit_write() in case of success or by
folio_zero_new_buffers() in case of failure.

Reported-by: Baolin Liu <liubaolin@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/ext4.h   |  3 ++-
 fs/ext4/inline.c |  7 ++++---
 fs/ext4/inode.c  | 42 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5f8257b68190..b653bd423b11 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3851,7 +3851,8 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
-extern int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
+				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
 #endif	/* __KERNEL__ */
 
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 0a1a8431e281..8d5599d5af27 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -601,10 +601,11 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto out;
 
 	if (ext4_should_dioread_nolock(inode)) {
-		ret = ext4_block_write_begin(folio, from, to,
+		ret = ext4_block_write_begin(handle, folio, from, to,
 					     ext4_get_block_unwritten);
 	} else
-		ret = ext4_block_write_begin(folio, from, to, ext4_get_block);
+		ret = ext4_block_write_begin(handle, folio, from, to,
+					     ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -856,7 +857,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
-	ret = ext4_block_write_begin(folio, 0, inline_size,
+	ret = ext4_block_write_begin(NULL, folio, 0, inline_size,
 				     ext4_da_get_block_prep);
 	if (ret) {
 		up_read(&EXT4_I(inode)->xattr_sem);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4964c67e029e..a28f279fd02f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -49,6 +49,11 @@
 
 #include <trace/events/ext4.h>
 
+static void ext4_journalled_zero_new_buffers(handle_t *handle,
+					    struct inode *inode,
+					    struct folio *folio,
+					    unsigned from, unsigned to);
+
 static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			      struct ext4_inode_info *ei)
 {
@@ -1041,7 +1046,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
-int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
+int ext4_block_write_begin(handle_t *handle, struct folio *folio,
+			   loff_t pos, unsigned len,
 			   get_block_t *get_block)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
@@ -1055,6 +1061,7 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 	struct buffer_head *bh, *head, *wait[2];
 	int nr_wait = 0;
 	int i;
+	bool should_journal_data = ext4_should_journal_data(inode);
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(from > PAGE_SIZE);
@@ -1084,10 +1091,22 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			if (err)
 				break;
 			if (buffer_new(bh)) {
+				/*
+				 * We may be zeroing partial buffers or all new
+				 * buffers in case of failure. Prepare JBD2 for
+				 * that.
+				 */
+				if (should_journal_data)
+					do_journal_get_write_access(handle,
+								    inode, bh);
 				if (folio_test_uptodate(folio)) {
-					clear_buffer_new(bh);
+					/*
+					 * Unlike __block_write_begin() we leave
+					 * dirtying of new uptodate buffers to
+					 * ->write_end() time or
+					 * folio_zero_new_buffers().
+					 */
 					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
@@ -1117,7 +1136,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		folio_zero_new_buffers(folio, from, to);
+		if (should_journal_data)
+			ext4_journalled_zero_new_buffers(handle, inode, folio,
+							 from, to);
+		else
+			folio_zero_new_buffers(folio, from, to);
 	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
@@ -1215,10 +1238,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	folio_wait_stable(folio);
 
 	if (ext4_should_dioread_nolock(inode))
-		ret = ext4_block_write_begin(folio, pos, len,
+		ret = ext4_block_write_begin(handle, folio, pos, len,
 					     ext4_get_block_unwritten);
 	else
-		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
+		ret = ext4_block_write_begin(handle, folio, pos, len,
+					     ext4_get_block);
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
 					     folio_buffers(folio), from, to,
@@ -2951,7 +2975,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(NULL, folio, pos, len,
+				     ext4_da_get_block_prep);
 	if (ret < 0) {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -6205,7 +6230,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		if (folio_pos(folio) + len > size)
 			len = size - folio_pos(folio);
 
-		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
+		err = ext4_block_write_begin(handle, folio, 0, len,
+					     ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
 			if (ext4_journal_folio_buffers(handle, folio, len))
-- 
2.33.0


