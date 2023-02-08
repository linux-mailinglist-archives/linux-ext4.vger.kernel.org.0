Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09ED68F7E0
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Feb 2023 20:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBHTR1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 14:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHTR0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 14:17:26 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E3D506;
        Wed,  8 Feb 2023 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1675883845; x=1707419845;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=gRVyRdCqxd+YZHnVk5LjI+EiGSkpfor/I1aRASpX1w4=;
  b=B3jPJ0bznXn45FVAxFWUiroHCvQscWgIkKfM07iw/faqCsC8W7/HBJc8
   svI//39vNcKpvXnu5moKcdLC3oY3wJ9wfE8gNSI/P4omYduNqnQl5D6D6
   OfoDRgWfHHX/EG8EZ3JuJLHsZBLz1LnwkKZF37UJq+nAOZa1o1NxMNSIr
   E=;
X-IronPort-AV: E=Sophos;i="5.97,281,1669075200"; 
   d="scan'208";a="179831383"
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 19:17:24 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id 35C2E60E75;
        Wed,  8 Feb 2023 19:17:24 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Wed, 8 Feb 2023 19:17:23 +0000
Received: from [192.168.29.35] (10.43.162.56) by EX19D002UWC004.ant.amazon.com
 (10.13.138.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24; Wed, 8 Feb 2023
 19:17:22 +0000
Message-ID: <1c134792-1763-8c92-6516-78a330d4756e@amazon.com>
Date:   Wed, 8 Feb 2023 11:17:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <abuehaze@amazon.com>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
 <20230126093231.ujn6yaxhexwzizp5@quack3>
 <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
 <20230127121721.lerrb36nhj7gdiwm@quack3>
 <6a0fcca5-b869-ffb7-426b-b49a6782c1c0@amazon.com>
 <20230208140247.rt62xdtriopfdb4o@quack3>
Content-Language: en-US
In-Reply-To: <20230208140247.rt62xdtriopfdb4o@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D41UWC002.ant.amazon.com (10.43.162.127) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2/8/23 6:02 AM, Jan Kara wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon 30-01-23 09:45:32, Bhatnagar, Rishabh wrote:
>> On 1/27/23 4:17 AM, Jan Kara wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu 26-01-23 10:23:07, Bhatnagar, Rishabh wrote:
>>>> On 1/26/23 1:32 AM, Jan Kara wrote:
>>>>> On Wed 25-01-23 16:33:54, Bhatnagar, Rishabh wrote:
>>>>>> Fio with buffered io/fsync=1/randwrite
>>>>> So I'm curious. Do you have any workload that actually does these
>>>>> synchronous random buffered IOs? Or is it just a benchmarking exercise?
>>>>>
>>>> So database team was a running benchmark called hammerdb with 16 connections
>>>> where they started noticing dropped
>>>> performance for 5.10. We traced it back to filesystem with this benchmark.
>>>> Although the database workload would be something similar
>>>>    I guess.
>>> HammerDB is a TPC-C and TPC-H benchmark but details of the IO depend more
>>> on the database it is hammering. Do you know which one? Anyway the most
>>> important fact for me is that it is visible in a real world workload (well,
>>> as much as DB benchmarking is real-world ;)).
>> I believe its the MySQL database though not so sure.
> Well, in that case I think your MySQL DB is somewhat misconfigured. At
> least as far as we have been consulting MySQL / MariaDB developers
> regarding benchmarking, they suggested we should configure the database to
> use direct IO and increase DB internal buffers instead of relying on
> buffered IO and pagecache behavior. And if your fio job is representative
> of the IO load the DB really creates, I'd agree that that would be a saner
> and likely more performant configuration ;)
>
>>>>>> + /*
>>>>>> + * We come here when we got at @end. We take care to not overflow the
>>>>>> + * index @index as it confuses some of the callers. This breaks the
>>>>>> + * iteration when there is page at index -1 but that is already broken
>>>>>> + * anyway.
>>>>>> + */
>>>>>> + if (end == (pgoff_t)-1)
>>>>>> + *index = (pgoff_t)-1;
>>>>>> + else
>>>>>> + *index = end + 1;
>>>>>> +out:
>>>>>> rcu_read_unlock();
>>>>>>
>>>>>> - if (ret)
>>>>>> - *index = pages[ret - 1]->index + 1;
>>>>>> -
>>>>>>
>>>>>>    From the description of the patch i didn't see any mention of this
>>>>>> functional change.
>>>>>> Was this change intentional and did help some usecase or general performance
>>>>>> improvement?
>>>>> So the change was intentional. When I was working on the series, I was
>>>>> somewhat concerned that the old code could end up in a pathological
>>>>> situation like:
>>>>>      We scan range 0-1000000, find the only dirty page at index 0, return it.
>>>>>      We scan range 1-1000000, find the only dirty page at index 1, return it.
>>>>>      ...
>>>>>
>>>>> This way we end up with rather inefficient scanning and in theory malicious
>>>>> user could livelock writeback like this. That being said this was/is mostly
>>>>> a theoretical concern.
>>>> Ok so its more of a security concern. But do you think this has a latency
>>>> impact? I didn't see
>>>> much latency impact between the two sets and throughput is higher.
>>> Yes, I expect there will be latency impact but for this workload probably
>>> relatively small. I expect the expensive part on your workload is the
>>> fsync(2) call, in particular the committing of the transaction and the
>>> flushing of the disk caches as a result of that. Data writes themselves are
>>> relatively cheap. If you had say 1MB blocks instead of 16k ones, I'd expect
>>> the numbers to start looking differently as the cost of IO and of cache
>>> flushing becomes for comparable - obviously it all depends on the details
>>> of the backing storage as well. Perhaps could you measure how much time we
>>> spend in file_write_and_wait_range() calls vs in the whole ext4_sync_file()
>>> call to confirm that?
>>>
>>> Overall your tests show we could gain some throughput without sacrificing
>>> too much latency if we somehow batch tiny fsync requests more. The trick is
>>> how to do this without regressing other workloads and also across various
>>> storage types which are going to have very different properties.
>> Yeah i agree fsync is much more expensive operation than just dirtying
>> buffers in page cache.  I did use the ext4dist tool from bcc to get the
>> distribution of write vs fsync.  Overall fsync is much more expensive
>> operation so yeah if we can get higher throughput here with batching it
>> shouldn't impact fsync latency that much.
> Well, I was more interested in file_write_and_wait_range() vs
> ext4_sync_file() latency comparison. write(2) calls are indeed very fast
> because they just copy into the page cache so that is not very interesting.
> But file_write_and_wait_range() is more interesting because that measures
> the cost of writing file data to the disk while whole ext4_sync_file()
> measures the cost of writing file data to the disk + the cost of flushing
> the journal and I'm interested in how much is the flushing of the journal
> costly compared to the data writeback.

