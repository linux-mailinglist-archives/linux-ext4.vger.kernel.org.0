Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F69485C37
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiAEXYn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 18:24:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60263 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245364AbiAEXYm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 18:24:42 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 205NOaG5013479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 18:24:37 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 598C115C00E1; Wed,  5 Jan 2022 18:24:36 -0500 (EST)
Date:   Wed, 5 Jan 2022 18:24:36 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     cgel.zte@gmail.com
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH v2] ext4: Remove unnecessary assignments
Message-ID: <YdYotAyQqQgI+Oo+@mit.edu>
References: <20211104063637.2842-1-luo.penghao@zte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104063637.2842-1-luo.penghao@zte.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 04, 2021 at 06:36:37AM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The assignment at the end of the function is not necessary
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 089c958..f1258a7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3886,7 +3886,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  	if (err)
>  		goto out_err;
>  	sync_dirty_buffer(bitmap_bh);
> -	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> +	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>  	sync_dirty_buffer(gdp_bh);
>  
>  out_err:

There's actually a bigger issue here than the Clang analyzer
complaining about the unnecessasary assignment --- and that is we
*should* be propagating the error up to ext4_mb_mark_bb's callers, and
those callers should be logging errors and potentially aborting the
fast_commit replay.

There might be some errors that can be ignored, if an idempotent
operation doesn't need to be redone.  However, in cases like
ext4_handle_dirty_metadata(), or ext4_read_block_bitmap(), any
failures are probably due to something fatal happening --- either an
ENOMEM, or an I/O error, etc., and simply silently aborting the
current function without logging any kind of problem is going to make
it much harder to root cause a potential fast commit replay failure.

So what we should probably do is make ext4_mb_mark_bb return an error,
and then we'll need to look at all of the callers of ext4_mb_mark_bb,
and fix them up as necessary.

					- Ted
