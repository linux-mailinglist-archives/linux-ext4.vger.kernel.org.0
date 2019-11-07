Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B06F3385
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2019 16:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfKGPiZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Nov 2019 10:38:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52145 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbfKGPiZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Nov 2019 10:38:25 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA7FcLB9003883
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Nov 2019 10:38:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3C15F420311; Thu,  7 Nov 2019 10:38:19 -0500 (EST)
Date:   Thu, 7 Nov 2019 10:38:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix extent_status fragmentation for plain files
Message-ID: <20191107153819.GI26959@mit.edu>
References: <20191106122502.19986-1-dmonakhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106122502.19986-1-dmonakhov@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
> # Example: I have plain file:
> File size of /mnt/test is 33554432 (8192 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..    8191:      40960..     49151:   8192:             last,eof
> 
> $ perf record -e 'ext4:ext4_es_*' /root/bin/fio --name=t --direct=0 --rw=randread --bs=4k --filesize=32M --size=32M --filename=/mnt/test
> $ perf script | grep ext4_es_insert_extent | head -n 10
>              fio   131 [000]    13.975421:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [494/1) mapped 41454 status W
>              fio   131 [000]    13.976467:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6907/1) mapped 47867 status W

So this is certainly bad behavior, but the original intent was to not
cached extents that were in the inode's i_blocks[] array because the
information was already in the inode cache, and so we could save
memory but just pulling the information out of the i_blocks away and
there was no need to cache the extent in the es cache.

There are cases where we do need to track the extent in the es cache
--- for example, if we are writing the file and we need to track its
delayed allocation status.

So I wonder if we might be better off defining a new flag
EXT4_MAP_INROOT, which gets set by ext4_ext_map_blocks() and
ext4_ind_map_blocks() if the mapping is exclusively found in the
i_blocks array, and if EXT4_MAP_INROOT is set, and we don't need to
set EXTENT_STATUS_DELAYED, we skip the call to
ext4_es_insert_extent().

What do you think?  This should significantly reduce the memory
utilization of the es_cache, which would be good for low-memory
workloads, and those where there are a large number of inodes that fit
in the es_cache, which is probably true for most desktops, especially
those belonging kernel developers.  :-)

						- Ted
