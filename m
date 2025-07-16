Return-Path: <linux-ext4+bounces-9025-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239AB06E7C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028601A62390
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15D289E15;
	Wed, 16 Jul 2025 07:05:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF03289E04;
	Wed, 16 Jul 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649544; cv=none; b=tCymTCjkUDRzUQDzBWjh16f88fttJaAJjxihdpLZDqtl5RnNUKCVOwKQWWGECbRiOcJZFUNMX0wHcAHCI1wFw7lKIsDc2Bj3ipC59fe6DYNFPXjzbiUBB+0D6ghglbXzdYlOngbkB+nY65KfdGykdQJxdlI6KkUSOop8Txkc4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649544; c=relaxed/simple;
	bh=Yvf13pjIC0oaLeeAMDo6xAXVpC5ZAgzfWmrSA0+wzLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1jz/CxDiCJs4CzzhqzxMu8M7qnAh0A3tDfR096JBYzS6baEp9Kge6ERcdyyESxpZ66gJWiK3p/dlQFiTmNqxxRgasYoi3oeFiKWck0V2SSB1fvLVGjCwovknA0Rf7f4N44R4HVT5WFswLKj60zUyemwtdJnc0tXguyBalnmjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bhnBs102XzYQtFs;
	Wed, 16 Jul 2025 15:05:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DCE811A084D;
	Wed, 16 Jul 2025 15:05:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHgxNCT3do4069AQ--.2681S3;
	Wed, 16 Jul 2025 15:05:39 +0800 (CST)
Message-ID: <0e32bf57-6658-45c8-9b97-cbf1c958220c@huaweicloud.com>
Date: Wed, 16 Jul 2025 15:05:38 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags
 mask
To: chuguangqing <chuguangqing@inspur.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
References: <f42f9a79-75cf-491e-bf46-5ea036cf6656@huawei.com>
 <20250716030420.4528-1-chuguangqing@inspur.com>
 <20250716030420.4528-2-chuguangqing@inspur.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250716030420.4528-2-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHgxNCT3do4069AQ--.2681S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww18ZF17XryxGry8ZF1rCrg_yoW8GrWxpF
	4rWF18Wa48X34Ykas5Cw4v9rs8Xa1DGry5Wr4Syry8urW7Jrn7Kr4rK3Z5J3Z5WFW8Ar4U
	tF1ag3ZrXF43A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/16 11:04, chuguangqing wrote:
> Add FALLOC_FL_ALLOCATE_RANGE to the set of supported fallocate mode flags.
> This change improves code clarity and maintains by explicitly showing
> this flag in the supported flags mask.
> 
> Note that since FALLOC_FL_ALLOCATE_RANGE is defined as 0x00, this addition
> has no functional modifications.
> 
> Signed-off-by: chuguangqing <chuguangqing@inspur.com>

OK, now it looks good to me. Feel free to add:

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/extents.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index b43aa82c1b39..46cbb8697252 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4784,9 +4784,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		return -EOPNOTSUPP;
>  
>  	/* Return error if mode is not supported */
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> -		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
> -		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
> +	if (mode & ~(FALLOC_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
> +		     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> +		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE |
> +		     FALLOC_FL_WRITE_ZEROES))
>  		return -EOPNOTSUPP;
>  
>  	inode_lock(inode);


