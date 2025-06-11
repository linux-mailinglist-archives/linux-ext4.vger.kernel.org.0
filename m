Return-Path: <linux-ext4+bounces-8367-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB77AD5CA7
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 18:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C2D173F30
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E520E713;
	Wed, 11 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTXxqDjG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B71F91C8;
	Wed, 11 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660481; cv=none; b=layUkyb9NJun5Q2AvT/ZouE/3HVjvjgLfXWnYJuZcPJN+oH0R0IGO7SjMVXA69lIopR76G3Th3PzcBuEtS2+LvkdLmMJJU6qEZsMYRwWeaF45b00JgIA48PJRBnaw61P0b/ZKA2fIvRntzlVLD9Q6O/ck0ST2cDH8VLVjoWExvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660481; c=relaxed/simple;
	bh=I9mqgXd9Ufhb22J0vFmLN/XFtTu2g2mWaKX5hF1Cdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbifCo8F8w+vKjxlMAQYDIC28ShaGh2ZoR3pzwkQzu5+7srdLN+I5VpioURwmvJKNp5KQ9t5p2jkK2K3lnjy4w7TOQdLAdY7vLVZfNEYpxsYBNgJmlv+pzlgrMGSRUAuPz5t8itlMUW5hwwXDuX4ZlnOawQkmhc+77B+Fdqc44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTXxqDjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C81C4CEEF;
	Wed, 11 Jun 2025 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660481;
	bh=I9mqgXd9Ufhb22J0vFmLN/XFtTu2g2mWaKX5hF1Cdr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTXxqDjGKKYme+hA/UjSezMXPAQQ6eys43nj8bfQtuECrWnxw43ZlL9HloGvJnAz4
	 7Jfx+NPRqB3Pqfru+Dcci1xfMbshPBZxVtHEhSssNx/1/BGv4S70p33bmvNbJvBMiL
	 bvvSzp12r5r042ilv23I11Cw1C+9oQYlKpjwmqR5yZ1MfxzTB2yB/JwtMe8u1fh/pO
	 0nXk3/nvl0hTlTCi9ZsI4ylns4dlHmtFT+oNiz68QPYHRVhrPtVylUJ5rv32cKWSng
	 QcGFpByzPlXezYPw7w8LNgDuCrp7kC4Yoen3jeqGiNtCdX+1GYySM5fuCa1WfmzEzH
	 +2FkbPYVStpbA==
Date: Wed, 11 Jun 2025 09:48:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
Message-ID: <20250611164800.GC6134@frogsfrogsfrogs>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610091200.54075-2-bagasdotme@gmail.com>

On Tue, Jun 10, 2025 at 04:11:59PM +0700, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warnings on ext4 atomic block writes docs:
> 
> Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate label atomic_writes, other instance in Documentation/filesystems/ext4/atomic_writes.rst
> Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplicate label atomic_write_bdev_support, other instance in Documentation/filesystems/ext4/atomic_writes.rst
> 
> These warnings reference duplicated cross-reference labels to themselves in
> the same doc, which are because atomic_writes.rst is transcluded in
> overview.rst via include:: directive, thus the culprit docs get processed
> twice.

<confused> How is that possible?  atomic_writes.rst is only "include::"d
once in overview.rst.  Is the file implicitly included through some
other means?

--D

> Remove the labels to fix the warnings.
> 
> Fixes: 0bf1f51e34c4 ("ext4: Add atomic block write documentation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/filesystems/ext4/atomic_writes.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
> index f65767df3620d5..f1a086aa026b1b 100644
> --- a/Documentation/filesystems/ext4/atomic_writes.rst
> +++ b/Documentation/filesystems/ext4/atomic_writes.rst
> @@ -1,5 +1,4 @@
>  .. SPDX-License-Identifier: GPL-2.0
> -.. _atomic_writes:
>  
>  Atomic Block Writes
>  -------------------------
> @@ -154,7 +153,7 @@ Creating Filesystems with Atomic Write Support
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  First check the atomic write units supported by block device.
> -See :ref:`atomic_write_bdev_support` for more details.
> +See "Hardware Support" section below for more details.
>  
>  For single-fsblock atomic writes with a larger block size
>  (on systems with block size < page size):
> @@ -201,7 +200,6 @@ details:
>  The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
>  writes are supported.
>  
> -.. _atomic_write_bdev_support:
>  
>  Hardware Support
>  ----------------
> 
> base-commit: d3f825032091fc14c7d5e34bcd54317ae4246903
> -- 
> An old man doll... just what I always wanted! - Clara
> 
> 

