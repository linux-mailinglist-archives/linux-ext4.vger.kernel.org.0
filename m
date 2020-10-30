Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B062A0653
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 14:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgJ3NSi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 09:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbgJ3NSh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 30 Oct 2020 09:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604063916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IpBz9HE0+LF1roOf+93vzSdfOChLyFY4c0u+B2Dio2o=;
        b=gXdQIRypedSj06Bt48/L2+ZORCQnxiiSqjqugwVnSs6fnqGUD9SoF2Lz+DEjlRL1ckp/vi
        mNWkkK5WWyl0NA4jDqXIOfVlowx2CjcTCv5SJgmQziNyfqvy822X51p6B9qiWP/0VuP9Bd
        nIQNRoYBo1G1AtFBUl8vD/AIkf7Jc7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-UgVc5cf0MX2JsHjS2xyaxg-1; Fri, 30 Oct 2020 09:18:34 -0400
X-MC-Unique: UgVc5cf0MX2JsHjS2xyaxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75044188C130;
        Fri, 30 Oct 2020 13:18:32 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D875B4A7;
        Fri, 30 Oct 2020 13:18:31 +0000 (UTC)
Date:   Fri, 30 Oct 2020 09:18:29 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com,
        Eryu Guan <guan@eryu.me>, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] common/rc: Make swapon check in
 _require_scratch_swapfile() specific to btrfs
Message-ID: <20201030131829.GB1794672@bfoster>
References: <cover.1604000570.git.riteshh@linux.ibm.com>
 <6070d16aab6a61bbbc988fc68cc727c21ec7baef.1604000570.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6070d16aab6a61bbbc988fc68cc727c21ec7baef.1604000570.git.riteshh@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 01:22:51AM +0530, Ritesh Harjani wrote:
> swapon/off check in _require_scratch_swapfile() was specifically added
> for btrfs[1]/[2] since in previous kernels, swapfile was not supported on btrfs.
> This rather masks the issue sometimes with swapon system call in
> case if it fails.
> for e.g. in latest ext4 upstream tree when "-g quick" (which ran swap tests too)
> was tested, all swap tests resulted into "_notrun" since swapon failed
> inside _require_scratch_swapfile() itself.
> Whereas this failure on ext4 was actually due to a regression with latest
> fast-commit patch, which went un-noticed.
> Hence make this swapon/off check only specific to btrfs.
> Tested default config of xfs/btrfs/ext4/f2fs with this patch.
> 
> With this change on buggy kernel, we could clearly catch the swap failures.
> e.g.
> generic/472 17s ...
> <...>
> @@ -1,4 +1,7 @@
> QA output created by 472
> regular swap
> +swapon: Invalid argument
> too long swap
> +swapon: Invalid argument
> tiny swap
> +swapon: Invalid argument
> ...
> (Run 'diff -u /home/qemu/src/tools-work/xfstests-dev/tests/generic/472.out \
> /home/qemu/src/tools-work/xfstests-dev/results//ext4/generic/472.out.bad' \
> to see the entire diff)
> 
> [1]: 8c96cfbfe530 ("generic/35[67]: disable swapfile tests on Btrfs")
> [2]: bd6d67ee598e ("generic: enable swapfile tests on Btrfs")
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  common/rc | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index b0c353c4c107..4c59968a6bd3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2358,18 +2358,20 @@ _require_scratch_swapfile()
>  	[ -n "$SELINUX_MOUNT_OPTIONS" ] && export \
>  		SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
>  
> -	_scratch_mount
> +	if [ "$FSTYP" = "btrfs" ]; then
> +		_scratch_mount
> +
> +		# Minimum size for mkswap is 10 pages
> +		_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
>  
> -	# Minimum size for mkswap is 10 pages
> -	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +			_scratch_unmount
> +			_notrun "swapfiles are not supported"
> +		fi
>  
> -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +		swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
>  		_scratch_unmount
> -		_notrun "swapfiles are not supported"
>  	fi
> -
> -	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> -	_scratch_unmount
>  }

This factors out the majority of this function for !btrfs cases to the
point where it doesn't do anything swap related. Perhaps it would be
more clear to do something like '[ $FSTYP = "btrfs" ] &&
_require_scratch_swapfile()' in the actual tests that require filtering
out on btrfs..?

Brian

>  
>  # Check that a fs has enough free space (in 1024b blocks)
> -- 
> 2.26.2
> 

