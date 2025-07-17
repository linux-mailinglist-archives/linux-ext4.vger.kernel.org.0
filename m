Return-Path: <linux-ext4+bounces-9047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE520B09013
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD6B1C42ECB
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073062F7D04;
	Thu, 17 Jul 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhu1YAG4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477C201266;
	Thu, 17 Jul 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764531; cv=none; b=ONzLyDN7HbkbxClap9WZWYEOjb3XFl5kdZrF0k63nnmkrvKju/AKSjH/Y1dnP9e3giqufMJ3dS97E+CbarAOtDcm4z97AFtInIVqHqztfIaz7b2jYBfMgYpRQlbSxUtL1HEZIG4sNaCU/4XbzFMLXvOnk6T/ZxFk1Wa+5Cf6INs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764531; c=relaxed/simple;
	bh=KqWDUIfhp6C5IQa60+DUPCV9MEGr1/8csnF0epvNtYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBnhL4gG+hit7aXArHxUfe0FD3id5s2H0zizmD1qgjFBaarirBsuEcCvmdD/TDw8Ik+h/ezfsbG4qqnUASc4a/NQC5Pc5+nW1NymIb9lKAQSmdkuUzAamALcTL03TC5B1Qa6NIgjLfS2cX3nENSVamzcMIbt5iU+fEAshYZqyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhu1YAG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B1BC4CEE3;
	Thu, 17 Jul 2025 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764531;
	bh=KqWDUIfhp6C5IQa60+DUPCV9MEGr1/8csnF0epvNtYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bhu1YAG492+0oC91fZDJES9Q8dFUzAMf1L2h65aYbNw01djxWs/qFn4oY30FfzVcv
	 gKOreg+eW0nRvvdPCYLo8SGeVR+3oTOapZsfvOXdir2VB33szDX8tKHr7RTmMzZdK+
	 Gudby9bMsrZxZ6K5NyYPMwlSTki6aVEZ85fG3/sVlia4Q8e26IhqV4GUA2YNLJn6Kf
	 7hUzA3sn9Vako3Skr6Zl0b4lI3AJoAswp41fBMrQDMLyqC73vsm6k5U6PuMuCahFPB
	 s+w3Hq9vfKUYLcnbmkTpawGUULEJJ8oXxPUYLFeogXxFIP0hOzOcBEtBTyWgtApTvg
	 O/804aEJwRjiQ==
Date: Thu, 17 Jul 2025 08:02:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 01/13] common/rc: Add _min() and _max() helpers
Message-ID: <20250717150210.GK2672022@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <f61636e664cf22024ee68b2f0ca3d3583eec7ec4.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61636e664cf22024ee68b2f0ca3d3583eec7ec4.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:43PM +0530, Ojaswin Mujoo wrote:
> Many programs open code these functionalities so add it as a generic helper
> in common/rc
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks decent,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index f71cc8f0..9a9d3cc8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5817,6 +5817,28 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> +_min() {
> +	local ret
> +
> +	for arg in "$@"; do
> +		if [ -z "$ret" ] || (( $arg < $ret )); then
> +			ret="$arg"
> +		fi
> +	done
> +	echo $ret
> +}
> +
> +_max() {
> +	local ret
> +
> +	for arg in "$@"; do
> +		if [ -z "$ret" ] || (( $arg > $ret )); then
> +			ret="$arg"
> +		fi
> +	done
> +	echo $ret
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.49.0
> 
> 

