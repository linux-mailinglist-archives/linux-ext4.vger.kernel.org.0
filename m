Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D476667C1BD
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 01:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjAZAeC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 19:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjAZAeB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 19:34:01 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B583C2AE;
        Wed, 25 Jan 2023 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674693241; x=1706229241;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=nuFZ7JWueZSk4ZKs2v/HsBakEfBEo8m7KeqzL4CyUT4=;
  b=WTntRHfkfxbWhMoiYdHNfQDVgNhbj9QdLCSICQuwBFKztyd2UjkAPFil
   NqwYu+zIAv3tfF085gFpZxZ3rSlbybdCi+Mpv05ky1M3stdyNrL1GhKUl
   Oqd09OFuqRNHKU8WFmjkznSHXsQ7YrgQgAaMs2kdg3gJWDGelPE//u7+w
   I=;
X-IronPort-AV: E=Sophos;i="5.97,246,1669075200"; 
   d="scan'208";a="175195278"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 00:34:01 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id D7CFE81A79;
        Thu, 26 Jan 2023 00:33:59 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 26 Jan 2023 00:33:56 +0000
Received: from [192.168.18.75] (10.43.162.56) by EX19D002UWC004.ant.amazon.com
 (10.13.138.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7; Thu, 26 Jan 2023
 00:33:55 +0000
Message-ID: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
Date:   Wed, 25 Jan 2023 16:33:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
Subject: EXT4 IOPS degradation between 4.14 and 5.10
To:     Jan Kara <jack@suse.cz>, <tytso@mit.edu>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D31UWA002.ant.amazon.com (10.43.160.82) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan

As discussed in the previous thread I'm chasing IOPS regression between 
4.14 -> 5.10 kernels.
https://lore.kernel.org/lkml/20230112113820.hjwvieq3ucbwreql@quack3/T/
<https://lore.kernel.org/lkml/20230112113820.hjwvieq3ucbwreql@quack3/T/>

Last issue we discussed was difficult to resolve so keeping it on the 
back burner for now.

I did some more bisecting and saw another series of patches that 
potentially impacts iops score:
72b045aecdd856b083521f2a963705b4c2e59680 (mm: implement 
find_get_pages_range_tag())

Running fio tests on tip as 9c19a9cb1642c074aa8bc7693cd4c038643960ae 
(including the 16 patch series) vs tip as
6b4c54e3787bc03e810062bd257a3b05fd9c72d6 (without the above series) 
shows an IOPS jump.

Fio with buffered io/fsync=1/randwrite

With HEAD as 9c19a9cb1642c074aa8bc7693cd4c038643960ae (with the above 
series)

write: io=445360KB, bw=7418.6KB/s, *iops=463*, runt= 60033msec
clat (usec): min=4, max=32132, avg=311.90, stdev=1812.74
lat (usec): min=5, max=32132, avg=312.28, stdev=1812.74
clat percentiles (usec):
| 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 25],
| 30.00th=[ 36], 40.00th=[ 47], 50.00th=[ 60], 60.00th=[ 71],
| 70.00th=[ 84], 80.00th=[ 97], 90.00th=[ 111], 95.00th=[ 118],
| 99.00th=[11840], 99.50th=[15936], 99.90th=[21888], 99.95th=[23936],

With HEAD as 6b4c54e3787bc03e810062bd257a3b05fd9c72d6(without the above 
series)

write: io=455184KB, bw=7583.4KB/s, *iops=473*, runt= 60024msec
clat (usec): min=6, max=24325, avg=319.72, stdev=1694.52
lat (usec): min=6, max=24326, avg=319.99, stdev=1694.53
clat percentiles (usec):
| 1.00th=[ 9], 5.00th=[ 11], 10.00th=[ 17], 20.00th=[ 26],
| 30.00th=[ 38], 40.00th=[ 50], 50.00th=[ 60], 60.00th=[ 73],
| 70.00th=[ 85], 80.00th=[ 98], 90.00th=[ 111], 95.00th=[ 118],
| 99.00th=[ 9792], 99.50th=[14016], 99.90th=[21888], 99.95th=[22400],
| 99.99th=[24192]


I also see that number of handles per transaction were much higher 
before this patch series

0ms waiting for transaction
0ms request delay
20ms running transaction
0ms transaction was being locked
0ms flushing data (in ordered mode)
10ms logging transaction
*13524us average transaction commit time*
*73 handles per transaction*
0 blocks per transaction
1 logged blocks per transaction

vs after the patch series.

0ms waiting for transaction
0ms request delay
20ms running transaction
0ms transaction was being locked
0ms flushing data (in ordered mode)
20ms logging transaction
*21468us average transaction commit time*
*66 handles per transaction*
1 blocks per transaction
1 logged blocks per transaction

This is probably again helping in bunching the writeback transactions 
and increasing throughput.

I looked at the code to understand what might be going on.
It seems like commit 72b045aecdd856b083521f2a963705b4c2e59680 changes 
the behavior of find_get_pages_range_tag.
Before this commit if find_get_pages_tag cannot find nr_pages 
(PAGEVEC_SIZE) it returns the number of pages found as ret and
sets the *index to the last page it found + 1. After the commit the 
behavior changes such that if we don’t find nr_pages pages
we set the index to end and not to the last found page. (added diff from 
above commit)
Since pagevec_lookup_range_tag is always called in a while loop (index 
<= end) the code before the commit helps in coalescing
writeback of pages if there are multiple threads doing write as it might 
keep finding new dirty (tagged) pages since it doesn’t set index to end.

+ /*
+ * We come here when we got at @end. We take care to not overflow the
+ * index @index as it confuses some of the callers. This breaks the
+ * iteration when there is page at index -1 but that is already broken
+ * anyway.
+ */
+ if (end == (pgoff_t)-1)
+ *index = (pgoff_t)-1;
+ else
+ *index = end + 1;
+out:
rcu_read_unlock();

- if (ret)
- *index = pages[ret - 1]->index + 1;
-

 From the description of the patch i didn't see any mention of this 
functional change.
Was this change intentional and did help some usecase or general 
performance improvement?

Thanks
Rishabh

