Return-Path: <linux-ext4+bounces-12373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F255CC16C9
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 09:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A443024ACA
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CE339B3D;
	Tue, 16 Dec 2025 07:59:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D2335564;
	Tue, 16 Dec 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871981; cv=none; b=lJIqeLHX9sl1jrXQgjxvFQ+anXi3m0aaiaq21e+tfuWwCqbTGxgPSGeDtRIzGuaPI6+xpHIlhHup9LrG8osMcUxo4vlxPfFNMIvsIZz9DiKJNriZ5G+id4w2QKPUP23ht7/Wzc4dVGcTaSpRoPgF5I6sk3sj8cRpxOptPZYCnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871981; c=relaxed/simple;
	bh=1aGeO8jKnWFbaYknyY+lx+w3MkzVhSNp1sxB4O0YSHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAIkkzC/w+UrmJ0dF5V389BsHtIE2cofxWtMXgGvJUMYp17bm9UjdKK0PkSegO+GIJiU32GwX32Rp/QYmkT/mkqaEGoKllASXV78KnHvHRVWRPr4IQer8cPSIprDFGwxCdMbOlc8hybRM4/ZEApgprrBxiE2a58Z4E9wsCOM96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVq7r5VrKzYQv4P;
	Tue, 16 Dec 2025 15:59:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9BD781A06DD;
	Tue, 16 Dec 2025 15:59:29 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_dfEUFp8219AQ--.21551S3;
	Tue, 16 Dec 2025 15:59:29 +0800 (CST)
Message-ID: <8f7133f3-5303-4782-84da-e43fc57e86e3@huaweicloud.com>
Date: Tue, 16 Dec 2025 15:59:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ext4: Remove unnecessary zero-initialization via
 memset
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>
References: <20251211123829.2777009-1-dolinux.peng@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251211123829.2777009-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXd_dfEUFp8219AQ--.21551S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4xKF13uFy5Jr45JF1fWFg_yoW3uFcE9a
	4xAws7Wr4Y93WI9a4Svr1Sgr9xta48WrWfWrW3Gr1fXFyUt3yru3WDXw4Y9rn8WrW3GFW8
	Awn5XF4rKas8JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
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
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/11/2025 8:38 PM, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> The d_path function does not require the caller to pre-zero the
> buffer.
> 
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>

This should just be a cleanup.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..484cb7388802 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -858,7 +858,6 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>  	 * when trying to sort through large numbers of block
>  	 * devices or filesystem images.
>  	 */
> -	memset(buf, 0, sizeof(buf));
>  	path.mnt = mnt;
>  	path.dentry = mnt->mnt_root;
>  	cp = d_path(&path, buf, sizeof(buf));