Sorry i misunderstood your comment. Here is the revised data. Flushing 
journal
very heavy compared to flushing data.

ext4_sync_file:       ~18.6 msecs
fdatawrite_range:   ~ 4usecs
fdatawait_range:     ~ 83.6usecs
fc_commit:             ~18.6 msecs

Tracing 1 functions for "ext4_sync_file"


      nsecs               : count     distribution
    1048576 -> 2097151    : 75 |                                        |
    2097152 -> 4194303    : 1496 |****                                    |
    4194304 -> 8388607    : 3461 |**********                              |
    8388608 -> 16777215   : 6693 |********************                    |
   16777216 -> 33554431   : 13355 |****************************************|
   33554432 -> 67108863   : 1631 |****                                    |

avg = 18624922 nsecs, total: 505778389231 nsecs, count: 27156


Tracing 1 functions for "__filemap_fdatawrite_range"

      nsecs               : count     distribution
        512 -> 1023       : 0 |                                        |
       1024 -> 2047       : 1 |**                                      |
       2048 -> 4095       : 14 |****************************************|
       4096 -> 8191       : 5 |**************                          |
       8192 -> 16383      : 1 |**                                      |

avg = 3943 nsecs, total: 82809 nsecs, count: 21

Tracing 1 functions for "__filemap_fdatawait_range

      nsecs               : count     distribution
        128 -> 255        : 0 |                                        |
        256 -> 511        : 1 |********************                    |
        512 -> 1023       : 2 |****************************************|
       1024 -> 2047       : 2 |****************************************|
       2048 -> 4095       : 0 |                                        |
       4096 -> 8191       : 0 |                                        |
       8192 -> 16383      : 0 |                                        |
      16384 -> 32767      : 0 |                                        |
      32768 -> 65535      : 0 |                                        |
      65536 -> 131071     : 0 |                                        |
     131072 -> 262143     : 0 |                                        |
     262144 -> 524287     : 1 |********************                    |

avg = 83644 nsecs, total: 501866 nsecs, count: 6

Tracing 1 functions for "ext4_fc_commit

      nsecs               : count     distribution
    1048576 -> 2097151    : 70 |                                        |
    2097152 -> 4194303    : 1512 |****                                    |
    4194304 -> 8388607    : 3436 |**********                              |
    8388608 -> 16777215   : 6699 |********************                    |
   16777216 -> 33554431   : 13349 |****************************************|
   33554432 -> 67108863   : 1641 |****                                    |

avg = 18622010 nsecs, total: 505699318966 nsecs, count: 27156

Thanks
Rishabh

>
>                                                                  Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
