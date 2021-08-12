Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2313EA9B1
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 19:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhHLRor (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 13:44:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36063 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232025AbhHLRor (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 13:44:47 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17CHiGR1016019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 13:44:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BB0D415C37C1; Thu, 12 Aug 2021 13:44:16 -0400 (EDT)
Date:   Thu, 12 Aug 2021 13:44:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 2/5] ext4: add new helper interface
 ext4_try_to_trim_range()
Message-ID: <YRVd8CCjhkpGJ/tb@mit.edu>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-3-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724074124.25731-3-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jul 24, 2021 at 03:41:21PM +0800, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> There is no functional change in this patch but just split the
> codes, which serachs free block and does trim, into a new function
> ext4_try_to_trim_range. This is preparing for the following async
> backgroup discard.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> ---
>  fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 018d5d3c6eeb..e3844152a643 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6218,6 +6218,54 @@ __acquires(bitlock)
>  	return ret;
>  }
>  
> +static int ext4_try_to_trim_range(struct super_block *sb,
> +		struct ext4_buddy *e4b, ext4_grpblk_t start,
> +		ext4_grpblk_t max, ext4_grpblk_t minblocks)
> +{
> +	ext4_grpblk_t next, count, free_count;
> +	void *bitmap;
> +	int ret = 0;
> +
> +	bitmap = e4b->bd_bitmap;
> +	start = (e4b->bd_info->bb_first_free > start) ?
> +		e4b->bd_info->bb_first_free : start;
> +	count = 0;
> +	free_count = 0;
> +
> +	while (start <= max) {
> +		start = mb_find_next_zero_bit(bitmap, max + 1, start);
> +		if (start > max)
> +			break;
> +		next = mb_find_next_bit(bitmap, max + 1, start);
> +
> +		if ((next - start) >= minblocks) {
> +			ret = ext4_trim_extent(sb, start, next - start, e4b);
> +			if (ret && ret != -EOPNOTSUPP)
> +				break;
> +			ret = 0;
> +			count += next - start;
> +		}

"ret" is only used inside the if statement, so this might be better as:

> +		if ((next - start) >= minblocks) {
> +			int ret = ext4_trim_extent(sb, start, next - start, e4b);
> +
> +			if (ret && ret != -EOPNOTSUPP)
> +				break;
> +			count += next - start;
> +		}

... and then drop the "int ret = 0" above.

Otherwise, looks good.

						- Ted
