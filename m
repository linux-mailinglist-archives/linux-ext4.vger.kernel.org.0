Return-Path: <linux-ext4+bounces-1852-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52789848C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 12:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4351C25503
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA9762EF;
	Thu,  4 Apr 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CV47OjUS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB425D8EB;
	Thu,  4 Apr 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224847; cv=none; b=kzRNdVIFAbydmyz8yBV6vpbkkXzu/RGFKhkhom8b89JPlF7yFFr0gQO6enL6xtVggERfmbPNqYWi+LKIn6/x5p44YBcP35MQQF2ByONJFDkNKyDhMvmPAJQcZx+Py4vZuVqcWfYEYQs2dneWfhvZhPAegWnuf3SeS/7GGdC5aXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224847; c=relaxed/simple;
	bh=pzg/NxCbsTpVY8BNmN1lAO6InQKeDAeyEthGxsKZB04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkCZaiiMib5E9qYW3bk0sSDYje/gHy5sH+ID9WTwcaqGmzBmWp5QjIxODY9nzX3au5ZweAq7K7Ldpthg+tRnsnTxa0eeFo3DR3Jl1+/6LNqjmHYopDhzY3sqe7E4YqLwEvaeDPMMsTk5sNXv3PQAhZtQNqesLkYpHbl6eR1LE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CV47OjUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC1AC433C7;
	Thu,  4 Apr 2024 10:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712224847;
	bh=pzg/NxCbsTpVY8BNmN1lAO6InQKeDAeyEthGxsKZB04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CV47OjUS7AHnFMtpiQzFpVg9yPfEeouSXWGrCsve6UuRIY5+vrKeIeFjOcXQMtcYY
	 dNqTCNhzR+XJJh1mSeGewOutrdaiiceST0bcCciVHBTqOTr8PAd15sEBkEX1Ui8f7O
	 dkUiY54HhrqumPKZXE4qdtnQ7uBmx2S2CourDoXE=
Date: Thu, 4 Apr 2024 12:00:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michail Ivanov <iwanov-23@bk.ru>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Message-ID: <2024040424-fax-freeway-ff7c@gregkh>
References: <20240404095000.5872-1-mish.uxin2012@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404095000.5872-1-mish.uxin2012@yandex.ru>

On Thu, Apr 04, 2024 at 12:50:00PM +0300, Mikhail Ukhin wrote:
> Fuzzing reports a possible deadlock in jbd2_log_wait_commit.
> 
> The problem occurs in ext4_ind_migrate due to an incorrect order of
> unlocking of the journal and write semaphores - the order of unlocking
> must be the reverse of the order of locking.
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>

Does not match your From: line :(

> ---
>  fs/ext4/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index d98ac2af8199..a5e1492bbaaa 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -663,8 +663,8 @@ int ext4_ind_migrate(struct inode *inode)
>  	if (unlikely(ret2 && !ret))
>  		ret = ret2;
>  errout:
> -	ext4_journal_stop(handle);
>  	up_write(&EXT4_I(inode)->i_data_sem);
> +	ext4_journal_stop(handle);
>  out_unlock:
>  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
>  	return ret;
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

