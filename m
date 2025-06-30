Return-Path: <linux-ext4+bounces-8712-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86BAEE23C
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A571C7ABB94
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00AF286434;
	Mon, 30 Jun 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAFdgNJP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C41282FA
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296621; cv=none; b=NYne/8gDOERIO7vcfKF5DownyXnOW2ynQcOQ7AnAP3yX268OuSKRFf/121eJ6/HFrbZqNyiPF6uY20z220C2gqprr3v3G0QQmM+IMaqvd9jfDoeyjtgC8zT6n3EUI1E6EXeN0GLOW6qL9mT38dkG4UDkPgzQyolCtPPm2GYUf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296621; c=relaxed/simple;
	bh=o+UuY9ZOUKXFF3hp2l7ZowTncqlBexog7yucSv5p6Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNG/uanpfGzeWT4pkbbFvY1E56HhsneFEaSms1k8avPSuAXWomiKL4ZO37dANIhMnxJOyV7sRadb5UJm9WsD/W7jX/QC6YYwM9gh0aK7KVaqaP63hSjf48ReYCa6VNVeUiC8p/K8Fx1W9k0k/0EfOp2wx8dvrQMqCG0VkFuNtwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAFdgNJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57DAC4CEE3;
	Mon, 30 Jun 2025 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296620;
	bh=o+UuY9ZOUKXFF3hp2l7ZowTncqlBexog7yucSv5p6Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAFdgNJPefKgGFi6pw7S6i3ET2O+U9k7tUW9lRnzUDxZ1eXi7u0qXlXiXg0RGPUfp
	 FZgrMUNgjRpDAoBZ7iQzfNbuDoLMeB5ZMw/rQb004IO3QtW5IRiVsyRnzmV93BFaDh
	 7RdReeB1OMMBFrx06mAKZGl6v/P6KrJaJDfGO6nV1iHZHQQa8ZEsCvFGx3uVNheL5z
	 daRu9oSqz+Cp9lgjUpYYpkrV1F27qcH28xawQ+jB73druC47kgoAORGXoGA2Jocv0f
	 pxMBzJ98dn5vZUQu7FSbeaAp54kyT/pDJhqJI6PlMa5cfBZW5mSSEcWkLorjdMdK/t
	 vaHiRm+fuVZlA==
Date: Mon, 30 Jun 2025 08:17:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: zhangjian <zhangjian496@huawei.com>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] debugfs: fix printing for sequence in descriptor/revoke
 block
Message-ID: <20250630151700.GB9987@frogsfrogsfrogs>
References: <20250627212451.3600741-1-zhangjian496@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627212451.3600741-1-zhangjian496@huawei.com>

On Sat, Jun 28, 2025 at 05:24:51AM +0800, zhangjian wrote:
> When cursor cross the last journal block and will dump old journal blocks
> sequence number will be lower than transaction number. Sequence number
> should be read from descriptor block rather than accelerating transaction.
> 
> For example:
> A snippet from "logdump -aO"
> ===============================================================
> Found expected sequence 6, type 1 (descriptor block) at block 13
> Dumping descriptor block, sequence 13, at block 13:
>   FS block 276 logged at journal block 14 (flags 0x0)
>   FS block 2 logged at journal block 15 (flags 0x2)
>   FS block 295 logged at journal block 16 (flags 0x2)
>   FS block 292 logged at journal block 17 (flags 0x2)
>   FS block 7972 logged at journal block 18 (flags 0x2)
>   FS block 1 logged at journal block 19 (flags 0x2)
>   FS block 263 logged at journal block 20 (flags 0xa)
> Found sequence 6 (not 13) at block 21: end of journal.
> ===============================================================
> 
> sequence number should be 6 from header->h_sequence, rather than 13 from
> transaction accelerating from jsb->s_sequence
> 
> Signed-off-by: zhangjian <zhangjian496@huawei.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@h-partners.com>
> ---
>  debugfs/logdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index 324ed425..56f36291 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -532,7 +532,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  		case JBD2_DESCRIPTOR_BLOCK:
>  			dump_descriptor_block(out_file, source, buf, jsb,
>  					      &blocknr, blocksize, maxlen,
> -					      transaction);
> +					      sequence);
>  			continue;
>  
>  		case JBD2_COMMIT_BLOCK:
> @@ -545,7 +545,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>  		case JBD2_REVOKE_BLOCK:
>  			dump_revoke_block(out_file, buf, jsb,
>  					  blocknr, blocksize,
> -					  transaction);
> +					  seqeunce);

If you're going to resend the patch in rapid succession, you could at
least fix the typo build errors too...

$ pwd
/home/djwong/e2fsprogs
$ git grep seqeunce
$

--D

>  			blocknr++;
>  			WRAP(jsb, blocknr, maxlen);
>  			continue;
> -- 
> 2.33.0
> 
> 

