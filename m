Return-Path: <linux-ext4+bounces-10471-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87531BA7C83
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 04:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAEF3AC785
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2F1E9B22;
	Mon, 29 Sep 2025 02:01:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767514286;
	Mon, 29 Sep 2025 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759111275; cv=none; b=ny5vwj0pr66km8AbRWdLgAB9KTEhLnX6ya6aRp3NyHV92cbMVAIYNB5t3huL4CnzogKVjiQfxA3JdxJ82WGgvU5H6JrniWpnlzwGRn2ZFkXiUkTddAMFuh2YGQw3hUZLwucnc4FwwgsFNrBXHgaljlG3gS/1W+vI9RYlj24wfLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759111275; c=relaxed/simple;
	bh=Ro7Kx2h2/6a55aSoFI7nfRu4gTKQyLI+4hme6PHnEBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnHlNm6GVVJ5dJ4WaKuCf0C1Lg3UTLwOpPe8ANLwJPp0UQCmTPLjyfHIBq9uee9YGexjgd+X6cdtrecMYCcOjyPMH8Xpv5G/FXMWkM2gLU/eEb+5zE/gQbbzr3djyr7kXmNPzSlgM2b+IRN/zoom+y3QTDoTUv+FUSSRQQW/9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZktb4LdNzYQtvN;
	Mon, 29 Sep 2025 10:00:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C5B421A0A37;
	Mon, 29 Sep 2025 10:01:10 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXW2Nk6NloSkWuBA--.20602S3;
	Mon, 29 Sep 2025 10:01:09 +0800 (CST)
Message-ID: <68829b32-7a8c-475a-9e27-f71822eb541b@huaweicloud.com>
Date: Mon, 29 Sep 2025 10:01:08 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: validate extent entries before caching in
 ext4_find_extent()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
References: <20250928100946.12445-1-kartikey406@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250928100946.12445-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXW2Nk6NloSkWuBA--.20602S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1DJryxGw1UJryUKrWDXFb_yoW5Jr43pr
	ZF9r1UtrykX34DG393tF4UZ3W2g348GrW7Ga9xKw4YvasxWFy8WFy7tay5XFn5ur4ruw4j
	vF4Ykas8GanxZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Deepanshu!

On 9/28/2025 6:09 PM, Deepanshu Kartikey wrote:
> syzbot reported a BUG_ON in ext4_es_cache_extent() triggered when
> opening a verity file on a corrupted ext4 filesystem mounted without
> a journal.
> 
> The issue occurs when the extent tree contains out-of-order extents,
> which can happen in a corrupted filesystem. ext4_find_extent() calls
> ext4_cache_extents() without validating the extent entries when the
> tree depth is 0 (leaf level). This allows corrupted extent trees with
> out-of-order extents to be cached, triggering a BUG_ON in
> ext4_es_cache_extent() due to integer underflow when calculating hole
> sizes:
> 
>   If prev = 4352 and lblk = 1280:
>   lblk - prev = 1280 - 4352 = -3072 (as signed)
>   = 4294964224 (as unsigned)
>   end = lblk + len - 1 = 4352 + 4294964224 - 1 = 1279 (after overflow)
>   BUG_ON(end < lblk) triggers because 1279 < 4352
> 
> Fix this by adding extent entry validation using the existing
> ext4_valid_extent_entries() function before caching. This ensures
> corrupted extent trees are detected and handled properly through the
> error path, preventing both the BUG_ON and potential use-after-free
> issues.
> 

Thank you for the fix patch! However, I am curious why the check in
__ext4_iget()->ext4_ext_check_inode() fails? It should check the
extents of the root node and be able to caught this corruption.

Thanks,
Yi

> Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/ext4/extents.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ca5499e9412b..f8e45623f7ea 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -924,8 +924,18 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  	path[0].p_bh = NULL;
>  
>  	i = depth;
> -	if (!(flags & EXT4_EX_NOCACHE) && depth == 0)
> +	if (!(flags & EXT4_EX_NOCACHE) && depth == 0) {
> +		ext4_fsblk_t pblk = 0;
> +
> +		if (!ext4_valid_extent_entries(inode, eh, 0, &pblk, 0)) {
> +			EXT4_ERROR_INODE(inode,
> +				"invalid extent entries, pblk %llu",
> +				pblk);
> +			ret = -EFSCORRUPTED;
> +			goto err;
> +		}
>  		ext4_cache_extents(inode, eh);
> +	}
>  	/* walk through the tree */
>  	while (i) {
>  		ext_debug(inode, "depth %d: num %d, max %d\n",


