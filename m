Return-Path: <linux-ext4+bounces-6743-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E96A58FCE
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ADD168027
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926CB224B08;
	Mon, 10 Mar 2025 09:36:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9371C5F34;
	Mon, 10 Mar 2025 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599363; cv=none; b=DLveUX/ymw2B20LBEu9FCItX9HprN8igWaY49cAtkbG5RjewVKrNtk3cpxZiq4BvlaQqW2wjQHWfnothWabCkWapvRNhxpHIfbChbAjalMub+f8nxVZSLkpEGRfjaw3ifhQbfM/+X7mUIZDbqy2ePvuX476yqlJ+Wp6B3NIQ3LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599363; c=relaxed/simple;
	bh=kNb2JQdgpmQuQ04YabLBxOjcWUhVsjdPLsrTQR3QvZk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fsrKJrSe6XsJYZaoeV23rcFBZR6tEgX3GqBoXZ51qrcpLz2xr2QN5iBdPrN9YdGnTY9zui6S8d+EsIRrodp2ORJACklx6MCFLIkDkYVB/29uHq4OcwLdd9XDOsBVD5Pq6yfaR2u/H+IvBERr0mij2GM7NuWZEHmHSkz7NPTUsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZBBZz2stNz4f3kkF;
	Mon, 10 Mar 2025 17:35:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5806E1A1176;
	Mon, 10 Mar 2025 17:35:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgAX1Wd6ss5nFPMwGA--.11533S2;
	Mon, 10 Mar 2025 17:35:56 +0800 (CST)
Subject: Re: [PATCH] ext4: Fix potential null dereference in ext4 test
To: Charles Han <hanchunchao@inspur.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250307115432.2112-1-hanchunchao@inspur.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <db5726b6-9320-8f53-7e26-31c1a755dc12@huaweicloud.com>
Date: Mon, 10 Mar 2025 17:35:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307115432.2112-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAX1Wd6ss5nFPMwGA--.11533S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43Zry5uFyDCr4UWw15Jwb_yoW8XF4Upw
	s5KF1jkr4rWr1j9w47ur48WFWIqws8Kan8WryfWw4YvF9xJFyfC3ZIyw1UGr1kAFWxWa15
	Za4aqF47Ga17WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/7/2025 7:54 PM, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add a NULL check for test_state
> 
> Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
> Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  fs/ext4/mballoc-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index bb2a223b207c..d634c12f1984 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -796,6 +796,7 @@ static void test_mb_mark_used(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
>  	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
>  				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
>  
>  	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -860,6 +861,7 @@ static void test_mb_free_blocks(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
>  	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
>  				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
>  
>  	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
> 
Good catch, looks good to me.

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>


