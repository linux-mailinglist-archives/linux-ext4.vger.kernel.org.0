Return-Path: <linux-ext4+bounces-6263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0EA21208
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87381166F4B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0ED1DED5C;
	Tue, 28 Jan 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PktOBF/Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E581DE8A5;
	Tue, 28 Jan 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091684; cv=none; b=S2gAnx6D6VzI7zQX6KfIvPVb6wkk1c4IsKNNF0u5UuV0MMWUm5FPmXgt1QFdFB0nC4k8dMxkp/5EudTwgUnhoWai4q9noirqrL4Y+2QJSKYnVGsMHaMla2jj/clNpuBZl9FeU+TQ7fu1lqbMivDKs2ckCZVNS70YCieq+6tuy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091684; c=relaxed/simple;
	bh=ay2LMsgABI4SmCJAe/J7D/xpvdar0Iti35BCKJ/0V58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1yHn+v9KVyhGkhe4WM0VPEth9D4fcqoHlf6NBwTq5TpuRbMYwT+GTCJyLhKYgkwp7+5XkDOTcj7egUDpQLD+DaRPFDMEY4jmAfUhSOUo9Lxe7b+ctxiqWc6Gv95MHPExMvIgQqzSqgcugD8xq+rtcSxbhNzAGFg9pyAe5pyf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PktOBF/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC6C4CED3;
	Tue, 28 Jan 2025 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738091683;
	bh=ay2LMsgABI4SmCJAe/J7D/xpvdar0Iti35BCKJ/0V58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PktOBF/ZtRxoMf9ztCorFP6edWaSykd9tWgPIwOBcdzUMoTZ8SUG2/zawuJ5QlFPg
	 pR+inx0RUfjJZA7jNe45PrXRzLoju6ZMAUy9a1sz8wz8cVvcKue7pXuKXQKp1LfkiC
	 RYFTxGtWZMRsoC+RbshygPbPMzQ794xwYa1Cqs5IpMMsY5QQGjJOh0QepYCNv5u0Ax
	 73uyoewrdJV9JebxKC6KaBKFhV9KvzdWKKOwvYA/JgHrEKldJMiKMKw3Wb0YdHtAWB
	 D+gF0gP/mHWpCxZNROZQ7VQvvopoNxbYOqq53GzIs30iEks7j7ZYGLBG8GNOTMdLYd
	 6vvA4lHc9v3+w==
Date: Tue, 28 Jan 2025 11:14:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] common: remove the $FSYP check in _cleanup_dump
Message-ID: <20250128191442.GP3557695@frogsfrogsfrogs>
References: <20250128071315.676272-1-hch@lst.de>
 <20250128071315.676272-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128071315.676272-3-hch@lst.de>

On Tue, Jan 28, 2025 at 08:12:59AM +0100, Christoph Hellwig wrote:
> Despite the comment, _cleanup_dump is only called from xfs specific
> tests, so this is superfluous.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch looks ok, but I have a few extra[neous] comments...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

> ---
>  common/dump | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/common/dump b/common/dump
> index 50b2ba03c670..3761c16100d8 100644
> --- a/common/dump
> +++ b/common/dump
> @@ -223,12 +223,6 @@ _require_tape()
>  #
>  _cleanup_dump()
>  {
> -    # Some tests include this before checking _supported_fs xfs
> -    # and the sleeps & checks here get annoying
> -    if [ "$FSTYP" != "xfs" ]; then
> -       return
> -    fi
> -

I went looking in common/dump and I noticed the lack of an explicit
setup routine.  Instead, variables and _require calls are done when
sourcing the file.  Curiously there's no check for FSTYP==xfs, which I
guess is reasonable for sourced stuff, but I think that should all get
pulled up into _init_dump() or something.

The other thing I noticed is that sourcing common/dump deletes
$seqres.full, which seems like a real bug.

--D

>      cd $here
>  
>      if [ -n "$DEBUGDUMP" ]; then
> -- 
> 2.45.2
> 
> 

