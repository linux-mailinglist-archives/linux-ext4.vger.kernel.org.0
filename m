Return-Path: <linux-ext4+bounces-11903-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B906C6B360
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 19:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65D874E1FB3
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D731E5205;
	Tue, 18 Nov 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3DH+eZZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B936C0C6
	for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490623; cv=none; b=av6O2Fu+l8vedOHCotqO+n5F3eOIqeYRZeIERUedTl2HgUyomk7ZvSYRkE0syL5sGUHXJnMOflKIqewvpd32XufCV0nkQpWnTKUyymZVd+0CHd2LmiYTIUe3Hx1i/PA+fqzxl6qfzxAWR2UwAZesIf+e42UNaZV7LktGISZokFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490623; c=relaxed/simple;
	bh=JDYPKPeYMHGC/xrUxvOYR92MsrM0jjAznu9rEO3otO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz3W4upzcSiqfrQ9qwmLr770edEsgYRMjBbhVMP1UPOZjqgSIJezp0iBlaXx0IbY+y5vQZU5CcpGL3cIRcCpl1WG+iI0Uq4EZFQgkTHVymqgzkhOJS9KjsE+UMKtvUWZ4ACjBwzKI3Q2nsyb1jZC/1469QRgsqJ/nb+6UXDGNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3DH+eZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F99C116D0;
	Tue, 18 Nov 2025 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763490622;
	bh=JDYPKPeYMHGC/xrUxvOYR92MsrM0jjAznu9rEO3otO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3DH+eZZiRXB712Y1ufKeC4t57SG8151PIWxuWXzRXXJ370XNw8ZBMwnkNndZQ22Z
	 bxOHY+awPNuaj8GJHgpJLZ9UJT/VbliVmURKhA6LqQDPZ8ymlv3N/l/djSAPqYbNi8
	 tQs0ppDGMS6C1L0xmL7Y8iMP1dkYxEqpPqmG4yqL8gIBZjW6R2zxNPGhg8zrcihjh7
	 hPeWFeD1zE7C2wiBaeeMU75ax/39W2GLU5Jpe8M6Msul8phIvY/4YFfEvREdJNipe/
	 XQZ9PHiOaONwtd21HSJN5vGm85BgQiM5RnNI3Gd/0ykp04krm92qDT9b5y9LEaQ/u9
	 XKJe3OdYQNPNw==
Date: Tue, 18 Nov 2025 10:30:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wu Guanghao <wuguanghao3@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	yangyun50@huawei.com
Subject: Re: [PATCH 1/2] fsck: fix memory leak of inst->type
Message-ID: <20251118183021.GQ196358@frogsfrogsfrogs>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-2-wuguanghao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118132601.2756185-2-wuguanghao3@huawei.com>

On Tue, Nov 18, 2025 at 09:26:00PM +0800, Wu Guanghao wrote:
> The function free_instance() does not release i->type, resulting in a
> memory leak.

Does anyone still use this wrapper?  I thought everyone used the
/sbin/fsck from util-linux...

--D

> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> ---
>  misc/fsck.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 64d0e7c0..a06f2668 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -235,6 +235,7 @@ static void parse_escape(char *word)
>  static void free_instance(struct fsck_instance *i)
>  {
>  	free(i->prog);
> +	free(i->type);
>  	free(i->device);
>  	free(i->base_device);
>  	free(i);
> -- 
> 2.27.0
> 
> 

