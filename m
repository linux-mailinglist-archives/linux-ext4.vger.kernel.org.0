Return-Path: <linux-ext4+bounces-592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2319D821B86
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB05C1F210A8
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EBCF9D2;
	Tue,  2 Jan 2024 12:17:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F239F9C3
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4BgR3HVzz4f3jqL
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 20:17:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 316CD1A04BA
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 20:17:25 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgCXOUjE_pNlO3rLFQ--.53261S2;
	Tue, 02 Jan 2024 20:17:23 +0800 (CST)
Subject: Re: [PATCH] ext4: return 0 when ext4_get_group_info failed in
 __mb_check_buddy
To: yangerkun <yangerkun@huawei.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz
Cc: linux-ext4@vger.kernel.org
References: <20240102112012.672260-1-yangerkun@huawei.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <48ec32eb-145d-d6fd-e2d3-bd4a4087627b@huaweicloud.com>
Date: Tue, 2 Jan 2024 20:17:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240102112012.672260-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCXOUjE_pNlO3rLFQ--.53261S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1fuw48AFyDKr1rGFWDXFb_yoWDAwc_Ka
	s7Ar1rJr93JrnakFn5Kr1Fvr45tF4fWr4rXFWrJr4fXFWUXa93CaykAr93AF47u392kFW2
	kFy5Ary7GF1SvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 1/2/2024 7:20 PM, yangerkun wrote:
> The return value for __mb_check_buddy should be a integer. Found this by
> code review.
> 
Hi yangerkun,
I think the return value of __mb_check_buddy is actually not used and can
be removed. See [1] for details :). Thanks!

[1] https://lore.kernel.org/lkml/20231125161143.3945726-2-shikemeng@huaweicloud.com/

> Fixes: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..55c70a1b445a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -758,7 +758,7 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  
>  	grp = ext4_get_group_info(sb, e4b->bd_group);
>  	if (!grp)
> -		return NULL;
> +		return 0;
>  	list_for_each(cur, &grp->bb_prealloc_list) {
>  		ext4_group_t groupnr;
>  		struct ext4_prealloc_space *pa;
> 


