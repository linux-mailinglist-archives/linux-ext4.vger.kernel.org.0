Return-Path: <linux-ext4+bounces-9345-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC9B22EE7
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047742A39E4
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C12FDC49;
	Tue, 12 Aug 2025 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQs/QBfg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A82FD1D3;
	Tue, 12 Aug 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019210; cv=none; b=C4xlYGLf3rEWNsGwutlfx0Kzq5Xxa9G/ERkVOYFmrwk8PUqMpOFelGU1Dp6o3LHv+o0UXEfq7ZWRJFTu3yGi+QtAAo4kxLy9GERYoOauhdvshxJcsF5ODMMjEUsvfDa07vAsTSfX/cBdowGGODT1n7rzRrA+thxL/9ToxSwpIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019210; c=relaxed/simple;
	bh=GVVr9x4BliJpzmi2+FHAJNSzN7cSTvVQiXWiA4/3q1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg1oSTY8tb2bMvsgzHxzBzwhXwoc0VAmOBFSDTvKRXBAVesEUpdtgfToujkwXA/JEuDemH/5Gq14xkzwOyjsEIVLm9e5ORyR8+UH2jnv4voX695YIl1P4tzvAXzEsPULQtDPM7NGPz/lN3MO/65E7t3i4CVXUVNi5WRi4IjbQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQs/QBfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430C1C4CEF0;
	Tue, 12 Aug 2025 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019210;
	bh=GVVr9x4BliJpzmi2+FHAJNSzN7cSTvVQiXWiA4/3q1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQs/QBfg8+iZxCYJQm/cheH2U6e5R9dPnq83S4n3PZ5SZ9Wd4W7eSapOM06sexH2f
	 8yRzmO58b9gvhaYgsXJfE86DSNibscKzwd/d7i2vtyYuyAeycF0miGvLLQMgz2ezx6
	 YJgVk9XPfXQYpNrvbspB4ZCrtgTk12qSwXv5EHBA0WYZCTFyXRibARAMrzhUqvQ8r7
	 qArn8sew5MHL+zzxUlcFV+6n4Px+YtbfUoCPPKuvpTIsWOXJV4/YzUBhdhR/aj2nMh
	 J5dru2He9zMMvjN044S26WsgS57RvOpnXo0OGa3ZCpAJ+eIl8WRxs1J0RzhoNd93xo
	 oqGBmUN9js0Cg==
Date: Tue, 12 Aug 2025 10:20:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Baolin Liu <liubaolin12138@163.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: fix incorrect function name in comment
Message-ID: <20250812172009.GE7938@frogsfrogsfrogs>
References: <20250812021709.1120716-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812021709.1120716-1-liubaolin12138@163.com>

On Tue, Aug 12, 2025 at 10:17:09AM +0800, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> The comment mentions block_write_begin(), but the actual function
> called is ext4_block_write_begin().
> Fix the comment to match the real function name.
> 
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Heh, that comment was copy-pasted too :/

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ed54c4d0f2f9..b0e3814f8502 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3155,7 +3155,7 @@ static int ext4_da_write_begin(const struct kiocb *iocb,
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		/*
> -		 * block_write_begin may have instantiated a few blocks
> +		 * ext4_block_write_begin may have instantiated a few blocks
>  		 * outside i_size.  Trim these off again. Don't need
>  		 * i_size_read because we hold inode lock.
>  		 */
> -- 
> 2.39.2
> 
> 

