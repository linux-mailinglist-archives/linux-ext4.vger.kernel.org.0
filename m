Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E814E99CA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJ3KPO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 06:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfJ3KPO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Oct 2019 06:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1B7AB2E2;
        Wed, 30 Oct 2019 10:15:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C76E81E485C; Wed, 30 Oct 2019 11:15:11 +0100 (CET)
Date:   Wed, 30 Oct 2019 11:15:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: don't set *count in the case of failure in
 ext2_try_to_allocate()
Message-ID: <20191030101511.GA28525@quack2.suse.cz>
References: <20191026090721.23794-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090721.23794-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 26-10-19 17:07:21, Chengguang Xu wrote:
> Currently we set *count to num(value 0) in the failure
> of block allocation in ext2_try_to_allocate(). Without
> reservation, we reuse *count(value 0) to retry block
> allocation and wrong *count will cause only allocating
> maximum 1 block even though having sufficent free blocks
> in that block group. Finally, it probably cause significant
> fragmentation.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks! Patch applied.

								Honza

> ---
> v1->v2:
> - Add detail explanation of effect to changelog.
> 
>  fs/ext2/balloc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index e0cc55164505..29fc3a5054f8 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -736,7 +736,6 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>  	*count = num;
>  	return grp_goal - num;
>  fail_access:
> -	*count = num;
>  	return -1;
>  }
>  
> -- 
> 2.21.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
