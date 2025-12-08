Return-Path: <linux-ext4+bounces-12231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036ACADEDF
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 18:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0871030840DC
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21796221F24;
	Mon,  8 Dec 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL2vTawS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BA199230;
	Mon,  8 Dec 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765215298; cv=none; b=jBJmQH7+xSUQ5Gi7+spBq+TsidaYranXm8hV5IJCJxB9PmCgQX5x9+7OfFS/D66RgCVQKF66PainK7ckNkKmOwheg6JTPufiHfLuAwt5tIYyKXRVdbGDgI8m38JkNT3aWgRhfXJxY4aN7kwOuAlqabwmKbPvQDl48yS+Q4axgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765215298; c=relaxed/simple;
	bh=nSV9WPDb5UtOwVi/S/3KhRv+j/yGjhBj3v8LR+2z7FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGpd8SQGp9LKCNGK3hVW25B8HaHZ6NDGhDoPHuh4Sh+/i1CXcki+PCZmnJFwHTeY3qx+jE9ltwmmyXpKaY/EM1b+H/nI/OJPfPqJUUSq+GJSN0+f1rfq6sEfURfXZvmmGTdWNaAp+R6sj4cU68FyuDIHs8qvuVp5tWyiYNzxfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL2vTawS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E863C4CEF1;
	Mon,  8 Dec 2025 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765215298;
	bh=nSV9WPDb5UtOwVi/S/3KhRv+j/yGjhBj3v8LR+2z7FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pL2vTawSgxCZusiciHH+TQyh7QxomFau7qh9b7Z7xEzTAZA30L5mA2UKQtjZJkRz4
	 g9dUwJ/JLGbkt/FUrXOIq+K96vFmehWZ3lbxHxrLrFiIWJuZwmkDh0iWO3HkyYnYT+
	 7wj60OgyooKBR1ndodDilfoi+r3T0eeObTFgXqFdKXCZafZvXtTD0+KRMipWXnFNGb
	 zBHtxj8ljMcMDMVhSG2Oq8Cxcftbi+K5t0hsJcJBhTzZIAIdid+H87hnh9FwMLe4Zk
	 8YHDm8iOdxrFlBK+vqyGykd+rxpLK+xwunNM9do+aRjCF5DiPTp3L6DyIEYECnfU2e
	 BeI57GIUj9gjQ==
Date: Mon, 8 Dec 2025 09:34:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, l@damenly.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH v2] generic: use _qmount_option and _qmount
Message-ID: <20251208173457.GH89454@frogsfrogsfrogs>
References: <20251208065829.35613-1-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208065829.35613-1-glass.su@suse.com>

On Mon, Dec 08, 2025 at 02:58:29PM +0800, Su Yue wrote:
> This commit touches generic tests call `_scratch_mount -o usrquota`
> then chmod 777, quotacheck and quotaon. They can be simpilfied
> to _qmount_option and _qmount. _qmount already calls quotacheck,
> quota and chmod ugo+rwx. The conversions can save a few lines.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
> Changelog:
> v2:
>   Only convert the tests calling chmod 777.

LGTM
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/231 | 6 ++----
>  tests/generic/232 | 6 ++----
>  tests/generic/233 | 6 ++----
>  tests/generic/270 | 6 ++----
>  4 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/generic/231 b/tests/generic/231
> index ce7e62ea1886..02910523d0b5 100755
> --- a/tests/generic/231
> +++ b/tests/generic/231
> @@ -47,10 +47,8 @@ _require_quota
>  _require_user
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  if ! _fsx 1; then
>  	_scratch_unmount 2>/dev/null
> diff --git a/tests/generic/232 b/tests/generic/232
> index c903a5619045..21375809d299 100755
> --- a/tests/generic/232
> +++ b/tests/generic/232
> @@ -44,10 +44,8 @@ _require_scratch
>  _require_quota
>  
>  _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  _fsstress
>  _check_quota_usage
> diff --git a/tests/generic/233 b/tests/generic/233
> index 3fc1b63abb24..4606f3bde2ab 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -59,10 +59,8 @@ _require_quota
>  _require_user
>  
>  _scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
>  
>  _fsstress
> diff --git a/tests/generic/270 b/tests/generic/270
> index c3d5127a0b51..9ac829a7379f 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
>  _require_attrs security
>  
>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> -_scratch_mount "-o usrquota,grpquota"
> -chmod 777 $SCRATCH_MNT
> -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> +_qmount_option "usrquota,grpquota"
> +_qmount
>  
>  if ! _workout; then
>  	_scratch_unmount 2>/dev/null
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

