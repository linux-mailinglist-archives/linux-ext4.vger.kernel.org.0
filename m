Return-Path: <linux-ext4+bounces-6422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90564A3313E
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282943A8790
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B51202C5C;
	Wed, 12 Feb 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy+zsUsE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618C201018;
	Wed, 12 Feb 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394372; cv=none; b=Ax9Kr52CXVM+Ki8xU3E8iEFY3YoD6bmHqBN7g+4p8YF2yutTA8ZkJXX7QaSW0xDgDyz8oqG8gHXsPUNi6V/Xb/Vw1DFqQmxbeZHC6V/S6XV9C79pZtu9Q3RqwYkClVqeO1zg3Hmui59Lc+026NcCE5EoVPokImvlmJBNsf+A3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394372; c=relaxed/simple;
	bh=kjvRLO5npKcpJ3A3vEjixEOPis2d3acjOFa6cM0pDA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGwwC4S5jgL0GpH5crleH6tIxgXqhJYU8hVzHkABk0XtdgrlJUxGAoX28C+Sv0j045JMOwVoZKcD7ZN8cIUVG1QBgbUeJXQeMRpJ2qQ2C7eAThnxwSi3qQBw5K5IqQtW2WGTrVCCpZfJhIWn6QTua/nZoICr3aHRkPJT3t+NU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy+zsUsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A4FC4CEDF;
	Wed, 12 Feb 2025 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739394371;
	bh=kjvRLO5npKcpJ3A3vEjixEOPis2d3acjOFa6cM0pDA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gy+zsUsEBW398zqE8HB0pVujP3WkYZqrrbe862qL6eFsd4hBedbNacFdd/p4FM9Cq
	 WjuyIqZdixT7h3s08punal2d/snY5H6BwlQgBMALwXkg40hNCWBqQ5KHNT5BSJFKXY
	 WxlTWKKvlZvhqOrS2AD0iJtaUAKvRV7a051WXPHgx2zLJz4Dc3RkA0g6f19diGFHLF
	 cxVz3+W9i8iLy1IVvY+2fTiiCubXqPnri7QJfF6ytOXMhm7EyTJ6lBgTGdtz3igH/w
	 3nkzCTBDHzIXEP+UrzimquhxgqCXOLEG29iKn/etyEaiGdG26DdTTXsZ3xjstqDwzX
	 Z4fpFucmCneRA==
Date: Wed, 12 Feb 2025 13:06:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v1 1/3] xfs/539: Skip noattr2 remount option on v5
 filesystems
Message-ID: <20250212210610.GY21799@frogsfrogsfrogs>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>

On Wed, Feb 12, 2025 at 12:39:56PM +0000, Nirjhar Roy (IBM) wrote:
> This test is to verify that repeated warnings are not printed
> for default options (attr2, noikeep) and warnings are
> printed for non default options (noattr2, ikeep). Remount
> with noattr2 fails on a v5 filesystem, so skip the mount option.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/xfs/539 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/539 b/tests/xfs/539
> index b9bb7cc1..58eead67 100755
> --- a/tests/xfs/539
> +++ b/tests/xfs/539
> @@ -42,7 +42,8 @@ echo "Silence is golden."
>  
>  # Skip old kernels that did not print the warning yet
>  log_tag
> -_scratch_mkfs > $seqres.full 2>&1
> +is_v5=true
> +_scratch_mkfs |& grep -q "crc=0" && is_v5=false >> $seqres.full 2>&1

Usually we do this with something more like:

_scratch_mkfs | _filter_mkfs >>$seqres.full 2>$tmp.mkfs
. $tmp.mkfs

if [ $_fs_has_crcs -eq 1 ]; then
	# v5 stuff
else
	# v4 stuff
endif

>  _scratch_mount -o attr2
>  _scratch_unmount
>  check_dmesg_for_since_tag "XFS: attr2 mount option is deprecated" || \
> @@ -60,8 +61,13 @@ for VAR in {attr2,noikeep}; do
>  		echo "Should not be able to find deprecation warning for $VAR"
>  done
>  for VAR in {noattr2,ikeep}; do
> +	if [[ "$VAR" == "noattr2" ]] && $is_v5; then
> +		echo "remount with noattr2 will fail in v5 filesystem. Skip" \
> +			>> $seqres.full
> +		continue

/me wonders if it'd be cleaner to do:

VARS=(ikeep)
test $_fs_has_crcs -eq 0 && VARS+=(noattr2)

for VAR in "${VARS[@]}"; do
	...
done

> +	fi
>  	log_tag
> -	_scratch_remount $VAR
> +    _scratch_remount $VAR >> $seqres.full 2>&1

Nit: Indentation.

--D

>  	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
>  		echo "Could not find deprecation warning for $VAR"
>  done
> -- 
> 2.34.1
> 
> 

