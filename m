Return-Path: <linux-ext4+bounces-4676-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9D9A7012
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340011C20AE6
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECFC1D2F54;
	Mon, 21 Oct 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YQB4gjn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4347A73;
	Mon, 21 Oct 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529393; cv=none; b=O91ZiuhwxOJqmgbQjrg5Vl/8xad8oJA1lObfezzpyOEiqgm5d59iFskuwxVTAhnMfX7yi+ncvRI9rFdU3WZxdOweGumvQroZk7U0ME2DpLDn5GdvhTFwZ18LXxqLOML+qNc2tcgU5aP63M6uA3ag9oY1GlWuhogvcd9ynuorUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529393; c=relaxed/simple;
	bh=s7cQ67V0WvFW7xc6NDJ+wWfNiLXP6oPPIKArIaaLn+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKCmCXzJI7SVGnvJdFu7J0QwBnSK54F/gxDh9Hps8VtA6ATCqj+j7d5AQ7GEJ3f1lWtz/HS39HDvAB3iNFfI4+TN5RuMDR1bCXm4msiusAhyVZgxcOhAHJJ2+40/Y2B0kcrC8wPYzbvQYspPE8TJMu/FqaXR0sXhoggFKrLqilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YQB4gjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36D5C4CEC3;
	Mon, 21 Oct 2024 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729529393;
	bh=s7cQ67V0WvFW7xc6NDJ+wWfNiLXP6oPPIKArIaaLn+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2YQB4gjnNkPFma1Urq/z+KbRJrUWiGYDOrbFZScD3cTlC7pdPRwH3FOli2pvpiaXQ
	 iM94vG0sm5Dh3nW/q3rqn+s+5HJawBZr80aZ6kY2lxIf8vCNtU+ZI8PoEqWnQ6fuuw
	 twuhm1GNz6bHoKRdjhPBa57UEBlaQw9JKQZOitSg=
Date: Mon, 21 Oct 2024 18:49:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: jack@suse.cz, hch@lst.de, sashal@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [5.10.y] Regression in EXT3/4 with v5.10.227, LTP preadv03 is
 failing
Message-ID: <2024102130-thieving-parchment-7885@gregkh>
References: <lrkyqy12hpikl.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqy12hpikl.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>

On Mon, Oct 21, 2024 at 05:43:54PM +0200, Mahmoud Adam wrote:
> 
> Hello,
> 
>   In the latest 5.10.227 we see LTP preadv03 failing on EXT3/4, when
> bisected it was found that the commit dde4c1e1663b6 ("ext4: properly
> sync file size update after O_SYNC direct IO") is causing it
> 
> This seems similar to what occurred before[1] and if I understand
> correctly it was because of missing dependency backport 936e114a245b6
> ("iomap: update ki_pos a little later in iomap_dio_complete") which was
> then backported to 5.15 & 6.1 but not to 5.10.
> 
> *This is not failing on 5.15 nor 6.1, and it does fail consistently in x86-64 & ARM
> 
> [1]: https://lore.kernel.org/all/20231205122122.dfhhoaswsfscuhc3@quack3/
> 


What do you suggest be done?

thanks,

greg k-h

