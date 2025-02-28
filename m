Return-Path: <linux-ext4+bounces-6626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F0A4970B
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 11:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA841891614
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE712594AA;
	Fri, 28 Feb 2025 10:19:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE025BAD6
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737989; cv=none; b=miBMIFf39zoa/YKVR1gyHa9FtqES+bs+td2lhkOhWABt0cFT40RzBMjzakf2tkUjmabY5T7wXOwV8bl9Aen2DvyXhzABXk2CVee7jfGBInOJvFa5YWLjywLhYTzCzb/AePL9Vxu711VWkN+5PB3q69Zn7qLvp4KvLfQxunI1OjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737989; c=relaxed/simple;
	bh=Y2/CqOM0ENqNiA8M2/7384iZZAk22/M9N1nzz/+Kehs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDvfC5Q5nDiC6u/adB1tUrLo47mlCnMc84TMVjlODXZDdgOmMPqKB/ewi+b+5l4nQi4PV4iQjkM8+vPZJDQPY8AT3hAT2UB/1sPHz2Vryonz4t3Tt7j2CwERp7eAmOW5chGcHYOPtWKsxaA2zYvEWt4s6v1ICmSlxQGljxLEnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z441t3RPrz4f3lCm
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 18:19:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D24E71A06E0
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 18:19:37 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2C4jcFnicCKFA--.53236S3;
	Fri, 28 Feb 2025 18:19:37 +0800 (CST)
Message-ID: <5105eacf-fc32-4c14-98ae-6c1f67df10ba@huaweicloud.com>
Date: Fri, 28 Feb 2025 18:19:35 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: remove unnecessary checks for __GFP_NOFAIL
 allocation.
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-ext4@vger.kernel.org
References: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHK2C4jcFnicCKFA--.53236S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4DXry5Gw4rtw47Aw4fXwb_yoWfWFg_Wa
	y8JrnYqrZIqFs29a10kr13ArWqva18Kr1rua4xKrn3Z3WDurZ5uFWkurs3ArZxurZ2yFZ8
	ArWqyr1DKF9FqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
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
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/2/28 16:11, Julian Sun wrote:
> The __GFP_NOFAIL flag ensures that allocation will not fail.
> So remove the unnecessary checks.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Thanks for the cleanup, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/extents.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a07a98a4b97a..95debd5d6506 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2940,10 +2940,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  	} else {
>  		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
>  			       GFP_NOFS | __GFP_NOFAIL);
> -		if (path == NULL) {
> -			ext4_journal_stop(handle);
> -			return -ENOMEM;
> -		}
>  		path[0].p_maxdepth = path[0].p_depth = depth;
>  		path[0].p_hdr = ext_inode_hdr(inode);
>  		i = 0;


