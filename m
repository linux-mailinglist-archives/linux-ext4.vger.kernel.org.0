Return-Path: <linux-ext4+bounces-8820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB05AF9411
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C871CA4B50
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88A2FCE33;
	Fri,  4 Jul 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmRzdqSf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCC2FC3D1;
	Fri,  4 Jul 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635569; cv=none; b=kcdPOv/9bd7oZbNuBzOIiMsMs+dsef9ZWPfJ04E5bOyTZy3OjYh79+00LVj+J74MOFVVn4X6PKi/s+hT+i9AUEhViXZSvFJNZ511Tp5S+dDbhMCT2owuPoJPpB4OJbcplVyXmHbD+juILMlalTCdBDVlDvfX6fE+T1915n7uKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635569; c=relaxed/simple;
	bh=QfccnA0zgksNdZVm05TGsQ7eVbfl0jI/QjcOiED9+eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpkIs4p1QvGoKRhMAZAeXU42dQWwU+UOAE4tQJrLhRQLQSoT6eXXwdiOYAELIbDM0gi7QCHmsiXYQ7GVNQYnl2HMNXsrkRNac20WZYDtOVjjfexBWTI6+PBmKL/r3fg+e3ykkzgK6XqGZgrMdsWLK2Pyx+jQfCC3RFSOoTlLzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmRzdqSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD37C4AF09;
	Fri,  4 Jul 2025 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751635568;
	bh=QfccnA0zgksNdZVm05TGsQ7eVbfl0jI/QjcOiED9+eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mmRzdqSfD8ONxtlGzxNB29pHclwkaak8zScqIQshytzm/cx6ARkj8sp/kG8pRTdJ9
	 COVGmCqf3SMaFTMRL1UsX8p/pWgLzL/AlQNhTJsLDojq0gdJO0yYlB7cGeYiFeTFUR
	 BTZsySFOieY3QEO/6yWvG1qVXUlrIq/GNukGVrYDV9hcVEKBcdpy1ZfELW06zoXnxd
	 F19/yKj/2aNYCZHSAlyLsP+LmzSCeJH8FFnmr9+aA92aAirL9B0lSlkLHbJwrK1Fjd
	 ziZVgt8C6WW1KXEDQA+u6Nxf1bbhJ52bTRiBSIbpgVd5kB9SSIZJhaHaFFQdYHUgAQ
	 ha89IDa3Cu5Sg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553b584ac96so930196e87.1;
        Fri, 04 Jul 2025 06:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqLg4G9e59uPXzU5dsvkAD+gbstEMA9yhRfUC65O0VRIv8kLQBVDMjCyZsLT31crBH0PGn7q5T5WuInQ==@vger.kernel.org, AJvYcCWgDyc8M1TRly9vTkpBBa9ct4RRwFVXV0NQU0Wfv7ot3usJdmzlntrAgBjO9TWsycgTYTXXBrlgXVAeNfOC@vger.kernel.org, AJvYcCX9s0dqxBil98VKg2YwtwsfI91u/EJJeJON9Vf7XduIh0i1oqdxCl68n1vmVgQjc8jpNFjbNcqHaDKnAQ==@vger.kernel.org, AJvYcCXkMG851Z9slO4leDH9WrB9zfRptv3qLcOBnDtykmFtx/V5O5pxr2moceO2tyWU3LclOtWbgjmdXKVlgEjY@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkxr99dIOpzS+H25K0edfk+FBEH0QYFjqM1RWiBmSWLICh83q
	gUyonXpEQSoB/wP+BU3rd6hlZR1JUR/F8YajqoDgbxuNywRwJf797GWZpbsHk4s4G3XEjRLUnl9
	FSEayteFUI3leJdf/7gCrPRczWBtvy9o=
X-Google-Smtp-Source: AGHT+IGvVOO4kge0EEISokAVNGwR5hqz4/i/BGd42crh5oVCF+hAQX4pwsOeZZ2n1F20FE5+Y24MNfsy4OsedRlOW9Q=
X-Received: by 2002:a05:6512:3a88:b0:553:2e4a:bb58 with SMTP id
 2adb3069b0e04-556dbe8b3e7mr1012627e87.9.1751635567154; Fri, 04 Jul 2025
 06:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630172224.46909-1-ebiggers@kernel.org>
In-Reply-To: <20250630172224.46909-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 4 Jul 2025 15:25:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-eYjzxsZbCZKaje_a3jLAJMPXEu8Bb76O7ueO4tgisQ@mail.gmail.com>
X-Gm-Features: Ac12FXxiAnERbdwaoRjBCKkpahtdEbFUP_6dhB0XhYuW8ofqI7av77U-BIpSKE4
Message-ID: <CAMj1kXG-eYjzxsZbCZKaje_a3jLAJMPXEu8Bb76O7ueO4tgisQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Convert fs/verity/ to use SHA-2 library API
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 19:24, Eric Biggers <ebiggers@kernel.org> wrote:
>
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
>


Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  Documentation/filesystems/fsverity.rst |   3 +-
>  crypto/Kconfig                         |   3 -
>  crypto/Makefile                        |   1 -
>  fs/verity/Kconfig                      |   6 +-
>  fs/verity/enable.c                     |   8 +-
>  fs/verity/fsverity_private.h           |  24 +--
>  fs/verity/hash_algs.c                  | 194 +++++++++----------------
>  fs/verity/open.c                       |  36 ++---
>  fs/verity/verify.c                     |   7 +-
>  lib/crypto/Kconfig                     |   3 +
>  lib/crypto/Makefile                    |   2 +
>  {crypto => lib/crypto}/hash_info.c     |   0
>  12 files changed, 107 insertions(+), 180 deletions(-)
>  rename {crypto => lib/crypto}/hash_info.c (100%)
>
> --
> 2.50.0
>

