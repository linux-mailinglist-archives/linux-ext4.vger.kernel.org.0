Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B14449EAD
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Nov 2021 23:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbhKHWeS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 17:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239746AbhKHWeS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 8 Nov 2021 17:34:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DEA161994;
        Mon,  8 Nov 2021 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636410693;
        bh=0viScEuCXruHkpBXs/F8VA07Mw4ZXfpFWlr+/Q16EFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrOJ/dTo4cbHJ41cR59E2J35blfnM9QPx9/vS7LEQx3MKi5lW7mn7uB8xtvQulVa9
         6a2wn4ZKWfI4bnVu28HSuc6VHQyni1QyD/97/3WQc8xOKzc7vjW91XOUwX2Hcb7YBO
         frB8nMOam3dob+t4EMdx4e/WJB7crDvPNlhhQN/zADe8VIaQ1BePVzLGWFhMiA9edh
         kzjwN99ZqG4tt5kAeo8derqw8AZvtXbHFnWlOh5ZUNe5E1O/S5lgor5VSQPSXd6ohF
         SRZ2XJccWB1TvKH7Ql+xLzREiJO44fOQtsQigKCurwe2EzxohWeaCo6lpTQ/2YW08L
         3t5LZL4zVj4OA==
Date:   Mon, 8 Nov 2021 14:31:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH v2 1/2] common/rc: add _require_kernel_config and
 _has_kernel_config
Message-ID: <20211108223132.GB24255@magnolia>
References: <20211108151916.27845-1-lczerner@redhat.com>
 <20211108210423.28980-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108210423.28980-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 08, 2021 at 10:04:23PM +0100, Lukas Czerner wrote:
> Add _require_kernel_config() and _has_kernel_config() helpers to check
> whether a specific kernel configuration is enabled on the kernel.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> v2: Document KCONFIG_PATH in README
> 
>  README        |  2 ++
>  common/config |  1 +
>  common/rc     | 29 +++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/README b/README
> index 63f0641a..e9284b22 100644
> --- a/README
> +++ b/README
> @@ -129,6 +129,8 @@ Preparing system for tests:
>                 xfs_check to check the filesystem.  As of August 2021,
>                 xfs_repair finds all filesystem corruptions found by xfs_check,
>                 and more, which means that xfs_check is no longer run by default.
> +	     - Set KCONFIG_PATH to specify your preferred location of kernel
> +	       config file.

The indentation here looks kind of off, but the core logic looks
correct.

With that fixed:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>          - or add a case to the switch in common/config assigning
>            these variables based on the hostname of your test
> diff --git a/common/config b/common/config
> index 164381b7..e0a5c5df 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,6 +226,7 @@ export OPENSSL_PROG="$(type -P openssl)"
>  export ACCTON_PROG="$(type -P accton)"
>  export E2IMAGE_PROG="$(type -P e2image)"
>  export BLKZONE_PROG="$(type -P blkzone)"
> +export GZIP_PROG="$(type -P gzip)"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/common/rc b/common/rc
> index 0d261184..84154868 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4703,6 +4703,35 @@ _require_names_are_bytes() {
>          esac
>  }
>  
> +_has_kernel_config()
> +{
> +	option=$1
> +	uname=$(uname -r)
> +	config_list="$KCONFIG_PATH
> +		     /proc/config.gz
> +		     /lib/modules/$uname/build/.config
> +		     /boot/config-$uname
> +		     /lib/kernel/config-$uname"
> +
> +	for config in $config_list; do
> +		[ ! -f $config ] && continue
> +		[ $config = "/proc/config.gz" ] && break
> +		grep -qE "^${option}=[my]" $config
> +		return
> +	done
> +
> +	[ ! -f $config ] && _notrun "Could not locate kernel config file"
> +
> +	# We can only get here with /proc/config.gz
> +	_require_command "$GZIP_PROG" gzip
> +	$GZIP_PROG -cd $config | grep -qE "^${option}=[my]"
> +}
> +
> +_require_kernel_config()
> +{
> +	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
> +}
> +
>  init_rc
>  
>  ################################################################################
> -- 
> 2.31.1
> 
