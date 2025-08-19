Return-Path: <linux-ext4+bounces-9396-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB1B2CA6A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAB104E2E8A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857353002DB;
	Tue, 19 Aug 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sflB6Bub"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7852FF673;
	Tue, 19 Aug 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624106; cv=none; b=X0lNsvOLa4fqQAAounssL5YCyKrq2aEGsoxELqAwoco2V/VpzhQ0vtqWXkR9HeSXMBA4X2orWu1L5JDVY4maOYq2q6cEKoI1167fYJenVpvDezS64GCXnrBW6fA48zVZu3GwLq04r46AsNQAFzN85rPj1iSTV1pbS4QGgVPw0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624106; c=relaxed/simple;
	bh=SDWSd9eDIVaOgvKOAno67JrZJi9jJ5T+MPV9EI76C2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVfl1i5XO17Jiph/HDvUA3ddpYLYaQ5rpk0D9cCfvNL8oEuWKjO2pB5LG23O/hpoRumIIYajFfTfy6akNYxDPJ74B01E503hQasropjyJqPnoC8OOfPGqKFaNzoJ4Lyi7XW+UjIL57Oh5uPRnaEojmqlEEQAEE9CWkKz5UsvhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sflB6Bub; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lgCY7eZ6MuSdBzowaVX9lsgvvatMY7ZW2gqbJ3qeJk8=; b=sflB6BubXc0WPqipoahes9+PDs
	HlZsvbvGnqVsMDR+diQOEZfV103qynUzZ8dmIymyfsbfPXI1ZzaNOHhl66hLfF4bgWzZXLSjhO2QH
	7YipIRtIKnlxsNXSCe/+3bYkkeLncnhQDboABQoCLvYum1SfGorN4abXB4qR0GFhqPAwRGvhhQ3al
	g8kAgyw5lLC7IdTglsjW4ohLd18CEPDG9J/ifDRR+Bt2J+uF7D//MaiFT0ZGmL6q/xOpX3722ayI1
	bsYCe6KZ+R0O26EMoPZ7yLDhlgPG9fFmAyukD6KRnnT8R62izEzHGBjGsRuhjrfN2z6w2ZokgOQYN
	f52Pbe0Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQ1o-0000000B5jT-0ESe;
	Tue, 19 Aug 2025 17:21:44 +0000
Message-ID: <3fb70bd5-76a6-4099-90d4-2cbee7f47475@infradead.org>
Date: Tue, 19 Aug 2025 10:21:43 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix spelling and grammar in atomic_writes
To: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, corbet@lwn.net, linux-ext4@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819124604.8995-1-mallikarjunst09@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250819124604.8995-1-mallikarjunst09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 5:46 AM, Mallikarjun Thammanavar wrote:
> Fix minor spelling and grammatical issues in the ext4 atomic_writes
> documentation.
> 
> Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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

-- 
~Randy

