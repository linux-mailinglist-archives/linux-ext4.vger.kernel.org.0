Return-Path: <linux-ext4+bounces-3771-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F909564C0
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F1B21D79
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA215697A;
	Mon, 19 Aug 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3FRYoNh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67837199B9;
	Mon, 19 Aug 2024 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052861; cv=none; b=dcwMNQ8y0ABc+E1EsdVW0bP1Zs9eis27AOUad6vC5hbnYp2pStsmfG78k0N5H96Mv0b9PqUHiQ/1gUYboRy2A62gyQ1ozTKIh1GypcOET+g++KkOCEtK85ZhKz60PSPdhRTtlt3ifM442nlWDBkofPDSRQQjRFL5MKWVosTShuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052861; c=relaxed/simple;
	bh=jWCdw6+Mt7vTwAMd410byNxcR/efNsh0Co3i6REIQqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXVRoWGE9eqUp2RD/T5eLTNdsu76HH+3QNNSd2/BgkEOqyoi0pzdswPR/W4mdiQLafXWp6pu2ecFF2qHvRdqBGJ7NhIcgiGlRRKAt7XDVtY5VQISzdhGSsedSxSj4Y00Fcy6YT8szBqT7gZrxNmv6YELcCiDh5vMHSxsn2KEreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3FRYoNh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724052859; x=1755588859;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jWCdw6+Mt7vTwAMd410byNxcR/efNsh0Co3i6REIQqE=;
  b=Y3FRYoNhJ9Zjhq1jbTMr/rJNEf6RwPUe4hWt4u/A+YilWreXM6da3GmS
   H9kMalzuuulCtvCS32f02sP3LTYHj/AKCrhe/bbx4kVAtLCctgzU+UTQt
   6tBLiztABzatagXE/a4QRU9VR7Jw5m+75tvg/yDrpiFfSxX1HdGJ7YEog
   QjG3rUnAuQ1TMsz+t5o0ez4uJVjRyh9hcCA1TzEoKMUM6yNmcmQCEv8xZ
   yFIM8ACsul53PYYsejRpDRjF/QTwc1xga0T2+R/b6KSMDWApUza9+Oiy/
   IM1rZugCVEksgG+MB2mJ4TXsbEBINXP9IXqMHonSNmy/vimDnCnEbXDUP
   Q==;
X-CSE-ConnectionGUID: a0zdzh9pTNSIQaQTDAuqPA==
X-CSE-MsgGUID: RILr0rTbT72jlG56sk+ByQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22445177"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22445177"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:34:19 -0700
X-CSE-ConnectionGUID: O+B60iEqRGqYo4fRX3CQFg==
X-CSE-MsgGUID: FTEnVBr5RkuC77QyZMAnGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60587214"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:34:13 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: abid-sayyad <sayyad.abid16@gmail.com>, airlied@gmail.com
Cc: daniel@ffwll.ch, dmitry.baryshkov@linaro.org, mripard@kernel.org,
 ankit.k.nautiyal@intel.com, imre.deak@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, quic_abhinavk@quicinc.com,
 dianders@chromium.org, marilene.agarcia@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 skhan@linuxfoundation.org, abid-sayyad <sayyad.abid16@gmail.com>
Subject: Re: [PATCH] fix member variable description warnings while building
 docs
In-Reply-To: <20240818112543.1089986-1-sayyad.abid16@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240818112543.1089986-1-sayyad.abid16@gmail.com>
Date: Mon, 19 Aug 2024 10:34:09 +0300
Message-ID: <87a5h96k5q.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 18 Aug 2024, abid-sayyad <sayyad.abid16@gmail.com> wrote:
> Fix the following warnings while building the docs :-
>
> ./include/linux/jbd2.h:1303: warning: Function parameter or struct member
> 		'j_transaction_overhead_buffers' not described in 'journal_s'
> ./include/linux/jbd2.h:1303: warning: Excess struct member
> 		'j_transaction_overhead' description in 'journal_s'
>
> Fix spelling error for j_transaction_overhead to j_transaction_overhead_buffers.
>
> ./include/drm/display/drm_dp_helper.h:127: warning: Function parameter or struct
> 		member 'target_rr_divider' not described in 'drm_dp_as_sdp'
>
> Add description for the 'target_rr_divider' member.

Please send the two separately. They are part of two completely
different subsystems.

BR,
Jani.

>
> Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
> ---
>  include/drm/display/drm_dp_helper.h | 1 +
>  include/linux/jbd2.h                | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index ea03e1dd26ba..7f2567fa230d 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -112,6 +112,7 @@ struct drm_dp_vsc_sdp {
>   * @target_rr: Target Refresh
>   * @duration_incr_ms: Successive frame duration increase
>   * @duration_decr_ms: Successive frame duration decrease
> + * @target_rr_divider: Target refresh rate divider
>   * @mode: Adaptive Sync Operation Mode
>   */
>  struct drm_dp_as_sdp {
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 5157d92b6f23..17662eae408f 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1086,7 +1086,7 @@ struct journal_s
>  	int			j_revoke_records_per_block;
>
>  	/**
> -	 * @j_transaction_overhead:
> +	 * @j_transaction_overhead_buffers:
>  	 *
>  	 * Number of blocks each transaction needs for its own bookkeeping
>  	 */
> --
> 2.39.2
>

-- 
Jani Nikula, Intel

