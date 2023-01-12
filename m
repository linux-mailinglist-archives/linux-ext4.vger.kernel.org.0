Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4966688E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 02:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjALBsW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 20:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjALBsV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 20:48:21 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7754101D;
        Wed, 11 Jan 2023 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1673488101; x=1705024101;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=P6FCm11oaxjhqDLTftU5oMFmguyt3yGbwjvj6ga5anU=;
  b=Yr33/g8QcDfk34geG4jdil7x02Ik6tcVhaT+sYQkjFby01LpGtCiX18I
   DT56yoragVzdPYV7x/wZPzgVRlZU448psgQZncG/c6cVC+zZwSi1sOpgT
   qTl8XLaRzWwn/dQ57oKFou21Ax6CXzKlR+UVbQM7KtdJXiFU9WVd7TbX3
   8=;
X-IronPort-AV: E=Sophos;i="5.96,318,1665446400"; 
   d="scan'208";a="254506896"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:48:19 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 7F6E3419A0;
        Thu, 12 Jan 2023 01:48:17 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 12 Jan 2023 01:48:14 +0000
Received: from [192.168.5.53] (10.43.160.120) by EX19D002UWC004.ant.amazon.com
 (10.13.138.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7; Thu, 12 Jan 2023
 01:48:13 +0000
Message-ID: <2532321d-614b-ac02-e921-db8e2b6bcbe8@amazon.com>
Date:   Wed, 11 Jan 2023 17:48:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
Subject: EXT4 IOPS degradation in 5.10 compared to 5.4
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <abuehaze@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D27UWA004.ant.amazon.com (10.43.160.43) To
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

Hi Theodore/Jan

We have been seeing a consistent 3% degradation in IOPS score between 
5.4 and 5.10 stable kernels while running fio tests.

I'm running test case on m6g.8xlarge AWS instances using arm64. The test 
involves:

1. Creating 100GB volume with IO1 500 iops. Attaching it to the instance.

2. Setup and mount fs:

|> mke2fs -m 1 -t ext4 -b 4096 -L /mnt /dev/nvme1n1 > mount -t ext4 -o 
noatime,nodiratime,data=ordered /dev/nvme1n1 /mnt|

3. Install fio package and run following test:

(running 16 threads doing random buffered 16kb writes on a file. 
ioengine=psync, runtime=60secs)

|#!/bin/bash jobs=16 blocksize="16k" filesize=1000000 if [[ -n $1 ]]; 
then jobs=$1; fi if [[ -n $2 ]]; then blocksize=$2; fi /usr/bin/fio 
--name=fio-test --directory=/mnt --rw=randwrite --ioengine=psync 
--buffered=1 --bs=${blocksize} \ --max-jobs=${jobs} --numjobs=${jobs} 
--runtime=30 --thread \ --filename=file0 --filesize=${filesize} \ 
--fsync=1 --group_reporting --create_only=1 > /dev/null sudo echo 1 > 
/proc/sys/vm/drop_caches set -x echo "Running with jobs=${jobs} 
filesize=${filesize} blocksize=${blocksize}" /usr/bin/fio 
--name=fio-test --directory=/mnt --rw=randwrite --ioengine=psync 
--buffered=1 --bs=${blocksize} \ --max-jobs=${jobs} --numjobs=${jobs} 
--runtime=60 --thread \ --filename=file0 --filesize=${filesize} \ 
--fsync=1 --group_reporting --time_based|

After doing some kernel bisecting between we were able to pinpoint this 
commit**that drops the iops score by 10~15 points (~3%).*
ext4: avoid unnecessary transaction starts during writeback 
(6b8ed62008a49751fc71fefd2a4f89202a7c2d4d)
*

We see higher iops/bw/total io after reverting the commit compared to 
base 5.10 kernel.
Although the average clat is higher after reverting the commit the 
higher bw drives the iops score higher as seen in below fio output.

*Fio output (5.10.162):/
write: io=431280KB, bw=7186.3KB/s, iops=449, runt= 60015msec/*
/clat (usec): min=6, //*max=25942, avg=267.76,*//stdev=1604.25//
//lat (usec): min=6, //*max=25943, avg=267.93,*//stdev=1604.25//
//clat percentiles (usec)://
//| 1.00th=[ 9], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 24],//
//| 30.00th=[ 34], 40.00th=[ 45], 50.00th=[ 58], 60.00th=[ 70],//
//| 70.00th=[ 81], 80.00th=[ 94], 90.00th=[ 107], 95.00th=[ 114],//
//| 99.00th=[10048], 99.50th=[14016], 99.90th=[20096], 99.95th=[21888],//
//| 99.99th=[24448]//
//lat (usec) : 10=3.46%, 20=12.54%, 50=26.66%, 100=41.16%, 250=13.64%//
//lat (usec) : 500=0.02%, 750=0.03%, 1000=0.01%//
//lat (msec) : 2=0.23%, 4=0.50%, 10=0.73%, 20=0.91%, 50=0.12%//
//cpu : usr=0.02%, sys=0.42%, ctx=299540, majf=0, minf=0//
//IO depths : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%//
//submit : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%//
//complete : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%//
//issued : total=r=0/w=26955/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0//
//latency : target=0, window=0, percentile=100.00%, depth=1//
//Run status group 0 (all jobs)://
//WRITE: io=431280KB, aggrb=7186KB/s, minb=7186KB/s, maxb=7186KB/s, 
mint=60015msec, maxt=60015msec//
//Disk stats (read/write)://
//nvme1n1: ios=0/30627, merge=0/2125, ticks=0/410990, in_queue=410990, 
util=99.94%/

*Fio output (5.10.162 with revert):*
/*write: io=441920KB, bw=7363.7KB/s, iops=460, runt= 60014msec*/
/clat (usec): min=6, //*max=35768, avg=289.09, *//stdev=1736.62//
//lat (usec): min=6, //*max=35768, avg=289.28,*//stdev=1736.62//
//clat percentiles (usec)://
//| 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 24],//
//| 30.00th=[ 36], 40.00th=[ 46], 50.00th=[ 59], 60.00th=[ 71],//
//| 70.00th=[ 83], 80.00th=[ 97], 90.00th=[ 110], 95.00th=[ 117],//
//| 99.00th=[10048], 99.50th=[14144], 99.90th=[21632], 99.95th=[25984],//
//| 99.99th=[28288]//
//lat (usec) : 10=4.13%, 20=11.67%, 50=26.59%, 100=39.57%, 250=15.28%//
//lat (usec) : 500=0.03%, 750=0.03%, 1000=0.03%//
//lat (msec) : 2=0.20%, 4=0.64%, 10=0.80%, 20=0.86%, 50=0.18%//
//cpu : usr=0.01%, sys=0.43%, ctx=313909, majf=0, minf=0//
//IO depths : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, 
 >=64=0.0%//
//submit : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%//
//complete : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%//
//issued : total=r=0/w=27620/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0//
//latency : target=0, window=0, percentile=100.00%, depth=1//
//Run status group 0 (all jobs)://
//WRITE: io=441920KB, aggrb=7363KB/s, minb=7363KB/s, maxb=7363KB/s, 
mint=60014msec, maxt=60014msec//
//Disk stats (read/write)://
//nvme1n1: ios=0/31549, merge=0/2348, ticks=0/409221, in_queue=409221, 
util=99.88%/


Also i looked ext4_writepages latency which increases when the commit is 
reverted. (This makes sense since the commit avoids unnecessary 
transactions).

*./funclatency ext4_writepages -->(5.10.162)*
*avg = 7734912* nsecs, total: 134131121171 nsecs, *count: 17341*

*./funclatency ext4_writepages -->(5.10.162 with revert)*
*avg = 9036068* nsecs, total: 168956404886 nsecs, *count: 18698*


Looking at the journal transaction data I can see that the average 
transaction commit time decreases after reverting the commit.
This probably helps in the IOPS score.

*5.10.162:*
/*cat /proc/fs/jbd2/nvme1n1-8/info *//--> After 1st test iteration
//2143 transactions (2143 requested), each up to 8192 blocks//
//average: //
//0ms waiting for transaction//
//0ms request delay//
//0ms running transaction//
//0ms transaction was being locked//
//0ms flushing data (in ordered mode)//
//20ms logging transaction//
////*20731us average transaction commit time*//
//51 handles per transaction//
//1 blocks per transaction//
//3 logged blocks per transaction/

*/cat /proc/fs/jbd2/nvme1n1-8/info/*/--> After 2nd test iteration
//4292 transactions (4292 requested), each up to 8192 blocks//
//average: //
//0ms waiting for transaction//
//0ms request delay//
//0ms running transaction//
//0ms transaction was being locked//
//0ms flushing data (in ordered mode)//
//20ms logging transaction//
/ /*26470us average transaction commit time*//
//51 handles per transaction//
//1 blocks per transaction//
//3 logged blocks per transaction/

*5.10.162 with revert:*
/*cat /proc/fs/jbd2/nvme1n1-8/info*///--> After 1st test iteration///
2092 transactions (2091 requested), each up to 8192 blocks//
//average: //
//0ms waiting for transaction//
//0ms request delay//
//20ms running transaction//
//0ms transaction was being locked//
//0ms flushing data (in ordered mode)//
//20ms logging transaction//
////*15981us average transaction commit time*//
//67 handles per transaction//
//1 blocks per transaction//
//2 logged blocks per transaction//
/

*/cat /proc/fs/jbd2/nvme1n1-8/info/*//--> After 2nd test iteration///
4263 transactions (4262 requested), each up to 8192 blocks//
//average: //
//0ms waiting for transaction//
//0ms request delay//
//10ms running transaction//
//0ms transaction was being locked//
//0ms flushing data (in ordered mode)//
//20ms logging transaction//
////*19795us average transaction commit time*//
//65 handles per transaction//
//1 blocks per transaction//
//2 logged blocks per transaction/


Looking at the commit it seems we should be avoiding unnecessary journal 
transactions. This is reflected in the ext4_writepages latency.
But the transaction commit time seems to be increasing with this commit 
leading to reduced IOPS. (atleast that's my theory).
Can you help look into why this commit introduces this IOPS regression? 
Also any suggestions on running any more tests to isolate the issue are 
welcome.

Thanks
Rishabh

