Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFACD1492FC
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 03:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbgAYCW3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 21:22:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50608 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387542AbgAYCW2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jan 2020 21:22:28 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P2MMmX030225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 21:22:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 55E1642014A; Fri, 24 Jan 2020 21:22:21 -0500 (EST)
Date:   Fri, 24 Jan 2020 21:22:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix extent_status fragmentation for plain files
Message-ID: <20200125022221.GL147870@mit.edu>
References: <20191106122502.19986-1-dmonakhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106122502.19986-1-dmonakhov@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 06, 2019 at 12:25:02PM +0000, Dmitry Monakhov wrote:
> It is appeared that extent are not cached for inodes with depth == 0
> which result in suboptimal extent status populating inside ext4_map_blocks()
> by map's result where size requested is usually smaller than extent size so
> cache becomes fragmented
> 

I've done some more performance testing, and analysis, and while for
some workloads this will cause a slight increase in memory, most of
the time, it's going to be a wash.  The one case where I could imagine
is where a large number of files are scanned to determine what type
they are (e.g., using file(1) command) and this causes the first block
(and only the first block) to be read.  In that case, if there are
four discontiguous regions in the inode's i_blocks[] area, this will
cause multiple extents_status structs to be allocated that will never
be used.

For most cases, though, the memory utilization will be the same or
better, and I can see how this could make a difference in the workload
that you described.

I experimented with a patch that only pulled into the extents status
cache the single physical extent that was found, e.g.

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 393533ff0527..1aad7c0bc0af 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -901,9 +901,18 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	/* find extent */
 	ext4_ext_binsearch(inode, path + ppos, block);
 	/* if not an empty leaf */
-	if (path[ppos].p_ext)
-		path[ppos].p_block = ext4_ext_pblock(path[ppos].p_ext);
-
+	if (path[ppos].p_ext) {
+		struct ext4_extent *ex = path[ppos].p_ext;
+
+		path[ppos].p_block = ext4_ext_pblock(ex);
+		if (!(flags & EXT4_EX_NOCACHE) && depth == 0)
+			ext4_es_cache_extent(inode, le32_to_cpu(ex->ee_block),
+					     ext4_ext_get_actual_len(ex),
+					     ext4_ext_pblock(ex),
+					     ext4_ext_is_unwritten(ex) ?
+					     EXTENT_STATUS_UNWRITTEN :
+					     EXTENT_STATUS_WRITTEN);
+	}
 	ext4_ext_show_path(inode, path);
 
 	return path;

But as I experimented with it, I realized that it really didn't make
that much difference in practice, so I decided to go with your
original proposed patch.  Apologies for it taking a while for me to do
the analysis/experiments.

Cheers,

						- Ted
