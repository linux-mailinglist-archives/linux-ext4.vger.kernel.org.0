Return-Path: <linux-ext4+bounces-4227-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7067D97CC06
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369442847C4
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B21A072C;
	Thu, 19 Sep 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ouvf36PG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF81A0718
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762006; cv=none; b=SDjc+QJFzghlt69e32N/GehbLTXOjEq+hmhHV31Q5gFx0U0FxoWCSfuw+Q7NHLTRdjo+tR75ZjFRapg2kRveUirhRS8T7ZRd6kcHaGmZzuN5B9ddG3c0CmBWq2AVBX6Jsq0jToC0B0RqBcA8PlBWKHvo70BlOifpiOynA7RPqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762006; c=relaxed/simple;
	bh=TVOfK/KEvFnMHoMkHjBgKgeBfW812uGd0HtAyR0WnQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCGXNY4OfG+5wlsIRLi6uJF+j6zn6+nWZR1Lyu0g4ds1Zd7UBOd3+uChGvqB3phztYBKmYggy6hRgeiqoaTEZORD9RU/WL1toAka/vSem1WArbDqHoUajQe0/wpu7BzsHO60H+ddm20bcrnl1fODVdUR5dv+V+5ecsHHf10AzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ouvf36PG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726762003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J42C6q/FXZPCUSvnSAnn35Rn8chzdx2XnsN02GbHj8A=;
	b=Ouvf36PG1JTBYu6S5urrQPmgY/rTCWC91U8rqMgftTYesDG6uSTfBt1ooTWxLkyheAuAZ5
	hWWmgdCzYdne3u+UYHdwZd7lGV3Nx/u6BQ5VvxxYaAkQPtGeyY3g0ZLYiuWiepUGcK3xbc
	L7h1s5WzzKXTmyMKFF6Q29jlBWkPGVA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-wfQAY_bfMzKVfvtJnsgYFg-1; Thu,
 19 Sep 2024 12:06:37 -0400
X-MC-Unique: wfQAY_bfMzKVfvtJnsgYFg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50B971936125;
	Thu, 19 Sep 2024 16:06:36 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.9.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6590919560A3;
	Thu, 19 Sep 2024 16:06:35 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 2/2] mm: zero range of eof folio exposed by inode size extension
Date: Thu, 19 Sep 2024 12:07:41 -0400
Message-ID: <20240919160741.208162-3-bfoster@redhat.com>
In-Reply-To: <20240919160741.208162-1-bfoster@redhat.com>
References: <20240919160741.208162-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On some filesystems, it is currently possible to create a transient
data inconsistency between pagecache and on-disk state. For example,
on a 1k block size ext4 filesystem:

$ xfs_io -fc "pwrite 0 2k" -c "mmap 0 4k" -c "mwrite 2k 2k" \
	  -c "truncate 8k" -c "fiemap -v" -c "pread -v 2k 16" <file>
...
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..3]:          17410..17413         4   0x1
   1: [4..15]:         hole                12
00000800:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
$ umount <mnt>; mount <dev> <mnt>
$ xfs_io -c "pread -v 2k 16" <file>
00000800:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

This allocates and writes two 1k blocks, map writes to the post-eof
portion of the (4k) eof folio, extends the file, and then shows that
the post-eof data is not cleared before the file size is extended.
The result is pagecache with a clean and uptodate folio over a hole
that returns non-zero data. Once reclaimed, pagecache begins to
return valid data.

Some filesystems avoid this problem by flushing the EOF folio before
inode size extension. This triggers writeback time partial post-eof
zeroing. XFS explicitly zeroes newly exposed file ranges via
iomap_zero_range(), but this includes a hack to flush dirty but
hole-backed folios, which means writeback actually does the zeroing
in this particular case as well. bcachefs explicitly flushes the eof
folio on truncate extension to the same effect, but doesn't handle
the analogous write extension case (i.e., replace "truncate 8k" with
"pwrite 4k 4k" in the above example command to reproduce the same
problem on bcachefs). btrfs doesn't seem to support subpage block
sizes.

The two main options to avoid this behavior are to either flush or
do the appropriate zeroing during size extending operations. Zeroing
is only required when the size change exposes ranges of the file
that haven't been directly written, such as a write or truncate that
starts beyond the current eof. The pagecache_isize_extended() helper
is already used for this particular scenario. It currently cleans
any pte's for the eof folio to ensure preexisting mappings fault and
allow the filesystem to take action based on the updated inode size.
This is required to ensure the folio is fully backed by allocated
blocks, for example, but this also happens to be the same scenario
zeroing is required.

Update pagecache_isize_extended() to zero the post-eof range of the
eof folio if it is dirty at the time of the size change, since
writeback now won't have the chance. If non-dirty, the folio has
either not been written or the post-eof portion was zeroed by
writeback.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 mm/truncate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..6e7f3cfb982d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -797,6 +797,21 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 	 */
 	if (folio_mkclean(folio))
 		folio_mark_dirty(folio);
+
+	/*
+	 * The post-eof range of the folio must be zeroed before it is exposed
+	 * to the file. Writeback normally does this, but since i_size has been
+	 * increased we handle it here.
+	 */
+	if (folio_test_dirty(folio)) {
+		unsigned int offset, end;
+
+		offset = from - folio_pos(folio);
+		end = min_t(unsigned int, to - folio_pos(folio),
+			    folio_size(folio));
+		folio_zero_segment(folio, offset, end);
+	}
+
 	folio_unlock(folio);
 	folio_put(folio);
 }
-- 
2.45.0


