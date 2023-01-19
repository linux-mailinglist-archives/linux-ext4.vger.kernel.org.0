Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB07672F37
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 03:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjASCsT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 21:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjASCsS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 21:48:18 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A51CF4B;
        Wed, 18 Jan 2023 18:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674096497; x=1705632497;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=7ykvX4PM26257DZ2NGH3psG5zJRH0pCV+rmvUyfK61o=;
  b=gfc8hKKZbTL0n2WPyhr4rvAvKKygQDkwq/BJf3iPXMIAdKQwKFzLscGw
   roJAlpHMh900eYItONIlRvDbTZFoeUxzQdKwmXV+Jsj5zuJeD+vHubZ4g
   amvrDYs58/99Ij2JhUgw114ckLPSWW2uRyo00DtLEZa5UnfsiEALVPmK8
   k=;
X-IronPort-AV: E=Sophos;i="5.97,226,1669075200"; 
   d="scan'208";a="256179274"
Subject: Re: EXT4 IOPS degradation in 5.10 compared to 5.4
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 02:48:16 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id 6B1FE42FDE;
        Thu, 19 Jan 2023 02:48:14 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 19 Jan 2023 02:48:13 +0000
Received: from [10.94.104.252] (10.43.161.198) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Thu, 19 Jan 2023 02:48:12 +0000
Message-ID: <c166a551-8e4a-b68e-cb7f-74b911379c49@amazon.com>
Date:   Wed, 18 Jan 2023 18:48:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <abuehaze@amazon.com>
References: <03d52010-06a8-9bff-0565-b698b48850a9@amazon.com>
 <20230112113820.hjwvieq3ucbwreql@quack3>
 <1cfef086-b3c1-6607-9328-b1bf70896ce4@amazon.com>
