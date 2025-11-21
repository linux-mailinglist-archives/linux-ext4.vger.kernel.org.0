Return-Path: <linux-ext4+bounces-11997-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839BC7AD15
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E294C3A157B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E926B76A;
	Fri, 21 Nov 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKR7OR48"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4981CEADB
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742183; cv=none; b=Yh47NCfcRST0JUC0h/CIb3vMnaxUf2NekLClW6w0FyYOQdwzn2Fi78DEOQIeJZn7zkB/cFQ3cEpfH7ZS19fxqCyJXDn4E+AQi37m8HQXxT1MeLZkqWR0CXA2Kq/+0beSAwVKIHaqGuQUYVcHxI+eZ6rGKR1//VTbylimudhi0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742183; c=relaxed/simple;
	bh=CXs+K1Dsa+/5D4FjlhMaI8tfAN0TTv7nM7MqPIT7D60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgUd+eYoDWG2wK8YyhxhL6WQuxn/kpkgSfYZiuyEn3JydUZHWxx8v9u2RpFPNZTl0aSrX04BLYPkMm/9liiXLN6sw/A/fGXITAFRbJ3379CM4++FlnH+bZmbr46973m7nDVTaSGIQrBpX5vgKJ1jogvZgQluiugzG2YdTyQZhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKR7OR48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB02DC4CEF1;
	Fri, 21 Nov 2025 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742181;
	bh=CXs+K1Dsa+/5D4FjlhMaI8tfAN0TTv7nM7MqPIT7D60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKR7OR482TjiVDZHv/lfm66DKEEIHcjifbYthApm7gW+1/+ShwhJTrUDnaj3dY9vG
	 Os6B7BLOY5coknhU9u77AC3RxB6LwYsYbT2592hf4hcmJlUFDHUfu7Ym4gkuLIHjr8
	 cpGGbkkJZoULBF/FwwOtb4Ovw5mqzrDVwwBmuaYYCawsOvYKutz1D9Y7LoI80Wt3aG
	 fmXvNRRoiDPhkxJbYNFnUQEqG0+2iYphlV7IGih/R93afGK6r6JBE2ovOEiNZc6X0K
	 C621Xrl01waHQOZ1sCRVrQem8QaBDT3IK+RQrwIcQ+E8ojsxKReQHa3Nd8JM1vifCN
	 QKsmeF2NgsOLg==
Date: Fri, 21 Nov 2025 08:23:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wu Guanghao <wuguanghao3@huawei.com>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
	yangyun50@huawei.com
Subject: Re: [PATCH v2 1/2] fsck: fix memory leak of inst->type
Message-ID: <20251121162301.GT196358@frogsfrogsfrogs>
References: <20251121033612.2423536-1-wuguanghao3@huawei.com>
 <20251121033612.2423536-2-wuguanghao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121033612.2423536-2-wuguanghao3@huawei.com>

On Fri, Nov 21, 2025 at 11:36:11AM +0800, Wu Guanghao wrote:
> The function free_instance() does not release i->type, resulting in a
> memory leak.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>

Looks good!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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

