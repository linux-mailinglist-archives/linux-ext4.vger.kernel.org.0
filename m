Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6593C3A224E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jun 2021 04:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFJCkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Jun 2021 22:40:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5364 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJCku (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Jun 2021 22:40:50 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0p3T4NGpz6vm7;
        Thu, 10 Jun 2021 10:35:01 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 10:38:53 +0800
Subject: Re: [RFC PATCH v3 5/8] jbd2,ext4: add a shrinker to release
 checkpointed buffers
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yukuai3@huawei.com>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-6-yi.zhang@huawei.com>
 <20210609030039.GB2419729@dread.disaster.area>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <6df860b8-0e65-72d3-1276-d7f585258a87@huawei.com>
Date:   Thu, 10 Jun 2021 10:38:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210609030039.GB2419729@dread.disaster.area>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Dave

On 2021/6/9 11:00, Dave Chinner wrote:
> On Thu, May 27, 2021 at 09:56:38PM +0800, Zhang Yi wrote:
>> +/**
>> + * jbd2_journal_shrink_scan()
>> + *
>> + * Scan the checkpointed buffer on the checkpoint list and release the
>> + * journal_head.
>> + */
>> +unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
>> +				       struct shrink_control *sc)
>> +{
>> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
>> +	unsigned long nr_to_scan = sc->nr_to_scan;
>> +	unsigned long nr_shrunk;
>> +	unsigned long count;
>> +
>> +	count = percpu_counter_sum_positive(&journal->j_jh_shrink_count);
>> +	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
>> +
>> +	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
>> +
>> +	count = percpu_counter_sum_positive(&journal->j_jh_shrink_count);
>> +	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
>> +
>> +	return nr_shrunk;
>> +}
>> +
>> +/**
>> + * jbd2_journal_shrink_scan()
>> + *
>> + * Count the number of checkpoint buffers on the checkpoint list.
>> + */
>> +unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
>> +					struct shrink_control *sc)
>> +{
>> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
>> +	unsigned long count;
>> +
>> +	count = percpu_counter_sum_positive(&journal->j_jh_shrink_count);
>> +	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
>> +
>> +	return count;
>> +}
> 
> NACK.
> 
> You should not be putting an expensive percpu counter sum in a
> shrinker object count routine. These gets called a *lot* under
> memory pressure, and summing over hundreds/thousands of CPUs on
> every direct reclaim instance over every mounted filesystem
> instance that uses jbd2 is really, really going to hurt system
> performance under memory pressure.
> 
> And, quite frankly, summing twice in the scan routine just to trace
> the result with no other purpose is unnecessary and excessive CPU
> overhead for a shrinker.
> 
> Just use percpu_counter_read() in all cases here - it is more than
> accurate enough for the purposes of both tracing and memory reclaim.

OK, I missed this point, thanks for the comments, I will use
percpu_counter_read_positive() in the next iteration.

Thanks,
Yi.
