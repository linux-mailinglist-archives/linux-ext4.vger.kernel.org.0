Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA76AA7B7
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Mar 2023 03:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCDC4t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 21:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDC4t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 21:56:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22901588C;
        Fri,  3 Mar 2023 18:56:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33D39B80CAC;
        Sat,  4 Mar 2023 02:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E780DC433D2;
        Sat,  4 Mar 2023 02:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677898605;
        bh=yKpl7ZcJEA2hgxvJuZEFKnjBMUgk01GSNiUjpWcx89w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEeXaJxjw3zni9yR95d0Md8mlsj0drTK4QW/9kKmE8sjCqf+Mxiq7mgxOWfZtKtfr
         /vRGYSPX8prejDLKns49OIQ2vzNlReMlVjcnkhCO+sphDrpkRt+fc338IoIO8EXk7e
         jsuHRw5PMGXjl65Z+S7B7B+kOpIX9bWtHvQXotkHIiHbuibK4UmpG1W6a0pMkZpRGg
         eHfDYoYfVcSyfYen5g9HHsBiwbwuCbTHPEoATeWaVkuIgPSN+ndoERKARFZoPkwcKv
         VzovKCeiCINTNDppfuxB3jrulwd+TCJpQoHwPpsTJS3K2IMTgr7E2Eos7Iu2/tuiTy
         OR02sbaL9cewg==
Date:   Fri, 3 Mar 2023 18:56:44 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     tytso@mit.edu, darrick.wong@oracle.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com
Subject: Re: [PATCH 2/3] ext4: fsmap: Consolidate fsmap_head checks
Message-ID: <20230304025644.GA1637890@frogsfrogsfrogs>
References: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
 <20230222131211.3898066-3-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222131211.3898066-3-tudor.ambarus@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 22, 2023 at 01:12:10PM +0000, Tudor Ambarus wrote:
> Sanity checks should be done the soonest possible to avoid superfluous
> computations when user provides wrong data. Gather all the checks on
> user provided data in a single method and call it immediately after
> copying the data from user.

This patch changes the validation criteria, moves chunks of code around,
and constifies parameters all at once.  And all you say here is that
you're moving validation code up in the sequence!

