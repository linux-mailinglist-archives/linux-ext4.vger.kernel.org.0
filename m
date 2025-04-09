Return-Path: <linux-ext4+bounces-7177-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF41A82A49
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B067146034D
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7B2673A3;
	Wed,  9 Apr 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3D5rT0Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA1266B5D;
	Wed,  9 Apr 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212128; cv=none; b=PAa1pxr/7lv4bVusJ/OxY9mTlY88aQGVZiLAreibgp7tWHIBzUkXddIKlVsonZDMm9DCGVUxtcujTVjBKIHoBRwc1urcY2/v6vndE60TPQyAr8ZwDulxN987zrpG1HBgAgW6N16E2Ky5AaAqLBrzFtZxdhs2IogCe0YD2PSOfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212128; c=relaxed/simple;
	bh=YiM8pDiAa3DevHhHQzVIScLLD1kA0X347dW+jWtRJ08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl8P5tatH6dh7jw4WTJo0DFJ/AXAwp2gzH1k1KC4rCKFkQO7ZpBVnDKj7ak5f6nBP1B0AbcZsBJI6hTWpck2MOtZB0Htdidgd38Do/MjOO9Hq43qoZhIzGCvQvZBJkU1vUpZNgGUP7vW2b6pqKuwXwwtW3mwinoe/KvwCx+RXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3D5rT0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561B5C4CEE2;
	Wed,  9 Apr 2025 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744212128;
	bh=YiM8pDiAa3DevHhHQzVIScLLD1kA0X347dW+jWtRJ08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3D5rT0ZkEs3uAlIfM3rEkHeNJf11AFeq30LDxDHzmrIM4+IbevBcGwGnmAjnhSut
	 wEDy+U3wjcSH7OOkANvQZle4BZPpe+rqQASZ0Q3jZMWGzZfWwpHreXuG/KJAKtlEaV
	 ZDuLs8FTW61V7SAs5Zl9gB7y+85fAuoV3qDiRPpkgl4v6CtmHmyb7k5krC6+/BqjDG
	 0dzn4c2A5qnYguZfnxEfzISwZrwetMX3Dp/sFtIC7/Rpmz4FSbd1kGdoJ6D4FOUMyR
	 9zEpIOsPPyDSmKi+43cgp+HkC1yi835R7QWHeMZiyLli+MDcxgmwPZPvsHzlgni/ja
	 Qtpz0ujwh71jw==
Date: Wed, 9 Apr 2025 08:22:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v4 4/6] check,common{rc,preamble}: Decouple init_rc()
 call from sourcing common/rc
Message-ID: <20250409152207.GO6283@frogsfrogsfrogs>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
 <419090f011da6494c5bf20db768bcb8f646737df.1744181682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419090f011da6494c5bf20db768bcb8f646737df.1744181682.git.nirjhar.roy.lists@gmail.com>

On Wed, Apr 09, 2025 at 07:00:50AM +0000, Nirjhar Roy (IBM) wrote:
> Silently executing scripts during sourcing common/rc isn't good practice
> and also causes unnecessary script execution. Decouple init_rc() call
> and call init_rc() explicitly where required.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Sounds good to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  check           | 2 ++
>  common/preamble | 1 +
>  common/rc       | 2 --
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index 3d621210..9451c350 100755
> --- a/check
> +++ b/check
> @@ -364,6 +364,8 @@ if ! . ./common/rc; then
>  	exit 1
>  fi
>  
> +init_rc
> +
>  # If the test config specified a soak test duration, see if there are any
>  # unit suffixes that need converting to an integer seconds count.
>  if [ -n "$SOAK_DURATION" ]; then
> diff --git a/common/preamble b/common/preamble
> index 0c9ee2e0..c92e55bb 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -50,6 +50,7 @@ _begin_fstest()
>  	_register_cleanup _cleanup
>  
>  	. ./common/rc
> +	init_rc
>  
>  	# remove previous $seqres.full before test
>  	rm -f $seqres.full $seqres.hints
> diff --git a/common/rc b/common/rc
> index 16d627e1..038c22f6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5817,8 +5817,6 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> -init_rc
> -
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.34.1
> 
> 

