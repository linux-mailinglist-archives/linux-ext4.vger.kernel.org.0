Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B53667D3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Apr 2021 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhDUJWd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Apr 2021 05:22:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235170AbhDUJWb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Apr 2021 05:22:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FAEFB2DC;
        Wed, 21 Apr 2021 09:21:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A5DAD1F2B69; Wed, 21 Apr 2021 11:21:56 +0200 (CEST)
Date:   Wed, 21 Apr 2021 11:21:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH v2] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
Message-ID: <20210421092156.GL8706@quack2.suse.cz>
References: <20210420142518.1573012-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420142518.1573012-1-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 20-04-21 22:25:18, Ye Bin wrote:
> We got follow bug_on when run fsstress with injecting IO fault:
> [130747.323114] kernel BUG at fs/ext4/extents_status.c:762!
> [130747.323117] Internal error: Oops - BUG: 0 [#1] SMP

Which BUG_ON is that please? I don't see any relevant one near that line in
current upstream kernel...

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

Thanks for the analysis and the patch but the fact is that the extent tree
is going to be corrupted one way or the other. And I think other disk
corruptions can lead to similar problematic extent layout anyway. So I
rather think we need to make the code more robust to not take the kernel
down when seeing corrupted extent tree - and we've done work to make code
more robust in this sence in the past. Can you reproduce the issue with the
current upstream kernel? If yes, we are probably still missing extent tree
consistency checks on some path and we need to add them...

								Honza

> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/extents.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 77c84d6f1af6..6161db9c17c9 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3245,8 +3245,11 @@ static int ext4_split_extent_at(handle_t *handle,
>  		err = ext4_zeroout_es(inode, &zero_ex);
>  
>  		goto out;
> -	} else if (err)
> +	} else if (err == -EROFS) {
> +		return err;
> +	} else {
>  		goto fix_extent_len;
> +	}
>  
>  out:
>  	ext4_ext_show_leaf(inode, path);
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
