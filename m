Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF73E6FF0
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2019 11:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfJ1Kvx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Oct 2019 06:51:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34074 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfJ1Kvx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Oct 2019 06:51:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id e4so2348183pgs.1
        for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2019 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=41LZBznqzMjRIBqWsHF9KQj0bmycavXaY90fbO/UooQ=;
        b=Y78vlRmhk7TKVgXHuQdCHYjj73OV9GL3R0sGrQD8CelWfG2lwoOryQP4U+FMKSbDLt
         EXWvekZl63NZ6b9awkG7xKRf7fk+QSZ0Zt4aQWvL88qEPngSHhutHCa4G1N5c5n8CCQ+
         xwig07Bxw87ca9PHyv3zivkE4hf46akK4Fqlh3KatDfk6DdgsNfcIRTSAHuIseJE2P5W
         3Cz6BroYIvuyFSJbU+jAKuWxTgNTVmj7MIxKweZsy2pEMBcKEMpSYRhlFBRG6aUgrZNF
         v0X9nqRN6STc1/AXbIixDyC9KRIMwYdrZez5gO8bMOt7iIxlliFYYro+o06ElvCCSUs6
         RH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=41LZBznqzMjRIBqWsHF9KQj0bmycavXaY90fbO/UooQ=;
        b=KuxkAVYZg5JUG27qadq+dHQeJsoWMubZZm2vLLfOZMVxJZ0HE8QFnlaJdQMOfv5Bci
         Wh6sjIFFcJqqBjZcjSnJJhWljgOotNRaK6xmDT43dZdLwXZGtiK4nY2FbI7VbMKl+2s1
         8t02Aq61pB3KOHIFpWPjyCEdwtwouICGsmULcNjJKMjY5jC2HqaTRn6ciY0K1mQ2lHhn
         vYE9lZ2SXVtXw/8QS9TDtW7R2joO8WwfRYjfL2kPZtVV/9hLTOSLGkWi3P9vzTMyxnPY
         4QUsErBSbB3UdaxBRaQmMxa4NiYtTleh2g4r5B7AnIB1dzeTnImIj32/Rh68mKtdRtQM
         eEjA==
X-Gm-Message-State: APjAAAUfJUd4xGHN5PS7Y/A1eid9UWX6ydvKWYn3Jh3siDv0ZBlYgdt/
        rVx48HQZNJ2pk8PL44Y4FudK
X-Google-Smtp-Source: APXvYqwbSBrw1To4jhjMs1F1ifrQEm5wpfYgLwjRvQeNq7wOaCbjN8ET+9C/CJZARRnL94UPMqphhg==
X-Received: by 2002:a63:8148:: with SMTP id t69mr20574828pgd.160.1572259912335;
        Mon, 28 Oct 2019 03:51:52 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id w62sm3286848pfb.15.2019.10.28.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:51:51 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:51:45 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 05/11] ext4: split IOMAP_WRITE branch in
 ext4_iomap_begin() into helper
Message-ID: <ebd609c876c763d9232f8423c0ddd669cee3eabb.1572255425.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for porting across the ext4 direct I/O path over to the
iomap infrastructure, split up the IOMAP_WRITE branch that's currently
within ext4_iomap_begin() into a separate helper
ext4_alloc_iomap(). This way, when we add in the necessary code for
direct I/O, we don't end up with ext4_iomap_begin() becoming a
monstrous twisty maze.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 113 ++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 073b7c873bb2..325abba6482c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3453,6 +3453,63 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	}
 }
 
+static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
+			    unsigned int flags)
+{
+	handle_t *handle;
+	u8 blkbits = inode->i_blkbits;
+	int ret, dio_credits, retries = 0;
+
+	/*
+	 * Trim the mapping request to the maximum value that we can map at
+	 * once for direct I/O.
+	 */
+	if (map->m_len > DIO_MAX_BLOCKS)
+		map->m_len = DIO_MAX_BLOCKS;
+	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
+
+retry:
+	/*
+	 * Either we allocate blocks and then don't get an unwritten extent, so
+	 * in that case we have reserved enough credits. Or, the blocks are
+	 * already allocated and unwritten. In that case, the extent conversion
+	 * fits into the credits as well.
+	 */
+	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
+	if (ret < 0)
+		goto journal_stop;
+
+	/*
+	 * If we've allocated blocks beyond EOF, we need to ensure that they're
+	 * truncated if we crash before updating the inode size metadata within
+	 * ext4_iomap_end(). For faults, we don't need to do that (and cannot
+	 * due to orphan list operations needing an inode_lock()). If we happen
+	 * to instantiate blocks beyond EOF, it is because we race with a
+	 * truncate operation, which already has added the inode onto the
+	 * orphan list.
+	 */
+	if (!(flags & IOMAP_FAULT) && map->m_lblk + map->m_len >
+	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
+		int err;
+
+		err = ext4_orphan_add(handle, inode);
+		if (err < 0)
+			ret = err;
+	}
+
+journal_stop:
+	ext4_journal_stop(handle);
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
+
+	return ret;
+}
+
+
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
@@ -3513,62 +3570,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			}
 		}
 	} else if (flags & IOMAP_WRITE) {
-		int dio_credits;
-		handle_t *handle;
-		int retries = 0;
-
-		/* Trim mapping request to maximum we can map at once for DIO */
-		if (map.m_len > DIO_MAX_BLOCKS)
-			map.m_len = DIO_MAX_BLOCKS;
-		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
-retry:
-		/*
-		 * Either we allocate blocks and then we don't get unwritten
-		 * extent so we have reserved enough credits, or the blocks
-		 * are already allocated and unwritten and in that case
-		 * extent conversion fits in the credits as well.
-		 */
-		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
-					    dio_credits);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-
-		ret = ext4_map_blocks(handle, inode, &map,
-				      EXT4_GET_BLOCKS_CREATE_ZERO);
-		if (ret < 0) {
-			ext4_journal_stop(handle);
-			if (ret == -ENOSPC &&
-			    ext4_should_retry_alloc(inode->i_sb, &retries))
-				goto retry;
-			return ret;
-		}
-
-		/*
-		 * If we added blocks beyond i_size, we need to make sure they
-		 * will get truncated if we crash before updating i_size in
-		 * ext4_iomap_end(). For faults we don't need to do that (and
-		 * even cannot because for orphan list operations inode_lock is
-		 * required) - if we happen to instantiate block beyond i_size,
-		 * it is because we race with truncate which has already added
-		 * the inode to the orphan list.
-		 */
-		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
-		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
-			int err;
-
-			err = ext4_orphan_add(handle, inode);
-			if (err < 0) {
-				ext4_journal_stop(handle);
-				return err;
-			}
-		}
-		ext4_journal_stop(handle);
+		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0)
-			return ret;
 	}
 
+	if (ret < 0)
+		return ret;
+
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 	if (delalloc && iomap->type == IOMAP_HOLE)
 		iomap->type = IOMAP_DELALLOC;
-- 
2.20.1

