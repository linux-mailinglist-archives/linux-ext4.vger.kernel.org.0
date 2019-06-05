Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB835762
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2019 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFEHF4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jun 2019 03:05:56 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52403 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfFEHF4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jun 2019 03:05:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TTTdodB_1559718352;
Received: from 30.5.112.239(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TTTdodB_1559718352)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jun 2019 15:05:52 +0800
Subject: Re: [RFC] jbd2: add new "stats" proc file
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
References: <20190603124238.9050-1-xiaoguang.wang@linux.alibaba.com>
 <20190603143801.GA3048@mit.edu>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <62a687d1-b5b9-e985-3a48-a1cd284ec4db@linux.alibaba.com>
Date:   Wed, 5 Jun 2019 15:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603143801.GA3048@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

> On Mon, Jun 03, 2019 at 08:42:38PM +0800, Xiaoguang Wang wrote:
>> /proc/fs/jbd2/${device}/info only shows whole average statistical
>> info about jbd2's life cycle, but it can not show jbd2 info in
>> specified time interval and sometimes this capability is very useful
>> for trouble shooting. For example, we can not see how rs_locked and
>> rs_flushing grows in specified time interval, but these two indexes
>> can explain some reasons for app's behaviours.
> 
> We actually had something like this, but we removed it in commit
> bf6993276f7: "jbd2: Use tracepoints for history file".  The idea was
> that you can get the same information using the jbd2_run_tracepoints
> 
> # echo jbd2_run_stats > /sys/kernel/debug/tracing/set_event
> # cat /sys/kernel/debug/tracing/trace_pipe
> 
> ... which will produce output like this:
> 
>        jbd2/vdg-8-293   [000] ...2   122.822487: jbd2_run_stats: dev 254,96 tid 4403 wait 0 request_delay 0 running 4 locked 0 flushing 0 logging 7 handle_count 98 blocks 3 blocks_logged 4
>        jbd2/vdg-8-293   [000] ...2   122.833101: jbd2_run_stats: dev 254,96 tid 4404 wait 0 request_delay 0 running 14 locked 0 flushing 0 logging 4 handle_count 198 blocks 1 blocks_logged 2
>        jbd2/vdg-8-293   [000] ...2   122.839325: jbd2_run_stats: dev 254,96 tid 4405 wait
> 
> With eBPF, we should be able to do something even more user friendly.
Yes, I'm learning it :)
For this patch, it's because we'd like to implement a monitor system based
on web to show jbd2 status's change, then for example if buffered write reports
high latency and jbd2 rs_locked and rs_flushing also report high value, we may
build a connection between buffered write and jbd2.
Previously we planned to make above monitor system parse a jbd2 status file provided
by kernel,this would be simplest. But ok, we can try to use ebpf.

> 
> BTW, if you are looking to try to optimize jbd2, a good thing to do is
> to take a look at jbd2_handle_stats, filtered on ones where the
> interval is larger than some cut-off.  Ideally, the time between a
> handle getting started and stopped should be as small as possible,
> because if a transaction is trying to close, an open handle will get
> in the way of that, and other CPU's will be stuck waiting for handle
> to complete.  This means that pre-reading blocks before starting a
> handle, etc., is a really good idea.  And monitoring jbd2_handle_stats
> is a good way to find potential spots to topimize in ext4.
Thanks for your detailed explanation and suggestions.

Regards,
Xiaoguang Wang
> 
>       	      	      		      	 	  - Ted
> 
