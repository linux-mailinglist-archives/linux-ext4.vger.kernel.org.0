Return-Path: <linux-ext4+bounces-1722-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9D881CD1
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 08:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F5B1C20E3F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 07:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D354FA1;
	Thu, 21 Mar 2024 07:16:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83E4D9E7;
	Thu, 21 Mar 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005382; cv=none; b=qqN+o1wFtqvGLsiqLk34vRvGPQcJ5FBM6aaSb7MDJ4OsvHctiKHKeMs14bofXSI1ZcnEzqSjPGSRsypsCEpxDxgnKRIxaTRGxpSE9JvsK6pd/C88gV82lheGHR/gpVPPDgckTmCHyEYhDCQnFo1PnsZQqF+Ppf5NgBXA5W60hRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005382; c=relaxed/simple;
	bh=daXV8oIKyjxwzug3KO844ksjd487mVSX4uDRO7d9I08=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YcXpDns6y0hCnpREv/te0sCIX/TTXy3+cuqoD1S0CbghczvveSxvTVqOLIk0b75daDtCFi9cMbs2ArEmTCTJF5pZvqOugI56iUDHxdpoSn8JknEit2seaBpW6uABqD/CBA4iEHaKDATzsH30+ojZ2dfJV60vihZrU7Y6HEaon68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0cFP4JB1z4f3mHb;
	Thu, 21 Mar 2024 15:16:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8A8A61A019F;
	Thu, 21 Mar 2024 15:16:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgBHYgvB3vtlZG91Hg--.64482S2;
	Thu, 21 Mar 2024 15:16:17 +0800 (CST)
Subject: Re: [PATCH v2 2/5] ext4: Add unit test of ext4_mb_generate_buddy
To: Guenter Roeck <linux@roeck-us.net>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
 <20240103104900.464789-3-shikemeng@huaweicloud.com>
 <30a8ce01-84d1-48ef-a93d-d14cc61723e3@roeck-us.net>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <6e062fdd-c2b8-d28f-2b0c-a130855d65ce@huaweicloud.com>
Date: Thu, 21 Mar 2024 15:16:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <30a8ce01-84d1-48ef-a93d-d14cc61723e3@roeck-us.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHYgvB3vtlZG91Hg--.64482S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18GFWfXw43Aw4UWFWxZwb_yoW8Kryrpr
	98Cr97Kr1DJry7JF18Aw1UXryIyw4UJa15JryrJr1UJrnxWw1UJr17XryUCr1DKr1UZr12
	yF1Uury7uw1DtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/21/2024 12:23 AM, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jan 03, 2024 at 06:48:57PM +0800, Kemeng Shi wrote:
>> Add unit test of ext4_mb_generate_buddy
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> With this and other new ext4 tests test in the tree, I see a variety
> of backtraces in the upstream kernel if debug options are enabled.
> An example is
> 
> [    6.821447]         KTAP version 1
> [    6.821769]         # Subtest: test_mb_generate_buddy
> [    6.824787] =============================================================================
> [    6.825568] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
> ...
> [    6.894341] ok 7 ext4_inode_test
> [    6.895411] =============================================================================
> [    6.895777] BUG inode_cache (Tainted: G    B            N): Padding overwritten. 0xfffff80006223f68-0xfffff80006223f6f @offset=16232
> 
> Another example, from another test run, is
> 
> [    3.938551]         # Subtest: test_new_blocks_simple
> [    3.947171]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    3.952988]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    3.958403]         ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    3.958890] =============================================================================
> [    3.959159] BUG inode_cache (Tainted: G                 N): Padding overwritten. 0xffff8de881adbf68-0xffff8de881adbf6f @offset=16232
> 
> Another one:
> 
> [   18.730473]         # Subtest: test_new_blocks_simple
> [   18.760547]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [   18.778477] ==================================================================
> [   18.778950] BUG: KFENCE: out-of-bounds write in ext4_mb_init+0x5d7/0xa60
> 
> This is just a sample, taken from a quick look at test results.
> 
> Are those backtraces expected ? If so, would it be possible to execute the
> tests without generating such backtraces ? The backtraces, if intentional,
> hide real problems in the noise.
Thanks for the report. The backtrace is not expected, I will look into this. Thansk!
> 
> Thanks,
> Guenter
> 


