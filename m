Return-Path: <linux-ext4+bounces-12229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65DCAD436
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 14:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3295F30567B9
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03290314D10;
	Mon,  8 Dec 2025 13:25:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD982EA169
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200326; cv=none; b=cB0e3XbUZ2KTeWmbo8McsDM/t6f9ZwZyRuSvCHslVoLU+fYxVVZj9yMBEwnMtci/nS4POLR7o0yEAV+L7OUnLf8MbFJiai2049I2cRG5lthygc9B8Q3T3G1Mutc3NLDAeXF0CvYG3kPhTbcVekdAokQuzFNzHIQZLUsVDc5xln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200326; c=relaxed/simple;
	bh=HEIbkl02HvccuRP51k8D6P60RosiMSDDMhD+mFgmAas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjqPj8icm4H1a4EGE26DnV/rvQ4TcOZTt3b79KnlWY+QdUwZziHrmh9efRfv9tPoFuXWlgfDR1coEcsCwVOIy+/7tjFXRL8fadgrpzrKa8FgE8VL3/JcwvK5U3useK84C3M7v6+iqms8W/FJnP2x/VQOWmH6LaRsYzoyjYhQ2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQ2N415yjzKHMfH
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 21:08:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 30D2D1A01A2
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 21:09:01 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnSFLpzTZpcywiBA--.39368S3;
	Mon, 08 Dec 2025 21:08:59 +0800 (CST)
Message-ID: <94b1a0d8-f025-4a9b-8229-da8dfbe2b531@huaweicloud.com>
Date: Mon, 8 Dec 2025 21:08:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add missing down_write_data_sem in
 mext_move_extent().
To: Julian Sun <sunjunchao@bytedance.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, jack@suse.cz
References: <20251208123713.1971068-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251208123713.1971068-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnSFLpzTZpcywiBA--.39368S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fKw43ZF4DXFWDGFy7Awb_yoW8WF17p3
	4xuF1DG340qwn29397Kw17ZF12g3yUKr47Wryagw18ZayqyryFgry5ta15tFyvvrWkXrWr
	XF4Ikryjqay3C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/8/2025 8:37 PM, Julian Sun wrote:
> Commit 962e8a01eab9 ("ext4: introduce mext_move_extent()") attempts to
> call ext4_swap_extents() on the failure path to recover the swapped
> extents, but fails to acquire locks for the two inode->i_data_sem,
> triggering the BUG_ON statement in ext4_swap_extents().
> 
> This issue can be fixed by calling ext4_double_down_write_data_sem()
> before ext4_swap_extents().
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Reported-by: syzbot+4ea6bd8737669b423aae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69368649.a70a0220.38f243.0093.GAE@google.com/
> Fixes: 962e8a01eab9 ("ext4: introduce mext_move_extent()")

Makes sense to me. Thanks for the fix.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/move_extent.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 0550fd30fd10..635fb8a52e0c 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -393,9 +393,11 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  
>  repair_branches:
>  	ret2 = 0;
> +	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>  	r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
>  				  mext->donor_lblk, orig_map->m_lblk,
>  				  *m_len, 0, &ret2);
> +	ext4_double_up_write_data_sem(orig_inode, donor_inode);
>  	if (ret2 || r_len != *m_len) {
>  		ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
>  				       EIO, "Unable to copy data block, data will be lost!");


