Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32D3997A3
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFCBtH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Jun 2021 21:49:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43183 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229758AbhFCBtG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Jun 2021 21:49:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1531l7DF011614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Jun 2021 21:47:08 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9660A15C3CAF; Wed,  2 Jun 2021 21:47:07 -0400 (EDT)
Date:   Wed, 2 Jun 2021 21:47:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
Message-ID: <YLg0mx3fhQSPHYb1@mit.edu>
References: <20210506141042.3298679-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506141042.3298679-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 06, 2021 at 10:10:42PM +0800, Ye Bin wrote:
> We got follow bug_on when run fsstress with injecting IO fault:
> [130747.323114] kernel BUG at fs/ext4/extents_status.c:762!
> [130747.323117] Internal error: Oops - BUG: 0 [#1] SMP
> ......
> [130747.334329] Call trace:
> [130747.334553]  ext4_es_cache_extent+0x150/0x168 [ext4]
> [130747.334975]  ext4_cache_extents+0x64/0xe8 [ext4]
> [130747.335368]  ext4_find_extent+0x300/0x330 [ext4]
> [130747.335759]  ext4_ext_map_blocks+0x74/0x1178 [ext4]
> [130747.336179]  ext4_map_blocks+0x2f4/0x5f0 [ext4]
> [130747.336567]  ext4_mpage_readpages+0x4a8/0x7a8 [ext4]
> [130747.336995]  ext4_readpage+0x54/0x100 [ext4]
> [130747.337359]  generic_file_buffered_read+0x410/0xae8
> [130747.337767]  generic_file_read_iter+0x114/0x190
> [130747.338152]  ext4_file_read_iter+0x5c/0x140 [ext4]
> [130747.338556]  __vfs_read+0x11c/0x188
> [130747.338851]  vfs_read+0x94/0x150
> [130747.339110]  ksys_read+0x74/0xf0
> 
> If call ext4_ext_insert_extent failed but new extent already inserted, we just
> update "ex->ee_len = orig_ex.ee_len", this will lead to extent overlap, then
> cause bug on when cache extent.
> If call ext4_ext_insert_extent failed don't update ex->ee_len with old value.
> Maybe there will lead to block leak, but it can be fixed by fsck later.
> 
> After we fixed above issue with v2 patch, but we got the same issue.
> ext4_split_extent_at:
> {
>         ......
>         err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
>         if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
>             ......
>             ext4_ext_try_to_merge(handle, inode, path, ex); ->step(1)
>             err = ext4_ext_dirty(handle, inode, path + path->p_depth); ->step(2)
>             if (err)
>                 goto fix_extent_len;
>         ......
>         }
>         ......
> fix_extent_len:
>         ex->ee_len = orig_ex.ee_len; ->step(3)
>         ......
> }
> If step(1) have been merged, but step(2) dirty extent failed, then go to
> fix_extent_len label to fix ex->ee_len with orig_ex.ee_len. But "ex" may not be
> old one, will cause overwritten. Then will trigger the same issue as previous.
> If step(2) failed, just return error, don't fix ex->ee_len with old value.
> 
> This patch's modification is according to Jan Kara's suggestion in V3 patch:
> ("https://patchwork.ozlabs.org/project/linux-ext4/patch/20210428085158.3728201-1-yebin10@huawei.com/")
> "I see. Now I understand your patch. Honestly, seeing how fragile is trying
> to fix extent tree after split has failed in the middle, I would probably
> go even further and make sure we fix the tree properly in case of ENOSPC
> and EDQUOT (those are easily user triggerable).  Anything else indicates a
> HW problem or fs corruption so I'd rather leave the extent tree as is and
> don't try to fix it (which also means we will not create overlapping
> extents)."
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
