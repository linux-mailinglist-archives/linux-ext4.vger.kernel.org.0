Return-Path: <linux-ext4+bounces-10500-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD47BAC3A6
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033344E2263
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED72F60C9;
	Tue, 30 Sep 2025 09:15:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41F2F60A4;
	Tue, 30 Sep 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223751; cv=none; b=ezlo40sXYThX2THcWAgjsK8bYfzRL3P/bkn7L21fHgMTa+BosVIoOK1wafjR8KNrMVKAKhBs/ixurWYP5gCD1ntydN9IPVEfq2BUNMBVA8k3lW6VXNYBMeUwC96TOm8g4lBg0UJrNEvky6HbFBcyezJFrEW7TLxbipe3IR4z4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223751; c=relaxed/simple;
	bh=I5NH2LMuwVM1YzMzzV27Eim0/974hIWEq3VwkdWzNvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0aWqVKbJbosuKcFN2VlxwQXwitjsKp6vLzqqfmRuvTzWWDD0IdfR+bqnOeJtNO88agb5yL1kjL/c7W467nXtu4MB7K1On27MF1fSJAGLtUT0vUtS/jija/ypLbLqRefZclWxzjcnlk4JnwlsBSnd0fBKURC8+cnh/Tzk2GfnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=fail smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbXTW6QZmzYQtpS;
	Tue, 30 Sep 2025 17:15:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 449E81A0DF1;
	Tue, 30 Sep 2025 17:15:45 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGS_n9toi7xBBQ--.46251S3;
	Tue, 30 Sep 2025 17:15:45 +0800 (CST)
Message-ID: <1d3f056c-f32d-4f47-a325-42ac88b0c981@huaweicloud.com>
Date: Tue, 30 Sep 2025 17:15:43 +0800
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
 linux-kernel@vger.kernel.org
References: <20250930090237.306607-1-kartikey406@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250930090237.306607-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHjGS_n9toi7xBBQ--.46251S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4kGFW8KrW7KrWUAFyftFb_yoW8JFWrpr
	W7G34Utw4kArykGayxtw47Xr1Y9w1fCw45ZFW5WrnrAF15Gw1rtFy5tF13AFy3CrZY9Fy2
	qF4jvas3uw13tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 9/30/2025 5:02 PM, Deepanshu Kartikey wrote:
> Zhang Yi,
> 
> Thank you for the review. Regarding the placement after ext4_set_inode_flags() - 
> this would be too early. My debug shows that i_inline_off changes during inode 
> initialization:
> 
>     After ext4_set_inode_flags(): flag=1, i_inline_off=0, has_inline=0
>     Before my patch validation check: flag=1, i_inline_off=164, has_inline=1
> 
> At the earlier point, ext4_has_inline_data() returns false, so we wouldn't catch 
> the corruption. The check needs to be after all inode fields are initialized.
> 

The return value of ext4_has_inline_data() changed since ext4_iget_extra_inode()
initialize the i_inline_off parameter from the ondisk inline xattr. However, in
your v2 patch, you checked the EXT4_INODE_INLINE_DATA flags directly instead of
the return value of ext4_has_inline_data(). The flags will not change, so it's
safe to move this check eralier, and it is more reasonable to directly check the
flags after getting flags from the disk and before checking inline xattr.

Thanks,
Yi.

> I'll fix the alignment and use function/line variables as you suggested, but keep 
> the check after "ret = 0;" where all inode fields are populated.
> 
> I'll send v3 with these fixes shortly.
> 
> Best regards,
> Deepanshu
> 


