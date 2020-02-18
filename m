Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5694A161E2D
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 01:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgBRAX5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Feb 2020 19:23:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgBRAX5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 17 Feb 2020 19:23:57 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D542072C;
        Tue, 18 Feb 2020 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581985436;
        bh=gL+BGx+KlxBBhRP2sjEp0pj3/3+h0KUC5HvG83rMDss=;
        h=From:To:Cc:Subject:Date:From;
        b=CXguKfBSxjO2rPR0/2i/F+PUM56Ll8U6n8j6nu1LpLxPOaQIX28qu467yt4funtjZ
         fqMTqi0XgT6Ef6vnO6X76VYbjwK7FBEeJ6cK3AxP0Y7TiHT5JO1uoTa1VmRlXVmVSe
         FduXgve4AXP7mE1Vci62mkaNj+zmFdredrJsw5jE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: fix race between writepages and enabling EXT4_EXTENTS_FL
Date:   Mon, 17 Feb 2020 16:21:51 -0800
Message-Id: <20200218002151.1581441-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If EXT4_EXTENTS_FL is set on an inode while ext4_writepages() is running
on it, the following warning in ext4_add_complete_io() can be hit:

WARNING: CPU: 1 PID: 0 at fs/ext4/page-io.c:234 ext4_put_io_end_defer+0xf0/0x120

Here's a minimal reproducer (not 100% reliable) (root isn't required):

	while true; do
		sync
	done &
	while true; do
		rm -f file
		touch file
		chattr -e file
		echo X >> file
		chattr +e file
	done

The problem is that in ext4_writepages(), ext4_should_dioread_nolock()
(which only returns true on extent-based files) is checked once to set
the number of reserved journal credits, and also again later to select
the flags for ext4_map_blocks() and copy the reserved journal handle to
ext4_io_end::handle.  But if EXT4_EXTENTS_FL is being concurrently set,
the first check can see dioread_nolock disabled while the later one can
see it enabled, causing the reserved handle to unexpectedly be NULL.

Fix this by checking ext4_should_dioread_nolock() only once and storing
the result in struct mpage_da_data.  This way, each ext4_writepages()
call uses a consistent dioread_nolock setting.

This was originally reported by syzbot without a reproducer at
https://syzkaller.appspot.com/bug?extid=2202a584a00fffd19fbf,
but now that dioread_nolock is the default I also started seeing this
when running syzkaller locally.

Reported-by: syzbot+2202a584a00fffd19fbf@syzkaller.appspotmail.com
Fixes: 6b523df4fb5a ("ext4: use transaction reservation for extent conversion in ext4_end_io")
Cc: stable@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e60aca791d3f1..7e02851043bca 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1527,6 +1527,7 @@ struct mpage_da_data {
 	struct ext4_map_blocks map;
 	struct ext4_io_submit io_submit;	/* IO submission data */
 	unsigned int do_map:1;
+	unsigned int dioread_nolock:1;
 };
 
 static void mpage_release_unused_pages(struct mpage_da_data *mpd,
@@ -2335,7 +2336,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	struct inode *inode = mpd->inode;
 	struct ext4_map_blocks *map = &mpd->map;
 	int get_blocks_flags;
-	int err, dioread_nolock;
+	int err;
 
 	trace_ext4_da_write_pages_extent(inode, map);
 	/*
@@ -2356,8 +2357,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
 			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
 			   EXT4_GET_BLOCKS_IO_SUBMIT;
-	dioread_nolock = ext4_should_dioread_nolock(inode);
-	if (dioread_nolock)
+	if (mpd->dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
 	if (map->m_flags & (1 << BH_Delay))
 		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
@@ -2365,7 +2365,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
 	if (err < 0)
 		return err;
-	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
+	if (mpd->dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
 		if (!mpd->io_submit.io_end->handle &&
 		    ext4_handle_valid(handle)) {
 			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
@@ -2685,6 +2685,9 @@ static int ext4_writepages(struct address_space *mapping,
 		 */
 		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
 						PAGE_SIZE >> inode->i_blkbits);
+		mpd.dioread_nolock = 1;
+	} else {
+		mpd.dioread_nolock = 0;
 	}
 
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-- 
2.25.0

