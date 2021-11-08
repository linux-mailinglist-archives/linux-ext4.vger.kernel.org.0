Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF879449AA6
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Nov 2021 18:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhKHRUw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 12:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhKHRUu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 8 Nov 2021 12:20:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB03561178;
        Mon,  8 Nov 2021 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636391885;
        bh=+WDW4Be1suFht0zC3mnSmRz2BI/lIZxA1DEVipn0jzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoTNrkZJiQlpeviY6tGp3e5GWNP7KNc97k2QyQDqg35TBz8y/PK0L3YL081iiqBAY
         butJEI+4dLSVU/GECdZV5rXaUI75wzsePyA3fHXuFgCuiSDbmpGcReMfhhUU2mo1bw
         s6cbLIXKK56SfdC4x6msRS9IteklY4t0CnseprObx4pL3WI6mC71zNMVWDNNEvt1Dm
         4Ikhj1M0tntxhdGBmH8Q296XT0trXsJvp3+WXZA/Wmow72WOHuHwG1NsQnzKgMnO7u
         5K3OkhB48m9LP2l2EenViUUFzRGDiK1OIfCHCfr5MVN1NOZiN9sMkbMNS8qGTwL/ls
         1jM45q9DTO/Eg==
Date:   Mon, 8 Nov 2021 09:18:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
        guan@eryu.me
Subject: Re: [PATCH 1/2] common/rc: add _require_kernel_config and
 _has_kernel_config
Message-ID: <20211108171805.GJ24282@magnolia>
References: <20211108151916.27845-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108151916.27845-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 08, 2021 at 04:19:15PM +0100, Lukas Czerner wrote:
> Add _require_kernel_config() and _has_kernel_config() helpers to check
> whether a specific kernel configuration is enabled on the kernel.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  common/config |  1 +
>  common/rc     | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
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

This new KCONFIG_PATH variable should be documented in the README.

Otherwise, the logic looks solid.

--D

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
