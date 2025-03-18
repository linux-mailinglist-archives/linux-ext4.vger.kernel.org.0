Return-Path: <linux-ext4+bounces-6845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C7A6651E
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 02:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D323B5D80
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9A85626;
	Tue, 18 Mar 2025 01:31:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A824A1E;
	Tue, 18 Mar 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261463; cv=none; b=tSDaLjdPHZAvpvSVjvGT2P4UVX+3RikFj0U/2OXf2i/cpLny7fZu/citF8d5XMdwXtPbijY5BIxCmK80lUu/UZjOhPzOuxGIPAWnQa/fo0B7oyZVMclT8y9P+qnUirZDNLJfj/DnM/ivsIKvQjWfCWOWW+a9hBQN23tc1BheGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261463; c=relaxed/simple;
	bh=GqOqPhNmpDOOBJ70eh1A+FKAbrzAzBJOSmr6fthvsnE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BOUg/xDHZmH1Smjabv0we6PI9UoSJS7gPmJAiLzgdPoYr6BpcLdiU64d2BHpw7YKWcCiI7psN4RWz/Oc55xbk5yrtd6g+g2tYsZfEKLIhG1ddBqTn7S9xRQokFqdmPZcTsGRerHbWlbZyuWt0Ldkzq4q9BrhmPq7hk1r0zJs3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZGvRf5ktDz4f3jkr;
	Tue, 18 Mar 2025 09:30:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 078F91A01A6;
	Tue, 18 Mar 2025 09:30:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgAnMGPPzNhnGXEYGw--.15476S2;
	Tue, 18 Mar 2025 09:30:55 +0800 (CST)
Subject: Re: [PATCH RESEND] ext4: Fix potential NULL pointer dereferences in
 test_mb_mark_used() and test_mb_free_blocks()
To: Qasim Ijaz <qasdev00@gmail.com>, adilger.kernel@dilger.ca, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250313000021.18170-1-qasdev00@gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <cb138f5d-2470-bfcc-9939-fcaec24de100@huaweicloud.com>
Date: Tue, 18 Mar 2025 09:30:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250313000021.18170-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnMGPPzNhnGXEYGw--.15476S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWkJw4DAr4kJr4DCFyUJrb_yoW8AFy5pw
	s5KF1jkr15Wr18uw47uw48Wa4xK3yFkr45WrWfWw1jvF9xJFyfC3ZIvw1UWF18AFWxXa15
	Z3WaqrWDWr4IkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwz
	uWDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/13/2025 8:00 AM, Qasim Ijaz wrote:
> test_mb_mark_used() and test_mb_free_blocks() call kunit_kzalloc() to 
> allocate memory, however both fail to ensure that the allocations 
> succeeded. If kunit_kzalloc() returns NULL, then dereferencing the 
> corresponding pointer without checking for NULL will lead to 
> a NULL pointer dereference.
> 
> To fix this call KUNIT_ASSERT_NOT_ERR_OR_NULL() to ensure 
> the allocation succeeded.
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Fixes: ac96b56a2fbd ("ext4: Add unit test for mb_mark_used")
> Fixes: b7098e1fa7bc ("ext4: Add unit test for mb_free_blocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
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


