Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55D39D2C8
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfHZPaP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 11:30:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728965AbfHZPaP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 11:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98C0DB035;
        Mon, 26 Aug 2019 15:30:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 321841E3DA1; Mon, 26 Aug 2019 17:30:14 +0200 (CEST)
Date:   Mon, 26 Aug 2019 17:30:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: fix integer overflow when calculating commit
 interval
Message-ID: <20190826153014.GI10614@quack2.suse.cz>
References: <20190826143547.95169-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826143547.95169-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 26-08-19 22:35:47, zhangyi (F) wrote:
> If user specify a large enough value of "commit=" option, it may trigger
> signed integer overflow which may lead to sbi->s_commit_interval becomes
> a large or small value, zero in particular.
> 
> UBSAN: Undefined behaviour in ../fs/ext4/super.c:1592:31
> signed integer overflow:
> 536870912 * 1000 cannot be represented in type 'int'
> [...]
> Call trace:
> [...]
> [<ffffff9008a2d120>] ubsan_epilogue+0x34/0x9c lib/ubsan.c:166
> [<ffffff9008a2d8b8>] handle_overflow+0x228/0x280 lib/ubsan.c:197
> [<ffffff9008a2d95c>] __ubsan_handle_mul_overflow+0x4c/0x68 lib/ubsan.c:218
> [<ffffff90086d070c>] handle_mount_opt fs/ext4/super.c:1592 [inline]
> [<ffffff90086d070c>] parse_options+0x1724/0x1a40 fs/ext4/super.c:1773
> [<ffffff90086d51c4>] ext4_remount+0x2ec/0x14a0 fs/ext4/super.c:4834
> [...]
> 
> Although it is not a big deal, still silence the UBSAN by limit the
> input value.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4079605d437a..7310facffa9d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1874,6 +1874,13 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  	} else if (token == Opt_commit) {
>  		if (arg == 0)
>  			arg = JBD2_DEFAULT_MAX_COMMIT_AGE;
> +		else if (arg > INT_MAX / HZ) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "Invalid commit interval %d, "
> +				 "must be smaller than %d",
> +				 arg, INT_MAX / HZ);
> +			return -1;
> +		}
>  		sbi->s_commit_interval = HZ * arg;
>  	} else if (token == Opt_debug_want_extra_isize) {
>  		sbi->s_want_extra_isize = arg;
> -- 
> 2.23.0.rc2.8.gff66981
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