Also, how does moving callsites around improve things?  Do the fstests
still pass?

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  fs/ext4/fsmap.c | 52 ++++++++++++++++++++++++++++++++++++-------------
>  fs/ext4/fsmap.h |  3 +++
>  fs/ext4/ioctl.c | 17 +++-------------
>  3 files changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index b5289378a761..a27d9f0967b7 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -9,6 +9,7 @@
>  #include "fsmap.h"
>  #include "mballoc.h"
>  #include <linux/sort.h>
> +#include <linux/string.h>
>  #include <linux/list_sort.h>
>  #include <trace/events/ext4.h>
>  
> @@ -571,7 +572,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>  
>  /* Do we recognize the device? */
>  static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
> -					  struct ext4_fsmap *fm)
> +					  const struct fsmap *fm)
>  {
>  	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
>  	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
> @@ -583,17 +584,19 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
>  }
>  
>  /* Ensure that the low key is less than the high key. */
> -static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
> -				     struct ext4_fsmap *high_key)
> +static bool ext4_getfsmap_check_keys(const struct fsmap *low_key,
> +				     const struct fsmap *high_key)
>  {
> +	u64 l_fmr_phys = low_key->fmr_physical + low_key->fmr_length;
> +
>  	if (low_key->fmr_device > high_key->fmr_device)
>  		return false;
>  	if (low_key->fmr_device < high_key->fmr_device)
>  		return true;
>  
> -	if (low_key->fmr_physical > high_key->fmr_physical)
> +	if (l_fmr_phys > high_key->fmr_physical)
>  		return false;
> -	if (low_key->fmr_physical < high_key->fmr_physical)
> +	if (l_fmr_phys < high_key->fmr_physical)

Why are you changing the comparison here?

>  		return true;
>  
>  	if (low_key->fmr_owner > high_key->fmr_owner)
> @@ -604,6 +607,36 @@ static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
>  	return false;
>  }
>  
> +int ext4_fsmap_check_head(struct super_block *sb,
> +			  const struct fsmap_head *head)
> +{
> +	const struct fsmap *l = &head->fmh_keys[0];
> +	const struct fsmap *h = &head->fmh_keys[1];
> +
> +	if (memchr_inv(head->fmh_reserved, 0, sizeof(head->fmh_reserved)) ||
> +	    memchr_inv(l->fmr_reserved, 0, sizeof(l->fmr_reserved)) ||
> +	    memchr_inv(h->fmr_reserved, 0, sizeof(h->fmr_reserved)))
> +		return -EINVAL;
> +	/*
> +	 * ext4 doesn't report file extents at all, so the only valid
> +	 * file offsets are the magic ones (all zeroes or all ones).
> +	 */
> +	if (l->fmr_offset || (h->fmr_offset != 0 && h->fmr_offset != -1ULL))
> +		return -EINVAL;
> +
> +	if (head->fmh_iflags & ~FMH_IF_VALID)
> +		return -EINVAL;
> +
> +	if (!ext4_getfsmap_is_valid_device(sb, l) ||
> +	    !ext4_getfsmap_is_valid_device(sb, h))
> +		return -EINVAL;
> +
> +	if (!ext4_getfsmap_check_keys(l, h))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  #define EXT4_GETFSMAP_DEVS	2
>  /*
>   * Get filesystem's extents as described in head, and format for
> @@ -635,12 +668,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>  	int i;
>  	int error = 0;
>  
> -	if (head->fmh_iflags & ~FMH_IF_VALID)
> -		return -EINVAL;
> -	if (!ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[0]) ||
> -	    !ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[1]))
> -		return -EINVAL;
> -
>  	head->fmh_entries = 0;
>  
>  	/* Set up our device handlers. */
> @@ -673,9 +700,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>  	dkeys[0].fmr_length = 0;
>  	memset(&dkeys[1], 0xFF, sizeof(struct ext4_fsmap));
>  
> -	if (!ext4_getfsmap_check_keys(dkeys, &head->fmh_keys[1]))
> -		return -EINVAL;

And why is it ok to turn validation of dkeys[0] vs. fmh_keys[1] into a
validation of fmh_keys[0..1] ?  I guess that's why check_keys now adds
the low key physical offset and length?

But why not leave the key checks the where they are, since it's
dkeys[0..1] that get passed around the implementations?

--D

> -
>  	info.gfi_next_fsblk = head->fmh_keys[0].fmr_physical +
>  			  head->fmh_keys[0].fmr_length;
>  	info.gfi_formatter = formatter;
> diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
> index ac642be2302e..8325258def7b 100644
> --- a/fs/ext4/fsmap.h
> +++ b/fs/ext4/fsmap.h
> @@ -8,6 +8,7 @@
>  #define	__EXT4_FSMAP_H__
>  
>  struct fsmap;
> +struct fsmap_head;
>  
>  /* internal fsmap representation */
>  struct ext4_fsmap {
> @@ -32,6 +33,8 @@ void ext4_fsmap_from_internal(struct super_block *sb, struct fsmap *dest,
>  		struct ext4_fsmap *src);
>  void ext4_fsmap_to_internal(struct super_block *sb, struct ext4_fsmap *dest,
>  		struct fsmap *src);
> +int ext4_fsmap_check_head(struct super_block *sb,
> +			  const struct fsmap_head *head);
>  
>  /* fsmap to userspace formatter - copy to user & advance pointer */
>  typedef int (*ext4_fsmap_format_t)(struct ext4_fsmap *, void *);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 8067ccda34e4..eb0ecb012e6a 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -874,20 +874,9 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
>  
>  	if (copy_from_user(&head, arg, sizeof(struct fsmap_head)))
>  		return -EFAULT;
> -	if (memchr_inv(head.fmh_reserved, 0, sizeof(head.fmh_reserved)) ||
> -	    memchr_inv(head.fmh_keys[0].fmr_reserved, 0,
> -		       sizeof(head.fmh_keys[0].fmr_reserved)) ||
> -	    memchr_inv(head.fmh_keys[1].fmr_reserved, 0,
> -		       sizeof(head.fmh_keys[1].fmr_reserved)))
> -		return -EINVAL;
> -	/*
> -	 * ext4 doesn't report file extents at all, so the only valid
> -	 * file offsets are the magic ones (all zeroes or all ones).
> -	 */
> -	if (head.fmh_keys[0].fmr_offset ||
> -	    (head.fmh_keys[1].fmr_offset != 0 &&
> -	     head.fmh_keys[1].fmr_offset != -1ULL))
> -		return -EINVAL;
> +	error = ext4_fsmap_check_head(sb, &head);
> +	if (error)
> +		return error;
>  
>  	xhead.fmh_iflags = head.fmh_iflags;
>  	xhead.fmh_count = head.fmh_count;
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
