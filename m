Return-Path: <linux-ext4+bounces-8910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7BAFF2FD
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 22:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320011BC5EA0
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1E244186;
	Wed,  9 Jul 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3t2jKeH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA7230D1E;
	Wed,  9 Jul 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093006; cv=none; b=o2WVQk2j48spv8LLWeWeq6D9Nyk0U3Xb0bsFAeMf2oXa1bLxAB4m3gP3M98s93ErJQI7kG7d1clk5fo13ZRD+ppHtCK2ntz5imDO25/HdZFN+Yjr+4A19HfnkvUByEQLE4gexPP7q+9Y7ru/cUJ5PVoaWedps66edQd4Uu1bhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093006; c=relaxed/simple;
	bh=9Q96tyvmm/n832GH6zIRTtNun3XU6jZzOe2zJCOpOjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYgnp/CWihXalzS0s/jFXeYpxVprhTOHPMqzt2moKIPZo5YscGr8Vh3mWekeMWlPSPUAletYGkx95W0Z7Oyg8BbN45RUWiI8rnwis7OCo0fl0Mof3rohkV/ziyzLc9OFyBpUBSTVKZk+q/qsZM2HPN9KNASKWnAoSU0BM8IHMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3t2jKeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B8EC4CEEF;
	Wed,  9 Jul 2025 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752093005;
	bh=9Q96tyvmm/n832GH6zIRTtNun3XU6jZzOe2zJCOpOjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3t2jKeHbZuG7Nf2jb48r87sW/ovq5oI0hQqRvXSzVBenc+MhgjDPuZwFeNPhCNTQ
	 ZB8pBdcNfn7V/cqJfGyRxiysWM2GluEVqtxIk1SqRNqbAI6ATQqTS/cnxEEJZLzZy/
	 GHmJuPAQ+nK4kE6WyEkibLwKq3jm2KexhTxlVpo8JvcxrjZl/e+K00Wf6LxJBgVH4D
	 woliFppHMtlHfXNNGu3q6h44jB8yBm/5uGVjl3XRLgbVnoQQrw170iEHExLiZHr8Ho
	 qOoh1Pubd+oO21Vpze5Yisjr463TADW/M+3LC60egjb8qRN7siN45tnsQ0FkNHFbqd
	 KTtK7EPOR6PvA==
Date: Wed, 9 Jul 2025 13:29:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/2] Convert fs/verity/ to use SHA-2 library API
Message-ID: <20250709202921.GC28537@sol>
References: <20250630172224.46909-1-ebiggers@kernel.org>
 <20250709192650.GB28537@sol>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709192650.GB28537@sol>

On Wed, Jul 09, 2025 at 12:26:50PM -0700, Eric Biggers wrote:
> On Mon, Jun 30, 2025 at 10:22:22AM -0700, Eric Biggers wrote:
> > This series, including all its prerequisites, is also available at:
> > 
> >     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git fsverity-libcrypto-v1
> > 
> > This series makes fs/verity/ use the SHA-2 library API instead of the
> > old-school crypto API.  This is simpler and more efficient.
> > 
> > This depends on my SHA-2 library improvements for 6.17 (many patches),
> > so this patchset might need to wait until 6.18.  But I'm also thinking
> > about just basing the fsverity tree on libcrypto-next for 6.17.
> > 
> > Eric Biggers (2):
> >   lib/crypto: hash_info: Move hash_info.c into lib/crypto/
> >   fsverity: Switch from crypto_shash to SHA-2 library
> 
> FYI, I've applied this series to
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next
> so that it gets linux-next coverage.
> 
> As mentioned, it depends on the SHA-256 and SHA-512 improvements in
> lib/crypto/.  But Linus has also expressed a preference to not put too
> much in one pull request.
> 
> My current plan is to do 3 pull requests:
> 
>     1. "Crypto library updates" - most patches, mainly SHA-256 and
>        SHA-512 library improvements
> 
>     2. "Crypto library tests" - based on (1) but adds:
>         lib/crypto: tests: Add hash-test-template.h and gen-hash-testvecs.py
>         lib/crypto: tests: Add KUnit tests for SHA-224 and SHA-256
>         lib/crypto: tests: Add KUnit tests for SHA-384 and SHA-512
>         lib/crypto: tests: Add KUnit tests for Poly1305
> 
>     3. "Crypto library conversions" - based on (1) but adds:
>         apparmor: use SHA-256 library API instead of crypto_shash API
>         fsverity: Explicitly include <linux/export.h>
>         fsverity: Switch from crypto_shash to SHA-2 library
> 
> I'll put all of these in libcrypto-next for linux-next coverage, but (3)
> will have a slightly different base commit in the final version.

Correction: everything can have the same commit ID in libcrypto-next as
in the final pull requests, if I put (2) and (3) on their own branches
and merge them together.  I've done that.

- Eric

