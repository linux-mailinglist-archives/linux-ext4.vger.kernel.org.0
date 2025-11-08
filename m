Return-Path: <linux-ext4+bounces-11699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8ABC42661
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 05:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9883BA48E
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 04:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F532D641F;
	Sat,  8 Nov 2025 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lMHptgO+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E376213E89;
	Sat,  8 Nov 2025 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574754; cv=none; b=aOEegXVs4K8XEYEtpj7FDAGqWHrTu+5mZnh3d91HC6+zDVIEEzK5pkmTVsvpJ1PrHbODXiGMHHMo4NPXIuw8i6SL1HT8lKMDfif4POsZUjmbcOSn+NPFVcWR3NMdKHZNHGwi7PU0alfOP8bikh96+6agn9dqpZbfxsIDWUDXyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574754; c=relaxed/simple;
	bh=84Fwes13GQzGGIEKu/rtOQJBIgj5vBKKGERWcmYs8MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dd3WA1wkdmd7tl7879KC99Z90LyUO4Lyx70rKdYrfRLsOtt7WklKgUZdsGSs2Ft0JvgwLRiPmDAELYO8nvRCKhIh+uSHmwpAAttZRHi1yNR5ivBaloeHfKV5nn/Mmi8EYs+FrQSDMJ4Veuba7H6lYmm3Ma1AHA5VkOrTvCpX+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lMHptgO+; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4d3Mfn12d9zThDX;
	Sat,  8 Nov 2025 12:01:05 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HPF/NcM3BtVLLC/sYQIVIuePAJPLl0cbuAATnLa0jMs=;
	b=lMHptgO+H1iEUVemG9PWkgd1tHuEkyMtmBpiHpsl0kLCj2rM9vbN9/ihOuzizPdf2g/aCKtNW
	WWJx1/ipZYLFpElKGMysMbKSDcDLBodoDbu5Sknp4BQMD0uqJOx4YYrw2PxEqoEZKSzAnsXiOoe
	+p0G/93HOv1wL/TBzsMHTEE=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d3MkL0dwGz1prMm;
	Sat,  8 Nov 2025 12:04:10 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A18D180B5A;
	Sat,  8 Nov 2025 12:05:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 12:05:46 +0800
Message-ID: <d4e265dd-a4c0-4e06-995e-98602275100c@huawei.com>
Date: Sat, 8 Nov 2025 12:05:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ext4: check if mount_opts is NUL-terminated in
 ext4_ioctl_set_tune_sb()
Content-Language: en-GB
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, Jan Kara
	<jack@suse.cz>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong"
	<djwong@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20251101160430.222297-1-pchelkin@ispras.ru>
 <20251101160430.222297-2-pchelkin@ispras.ru>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251101160430.222297-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-02 00:04, Fedor Pchelkin wrote:
> params.mount_opts may come as potentially non-NUL-term string.  Userspace
> is expected to pass a NUL-term string.  Add an extra check to ensure this
> holds true.  Note that further code utilizes strscpy_pad() so this is just
> for proper informing the user of incorrect data being provided.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>
> v2: check length of mount_opts in superblock tuning ioctl (Jan Kara)
>
>     Can't plainly return error at strscpy_pad() call site in
>     ext4_sb_setparams(), that's a void ext4_update_sb_callback.
>
> v1: https://lore.kernel.org/lkml/20251028130949.599847-1-pchelkin@ispras.ru/T/#u
>
>  fs/ext4/ioctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index a93a7baae990..3dec26c939fd 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1394,6 +1394,10 @@ static int ext4_ioctl_set_tune_sb(struct file *filp,
>  	if (copy_from_user(&params, in, sizeof(params)))
>  		return -EFAULT;
>  
> +	if (strnlen(params.mount_opts, sizeof(params.mount_opts)) ==
> +	    sizeof(params.mount_opts))
> +		return -E2BIG;
> +
>  	if ((params.set_flags & ~TUNE_OPS_SUPPORTED) != 0)
>  		return -EOPNOTSUPP;
>  



