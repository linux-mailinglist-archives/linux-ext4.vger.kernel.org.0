Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFDF3EAB43
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhHLTrY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 15:47:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55468 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235816AbhHLTrW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 15:47:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17CJkoQg026626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:46:51 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 30A9115C37C1; Thu, 12 Aug 2021 15:46:50 -0400 (EDT)
Date:   Thu, 12 Aug 2021 15:46:50 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 4/5] ext4: get discard out of jbd2 commit kthread
 contex
Message-ID: <YRV6qqZcsNBHZzyn@mit.edu>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-5-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724074124.25731-5-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jul 24, 2021 at 03:41:23PM +0800, Wang Jianchao wrote:
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 34be2f07449d..a496509e61b7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3474,6 +3530,14 @@ int ext4_mb_release(struct super_block *sb)
>  	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
>  	int count;
>  
> +	if (test_opt(sb, DISCARD)) {
> +		/*
> +		 * wait the discard work to drain all of ext4_free_data
> +		 */
> +		queue_work(ext4_discard_wq, &sbi->s_discard_work);
> +		flush_work(&sbi->s_discard_work);

I agree with Jan --- it's not clear to me why the call to queue_work()
is needed.  After the flush_work() call returns, if s_discard_work is
still non-empty, there must be something terribly wrong --- are we
missing something?

> @@ -3672,8 +3724,14 @@ int __init ext4_init_mballoc(void)
>  	if (ext4_free_data_cachep == NULL)
>  		goto out_ac_free;
>  
> +	ext4_discard_wq = alloc_workqueue("ext4discard", WQ_UNBOUND, 0);
> +	if (!ext4_discard_wq)
> +		goto out_free_data;
> +


Perhaps we should only allocate the workqueue when it's needed ---
e.g., when a file system is mounted or remounted with "-o discard"?

Then in ext4_exit_malloc(), we only free it if ext4_discard_wq is
non-NULL.

This would save a bit of memory on systems that wouldn't need the ext4
discard work queue.

					- Ted
