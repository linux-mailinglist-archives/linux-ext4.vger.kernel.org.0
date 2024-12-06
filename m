Return-Path: <linux-ext4+bounces-5498-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E999E7111
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA873283603
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901601547E7;
	Fri,  6 Dec 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/3dOn88"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0632C8B;
	Fri,  6 Dec 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496675; cv=none; b=QTxSzgBOnuwJ8pleSGi0eRikHnf90j8NXuvxP+x6fAsbYcS4e96WzM6pdlooa0e4pKTUOxxkUORj8sDtZozw+rnwhAHBDvoQHf0qRgVjiNCQhS3ikTd8Yh8Q1ipFVfPx7h1rehI/LbDlsNOyU16H43sl6OjFM3YepQm9XcNGedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496675; c=relaxed/simple;
	bh=13eSWcU4Nk/MMZfNkZzUcGKVyak+9ExtY9iKBuNzmRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9f4Xu1zaEJLjvKbUvz2nfRzoRqZt4IdHw4JruRrZ2q+CD1SWK91SRRkujAdXoPzMCrO76zXVzkEi7/5i36Un101TZu/ZvNxfOlKshFc95r/attZiW91S93uvM2TVTfoS6uvPdB6jEYTng90X02dUnaFXXkj1Tg2vJdTzfG7lJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/3dOn88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F4C4CED1;
	Fri,  6 Dec 2024 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496674;
	bh=13eSWcU4Nk/MMZfNkZzUcGKVyak+9ExtY9iKBuNzmRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/3dOn88knoSEaiA7evhFbn3vU5dQd0hJYSMY7Mpiicwi1EA/1UiQ63nto56SCMsp
	 npuIocTuSSE80apiMhCuTT2cXRK5v1g72f9YiVtjD98lz3CPxmDbP5KvDLUJ7JpzVh
	 vpdYfKj7y2oC0u86rb67LvsSbUAxnqd8s3VWMA50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 071/676] ext4: remove calls to to set/clear the folio error flag
Date: Fri,  6 Dec 2024 15:28:10 +0100
Message-ID: <20241206143656.132429280@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit ea4fd933ab4310822e244af28d22ff63785dea0e ]

Nobody checks this flag on ext4 folios, stop setting and clearing it.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20240420025029.2166544-11-willy@infradead.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 2f3d93e210b9 ("ext4: fix race in buffer_head read fault injection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/move_extent.c | 4 +---
 fs/ext4/page-io.c     | 3 ---
 fs/ext4/readpage.c    | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 0bfd5ff103aa4..a3aa85795d4a1 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -200,10 +200,8 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 			continue;
 		if (!buffer_mapped(bh)) {
 			err = ext4_get_block(inode, block, bh, 0);
-			if (err) {
-				folio_set_error(folio);
+			if (err)
 				return err;
-			}
 			if (!buffer_mapped(bh)) {
 				folio_zero_range(folio, block_start, blocksize);
 				set_buffer_uptodate(bh);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5cf0389..7ab4f5a9bf5b8 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -117,7 +117,6 @@ static void ext4_finish_bio(struct bio *bio)
 
 		if (bio->bi_status) {
 			int err = blk_status_to_errno(bio->bi_status);
-			folio_set_error(folio);
 			mapping_set_error(folio->mapping, err);
 		}
 		bh = head = folio_buffers(folio);
@@ -441,8 +440,6 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(folio_test_writeback(folio));
 
-	folio_clear_error(folio);
-
 	/*
 	 * Comments copied from block_write_full_page:
 	 *
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3e7d160f543f0..8cb83e7b699bd 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -296,7 +296,6 @@ int ext4_mpage_readpages(struct inode *inode,
 
 				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
 				set_error_page:
-					folio_set_error(folio);
 					folio_zero_segment(folio, 0,
 							  folio_size(folio));
 					folio_unlock(folio);
-- 
2.43.0




