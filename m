Return-Path: <linux-ext4+bounces-8909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE2AFF1D3
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD45E48496A
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA0242902;
	Wed,  9 Jul 2025 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPpKm1td"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58428241680;
	Wed,  9 Jul 2025 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089255; cv=none; b=qD7VAHFdqfq5gLSYkKoBG50Nt3zTN3Su5kWZG6sbg3hs0ZZRu+PgVAJHEfeW+SUNB1YA3pfuQWCQfwN9VIbG7x3cRgUNdabl+0QrMLA8oWjJY9YpuHwnrjGFQXBlme8+P0O8rSg43KU/l7lGtaQtCsSXC8WtjKBPjwAbQ7nATGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089255; c=relaxed/simple;
	bh=Zm+FZCamXFOfYZVRCK0BZ5RTFEHBxsMTaWL62PvvIec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQj2v7nKNM7qI3gI5owYTb7RjPawhkQW5vEilOdBABWOa+UWNLAkmZIV3rLUGUVXTRHS6H50wii6ikv9r0jJZEElL4+6/nc4X+rdnMqMT7zrpdWTtyq1bJG2tlQ/TZNM6h8IcP7N2Qo45vISxhLitUJJsDymjpMcvDLda06P81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPpKm1td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61672C4CEEF;
	Wed,  9 Jul 2025 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752089254;
	bh=Zm+FZCamXFOfYZVRCK0BZ5RTFEHBxsMTaWL62PvvIec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPpKm1tdvE3ARsw+TSv1uypiy1hysiratTvCWm6vUTCuPzCxYQG6Fxd+hiYAaZxTf
	 10aHeuPAJyFJrwqjOLVTOh+uXYVA9Xka5uOBboT312UEjfa45Lop/Qwh4VNxv2B/6g
	 i2nmJnQkX3guMBfi/dvMWsPpiQ5ac8ORB3lf4OcGGOq5VrY5LwkXdoKOCI1ejRerNK
	 7q1dhRLxF4MvQmBBB/rBRDvcWjMagYnHI5DewDrgLechb1Axm60uYJ0KEM1BN5pY1Y
	 nlhcbGe+TuqG/3l1hQN5ZLl3/fTnwJImeh7zL9ru3SGV6tVAxddg94N7Qd88KxndEs
	 GgfY895mRO6iQ==
Date: Wed, 9 Jul 2025 12:26:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/2] Convert fs/verity/ to use SHA-2 library API
Message-ID: <20250709192650.GB28537@sol>
References: <20250630172224.46909-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630172224.46909-1-ebiggers@kernel.org>

On Mon, Jun 30, 2025 at 10:22:22AM -0700, Eric Biggers wrote:
> This series, including all its prerequisites, is also available at:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git fsverity-libcrypto-v1
> 
> This series makes fs/verity/ use the SHA-2 library API instead of the
> old-school crypto API.  This is simpler and more efficient.
> 
> This depends on my SHA-2 library improvements for 6.17 (many patches),
> so this patchset might need to wait until 6.18.  But I'm also thinking
> about just basing the fsverity tree on libcrypto-next for 6.17.
> 
> Eric Biggers (2):
>   lib/crypto: hash_info: Move hash_info.c into lib/crypto/
>   fsverity: Switch from crypto_shash to SHA-2 library

FYI, I've applied this series to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next
so that it gets linux-next coverage.

As mentioned, it depends on the SHA-256 and SHA-512 improvements in
lib/crypto/.  But Linus has also expressed a preference to not put too
much in one pull request.

My current plan is to do 3 pull requests:

    1. "Crypto library updates" - most patches, mainly SHA-256 and
       SHA-512 library improvements

    2. "Crypto library tests" - based on (1) but adds:
        lib/crypto: tests: Add hash-test-template.h and gen-hash-testvecs.py
        lib/crypto: tests: Add KUnit tests for SHA-224 and SHA-256
        lib/crypto: tests: Add KUnit tests for SHA-384 and SHA-512
        lib/crypto: tests: Add KUnit tests for Poly1305

    3. "Crypto library conversions" - based on (1) but adds:
        apparmor: use SHA-256 library API instead of crypto_shash API
        fsverity: Explicitly include <linux/export.h>
        fsverity: Switch from crypto_shash to SHA-2 library

I'll put all of these in libcrypto-next for linux-next coverage, but (3)
will have a slightly different base commit in the final version.

- Eric

