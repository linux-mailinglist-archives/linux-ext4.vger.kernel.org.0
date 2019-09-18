Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5768B5D6C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfIRGfW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 02:35:22 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54061 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfIRGfW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Sep 2019 02:35:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tcfr-rl_1568788515;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tcfr-rl_1568788515)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Sep 2019 14:35:15 +0800
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
To:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, adilger@dilger.ca,
        mbobrowski@mbobrowski.org, rgoldwyn@suse.de
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
Date:   Wed, 18 Sep 2019 14:35:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917103249.20335-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ritesh,

On 19/9/17 18:32, Ritesh Harjani wrote:
> Hello,
> 
> This patch series is based on the upstream discussion with Jan
> & Joseph @ [1].
> It is based on top of Matthew's v3 ext4 iomap patch series [2]
> 
> Patch-1: Adds the ext4_ilock/unlock APIs and also replaces all
> inode_lock/unlock instances from fs/ext4/*
> 
> For now I already accounted for trylock/lock issue symantics
> (which was discussed here [3]) in the same patch,
> since the this whole patch was around inode_lock/unlock API,
> so I thought it will be best to address that issue in the same patch. 
> However, kindly let me know if otherwise.
> 
> Patch-2: Commit msg of this patch describes in detail about
> what it is doing.
> In brief - we try to first take the shared lock (instead of exclusive
> lock), unless it is a unaligned_io or extend_io. Then in
> ext4_dio_write_checks(), if we start with shared lock, we see
> if we can really continue with shared lock or not. If not, then
> we release the shared lock then acquire exclusive lock
> and restart ext4_dio_write_checks().
> 
> 
> Tested against few xfstests (with dioread_nolock mount option),
> those ran fine (ext4 & generic).
> 
> I tried testing performance numbers on my VM (since I could not get
> hold of any real h/w based test device). I could test the fact
> that earlier we were trying to do downgrade_write() lock, but with
> this patch, that path is now avoided for fio test case
> (as reported by Joseph in [4]).
> But for the actual results, I am not sure if VM machine testing could
> really give the reliable perf numbers which we want to take a look at.
> Though I do observe some form of perf improvements, but I could not
> get any reliable numbers (not even with the same list of with/without
> patches with which Joseph posted his numbers [1]).
> 
> 
> @Joseph,
> Would it be possible for you to give your test case a run with this
> patches? That will be really helpful.
> 
> Branch for this is hosted at below tree.
> 
> https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC
> 
I've tested your branch, the result is:
mounting with dioread_nolock, it behaves the same like reverting
parallel dio reads + dioread_nolock;
while mounting without dioread_nolock, no improvement, or even worse.
Please refer the test data below. 

fio -name=parallel_dio_reads_test -filename=/mnt/nvme0n1/testfile
-direct=1 -iodepth=1 -thread -rw=randrw -ioengine=psync -bs=$bs
-size=20G -numjobs=8 -runtime=600 -group_reporting

w/     = with parallel dio reads
w/o    = reverting parallel dio reads
w/o+   = reverting parallel dio reads + dioread_nolock
ilock  = ext4-ilock-RFC
ilock+ = ext4-ilock-RFC + dioread_nolock

bs=4k:
--------------------------------------------------------------
      |            READ           |           WRITE          |
--------------------------------------------------------------
w/    | 30898KB/s,7724,555.00us   | 30875KB/s,7718,479.70us  |
--------------------------------------------------------------
w/o   | 117915KB/s,29478,248.18us | 117854KB/s,29463,21.91us |
--------------------------------------------------------------
w/o+  | 123450KB/s,30862,245.77us | 123368KB/s,30841,12.14us |
--------------------------------------------------------------
ilock | 29964KB/s,7491,326.70us	  | 29940KB/s,7485,740.62us  |
--------------------------------------------------------------
ilock+| 123685KB/s,30921,245.52us | 123601KB/s,30900,12.11us |
--------------------------------------------------------------


bs=16k:
--------------------------------------------------------------
      |            READ           |           WRITE          |
--------------------------------------------------------------
w/    | 58961KB/s,3685,835.28us   | 58877KB/s,3679,1335.98us |
--------------------------------------------------------------
w/o   | 218409KB/s,13650,554.46us | 218257KB/s,13641,29.22us |
--------------------------------------------------------------
w/o+  | 222477KB/s,13904,552.94us | 222322KB/s,13895,20.28us |
--------------------------------------------------------------
ilock | 56039KB/s,3502,632.96us	  | 55943KB/s,3496,1652.72us |
--------------------------------------------------------------
ilock+| 222747KB/s,13921,552.57us | 222592KB/s,13912,20.31us |
--------------------------------------------------------------

bs=64k
----------------------------------------------------------------
      |            READ            |           WRITE           |
----------------------------------------------------------------
w/    | 119396KB/s,1865,1759.38us  | 119159KB/s,1861,2532.26us |
----------------------------------------------------------------
w/o   | 422815KB/s,6606,1146.05us  | 421619KB/s,6587,60.72us   |
--------------------------------------------,-------------------
w/o+  | 427406KB/s,6678,1141.52us  | 426197KB/s,6659,52.79us   |
----------------------------------------------------------------
ilock | 105800KB/s,1653,1451.68us  | 105721KB/s,1651,3388.64us |
----------------------------------------------------------------
ilock+| 427678KB/s,6682,1142.13us  | 426468KB/s,6663,52.31us   |
----------------------------------------------------------------

bs=512k
----------------------------------------------------------------
      |            READ            |           WRITE           |
----------------------------------------------------------------
w/    | 392973KB/s,767,5046.35us   | 393165KB/s,767,5359.86us  |
----------------------------------------------------------------
w/o   | 590266KB/s,1152,4312.01us  | 590554KB/s,1153,2606.82us |
----------------------------------------------------------------
w/o+  | 618752KB/s,1208,4125.82us  | 619054KB/s,1209,2487.90us |
----------------------------------------------------------------
ilock | 296239KB/s,578,4703.10us   | 296384KB/s,578,9049.32us  |
----------------------------------------------------------------
ilock+| 616636KB/s,1204,4143.38us  | 616937KB/s,1204,2490.08us |
----------------------------------------------------------------

bs=1M
----------------------------------------------------------------
      |            READ            |           WRITE           |
----------------------------------------------------------------
w/    | 487779KB/s,476,8058.55us   | 485592KB/s,474,8630.51us  |
----------------------------------------------------------------
w/o   | 593927KB/s,580,7623.63us   | 591265KB/s,577,6163.42us  |
----------------------------------------------------------------
w/o+  | 615011KB/s,600,7399.93us   | 612255KB/s,597,5936.61us  |
----------------------------------------------------------------
ilock | 394762KB/s,385,7097.55us   | 392993KB/s,383,13626.98us |
----------------------------------------------------------------
ilock+| 626183KB/s,611,7319.16us   | 623377KB/s,608,5773.24us  |
----------------------------------------------------------------

Thanks,
Joseph
