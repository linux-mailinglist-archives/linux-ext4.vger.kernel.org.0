Return-Path: <linux-ext4+bounces-7947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F21ABA1E4
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA41A22AD9
	for <lists+linux-ext4@lfdr.de>; Fri, 16 May 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1621FF57;
	Fri, 16 May 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOwNfwNm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D0635
	for <linux-ext4@vger.kernel.org>; Fri, 16 May 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416883; cv=none; b=GuTeJ5bBQq/ycors9BEWBsVLO0/FNErMn4kWTXZjVZTtstsq/3IC+4il5iBNsOFOiMoblz2eFz2xCYcb1gCth00gL3xSpXyKZuSKGGPg+ae1KJG3vzm7+AwfhSzAGaugeGXn1vMhmICLEtBqnu7xDP4D5YwKRRofX+1XgE+Hvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416883; c=relaxed/simple;
	bh=qf2D3u7VCqELdXrWpZZCziphwwe7xkFX8ENmpkQHpto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzNRXTbop7/gaz+CbQ65BkBhy6bTkqR+sdrzTR15RmNCam4SQrA+Zy8i3c4jygJ4V28NIHD2g+1vdBPeuMzJPopZH0muyBIEOcTXI3NWpxMOxCY1LtlQN59uCZ5MW2ipgqC8UrqoCXNsfvr14rYpTh6fgGkEcOHITBn3TLrY3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOwNfwNm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747416880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2j6qaf7MF4K44eafysgYfs5oShiWIvny3aScQSIWyOs=;
	b=iOwNfwNmo7PzoQQtHTAJJHvtrE1Y4ZBOpjMB9XOdx+JzZMiFNl2dzRNDG2xAxx8+Tvgck0
	E+joNXWtOMUXZ8YAZ0dFE5og+FCch03u7tYUIvqizOQ8uXXo8z3p1+LdDBQ6pKuweJtFIe
	LYZzYBgWPNASwC8mt9VvZFl/Og0ePnc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-E6vKXFliMu29Wgh7wqiz_A-1; Fri,
 16 May 2025 13:34:37 -0400
X-MC-Unique: E6vKXFliMu29Wgh7wqiz_A-1
X-Mimecast-MFC-AGG-ID: E6vKXFliMu29Wgh7wqiz_A_1747416876
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 183F21800361;
	Fri, 16 May 2025 17:34:36 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73596180045B;
	Fri, 16 May 2025 17:34:35 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: only dirty folios when data journaling regular files
Date: Fri, 16 May 2025 13:38:00 -0400
Message-ID: <20250516173800.175577-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

fstest generic/388 occasionally reproduces a crash that looks as
follows:

BUG: kernel NULL pointer dereference, address: 0000000000000000
...
Call Trace:
 <TASK>
 ext4_block_zero_page_range+0x30c/0x380 [ext4]
 ext4_truncate+0x436/0x440 [ext4]
 ext4_process_orphan+0x5d/0x110 [ext4]
 ext4_orphan_cleanup+0x124/0x4f0 [ext4]
 ext4_fill_super+0x262d/0x3110 [ext4]
 get_tree_bdev_flags+0x132/0x1d0
 vfs_get_tree+0x26/0xd0
 vfs_cmd_create+0x59/0xe0
 __do_sys_fsconfig+0x4ed/0x6b0
 do_syscall_64+0x82/0x170
 ...

This occurs when processing a symlink inode from the orphan list. The
partial block zeroing code in the truncate path calls
ext4_dirty_journalled_data() -> folio_mark_dirty(). The latter calls
mapping->a_ops->dirty_folio(), but symlink inodes are not assigned an
a_ops vector in ext4, hence the crash.

To avoid this problem, update the ext4_dirty_journalled_data() helper to
only mark the folio dirty on regular files (for which a_ops is
assigned). This also matches the journaling logic in the ext4_symlink()
creation path, where ext4_handle_dirty_metadata() is called directly.

Fixes: d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi Jan,

I'm not intimately familiar with the jbd machinery here so this may well
be wrong, but it survives my testing so far. I initially hacked this to
mark the buffer dirty instead of the folio, but discovered jbd2 doesn't
seem to like that. I suspect that is because jbd2 wants to dirty/submit
the buffer itself after it's logged..?

Anyways, after that, this struck me as most consistent with behavior
prior to d84c9ebdac1e and/or with the creation path, so I'm floating
this as a first pass. Is my understanding of d84c9ebdac1e correct in
that it is mainly an optimization to allow writeback to force the
journaling mechanism vs. otherwise waiting for the other way around
(i.e. a journal commit to mark folios dirty)? Thoughts appreciated..

Brian

 fs/ext4/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..d3c138003ad3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1009,7 +1009,12 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
  */
 static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
 {
-	folio_mark_dirty(bh->b_folio);
+	struct folio *folio = bh->b_folio;
+	struct inode *inode = folio->mapping->host;
+
+	/* only regular files have a_ops */
+	if (S_ISREG(inode->i_mode))
+		folio_mark_dirty(folio);
 	return ext4_handle_dirty_metadata(handle, NULL, bh);
 }
 
-- 
2.49.0


