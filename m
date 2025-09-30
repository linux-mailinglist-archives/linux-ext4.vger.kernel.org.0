Return-Path: <linux-ext4+bounces-10502-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896DBACAC4
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9173ADCA9
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5552F533A;
	Tue, 30 Sep 2025 11:25:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29C1D8A10;
	Tue, 30 Sep 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231506; cv=none; b=B/NPH4vV9HWFx1q3E8Vwokmfe3lBWLgfTKnmc3GhIkKQOMG1DjBRm3ks0ixWnZalI5188/zpMiPhS24PrCEuVDy+fPqb8rh7GdaDkecEDMJFlwkt4KFO20r946rhwnxsfu+9Jc+JUKESrToFYfvI7FGET7dSVuq+X85PdQjkX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231506; c=relaxed/simple;
	bh=NXRjKotQk2vAiCbWnW3c+m1O1zMOJHYM9S0J38k1EFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqfcvoAForWsNhvNFXwYWarlGqewYczYVj2i8HL8Splezhu2ctavpj/+n2JS661p2Za++WPzsRLSfFHXRH7Wn6B1H5ULpw4tsZYIAD3F9ejlF+vQmr0eUYKP8TuYG0JOOFXf6iyW9TGS4ZQHP01MiA4WWQZprZZUg1KNrDCWTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbZzP38VyzYQtrt;
	Tue, 30 Sep 2025 19:08:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E61E71A130A;
	Tue, 30 Sep 2025 19:08:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHGWEguttoImdKBQ--.23845S3;
	Tue, 30 Sep 2025 19:08:17 +0800 (CST)
Message-ID: <989a25da-c1a2-4541-a1a9-42b357276437@huaweicloud.com>
Date: Tue, 30 Sep 2025 19:08:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag
 combination
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
 Zhang Yi <yi.zhang@huawei.com>
References: <20250930102549.311578-1-kartikey406@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250930102549.311578-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHGWEguttoImdKBQ--.23845S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45JrWkXw1kuw45tF4xJFb_yoW5Wry3pF
	W5C3WDJ34vq34DuayIgr17XF1jgayrGr47XrZI9r1UZas8KFyxKF43tF47Za4kWr48u3Wj
	vF1FkF1UCw1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIccxYrVCFb41lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07brmiiUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/30/2025 6:25 PM, Deepanshu Kartikey wrote:
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

Thanks for the patch! It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
> Changes in v3:
> - Fix code alignment and use existing function/line variables per Zhang Yi
> - Keep check after ret = 0 where all inode fields are initialized, as
>   i_inline_off gets set during inode initialization after ext4_set_inode_flags()
> 
> Changes in v2:
> - Instead of adding validation in ext4_find_extent(), detect the invalid
>   INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
>   Zhang Yi to avoid redundant checks in the extent lookup path
> ---
>  fs/ext4/inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..5c97de5775c7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	}
>  
>  	ret = 0;
> +	/* Detect invalid flag combination - can't have both inline data and extents */
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
> +	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		ext4_error_inode(inode, function, line, 0,
> +			"inode has both inline data and extents flags");
> +		ret = -EFSCORRUPTED;
> +		goto bad_inode;
> +	}
> +
>  	if (ei->i_file_acl &&
>  	    !ext4_inode_block_valid(inode, ei->i_file_acl, 1)) {
>  		ext4_error_inode(inode, function, line, 0,


