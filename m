Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33D1E6464
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgE1Oru (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 10:47:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53391 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728456AbgE1Ort (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 10:47:49 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04SElk9h006091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:47:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 731D2420304; Thu, 28 May 2020 10:47:46 -0400 (EDT)
Date:   Thu, 28 May 2020 10:47:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Message-ID: <20200528144746.GE228632@mit.edu>
References: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 15, 2020 at 10:07:06AM +0000, Alex Zhuravlev wrote:
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2127,6 +2127,96 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
>  	return 0;
>  }
>  
> +/*
> + * each allocation context (i.e. a thread doing allocation) has own
> + * sliding prefetch window of @s_mb_prefetch size which starts at the
> + * very first goal and moves ahead of scaning.
> + * a side effect is that subsequent allocations will likely find
> + * the bitmaps in cache or at least in-flight.
> + */
> +static void
> +ext4_mb_prefetch(struct ext4_allocation_context *ac,
> +		    ext4_group_t start)
> +{
> +	struct super_block *sb = ac->ac_sb;
> +	ext4_group_t ngroups = ext4_get_groups_count(sb);
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_group_info *grp;
> +	ext4_group_t nr, group = start;
> +	struct buffer_head *bh;
> +
> +	/* limit prefetching at cr=0, otherwise mballoc can
> +	 * spend a lot of time loading imperfect groups */
> +	if (ac->ac_criteria < 2 && ac->ac_prefetch_ios >= sbi->s_mb_prefetch_limit)
> +		return;
> +
> +	/* batch prefetching to get few READs in flight */
> +	nr = ac->ac_prefetch - group;
> +	if (ac->ac_prefetch < group)
> +		/* wrapped to the first groups */
> +		nr += ngroups;
> +	if (nr > 0)I
> +		return;
> +	BUG_ON(nr < 0);

What are you trying to do here?  If nr > 0, we return; if nr < 0, we
BUG() --- but nr is an unsigned int, so we never can trigger --- which
was the warning reported by the kbuild test bot.  So we will only get
past this point if ac_prefetch == group.  But ac_prefetch appears to
be the last group that we prefetched, so it's not clear that the logic
is correct here.

						- Ted
