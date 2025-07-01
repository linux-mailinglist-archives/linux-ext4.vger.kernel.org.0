Return-Path: <linux-ext4+bounces-8722-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C9AEEC0D
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 03:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF68718910C2
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B087148832;
	Tue,  1 Jul 2025 01:23:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF08A47
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332985; cv=none; b=c1374xCO3q6v8nLZ8+VcQKQJ1KP0EdU3DHaUKZMoJ8rQ2GDhspw3i3/xtxEywZkvNU1tLezXYx9zCGdkH99gghQ2AhHe+07AEQ1tk5jYPK4fXZeMJPxA6CYBg7FHvCoEU109zB0KqpanqEGzORDF199/sxafwvWkL/yPPnmlPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332985; c=relaxed/simple;
	bh=POv1I8Rk5XDuIpnEERrWHknpnx5lZ+eoq1c3IL+bJJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L7lYVlR5UPq6S5T8/78/2cKRZVhLFPjsE8zXlmqzmQjh4zT19jlngD0SVTiypIsUR0IWs+wFubnm7CSPvjA9knMrgGX/ln6QB+6MZ3+Z/Z5xhfHDldFRfoeavMzAawnn7REDZ0o9eLclMI3MUQ4KHwFoZhKDuMxF3lkT8hzYAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bWQGJ0hfRz29dw3;
	Tue,  1 Jul 2025 09:21:12 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 55081140203;
	Tue,  1 Jul 2025 09:22:57 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 09:22:56 +0800
Message-ID: <09b41148-865e-4f47-8415-47dccafa971f@huawei.com>
Date: Tue, 1 Jul 2025 09:22:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix printing for sequence in descriptor/revoke
 block
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <tytso@mit.edu>, <linux-ext4@vger.kernel.org>
References: <20250627212451.3600741-1-zhangjian496@huawei.com>
 <20250630151700.GB9987@frogsfrogsfrogs>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <20250630151700.GB9987@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp200004.china.huawei.com (7.202.195.99)

yes, it should be sequence, thanks a lot.

On 2025/6/30 23:17, Darrick J. Wong wrote:
> On Sat, Jun 28, 2025 at 05:24:51AM +0800, zhangjian wrote:
>> When cursor cross the last journal block and will dump old journal blocks
>> sequence number will be lower than transaction number. Sequence number
>> should be read from descriptor block rather than accelerating transaction.
>>
>> For example:
>> A snippet from "logdump -aO"
>> ===============================================================
>> Found expected sequence 6, type 1 (descriptor block) at block 13
>> Dumping descriptor block, sequence 13, at block 13:
>>   FS block 276 logged at journal block 14 (flags 0x0)
>>   FS block 2 logged at journal block 15 (flags 0x2)
>>   FS block 295 logged at journal block 16 (flags 0x2)
>>   FS block 292 logged at journal block 17 (flags 0x2)
>>   FS block 7972 logged at journal block 18 (flags 0x2)
>>   FS block 1 logged at journal block 19 (flags 0x2)
>>   FS block 263 logged at journal block 20 (flags 0xa)
>> Found sequence 6 (not 13) at block 21: end of journal.
>> ===============================================================
>>
>> sequence number should be 6 from header->h_sequence, rather than 13 from
>> transaction accelerating from jsb->s_sequence
>>
>> Signed-off-by: zhangjian <zhangjian496@huawei.com>
>> Signed-off-by: zhanchengbin <zhanchengbin1@h-partners.com>
>> ---
>>  debugfs/logdump.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
>> index 324ed425..56f36291 100644
>> --- a/debugfs/logdump.c
>> +++ b/debugfs/logdump.c
>> @@ -532,7 +532,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>>  		case JBD2_DESCRIPTOR_BLOCK:
>>  			dump_descriptor_block(out_file, source, buf, jsb,
>>  					      &blocknr, blocksize, maxlen,
>> -					      transaction);
>> +					      sequence);
>>  			continue;
>>  
>>  		case JBD2_COMMIT_BLOCK:
>> @@ -545,7 +545,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>>  		case JBD2_REVOKE_BLOCK:
>>  			dump_revoke_block(out_file, buf, jsb,
>>  					  blocknr, blocksize,
>> -					  transaction);
>> +					  seqeunce);
> 
> If you're going to resend the patch in rapid succession, you could at
> least fix the typo build errors too...
> 
> $ pwd
> /home/djwong/e2fsprogs
> $ git grep seqeunce
> $
> 
> --D
> 
>>  			blocknr++;
>>  			WRAP(jsb, blocknr, maxlen);
>>  			continue;
>> -- 
>> 2.33.0
>>
>>
> 


