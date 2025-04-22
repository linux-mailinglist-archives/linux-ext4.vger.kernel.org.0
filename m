Return-Path: <linux-ext4+bounces-7394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386FA96CDC
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Apr 2025 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011603BB341
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Apr 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442328137D;
	Tue, 22 Apr 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OlZqMMca"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F741280CC8;
	Tue, 22 Apr 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328642; cv=none; b=SPtg5P8GUviPu2uqPF4dFtAVi+Xx1OFU9FbsLqqeQG9Un2CSyHGL0BvhRhDdMco2IHwHopsseZ+q+OKDnz/tqce9jgKSwo6klEctjOT3sYnW89XAbvfsOzyCxCwQ0WEtHEYcbcNt4qL4/84hCzTCsywLR3nQazBO44FAkIKUuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328642; c=relaxed/simple;
	bh=675nI73TK3yzWzYYdekYDaWI36QZ+fU5y2hIwCEJcK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JjdON0N/eqFoZT3F32PebkysUm23CtHMg+FNh0z/gAXLBjbQirudiBKEbgOpDwDxFQtgnkOKpsT2Z8P4FJOY1uvoGcfxj8y8mTrpmZ0uEe7DLo3tsBkasqivBc46UYbSpoRyH7ZcmUCXLnlRCR3Uj3mK8MUJYcGrvvPV6Z0gjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OlZqMMca; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4561541058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1745328640; bh=S8E9dCL2t2/JovDkCNE7YlquaFlBHiJ3Hvfqf4qvr2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OlZqMMcaBZWoHS3co3iNgHkdqedc880EqwruJ7CsAHqO1gPBMlJFb5gotxlXNgoDU
	 itWmT8essp0GnlOKlYcDTXczvUhwVBVWIhlhMxQF2iutiCh3TfkLjiAnt5FXJZEfLp
	 l+Cmg1AVY7x3+LWW0xN3TWxdKruVrrh22lt05Hpy/aZuxZ/9SoAa1nNivPwI1pihX1
	 i2kBTfo6W33vhDO5Vmcuibdi8YWwtv0XCTvZ/6/Nzv8Syn6LFKPdNqgn9BK8hSvSSh
	 knz23BcW+bddW1ryvL6njppZVsAioit6yPdKKe6G8QRKvYGx1ucaEkwHbcnVB3C4IK
	 dun6ClhqSX/Og==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4561541058;
	Tue, 22 Apr 2025 13:30:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: I Hsin Cheng <richard120310@gmail.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, I Hsin
 Cheng <richard120310@gmail.com>
Subject: Re: [PATCH] docs: ext4: Ammend white space
In-Reply-To: <20250422055702.451729-1-richard120310@gmail.com>
References: <20250422055702.451729-1-richard120310@gmail.com>
Date: Tue, 22 Apr 2025 07:30:39 -0600
Message-ID: <87zfg8uxvk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I Hsin Cheng <richard120310@gmail.com> writes:

> There should be a white space between the words "block" and "size",
> instead of writing them together as "blocksize". Ammend a white space
> between them.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  Documentation/filesystems/ext4/blockgroup.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
> index ed5a5cac6d40..32a66a956f31 100644
> --- a/Documentation/filesystems/ext4/blockgroup.rst
> +++ b/Documentation/filesystems/ext4/blockgroup.rst
> @@ -108,7 +108,7 @@ block groups which can be described by a single block group descriptor
>  block. Since the size of the block group descriptor structure is 64
>  bytes, a meta-block group contains 16 block groups for filesystems with
>  a 1KB block size, and 64 block groups for filesystems with a 4KB
> -blocksize. Filesystems can either be created using this new block group
> +block size. Filesystems can either be created using this new block group
>  descriptor layout, or existing filesystems can be resized on-line, and
>  the field s_first_meta_bg in the superblock will indicate the first
>  block group using this new layout.

Thank you for working to improve the documentation!

If you dig through our documentation, you will see that "blocksize" is
fairly common usage.  Changing them all will result in a fair amount of
churn without much in the way of benefit in either readability or
accuracy.  May I politely suggest focusing on the many real problems our
documentation has instead?

Thanks,

jon

