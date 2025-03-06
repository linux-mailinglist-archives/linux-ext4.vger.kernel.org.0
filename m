Return-Path: <linux-ext4+bounces-6694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD6A5533F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 18:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4425D1894AC3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9B25C716;
	Thu,  6 Mar 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPJqBjnB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8825BAC4;
	Thu,  6 Mar 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282919; cv=none; b=ml/OBmiAKwNAF3Xpi0YyEIGpb7rPzsuP2jWY0ZHSrZvVH7ln4SaFlhjQaJnLMCEQQpldS84sXpKP3kmSl2vDB//2srY6BIivMTh5dO3mvua+lueEjs8L/ajdiqTrYUn88ETRh0vX58Sr7kr8C3xiGiDoI12WvQSjRg4QJpqmbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282919; c=relaxed/simple;
	bh=MyYrjPsir3kbQH21QKS573iEO2prM4xeSOkTWRMb1zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3QRlQGsewPafrL9We++VWzC4H0oFByKGQ1mlobW2gGlMJgyj+j6Jl5WWHhFdwZa8gA6yCZZrDBNrqy3aJBIh9+d4IQXxejlMWGFnaY0V5W2n/HTa4neS85mGwxrjRTibpq7XcfqGcQk3VShqsoxMDDDta9Q1+htYVZ5ahFM5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPJqBjnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA03C4CEE0;
	Thu,  6 Mar 2025 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741282918;
	bh=MyYrjPsir3kbQH21QKS573iEO2prM4xeSOkTWRMb1zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPJqBjnB2NyRAdeioTJx8tfCVRYVLoa6poNivzApg5lXwQf1/dK2El/t8OImbSJM3
	 ysfAEJwK+J5H+XrKZvPJcX1CO6Pjjp4NzJXgAWKhiasOqQzLSkKkVjQTspRS94P1Qv
	 RpFFl2K764QKprMTjdG568OQhYUdUhPG/O9O2TOxsOMnpSmxxgPPobDrZHNRqZOUYf
	 uRVAxfP8qdcZR0fqh2XPIYZfP14+kO5IXTeXuLg3inUP4OeaxsqFdPBt3zfmJE6Qj4
	 SFZSOCjycPykpqvYlPYW4kujl+05p1PtJdObcM4OmGyhiPLxLjxoay7pp6IqPfFWBL
	 EBSiSUs+pIpbw==
Date: Thu, 6 Mar 2025 09:41:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v1 1/2] generic/749: Remove redundant sourcing of
 common/rc
Message-ID: <20250306174157.GO2803749@frogsfrogsfrogs>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <149c6c0678803e07e7f31f23df4b3036f7daf17f.1741248214.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149c6c0678803e07e7f31f23df4b3036f7daf17f.1741248214.git.nirjhar.roy.lists@gmail.com>

On Thu, Mar 06, 2025 at 08:17:40AM +0000, Nirjhar Roy (IBM) wrote:
> common/rc is already sourced before the test starts running
> in _begin_fstest() preamble.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Yeah, that sourceing shouldn't be necessary.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/749 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/749 b/tests/generic/749
> index fc747738..451f283e 100755
> --- a/tests/generic/749
> +++ b/tests/generic/749
> @@ -15,7 +15,6 @@
>  # boundary and ensures we get a SIGBUS if we write to data beyond the system
>  # page size even if the block size is greater than the system page size.
>  . ./common/preamble
> -. ./common/rc
>  _begin_fstest auto quick prealloc
>  
>  # Import common functions.
> -- 
> 2.34.1
> 
> 

