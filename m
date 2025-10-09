Return-Path: <linux-ext4+bounces-10696-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C3BC72E3
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 04:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F1F3C6D23
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 02:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6119CC27;
	Thu,  9 Oct 2025 02:11:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD261F92E;
	Thu,  9 Oct 2025 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975871; cv=none; b=DHioYfT1EWJIdjeijC/7hp5Nzag33PW0Tn6ysyazO9wbOqXQHX4EAEU/GBcEatkluBBV4Gacs5Mqj6p7QgzD/H3zb7yml5tF6Ud7JD1JUzPLn3z/XWvZa/JCvLcQ7Pd1+SgU533ur5RqSYEcjQcdJcW7Yzh0ZhRZmj4PSXiviPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975871; c=relaxed/simple;
	bh=F2JPeRTrb+18FKIQe3AusKYskJOkhvJMDhq3VVgEGck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNb9Xp1CXB41DEx9N/wNmgEEleCnrvFxlEKNcBLUDT8KvGtk6PwhydGuchywFIPbI6dJdudi8Gc1WJ/bdhQixL+Vr+PCE8ijBDcgRnXK5MJKZ1FqcOpbW6Y4MAs9RRzndd/1hYbvgC2tL22TZ8JcfKlArXT/aoNOV72kmghXOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4chtd63c8zzKHMQH;
	Thu,  9 Oct 2025 10:10:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ABA9D1A12FB;
	Thu,  9 Oct 2025 10:11:02 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgDX6GC0GedozBwgCQ--.12174S3;
	Thu, 09 Oct 2025 10:11:01 +0800 (CST)
Message-ID: <4962e5a0-a03e-4e9a-8f8e-5db04504c30e@huaweicloud.com>
Date: Thu, 9 Oct 2025 10:11:00 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag
 combination
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
 Zhang Yi <yi.zhang@huawei.com>
References: <20250930112810.315095-1-kartikey406@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250930112810.315095-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDX6GC0GedozBwgCQ--.12174S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45JrWkXw1kuw4rXF1kXwb_yoW5ArWDpF
	ZxC3WDJ34DX34DGa97Kr17XF4jg3WrGr4UJrZIvw1UZas8KFyxKF4xtF13ZF1DGr48Z3Wj
	vF1rKr1UCw1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/30/2025 7:28 PM, Deepanshu Kartikey wrote:
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

Thanks for the fix, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> 
> ---
> Changes in v4:
> - Move check to right after ext4_set_inode_flags() as suggested by Zhang Yi,
>   since we're checking flags directly (not ext4_has_inline_data() return value)
> 
> Changes in v3:
> - Fix code alignment and use existing function/line variables per Zhang Yi
> 
> Changes in v2:
> - Instead of adding validation in ext4_find_extent(), detect the invalid
>   INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
>   Zhang Yi to avoid redundant checks in the extent lookup path
> ---
>  fs/ext4/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..2fef378dbc97 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5348,6 +5348,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	}
>  	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
>  	ext4_set_inode_flags(inode, true);
> +	/* Detect invalid flag combination - can't have both inline data and extents */
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
> +	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		ext4_error_inode(inode, function, line, 0,
> +			"inode has both inline data and extents flags");
> +		ret = -EFSCORRUPTED;
> +		goto bad_inode;
> +	}
>  	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
>  	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
>  	if (ext4_has_feature_64bit(sb))


