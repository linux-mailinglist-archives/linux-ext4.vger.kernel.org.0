Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03D067D400
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 19:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjAZSXO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Jan 2023 13:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZSXN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Jan 2023 13:23:13 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5325C0CE;
        Thu, 26 Jan 2023 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674757393; x=1706293393;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=69nB4IZF5k0rMlK9aFpcwhnc+3Ug2D0zCpawDrUwM1Y=;
  b=CnH56BbP0+arbrKci3hQjFBb2RhTDKpRjxAtl23W+hZ7wZOfLDcCMaYI
   YL0cLFTraFVEZzhcBJI4OLesoCrV1/qElb8SEEpvYR1APNuY1i5twMajJ
   zJNh01VKZJk2crkd1ZybSWPf5bjd0AIS+ydzmptQtIhiR9reflD/XGpU8
   Q=;
X-IronPort-AV: E=Sophos;i="5.97,249,1669075200"; 
   d="scan'208";a="290746327"
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 18:23:12 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id B72CFA0B5B;
        Thu, 26 Jan 2023 18:23:09 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 26 Jan 2023 18:23:09 +0000
Received: from [192.168.13.29] (10.43.160.120) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Thu, 26 Jan 2023 18:23:08 +0000
Message-ID: <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
Date:   Thu, 26 Jan 2023 10:23:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <abuehaze@amazon.com>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
 <20230126093231.ujn6yaxhexwzizp5@quack3>
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <20230126093231.ujn6yaxhexwzizp5@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D35UWB002.ant.amazon.com (10.43.161.154) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 1/26/23 1:32 AM, Jan Kara wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> Hello!
>
> On Wed 25-01-23 16:33:54, Bhatnagar, Rishabh wrote:
>> As discussed in the previous thread I'm chasing IOPS regression between 4.14
>> -> 5.10 kernels.
>> https://lore.kernel.org/lkml/20230112113820.hjwvieq3ucbwreql@quack3/T/
>> <https://lore.kernel.org/lkml/20230112113820.hjwvieq3ucbwreql@quack3/T/>
>>
>> Last issue we discussed was difficult to resolve so keeping it on the back
>> burner for now.
>>
>> I did some more bisecting and saw another series of patches that potentially
>> impacts iops score:
>> 72b045aecdd856b083521f2a963705b4c2e59680 (mm: implement
>> find_get_pages_range_tag())
>>
>> Running fio tests on tip as 9c19a9cb1642c074aa8bc7693cd4c038643960ae
>> (including the 16 patch series) vs tip as
>> 6b4c54e3787bc03e810062bd257a3b05fd9c72d6 (without the above series) shows an
>> IOPS jump.
> Ok, thanks for pinpointing this. That series landed a long time ago ;).
>
Yes its quite old patch series. I was tracking a regression for teams 
moving to a newer 5.10 (although that's also old) kernel from 4.14.
>> Fio with buffered io/fsync=1/randwrite
> So I'm curious. Do you have any workload that actually does these
> synchronous random buffered IOs? Or is it just a benchmarking exercise?
>
So database team was a running benchmark called hammerdb with 16 
connections where they started noticing dropped
performance for 5.10. We traced it back to filesystem with this 
benchmark. Although the database workload would be something similar
  I guess.

>> With HEAD as 9c19a9cb1642c074aa8bc7693cd4c038643960ae (with the above
>> series)
>>
>> write: io=445360KB, bw=7418.6KB/s, *iops=463*, runt= 60033msec
>> clat (usec): min=4, max=32132, avg=311.90, stdev=1812.74
>> lat (usec): min=5, max=32132, avg=312.28, stdev=1812.74
>> clat percentiles (usec):
>> | 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 25],
>> | 30.00th=[ 36], 40.00th=[ 47], 50.00th=[ 60], 60.00th=[ 71],
>> | 70.00th=[ 84], 80.00th=[ 97], 90.00th=[ 111], 95.00th=[ 118],
>> | 99.00th=[11840], 99.50th=[15936], 99.90th=[21888], 99.95th=[23936],
>>
>> With HEAD as 6b4c54e3787bc03e810062bd257a3b05fd9c72d6(without the above
>> series)
>>
>> write: io=455184KB, bw=7583.4KB/s, *iops=473*, runt= 60024msec
>> clat (usec): min=6, max=24325, avg=319.72, stdev=1694.52
>> lat (usec): min=6, max=24326, avg=319.99, stdev=1694.53
>> clat percentiles (usec):
>> | 1.00th=[ 9], 5.00th=[ 11], 10.00th=[ 17], 20.00th=[ 26],
>> | 30.00th=[ 38], 40.00th=[ 50], 50.00th=[ 60], 60.00th=[ 73],
>> | 70.00th=[ 85], 80.00th=[ 98], 90.00th=[ 111], 95.00th=[ 118],
>> | 99.00th=[ 9792], 99.50th=[14016], 99.90th=[21888], 99.95th=[22400],
>> | 99.99th=[24192]
> OK, about 2% regression. How stable is that across multiple runs?
This is quite consistent. The thing to note here is this test is on 
4.14+ tip with and without
these patch series.
I tried reverting to the same behavior in 5.10 with the following patch 
but i only see a very low improvement. (~1%)

