Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A654FF2A78
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2019 10:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfKGJVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Nov 2019 04:21:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:58236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727408AbfKGJVT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Nov 2019 04:21:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43ACDAC90;
        Thu,  7 Nov 2019 09:21:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 844341E4415; Thu,  7 Nov 2019 10:21:17 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:21:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, jack <jack@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/5] ext2: code cleanup by calling
 ext2_group_last_block_no()
Message-ID: <20191107092117.GA11400@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-2-cgxu519@mykernel.net>
 <20191106154236.GB12685@quack2.suse.cz>
 <16e43c91b4e.12c0f5d17918.413402503051848643@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e43c91b4e.12c0f5d17918.413402503051848643@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 07-11-19 10:54:43, Chengguang Xu wrote:
>  ---- 在 星期三, 2019-11-06 23:42:36 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Mon 04-11-19 19:40:33, Chengguang Xu wrote:
>  > > Call common helper ext2_group_last_block_no() to
>  > > calculate group last block number.
>  > > 
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > 
>  > Thanks for the patch! I've applied it (as well as 1/5) and added attached
>  > simplification on top.
>  > 
> 
> In ext2_try_to_allocate()
> 
> +		if (my_rsv->_rsv_end < group_last_block)
> +			end = my_rsv->_rsv_end - group_first_block + 1;
> +		if (grp_goal < start || grp_goal > end)
> 
> Based on original code, shouldn't it be  if (grp_goal < start || grp_goal
> >=end) ?

Hum, that's a good point. The original code actually had an off-by-one bug
because 'end' is really the last block that can be used so grp_goal == end
still makes sense. And my cleanup fixed it. Now looking at the code in
ext2_try_to_allocate() we also have a similar bug in the loop allocating
blocks. There we can also go upto 'end' inclusive. Added a patch to fix
that. Thanks for pointing me to this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
