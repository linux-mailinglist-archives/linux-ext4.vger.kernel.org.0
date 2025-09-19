Return-Path: <linux-ext4+bounces-10308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04BB8A905
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E587C5F3D
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B66321278;
	Fri, 19 Sep 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzUR9hbl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019AB23C8AA;
	Fri, 19 Sep 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299238; cv=none; b=bPyNULTNqqeVCbnsMZa6qhO+m6iVrSzikooSu41yIqSP8oauHhRTzpMRbNLJWztEDaJMo9ivlPs1U7oT+R+v2NGDpAB0PrROX3/1ck6Z+TEhEBMuFT2j6h5RRj04bjDD4HZTA63IQqBCG/HxHTiHdslVbbLqpy41JUqI4yddaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299238; c=relaxed/simple;
	bh=cBEaJX7qa93PnH2/ea/ZMHgYNNOQHAPjJldATLirvXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+pOrdru/DU/qu7ozk9ufIFgjjPioa51JHIFphO8soevvXMBOKpyfdm15KhYjVaPqEtws/GE7QyBSHPtj9FVCiqbFE+53FkuLIpyrZhGMfZCYIAKqqKS/Kpwa3sdyI/saEreaOlIvE6LGDinHG0btLnRSQMEZPVEdFAejmxAKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzUR9hbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F55DC4CEF0;
	Fri, 19 Sep 2025 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758299237;
	bh=cBEaJX7qa93PnH2/ea/ZMHgYNNOQHAPjJldATLirvXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzUR9hblYskOYkVVEZDWBnjfxJKIRri9lPo6qDq63juOd93u4+iL/dF/J9yQOqBTq
	 +c8+VZUo4oZJQuOWCYJgbQfdLBb1P1zL6Ueo/KRjpUM7+SZlNMBPQVOZo3RA1pV3wa
	 AOOILk9ET3DVwzIck2rbPVeCEM68+iR1z7ITeznyF6LlxAFKYrC7kdeVN79FJqgVnq
	 WRf+rh91cKVMEUoShkeP+xiOsGYFEIoIzl56BForsEmSrm2pg+3LLAujOpS5ecJPag
	 F/FO56TxqudPkuSVPlDW9BSp7YD6KqwNehknb0xvau9u+PhVYytHjLUuyHxMAS7Wk+
	 /SoRWGwC9OHDw==
Date: Fri, 19 Sep 2025 09:27:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 02/12] common/rc: Add fio atomic write helpers
Message-ID: <20250919162716.GD8117@frogsfrogsfrogs>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <8e87c6c800f6ca53f0c89af554b85197c7e397f1.1758264169.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e87c6c800f6ca53f0c89af554b85197c7e397f1.1758264169.git.ojaswin@linux.ibm.com>

On Fri, Sep 19, 2025 at 12:17:55PM +0530, Ojaswin Mujoo wrote:
> The main motivation of adding this function on top of _require_fio is
> that there has been a case in fio where atomic= option was added but
> later it was changed to noop since kernel didn't yet have support for
> atomic writes. It was then again utilized to do atomic writes in a later
> version, once kernel got the support. Due to this there is a point in
> fio where _require_fio w/ atomic=1 will succeed even though it would
> not be doing atomic writes.
> 
> Hence, add an internal helper __require_fio_version to require specific
> versions of fio to work past such issues. Further, add the high level
> _require_fio_atomic_writes helper which tests can use to ensure fio
> has the right version for atomic writes.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks ok to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 28fbbcbb..8a023b9d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6000,6 +6000,49 @@ _max() {
>  	echo $ret
>  }
>  
> +# Due to reasons explained in fio commit 40f1fc11d, fio version between
> +# v3.33 and v3.38 have atomic= feature but it is a no-op and doesn't do
> +# RWF_ATOMIC write. Hence, use this helper to ensure fio has the
> +# required support. Currently, the simplest way we have is to ensure
> +# the version.
> +_require_fio_atomic_writes() {
> +	__require_fio_version "3.38+"
> +}
> +
> +# Check the required fio version. Examples:
> +#   __require_fio_version 3.38 (matches 3.38 only)
> +#   __require_fio_version 3.38+ (matches 3.38 and above)
> +#   __require_fio_version 3.38- (matches 3.38 and below)
> +#
> +# Internal helper, avoid using directly in tests.
> +__require_fio_version() {
> +	local req_ver="$1"
> +	local fio_ver
> +
> +	_require_fio
> +	_require_math
> +
> +	fio_ver=$(fio -v | cut -d"-" -f2)
> +
> +	case "$req_ver" in
> +	*+)
> +		req_ver=${req_ver%+}
> +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> +			_notrun "need fio >= $req_ver (found $fio_ver)"
> +		;;
> +	*-)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> +			_notrun "need fio <= $req_ver (found $fio_ver)"
> +		;;
> +	*)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> +			_notrun "need fio = $req_ver (found $fio_ver)"
> +		;;
> +	esac
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.49.0
> 

