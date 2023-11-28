Return-Path: <linux-ext4+bounces-211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5B7FB06B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Nov 2023 04:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914EC281C80
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Nov 2023 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A0C747A;
	Tue, 28 Nov 2023 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A7C9
	for <linux-ext4@vger.kernel.org>; Mon, 27 Nov 2023 19:32:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SfSgm332pz4f3kkQ
	for <linux-ext4@vger.kernel.org>; Tue, 28 Nov 2023 11:32:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 457461A01DA
	for <linux-ext4@vger.kernel.org>; Tue, 28 Nov 2023 11:32:23 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xFFX2VlxkePCA--.6972S3;
	Tue, 28 Nov 2023 11:32:23 +0800 (CST)
Subject: Re: [PATCH 2/2] jbd2: increase the journal IO's priority
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20231125121740.1035816-1-yi.zhang@huaweicloud.com>
 <20231125121740.1035816-2-yi.zhang@huaweicloud.com>
 <20231127161149.2s7yizu72gw332s2@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <44d18772-192c-46ad-2622-646b609752d6@huaweicloud.com>
Date: Tue, 28 Nov 2023 11:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127161149.2s7yizu72gw332s2@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDn6xFFX2VlxkePCA--.6972S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43Zr1Dtw1fKF15tF4UCFg_yoW8uw1xpF
	W0ya4kJFykKF9rA3Z7tws5XFWfta1kCr47GFy7Ga1jkFZ0gryxt3yvkr4ayFyjkFySkay0
	qFWY93s7Cr4YvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hello!

On 2023/11/28 0:11, Jan Kara wrote:
> Hello!
> 
> On Sat 25-11-23 20:17:39, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Current jbd2 only add REQ_SYNC for descriptor block, metadata log
>> buffer, commit buffer and superblock buffer, the submitted IO could be
>> throttled by writeback throttle in block layer, that could lead to
>> priority inversion in some cases. The log IO looks like a kind of high
>> priority metadata IO, so it should not be throttled by WBT like QOS
>> policies in block layer, let's add REQ_SYNC | REQ_IDLE to exempt from
>> writeback throttle, and also add REQ_META together indicates it's a
>> metadata IO.
> 
> So I agree about REQ_META but with REQ_IDLE I'm not so sure. __REQ_IDLE is
> documented as "anticipate more IO after this one" so that is a good fit for
> normal transaction writes but not so much for journal superblock writes.
> OTOH as far as I'm checking XFS uses REQ_IDLE as well for its log IO and
> the only places where REQ_IDLE is really checked is in blk-wbt... So I
> guess this makes sense.
> 

Thanks a lot for your review. Yeah, We've checked the block cgroup related
qos policies and blk-wbt, block cgroup based policies does not throttle IO
with REQ_META, and blk-wbt exempt IO with both REQ_IDLE and REQ_SYNC. But
submit_bh() can make sure the journal IO is always bind to the root cgroup,
so only blk-wbt is left for us to deal with, so I add REQ_IDLE like xfs does.

>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 52772c826c86..f7e8274b46ae 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1374,6 +1374,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
>>  JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
>>  JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>>  
>> +/* Journal high priority write IO operation flags */
>> +#define JBD2_REQ_HIPRIO		(REQ_META | REQ_SYNC | REQ_IDLE)
> 
> Since all journal IO is submitted with these flags I'd maybe name this
> JBD2_JOURNAL_REQ_FLAGS? Otherwise the patch looks good to me so feel free
> to add:
> 

Sure, JBD2_JOURNAL_REQ_FLAGS looks fine, I will use it in v2.

Thanks,
Yi.