This is because on 5.10 we also have this patch
ext4: avoid unnecessary transaction starts during writeback. (This 
limits the invocation of this function within the while loop)
If i revert the above patch as well along with applying below patch i 
get back around 4% IOPS.

-       if (end == (pgoff_t)-1)
-               *index = (pgoff_t)-1;
-       else
-               *index = end + 1;
+       if (xas.xa_index > end) {
+               if (end == (pgoff_t)-1)
+                       *index = (pgoff_t)-1;
+               else
+                       *index = end + 1;
+       }
+       else if (ret)
+               *index = xas.xa_index + 1;

>
>> I also see that number of handles per transaction were much higher before
>> this patch series
>>
>> 0ms waiting for transaction
>> 0ms request delay
>> 20ms running transaction
>> 0ms transaction was being locked
>> 0ms flushing data (in ordered mode)
>> 10ms logging transaction
>> *13524us average transaction commit time*
>> *73 handles per transaction*
>> 0 blocks per transaction
>> 1 logged blocks per transaction
>>
>> vs after the patch series.
>>
>> 0ms waiting for transaction
>> 0ms request delay
>> 20ms running transaction
>> 0ms transaction was being locked
>> 0ms flushing data (in ordered mode)
>> 20ms logging transaction
>> *21468us average transaction commit time*
>> *66 handles per transaction*
>> 1 blocks per transaction
>> 1 logged blocks per transaction
>>
>> This is probably again helping in bunching the writeback transactions and
>> increasing throughput.
> Yeah, probably.
>
>> I looked at the code to understand what might be going on.
>> It seems like commit 72b045aecdd856b083521f2a963705b4c2e59680 changes the
>> behavior of find_get_pages_range_tag.
>> Before this commit if find_get_pages_tag cannot find nr_pages (PAGEVEC_SIZE)
>> it returns the number of pages found as ret and
>> sets the *index to the last page it found + 1. After the commit the behavior
>> changes such that if we don’t find nr_pages pages
>> we set the index to end and not to the last found page. (added diff from
>> above commit)
>> Since pagevec_lookup_range_tag is always called in a while loop (index <=
>> end) the code before the commit helps in coalescing
>> writeback of pages if there are multiple threads doing write as it might
>> keep finding new dirty (tagged) pages since it doesn’t set index to end.
>>
>> + /*
>> + * We come here when we got at @end. We take care to not overflow the
>> + * index @index as it confuses some of the callers. This breaks the
>> + * iteration when there is page at index -1 but that is already broken
>> + * anyway.
>> + */
>> + if (end == (pgoff_t)-1)
>> + *index = (pgoff_t)-1;
>> + else
>> + *index = end + 1;
>> +out:
>> rcu_read_unlock();
>>
>> - if (ret)
>> - *index = pages[ret - 1]->index + 1;
>> -
>>
>>  From the description of the patch i didn't see any mention of this
>> functional change.
>> Was this change intentional and did help some usecase or general performance
>> improvement?
> So the change was intentional. When I was working on the series, I was
> somewhat concerned that the old code could end up in a pathological
> situation like:
>    We scan range 0-1000000, find the only dirty page at index 0, return it.
>    We scan range 1-1000000, find the only dirty page at index 1, return it.
>    ...
>
> This way we end up with rather inefficient scanning and in theory malicious
> user could livelock writeback like this. That being said this was/is mostly
> a theoretical concern.

Ok so its more of a security concern. But do you think this has a 
latency impact? I didn't see
much latency impact between the two sets and throughput is higher.

>
>                                                                  Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
