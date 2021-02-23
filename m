Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCA322F4F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhBWRCJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:02:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:56686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhBWRCA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Feb 2021 12:02:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B63E3ACBF;
        Tue, 23 Feb 2021 17:01:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 651021E14EF; Tue, 23 Feb 2021 18:01:18 +0100 (CET)
Date:   Tue, 23 Feb 2021 18:01:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ext4: fix integer overflow in s_log_groups_per_flex
Message-ID: <20210223170118.GD30433@quack2.suse.cz>
References: <20210203134351.1697508-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203134351.1697508-1-snovitoll@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 03-02-21 19:43:51, Sabyrzhan Tasbolatov wrote:
> syzbot found UBSAN: shift-out-of-bounds in ext4_mb_init [1], when
> 1 << sbi->s_es->s_log_groups_per_flex is bigger than UINT_MAX,
> where sbi->s_mb_prefetch is unsigned integer type.
> 
> 32 is the maximum allowed power of s_log_groups_per_flex. Following if
> check will also trigger UBSAN shift-out-of-bound:
> 
> if (1 << sbi->s_es->s_log_groups_per_flex > UINT_MAX) {
> 
> So I'm checking it against the raw number, perhaps there is another way
> to calculate UINT_MAX max power. Also use min_t as to make sure it's
> uint type.
> 
> [1] UBSAN: shift-out-of-bounds in fs/ext4/mballoc.c:2713:24
> shift exponent 60 is too large for 32-bit type 'int'
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x137/0x1be lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:148 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
>  ext4_mb_init_backend fs/ext4/mballoc.c:2713 [inline]
>  ext4_mb_init+0x19bc/0x19f0 fs/ext4/mballoc.c:2898
>  ext4_fill_super+0xc2ec/0xfbe0 fs/ext4/super.c:4983
> 
> Reported-by: syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  fs/ext4/mballoc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 99bf091fee10..e1e7ffbba1a6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2709,8 +2709,15 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	}
>  
>  	if (ext4_has_feature_flex_bg(sb)) {
> -		/* a single flex group is supposed to be read by a single IO */
> -		sbi->s_mb_prefetch = min(1 << sbi->s_es->s_log_groups_per_flex,
> +		/* a single flex group is supposed to be read by a single IO.
> +		 * 2 ^ s_log_groups_per_flex != UINT_MAX as s_mb_prefetch is
> +		 * unsigned integer, so the maximum shift is 32.
> +		 */
> +		if (sbi->s_es->s_log_groups_per_flex > 32) {
						    ^^ >= 32?

Otherwise the patch looks good.

									Honza


> +			ext4_msg(sb, KERN_ERR, "too many log groups per flexible block group");
> +			goto err_freesgi;
> +		}
> +		sbi->s_mb_prefetch = min_t(uint, 1 << sbi->s_es->s_log_groups_per_flex,
>  			BLK_MAX_SEGMENT_SIZE >> (sb->s_blocksize_bits - 9));
>  		sbi->s_mb_prefetch *= 8; /* 8 prefetch IOs in flight at most */
>  	} else {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
