Return-Path: <linux-ext4+bounces-11329-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A934AC1950D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 10:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54CC7567BAC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE731AF16;
	Wed, 29 Oct 2025 08:45:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A530E0F3
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727549; cv=none; b=e48vsD85LsTlXu2O3l242ep16NAb9S7lfuc8DeN9wMqoT5U7sLmAMjx+7xxq0Hvu0hwT94U2Pv/JGxb+UWTWqMm5ZGwo0K2vwlATxT2GRqz3F9yfsA2LwC2jW21w8By9qWW57RiFO58E+L/j1kfO1rSLtxdFDmpgZn9xDDXfPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727549; c=relaxed/simple;
	bh=SNqOvtkHkaUKUEIOp4sS3zaqtBYgZzW8vrnloygQj4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF2D2yxcTkFuK+s6pxmsE/nuaIummzuceekgtWnkiECaidFIycXD4dF6FlauaUUGTqKiadP77lMYLvkIH/txKmn+IsPVLrRKP2u6yTRZ73zmIzYcJqRwO+ekKC7N3OUm1g9IsilBlLQzem2PFeKBmsfs+VciKVFfmKbKwiwb7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cxLQZ6JJVzKHMNp
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 16:44:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C0EA31A1A7A
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 16:45:36 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgD3TUYv1AFpsjb9Bw--.46366S3;
	Wed, 29 Oct 2025 16:45:36 +0800 (CST)
Message-ID: <cf167bfa-fb1e-40fa-81e6-071dab2442c0@huaweicloud.com>
Date: Wed, 29 Oct 2025 16:45:34 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb
To: Ye Bin <yebin@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca
References: <20251028064728.91827-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251028064728.91827-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3TUYv1AFpsjb9Bw--.46366S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1kCFyxJr4DZr13WF4rKrg_yoW5Ary3pr
	y5CFZ8Zryv9FyUAw18KF4rJayFqryvyFWUKrWq9as7Kay3Gw12v34UtFn8CFWqvrWYgayx
	GFyUG39rCw12v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Bin!

On 10/28/2025 2:47 PM, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Copying the file system while it is mounted as read-only results in
> a mount failure:
> [~]# mkfs.ext4 -F /dev/sdc
> [~]# mount /dev/sdc -o ro /mnt/test
> [~]# dd if=/dev/sdc of=/dev/sda bs=1M
> [~]# mount /dev/sda /mnt/test1
> [ 1094.849826] JBD2: journal checksum error
> [ 1094.850927] EXT4-fs (sda): Could not load journal inode
> mount: mount /dev/sda on /mnt/test1 failed: Bad message
> 

I suppose we need to explain why we have this particular use case.

> Above issue may happen as follows:
> ext4_fill_super
>  set_journal_csum_feature_set(sb)
>   if (ext4_has_metadata_csum(sb))
>    incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
>   if (test_opt(sb, JOURNAL_CHECKSUM)
>    jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
>     lock_buffer(journal->j_sb_buffer);
>     sb->s_feature_incompat  |= cpu_to_be32(incompat);
>     //The data in the journal sb was modified, but the checksum was not
>       updated, so the data remaining in memory has a mismatch between the
>       data and the checksum.
>     unlock_buffer(journal->j_sb_buffer);
> 
> In this case, the journal sb copied over is in a state where the checksum
> and data are inconsistent, so mounting fails.
> To solve the above issue, update the checksum in memory after modifying
> the journal sb.

What about checking sb_rdonly(sb) before setting the journal feature, and
skipping the setting if the filesystem is mounted as read-only?

Regards,
Yi.

> 
> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/jbd2/journal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..5b6e8c1a5e6a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2349,6 +2349,8 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_compat    |= cpu_to_be32(compat);
>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
>  	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  
> @@ -2378,9 +2380,13 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  
>  	sb = journal->j_superblock;
>  
> +	lock_buffer(journal->j_sb_buffer);
>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
> +	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  }
>  EXPORT_SYMBOL(jbd2_journal_clear_features);


