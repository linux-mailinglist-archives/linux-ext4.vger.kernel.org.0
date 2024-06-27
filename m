Return-Path: <linux-ext4+bounces-2997-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD45591A85F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896BC2874AC
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4B19538B;
	Thu, 27 Jun 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yz+NUgDx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1991946BB
	for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496447; cv=none; b=Z3Mo8vkXcEB1Z8toNC5VMW8PzsGm8f7FSn7J/zW42Iv5NVlKKBd4qX7jNSLE8O2JlMoNQBAUR7DarESi0+SrjOlmkDnf7GmhH94qdy/ZOYaljfZqlRS/BDPUUKTn7Yy9IeDa54bD4vYWV0WBONIMWPLuEouVuCLY8X0h+BaFyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496447; c=relaxed/simple;
	bh=BhyQjUB20DyNLCbsVlNcG90NSdLghe8EYXQE/AWy5kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHUAGvFj3+3wb0jPwL75Vl2eq7B6b5G+A/8BuhQdzjqleozmoU/Bhdq9g/ywidRbp2AjBEzvZxsXxXv3PANBm8qvEpYGzA5TOQKgouYQ1E2SmkAKxHUcE3jIuMfXWs6UWCjcFY8HDnnGNFjTZtXxKC4Ei1cYGDdweWcy9padRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yz+NUgDx; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719496439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0OO5DYnxjOEWbc1tryLeGsCPnuTvb2MssSGWS2a+zQ=;
	b=Yz+NUgDxFfnrapkDKi0FEgLYBzp00I+FLUhEiqsNLLZUI3n/poZk80GOHrtEBLKIV1gbje
	//mpoA+aQJ67ZZeZ09wKqk88CPq9tdrMJPi0U3Z/8oN6ZOdAcOcFX6VvqWt3M2xP99xuWj
	K+Jgdw/IiDbhq6SVWZyEgQxtoNi5D60=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: yi.zhang@huaweicloud.com
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix infinite loop when replaying fast_commit
In-Reply-To: <20240515082857.32730-1-luis.henriques@linux.dev> (Luis
	Henriques's message of "Wed, 15 May 2024 09:28:57 +0100")
References: <20240515082857.32730-1-luis.henriques@linux.dev>
Date: Thu, 27 Jun 2024 14:53:52 +0100
Message-ID: <87a5j67aq7.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Wed, May 15 2024, Luis Henriques (SUSE) wrote:

> When doing fast_commit replay an infinite loop may occur due to an
> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
> not detect the replay and calls ext4_es_find_extent_range(), which will
> return immediately without initializing the 'es' variable.
>
> Because 'es' contains garbage, an integer overflow may happen causing an
> infinite loop in this function, easily reproducible using fstest generic/039.
>
> This commit fixes this issue by unconditionally initializing the structure
> in function ext4_es_find_extent_range().
>
> Thanks to Zhang Yi, for figuring out the real problem!
>
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Gentle ping...  Has this fell through the cracks?

Cheers,
-- 
Luis

> ---
>  fs/ext4/extents_status.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4a00e2f019d9..3a53dbb85e15 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
>  			       ext4_lblk_t lblk, ext4_lblk_t end,
>  			       struct extent_status *es)
>  {
> +	es->es_lblk = es->es_len = es->es_pblk = 0;
> +
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  

