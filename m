Return-Path: <linux-ext4+bounces-8738-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18868AEF36C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692CE4A2313
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4972238C0A;
	Tue,  1 Jul 2025 09:31:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FB269CF1
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362289; cv=none; b=sQ27Ch1j2JxACi2RK3+AAhw1L0aNfFOzxkMA3/4KTI64EB8El5AgYukzK+gmX690fGwUHwwLceOqI+4/eX4bos1GCOTKzEC698ES1sLEvA5bIVd0Y3epOx5RVBmn4C+L3VKc9OJQmDC+eyCjb7mU5GLFrkVLeGxJBGRqPvWVTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362289; c=relaxed/simple;
	bh=Gr71s4FgoPW4a0MLN8sZ2TnIkcNhu7PlOQpvjIiWuW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/NJE5UH4nQvx1QXuk1aHkAkBaLSQWufhH1jznbAavdT8SuOJnJJxSjBFaqNAXIHhslM7azAje1L2QhA5Ii6TY8MQxw4OOYm8DhY6lTfqmGOfZrpqOT5fofS243OgkV0PGviEJVLhWFq/aSh4lwHK7Wk44m4yOWz9dfzRlNzVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bWd8z69R0z27hSf;
	Tue,  1 Jul 2025 17:32:19 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 94AED14022D;
	Tue,  1 Jul 2025 17:31:23 +0800 (CST)
Received: from [10.174.187.231] (10.174.187.231) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:31:22 +0800
Message-ID: <18ea3a96-d205-0933-bb2f-5b792ef6884c@huawei.com>
Date: Tue, 1 Jul 2025 17:31:22 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] debugfs/logdump.c: Add parameter t to dump sequence
 commit timestamps
To: "Darrick J. Wong" <djwong@kernel.org>
CC: Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
	<qiangxiaojun@huawei.com>, <hejie3@huawei.com>
References: <50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com>
 <20250630151057.GA9987@frogsfrogsfrogs>
From: zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20250630151057.GA9987@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100017.china.huawei.com (7.202.195.215)

On 2025/6/30 23:10, Darrick J. Wong wrote:
> On Tue, Jun 17, 2025 at 07:31:35PM +0800, zhanchengbin wrote:
>> When filesystem errors occur, inspect journal sequences with parameter t to
>>   dump commit timestamps.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin@huawei.com>
>> ---
>>   debugfs/logdump.c | 63 ++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 54 insertions(+), 9 deletions(-)
>>
>> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
>> index 324ed42..bbe1384 100644
>> --- a/debugfs/logdump.c
>> +++ b/debugfs/logdump.c
>> @@ -47,7 +47,7 @@ enum journal_location {JOURNAL_IS_INTERNAL,
>> JOURNAL_IS_EXTERNAL};
>>
>>   #define ANY_BLOCK ((blk64_t) -1)
>>
>> -static int        dump_all, dump_super, dump_old, dump_contents,
>> dump_descriptors;
>> +static int        dump_all, dump_super, dump_old, dump_contents,
>> dump_descriptors, dump_time;
>>   static int64_t        dump_counts;
>>   static blk64_t        block_to_dump, bitmap_to_dump, inode_block_to_dump;
>>   static unsigned int    group_to_dump, inode_offset_to_dump;
>> @@ -67,6 +67,8 @@ static void dump_descriptor_block(FILE *, struct
>> journal_source *,
>>                     char *, journal_superblock_t *,
>>                     unsigned int *, unsigned int, __u32, tid_t);
>>
>> +static void dump_commit_time(FILE *out_file, char *buf);
>> +
>>   static void dump_revoke_block(FILE *, char *, journal_superblock_t *,
>>                     unsigned int, unsigned int, tid_t);
>>
>> @@ -118,10 +120,11 @@ void do_logdump(int argc, ss_argv_t argv, int sci_idx
>> EXT2FS_ATTR((unused)),
>>       inode_block_to_dump = ANY_BLOCK;
>>       inode_to_dump = -1;
>>       dump_counts = -1;
>> +    dump_time = 0;
> 
> Globals are initialized to zero if not given an explicit value so this
> isn't necessary.

When I run 'logdump -t', it displays the time，but when I run 'logdump'
without parameters for the second time, it still shows the time. Globals
retain their assigned values, which affects subsequent execution
results. So I think initializing the globals here is necessary.

Thanks,
  - bin.

> 
> .
> 

