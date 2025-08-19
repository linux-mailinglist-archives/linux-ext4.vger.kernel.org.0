Return-Path: <linux-ext4+bounces-9395-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DA0B2C77E
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95054170CB3
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F827B328;
	Tue, 19 Aug 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k04Ck/8Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3920299E;
	Tue, 19 Aug 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614938; cv=none; b=jStFfSGd0YDbx1TAUn3nV/nqFFTJ3PnFx6XmQHBEOg35Op9161iHE+TLt8ope/PYxtbcGKWDzuC7axpAPbf2/LKLN/6jMhLbstddanVya9fp4kR1hijPT0mg1LjKYp3pjHpEs5bD7sha1l4uMYUT0jE66HLNb/ern226O0gBDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614938; c=relaxed/simple;
	bh=H58fj0I4jkJlHc1hDy1CZKSXx0spVc4T64PEGNgAkqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF/CIKSpHXHERlU8RZ/kw9YMwmN8MAi6gVP3PcG9rqb/SK2L3W6a8HyYJfqCz+/o92wQd11RO9HvcMTJznilie6AIi5vl52ZTUHXT70/tCj2AWub4DslWPmB/uEIq8UHu4TxNBluBCYYjS3XmlD6h8U3YEfbslGc1mKxc+jIvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k04Ck/8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE3C4CEF1;
	Tue, 19 Aug 2025 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614937;
	bh=H58fj0I4jkJlHc1hDy1CZKSXx0spVc4T64PEGNgAkqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k04Ck/8QpSDp835pbZNEz5/PhrvQO6Z8lowWexOiAGI72Zz5hNn3aijoLlAeHu8Yh
	 yJdJovRzSs6s+Gu0UGO4+B9klCeBj87fHXtydqC9bfszENJmaig5zBvLjVGZWh6D1V
	 2zeX0FF7Gwik5AUw1gbQ2FT63tFTuP71M0pOnfjQGwrUnMKrzejqzgE+2/LnstPTqw
	 HDXOHmFObMFr4r01Rt0J/gSMeKI6H/07sVoCaIJC78ko9cI9d3SqlWIwt6aXJcmBVo
	 enllQ1zwxGnqyxhYGWj8OYPkqkpgGGO8J2dLuJV7VxtELjuJjHprzYbECQm6eANHbU
	 0MrT5/glfylDw==
Date: Tue, 19 Aug 2025 07:48:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, corbet@lwn.net,
	linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fix spelling and grammar in atomic_writes
Message-ID: <20250819144856.GI7938@frogsfrogsfrogs>
References: <20250819124604.8995-1-mallikarjunst09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819124604.8995-1-mallikarjunst09@gmail.com>

On Tue, Aug 19, 2025 at 12:46:04PM +0000, Mallikarjun Thammanavar wrote:
> Fix minor spelling and grammatical issues in the ext4 atomic_writes
> documentation.
> 
> Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>

Much improved, thanks!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/ext4/atomic_writes.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
> index f65767df3620..b614b5ffe76b 100644
> --- a/Documentation/filesystems/ext4/atomic_writes.rst
> +++ b/Documentation/filesystems/ext4/atomic_writes.rst
> @@ -14,7 +14,7 @@ I/O) on regular files with extents, provided the underlying storage device
>  supports hardware atomic writes. This is supported in the following two ways:
>  
>  1. **Single-fsblock Atomic Writes**:
> -   EXT4's supports atomic write operations with a single filesystem block since
> +   EXT4 supports atomic write operations with a single filesystem block since
>     v6.13. In this the atomic write unit minimum and maximum sizes are both set
>     to filesystem blocksize.
>     e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
> @@ -50,7 +50,7 @@ Multi-fsblock Implementation Details
>  
>  The bigalloc feature changes ext4 to allocate in units of multiple filesystem
>  blocks, also known as clusters. With bigalloc each bit within block bitmap
> -represents cluster (power of 2 number of blocks) rather than individual
> +represents a cluster (power of 2 number of blocks) rather than individual
>  filesystem blocks.
>  EXT4 supports multi-fsblock atomic writes with bigalloc, subject to the
>  following constraints. The minimum atomic write size is the larger of the fs
> @@ -189,7 +189,7 @@ The write must be aligned to the filesystem's block size and not exceed the
>  filesystem's maximum atomic write unit size.
>  See ``generic_atomic_write_valid()`` for more details.
>  
> -``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
> +``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provide following
>  details:
>  
>   * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
> -- 
> 2.43.0
> 
> 

