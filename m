Return-Path: <linux-ext4+bounces-12518-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80ECDDB3D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 12:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59CFE300AB28
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BB315775;
	Thu, 25 Dec 2025 11:09:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F9229B36;
	Thu, 25 Dec 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766660998; cv=none; b=RaYNpWj3nOeVlapcIJFkIQGKFCR+leL7Z4b88/bAe+vyGkqpcFeBtPdWIWAkxLjoO3/zImbujrq6/SrL+vJIVe3EzKr5OUwvXbsn60bJYKhzOS3WsF56KJv6YEB3dIaBQxrYMe6c4sroMc+IiIUhxVW4kXJESXQZGmP5gVBroVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766660998; c=relaxed/simple;
	bh=85m+MoiWpK6LsjG/c5ewsfYBNFGAgruk4bwN5HfQYWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHi2QPa+X4ek6IckOzS5dlthUhAmQaNwEdfw8vDVhPc/xWLPB+VTKtICDUwgWGmYFx5qd2B71XOSpLFWF52ljWcDHriuugAO9JTBsP8RsqniUdVj37xdFVxuuF1DfV6Hpg34Rc0YgBi/85bHW6hHsXcPSAAhfLJcN+AJQnBmb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dcQxR2ym0zKHLwk;
	Thu, 25 Dec 2025 19:09:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A3F4E4058C;
	Thu, 25 Dec 2025 19:09:52 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAHZ_d+G01pCrq3BQ--.51932S3;
	Thu, 25 Dec 2025 19:09:52 +0800 (CST)
Message-ID: <74c06707-d062-44b6-a519-4520713c135d@huaweicloud.com>
Date: Thu, 25 Dec 2025 19:09:50 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix memory leak in ext4_ext_shift_extents()
To: Zilin Guan <zilin@seu.edu.cn>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20251225084800.905701-1-zilin@seu.edu.cn>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251225084800.905701-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHZ_d+G01pCrq3BQ--.51932S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw4kWFW5WFy3Xr1rZrWfuFg_yoWkJwc_JF
	ZrJr18Gr9xtr1vqF1xCr15tFySkF18Kr15WFWkKF93uFy3XFWrXF1vyr9rAFZ8ur4Uur9r
	Crs7try8KFyIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/25/2025 4:48 PM, Zilin Guan wrote:
> In ext4_ext_shift_extents(), if the extent is NULL in the while loop, the
> function returns immediately without releasing the path obtained via
> ext4_find_extent(), leading to a memory leak.
> 
> Fix this by jumping to the out label to ensure the path is properly
> released.
> 
> Fixes: a18ed359bdddc ("ext4: always check ext4_ext_find_extent result")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2cf5759ba689..1d21943a09b0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5375,7 +5375,8 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  		if (!extent) {
>  			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
>  					 (unsigned long) *iterator);
> -			return -EFSCORRUPTED;
> +			ret = -EFSCORRUPTED;
> +			goto out;
>  		}
>  		if (SHIFT == SHIFT_LEFT && *iterator >
>  		    le32_to_cpu(extent->ee_block)) {


