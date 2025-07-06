Return-Path: <linux-ext4+bounces-8829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3AAFA725
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A3616CCA7
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC72BDC06;
	Sun,  6 Jul 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBdti2Ik"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4222BD585
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826493; cv=none; b=YYYzUYRuKhgkIIYBP9RNlPQ4ZEBmTwd4iI7jbfGLSVm0r6ecJ40S1wDWo5jdsb7BfZaToLJNDt5+0KR98FatRdzyhE8HfYFwhh8+ELUOHlb9RqQ5ehTkyJTUPe5FjOziM7mJyvOCHmznkOsWLd2wUA8Em9VY4DS2mw6AG+niHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826493; c=relaxed/simple;
	bh=yVb/f6SuUbXNknax9NowL1oGcJiaTT7iGYkt9OzEaP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcISxUe8dnN5r0eKjfaRszamgApZjVfZmN7QwILTUUm8WyaVXWERW1RZes0f6XoT+HE7gIF87B6xQ3u5faXcoaM0gxym/916S9uhtKA2ZWGaxeq1oy3GY0CEwTRncnm2zbpVtQ+tqfqJ2L9wcW4QUHXNPu4JV0lo6NHpI1mUWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBdti2Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B2AC4CEF2;
	Sun,  6 Jul 2025 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826493;
	bh=yVb/f6SuUbXNknax9NowL1oGcJiaTT7iGYkt9OzEaP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBdti2IkzcLnoXva99l43I2lm52ID8ue0g8n/hGB1GuyaWd7agNlm7TQZHdNG6JmM
	 nxZ7PIqJ2qoGUn1lnrc8Kb0ZT0LcMRJmQQBzTj4Kfx25JZe6rscu2Q91hzHy4LWBAV
	 eziDOkxbXLinp19LknIRVx1AQ5Lla2a2edbaD8Xc/deTuhuEVlmd9AVgsrAKgLGKwA
	 Ug59aA1/VDytadPbrYGt8rUKIrVmL97VnUAIHs17tVrVDXE0uxTKh85PJeZX6dwPAE
	 9EwYV++dHCz97/7/6VLjwmWcYmPyIx9afh/vy9Tclo0OMXN6q1qZiYI39zmRgmRWtg
	 JIbavyDIFfOWw==
Date: Sun, 6 Jul 2025 11:28:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Samuel Smith <satlug@net153.net>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] e2scrub: reorder exit status check after calling lvremove
Message-ID: <20250706182812.GB2672022@frogsfrogsfrogs>
References: <20250705033821.3695205-1-satlug@net153.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705033821.3695205-1-satlug@net153.net>

On Fri, Jul 04, 2025 at 10:38:21PM -0500, Samuel Smith wrote:
> Checking for snapshot device existence resets the status code in $?.
> Reording the conditions will allow the retry loop to work properly.
> 
> Signed-off-by: Samuel Smith <satlug@net153.net>

Yep, that was a mistake.  Sorry about that. :(
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  scrub/e2scrub.in | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scrub/e2scrub.in b/scrub/e2scrub.in
> index 043bc12b..6f9b5ce2 100644
> --- a/scrub/e2scrub.in
> +++ b/scrub/e2scrub.in
> @@ -182,7 +182,7 @@ snap_dev="/dev/${LVM2_VG_NAME}/${snap}"
>  teardown() {
>  	# Remove and wait for removal to succeed.
>  	${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}"
> -	while [ -e "${snap_dev}" ] && [ "$?" -eq "5" ]; do
> +	while [ "$?" -eq "5" ] && [ -e "${snap_dev}" ]; do
>  		sleep 0.5
>  		${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}"
>  	done
> @@ -210,7 +210,7 @@ setup() {
>  	# Try to remove snapshot for 30s, bail out if we can't remove it.
>  	lvremove_deadline="$(( $(date "+%s") + 30))"
>  	${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}" 2>/dev/null
> -	while [ -e "${snap_dev}" ] && [ "$?" -eq "5" ] &&
> +	while [ "$?" -eq "5" ] && [ -e "${snap_dev}" ] &&
>  	      [ "$(date "+%s")" -lt "${lvremove_deadline}" ]; do
>  		sleep 0.5
>  		${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}"
> -- 
> 2.39.5
> 
> 

