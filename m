Return-Path: <linux-ext4+bounces-10498-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D331BAC10C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A2A3209E3
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E9244693;
	Tue, 30 Sep 2025 08:34:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD22BB17;
	Tue, 30 Sep 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221276; cv=none; b=grplM41W5sbZEzxm5DezH069xEi67pqqu45aeLBeBD0RqKnR5WZssMlT2E/cqDUKBF1icPAE1wRCLO2cnLEFwYJ0z/4wk3DGGos5Z4vF5A8JP1wm7otG8jm7T8ZfbI5+oSCw7wpW2aYpRWLCYOXEIAQf6wbZBCiwNWbXJb//3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221276; c=relaxed/simple;
	bh=SXsgFq8Xtn7OrIbbPNrPBD+k61+5DOvZpeBqN5ND1yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjXMyUwhJEdMjDvATYlTjwVhVUucUKNcvFJOqQRdLNHpY/tOxg/fXjb16f7DUucN+k3sD47P4/47cmkLA7ExEEKb6V/wZ62RNt6A94MTFBT5OxWvDZ4lMggnGV4gEvRcFDavnP418ZzrXwguH8Plqgl80tugeZ24XtcmKUU/Ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbWYx50yKzYQv8x;
	Tue, 30 Sep 2025 16:34:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 08FE81A156A;
	Tue, 30 Sep 2025 16:34:31 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHi2MUltto8ZU+BQ--.47119S3;
	Tue, 30 Sep 2025 16:34:29 +0800 (CST)
Message-ID: <ec41dc81-f6cd-4aaf-8fbc-968d3e3d6ba8@huaweicloud.com>
Date: Tue, 30 Sep 2025 16:34:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag
 combination
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
 Zhang Yi <yi.zhang@huawei.com>
References: <20250929154308.360315-1-kartikey406@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250929154308.360315-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHi2MUltto8ZU+BQ--.47119S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45JrWkXw1kuw45KFyUJrb_yoW5WFWfpF
	Z8Cw1Dt34DX34qg3yxKr4UXFyjga95Gr47JrZxWr18Aas8KFyxKF13tF4UZa4UWr4F93Wj
	vF45KryUC3WUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/29/2025 11:43 PM, Deepanshu Kartikey wrote:
> syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
> file on a corrupted ext4 filesystem mounted without a journal.
> 
> The issue is that the filesystem has an inode with both the INLINE_DATA
> and EXTENTS flags set:
> 
>     EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
>     comm syz.0.17: corrupted extent tree: lblk 0 < prev 66
> 
> Investigation revealed that the inode has both flags set:
>     DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1, extents_flag=1
> 
> This is an invalid combination since an inode should have either:
> - INLINE_DATA: data stored directly in the inode
> - EXTENTS: data stored in extent-mapped blocks
> 
> Having both flags causes ext4_has_inline_data() to return true, skipping
> extent tree validation in __ext4_iget(). The unvalidated out-of-order
> extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
> underflow when calculating hole sizes.
> 
> Fix this by detecting this invalid flag combination early in ext4_iget()
> and rejecting the corrupted inode.
> 
> Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
> Suggested-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thank you for debugging and thoroughly investigating this issue! This
patch overall looks good to me, with just a few minor suggestions.

> ---
> Changes in v2:
> - Instead of adding validation in ext4_find_extent(), detect the invalid
>   INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
>   Zhang Yi to avoid redundant checks in the extent lookup path
> 
>  fs/ext4/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..71fa3faa1475 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	}
>  
>  	ret = 0;
> +	/* Detect invalid flag combination - can't have both inline data and extents */
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
> +		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
	    ^^^
	    I'd recommended to maintain format alignment.

> +		ext4_error_inode(inode, __func__, __LINE__, 0,
		                        ^^^^^^^^^^^^^^^^^^
		                        function, line,> +			"inode has both inline data and extents flags");
> +		ret = -EFSCORRUPTED;
> +		goto bad_inode;
> +	}
> +

Additionally, I would prefer to move this check earlier, immediately
after setting the flags, that is, after ext4_set_inode_flags(). What
do you think?

Thanks,
Yi.

>  	if (ei->i_file_acl &&
>  	    !ext4_inode_block_valid(inode, ei->i_file_acl, 1)) {
>  		ext4_error_inode(inode, function, line, 0,


