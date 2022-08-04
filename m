Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6058973B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 07:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiHDFDy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 01:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHDFDx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 01:03:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5595FADD;
        Wed,  3 Aug 2022 22:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BCD6B82394;
        Thu,  4 Aug 2022 05:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D6CC433C1;
        Thu,  4 Aug 2022 05:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659589430;
        bh=MNAl6XZ8UoFXNt+z/eBH1q/kL/m18X8MdS29g9B+SYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9bzvLMfNE8ySAJH4ks7Nmkn7AjD0SOiS8CcWt7ycmIQWXE/tBfWJ5YhnCo5U8t6/
         8ZPclcbY0aSjgz5S2sagbJomxyrQNIay1D9JGTikegh39iMvUoFBjhMkGEmwwBWpFt
         ncaaDLz90qv5DlW3nvm7/kLfm6QMZ3RXGCn0R3OZL99XrYHWQ3xr+u/FbGN7a0Dczs
         DEObkDNJ0p1w4ur1G0JbeT1zOauZJW0J8QWIf9a2qypywyBTLdeg/7/Enz5A03+b2n
         f+Dkc9l9CU4CbtrUFJZ/4apvl6aoflk/5hfzXgNrd8t1gSVspwHLKThUitdV9VmVxs
         8piqfeNQW4xcg==
Date:   Wed, 3 Aug 2022 22:03:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v1.2 3/3] common/ext4: provide custom ext4 scratch fs
 options
Message-ID: <YutTNdX6NUySU9xL@magnolia>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
 <165950051745.198922.6487109955066878945.stgit@magnolia>
 <YusR5ww7Y4+/HXTt@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YusR5ww7Y4+/HXTt@magnolia>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 03, 2022 at 05:25:11PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a _scratch_options backend for ext* so that we can inject
> pathnames to external log devices into the scratch fs mount options.
> This enables common/dm* to install block device filters, e.g. dm-error
> for stress testing.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> v1.2: refactor _scratch_mkfs_ext4 to use _scratch_options too

Self NAK, this still has broken bits...

> ---
>  common/ext4 |   34 +++++++++++++++++++++++++++++++---
>  common/rc   |    3 +++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/common/ext4 b/common/ext4
> index 287705af..8a3385af 100644
> --- a/common/ext4
> +++ b/common/ext4
> @@ -63,16 +63,24 @@ _setup_large_ext4_fs()
>  	return 0
>  }
>  
> +_scratch_mkfs_ext4_opts()
> +{
> +	mkfs_opts=$*
> +
> +	_scratch_options mkfs
> +
> +	echo "$MKFS_EXT4_PROG -F $SCRATCH_OPTIONS $mkfs_opts"

...the -F should go in _scratch_ext4_options...

> +}
> +
>  _scratch_mkfs_ext4()
>  {
> -	local mkfs_cmd="$MKFS_EXT4_PROG -F"
> +	local mkfs_cmd="`_scratch_mkfs_ext4_opts`"
>  	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \" | grep -v \"^$\""
>  	local tmp=`mktemp -u`
>  	local mkfs_status
>  
>  	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> -	    $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
> -	    mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
> +	    $MKFS_EXT4_PROG -F -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV
>  
>  	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
>  	mkfs_status=$?
> @@ -154,3 +162,23 @@ _require_scratch_richacl_ext4()
>  		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
>  	_scratch_unmount
>  }
> +
> +_scratch_ext4_options()
> +{
> +    local type=$1
> +    local log_opt=""
> +
> +    case $type in
> +    mkfs)
> +        log_opt="-J device=$SCRATCH_LOGDEV"
> +	;;
> +    mount)
> +	# As of kernel 5.19, the kernel mount option path parser only accepts
> +	# direct paths to block devices--the final path component cannot be a
> +	# symlink.
> +        log_opt="-o journal_path=$(realpath $SCRATCH_LOGDEV)"

...and this ought to be `realpath -q "$SCRATCH_LOGDEV"' to avoid
breaking the non-external-journal case.

> +	;;
> +    esac
> +    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> +	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}"

Tab/space insanity here.

--D

> +}
> diff --git a/common/rc b/common/rc
> index dc1d65c3..b82bb36b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -178,6 +178,9 @@ _scratch_options()
>      "xfs")
>  	_scratch_xfs_options "$@"
>  	;;
> +    ext2|ext3|ext4|ext4dev)
> +	_scratch_ext4_options "$@"
> +	;;
>      esac
>  }
>  