Content-Language: en-US
In-Reply-To: <1cfef086-b3c1-6607-9328-b1bf70896ce4@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.198]
X-ClientProxiedBy: EX13D40UWC004.ant.amazon.com (10.43.162.175) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 1/13/23 2:13 PM, Bhatnagar, Rishabh wrote:
>
> On 1/12/23 3:38 AM, Jan Kara wrote:
>> CAUTION: This email originated from outside of the organization. Do 
>> not click links or open attachments unless you can confirm the sender 
>> and know the content is safe.
>>
>>
>>
>> Hi!
>>
>> On Wed 11-01-23 18:06:39, Bhatnagar, Rishabh wrote:
>>> We have been seeing a consistent 3% degradation in IOPS score 
>>> between 5.4
>>> and 5.10 stable kernels while running fio tests.
>>>
>>> I'm running test case on m6g.8xlarge AWS instances using arm64. The 
>>> test
>>> involves:
>>>
>>> 1. Creating 100GB volume with IO1 500 iops. Attaching it to the 
>>> instance.
>>>
>>> 2. Setup and mount fs:
>>>
>>> mke2fs -m 1 -t ext4 -b 4096 -L /mnt /dev/nvme1n1
>>> mount -t ext4 -o noatime,nodiratime,data=ordered /dev/nvme1n1 /mnt
>>>
>>> 3. Install fio package and run following test:
>>> (running 16 threads doing random buffered 16kb writes on a file.
>>> ioengine=psync, runtime=60secs)
>>>
>>> jobs=16
>>> blocksize="16k"
>>> filesize=1000000
>>>
>>> if [[ -n $1 ]]; then jobs=$1; fi
>>> if [[ -n $2 ]]; then blocksize=$2; fi
>>>
>>> /usr/bin/fio --name=fio-test --directory=/mnt --rw=randwrite
>>> --ioengine=psync --buffered=1 --bs=${blocksize} \
>>>          --max-jobs=${jobs} --numjobs=${jobs} --runtime=30 --thread \
>>>          --filename=file0 --filesize=${filesize} \
>>>          --fsync=1 --group_reporting --create_only=1 > /dev/null
>>>
>>> sudo echo 1 > /proc/sys/vm/drop_caches
>>>
>>> set -x
>>> echo "Running with jobs=${jobs} filesize=${filesize} 
>>> blocksize=${blocksize}"
>>> /usr/bin/fio --name=fio-test --directory=/mnt --rw=randwrite
>>> --ioengine=psync --buffered=1 --bs=${blocksize} \
>>>          --max-jobs=${jobs} --numjobs=${jobs} --runtime=60 --thread \
>>>          --filename=file0 --filesize=${filesize} \
>>>          --fsync=1 --group_reporting --time_based
>>>
>>> After doing some kernel bisecting between we were able to pinpoint this
>>> commit that drops the iops score by 10~15 points (~3%).
>>> ext4: avoid unnecessary transaction starts during writeback
>>> (6b8ed62008a49751fc71fefd2a4f89202a7c2d4d)
>>>
>>> We see higher iops/bw/total io after reverting the commit compared 
>>> to base
>>> 5.10 kernel.
>>> Although the average clat is higher after reverting the commit the 
>>> higher bw
>>> drives the iops score higher as seen in below fio output.
>> I expect the difference is somewhere in waiting for the journal. Can you
>> just check whether there's a difference if you use --fdatasync=1 
>> instead of
>> --fsync=1? With this workload that should avoid waiting for the journal
>> because the only metadata updates are mtime timestamps in the inode.
> There is a difference of 5% with and with the commit if i change this 
> to fdatasync=1.
>>> Fio output (5.10.162):
>>> write: io=431280KB, bw=7186.3KB/s, iops=449, runt= 60015msec
>>> clat (usec): min=6, max=25942, avg=267.76,stdev=1604.25
>>> lat (usec): min=6, max=25943, avg=267.93,stdev=1604.25
>>> clat percentiles (usec):
>>> | 1.00th=[ 9], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 24]
>>> | 30.00th=[ 34], 40.00th=[ 45], 50.00th=[ 58], 60.00th=[ 70],
>>> | 70.00th=[ 81], 80.00th=[ 94], 90.00th=[ 107], 95.00th=[ 114],
>>> | 99.00th=[10048], 99.50th=[14016], 99.90th=[20096], 99.95th=[21888],
>>> | 99.99th=[24448]
>>> lat (usec) : 10=3.46%, 20=12.54%, 50=26.66%, 100=41.16%, 250=13.64%
>>> lat (usec) : 500=0.02%, 750=0.03%, 1000=0.01%
>>> lat (msec) : 2=0.23%, 4=0.50%, 10=0.73%, 20=0.91%, 50=0.12%
>>> cpu : usr=0.02%, sys=0.42%, ctx=299540, majf=0, minf=0
>>> IO depths : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
>>> >=64=0.0%
>>> submit : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>>> complete : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
>>> >=64=0.0%
>>> issued : total=r=0/w=26955/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>>> latency : target=0, window=0, percentile=100.00%, depth=1
>>> Run status group 0 (all jobs):
>>> WRITE: io=431280KB, aggrb=7186KB/s, minb=7186KB/s, maxb=7186KB/s,
>>> mint=60015msec, maxt=60015msec
>>> Disk stats (read/write):
>>> nvme1n1: ios=0/30627, merge=0/2125, ticks=0/410990, in_queue=410990,
>>> util=99.94%
>>>
>>> Fio output (5.10.162 with revert):
>>> write: io=441920KB, bw=7363.7KB/s, iops=460, runt= 60014msec
>>> clat (usec): min=6, max=35768, avg=289.09, stdev=1736.62
>>> lat (usec): min=6, max=35768, avg=289.28,stdev=1736.62
>>> clat percentiles (usec):
>>> | 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 24],
>>> | 30.00th=[ 36], 40.00th=[ 46], 50.00th=[ 59], 60.00th=[ 71],
>>> | 70.00th=[ 83], 80.00th=[ 97], 90.00th=[ 110], 95.00th=[ 117],
>>> | 99.00th=[10048], 99.50th=[14144], 99.90th=[21632], 99.95th=[25984],
>>> | 99.99th=[28288]
>>> lat (usec) : 10=4.13%, 20=11.67%, 50=26.59%, 100=39.57%, 250=15.28%
>>> lat (usec) : 500=0.03%, 750=0.03%, 1000=0.03%
>>> lat (msec) : 2=0.20%, 4=0.64%, 10=0.80%, 20=0.86%, 50=0.18%
>>> cpu : usr=0.01%, sys=0.43%, ctx=313909, majf=0, minf=0
>>> IO depths : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
>>> >=64=0.0%
>>> submit : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>>> complete : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
>>> >=64=0.0%
>>> issued : total=r=0/w=27620/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>>> latency : target=0, window=0, percentile=100.00%, depth=1
>>> Run status group 0 (all jobs):
>>> WRITE: io=441920KB, aggrb=7363KB/s, minb=7363KB/s, maxb=7363KB/s,
>>> mint=60014msec, maxt=60014msec
>>> Disk stats (read/write):
>>> nvme1n1: ios=0/31549, merge=0/2348, ticks=0/409221, in_queue=409221,
>>> util=99.88%
>>>
>>>
>>> Also i looked ext4_writepages latency which increases when the 
>>> commit is
>>> reverted. (This makes sense since the commit avoids unnecessary
>>> transactions).
>>>
>>> ./funclatency ext4_writepages -->(5.10.162)
>>> avg = 7734912 nsecs, total: 134131121171 nsecs, count: 17341
>>>
>>> ./funclatency ext4_writepages -->(5.10.162 with revert)
>>> avg = 9036068 nsecs, total: 168956404886 nsecs, count: 18698
>>>
>>>
>>> Looking at the journal transaction data I can see that the average
>>> transaction commit time decreases after reverting the commit.
>>> This probably helps in the IOPS score.
>> So what the workload is doing is:
>> write()
>>    inode lock
>>    dirty 16k of page cache
>>    dirty inode i_mtime
>>    inode unlock
>> fsync()
>>    walk all inode pages, write dirty ones
>>    wait for all pages under writeback in the inode to complete IO
>>    force transaction commit and wait for it
>>
>> Now this has the best throughput (and the worst latency) if all 16
>> processes work in lockstep - i.e., like:
>>
>>    task1         task2           task3 ...
>>    write()
>>                  write()
>>                                  write()
>>    fsync()
>>                  fsync()
>>                                  fsync()
>>
>> because in that case we writeout all dirty pages from 16 processes in 
>> one
>> sweep together and also we accumulate 16 mtime updates in single
>> transaction commit.
>>
>> Now I suspect the commit you've identified leads to less synchronization
>> between the processes and thus in less batching happening. In particular
>> before the commit we've called mpage_prepare_extent_to_map() twice 
>> and the
>> second invocation starts at where the first invocation saw last dirty 
>> page.
>> So it potentially additionally writes newly dirtied pages beyond that 
>> place
>> and that effectively synchronizes processes more.
>>
>> To confirm the theory, it might be interesting to gather a histogram 
>> of a
>> number of pages written back by ext4_writepages() call with / without 
>> the
>> commit.
>>
>> Honza
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>
> Hi Jan
>
> I collected some data w.r.t to number of pages being written by 
> ext4_writepages. What you pointed out seems to be correct.
> Without the commit I see more batching (more writeback count from 4-20 
> pages)happening compared to with the commit.
>
> Without the commit (reverted):
>
> [0-1]   —>  4246
> [2-3]   —>  312
> [4-5]   —>  20836
> [6-7]   —>  205
> [8-9]   —>  895
> [10-11] —>  56
> [12-13] —>  422
> [14-15] —>  62
> [16-17] —>  234
> [18-19] —>  66
> [20-21] —>  77
> [22-23] —>  9
> [24-25] —>  26
> [26-27] —>  1
> [28-29] —>  13
>
> Average page count : 3.9194
>
>
> With the commit:
>
> [0-1]   —> 1635
> [2-3]   —> 123
> [4-5]   —> 24302
> [6-7]   —> 38
> [8-9]   —> 604
> [10-11] —> 19
> [12-13] —> 123
> [14-15] —> 12
> [16-17] —> 24
> [18-19] —> 3
> [20-21] —> 8
> [22-23] —> 1
> [24-25] —> 3
> [26-27] —> 0
> [28-29] —> 1
>
> Average page count : 3.9184
>
> Also looking at journal data I see that without the commit we have 
> more handles per journal transaction:
>
> Without the commit:
> cat /proc/fs/jbd2/nvme1n1-8/info
> 2092 transactions (2091 requested), each up to 8192 blocks
> average:
> 0ms waiting for transaction
> 0ms request delay
> 20ms running transaction
> 0ms transaction was being locked
> 0ms flushing data (in ordered mode)
> 20ms logging transaction
> 15981us average transaction commit time
> 67 handles per transaction
> 1 blocks per transaction
> 2 logged blocks per transaction
>
> With the commit:
> cat /proc/fs/jbd2/nvme1n1-8/info
> 2143 transactions (2143 requested), each up to 8192 blocks
> average:
> 0ms waiting for transaction
> 0ms request delay
> 0ms running transaction
> 0ms transaction was being locked
> 0ms flushing data (in ordered mode)
> 20ms logging transaction
> 20731us average transaction commit time
> 51 handles per transaction
> 1 blocks per transaction
> 3 logged blocks per transaction
>
> Thanks
> Rishabh
>
Hi Jan

Gentle reminder.

Any thoughts on this data? Is there a usecase where this commit brings 
benefits that are worth considering if we decide to revert this?

