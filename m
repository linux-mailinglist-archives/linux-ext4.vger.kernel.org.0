Return-Path: <linux-ext4+bounces-661-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DE822E3C
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 14:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10141F243E2
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50796199B6;
	Wed,  3 Jan 2024 13:28:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C35199B2;
	Wed,  3 Jan 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T4rBt4xr0zZgRh;
	Wed,  3 Jan 2024 21:28:22 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 406BA1404F8;
	Wed,  3 Jan 2024 21:28:36 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 21:28:35 +0800
Subject: Re: [linus:master] [jbd2] 6a3afb6ac6: fileio.latency_95th_ms 92.5%
 regression
To: Jan Kara <jack@suse.cz>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <yukuai3@huawei.com>
References: <202401021525.a27b9444-oliver.sang@intel.com>
 <dcc72d34-89e1-6181-3556-a1a981256cc6@huawei.com>
 <20240103094907.iupboelwjxi243h3@quack3>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <5fb892c2-a532-84bf-fbe2-148b32079fa4@huawei.com>
Date: Wed, 3 Jan 2024 21:28:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240103094907.iupboelwjxi243h3@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/3 17:49, Jan Kara wrote:
> Hello!
> 
> On Wed 03-01-24 11:31:39, Zhang Yi wrote:
>> On 2024/1/2 15:31, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a 92.5% regression of fileio.latency_95th_ms on:
>>
>> This seems a little weird, the tests doesn't use blk-cgroup, and the patch
>> increase IO priority in WBT, so there shouldn't be any negative influence in
>> theory.
> 
> I don't have a great explanation either but there could be some impact e.g.
> due to a different request merging of IO done by JBD2 vs the flush worker or
> something like that. Note that the throughput reduction is only 5.7% so it
> is not huge.

Yeah, make sense, this should be one explanation that can be thought of at
the moment.

> 
>> I've tested sysbench on my machine with Intel Xeon Gold 6240 CPU,
>> 400GB memory with HDD disk, and couldn't reproduce this regression.
>>
>> ==
>> Without 6a3afb6ac6 ("jbd2: increase the journal IO's priority")
>> ==
>>
>>  $ sysbench fileio --events=0 --threads=128 --time=600 --file-test-mode=seqwr --file-total-size=68719476736 --file-io-mode=sync --file-num=1024 run
>>
>>   sysbench 1.1.0-df89d34 (using bundled LuaJIT 2.1.0-beta3)
>>
>>   Running the test with following options:
>>   Number of threads: 128
>>   Initializing random number generator from current time
>>
>>
>>   Extra file open flags: (none)
>>   1024 files, 64MiB each
>>   64GiB total file size
>>   Block size 16KiB
>>   Periodic FSYNC enabled, calling fsync() each 100 requests.
>>   Calling fsync() at the end of test, Enabled.
>>   Using synchronous I/O mode
>>   Doing sequential write (creation) test
>>   Initializing worker threads...
>>
>>   Threads started!
>>
>>
>>   Throughput:
>>            read:  IOPS=0.00 0.00 MiB/s (0.00 MB/s)
>>            write: IOPS=31961.19 499.39 MiB/s (523.65 MB/s)
>>            fsync: IOPS=327500.24
> 
> Well, your setup seems to be very different from what LKP was using. You
> are achieving ~500 MB/s (likely because all the files fit into the cache
> and more or less even within the dirty limit of the page cache) while LKP
> run achieves only ~54 MB/s (i.e., we are pretty much bound by the rather
> slow disk). I'd try running with something like 32GB of RAM to really see
> the disk speed impact...
> 

I'm afraid I missed the vmstat.io.bo changes, I will limit the dirty ratio
and test it again tomorrow.

Thanks,
Yi.

