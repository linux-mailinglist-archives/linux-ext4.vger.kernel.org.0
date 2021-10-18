Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6D430E74
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Oct 2021 05:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhJRD4r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Oct 2021 23:56:47 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51673 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhJRD4r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Oct 2021 23:56:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UsUGbVe_1634529274;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UsUGbVe_1634529274)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Oct 2021 11:54:34 +0800
Subject: Re: Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not
 cleared!
To:     Theodore Ts'o <tytso@mit.edu>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "enwlinux@gmail.com" <enwlinux@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <767ea5bb27e31cc58bea15cd2aec492946679bde.camel@nokia.com>
 <YWhxvOf5EoHMFxtl@B-P7TQMD6M-0146.local> <YWinzKvlbx0XlJKJ@mit.edu>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <389353b8-f1f0-1b73-92b9-f1b00644eaf6@linux.alibaba.com>
Date:   Mon, 18 Oct 2021 11:54:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWinzKvlbx0XlJKJ@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/15/21 5:57 AM, Theodore Ts'o wrote:
> On Fri, Oct 15, 2021 at 02:06:52AM +0800, Gao Xiang wrote:
>> On Thu, Oct 14, 2021 at 12:54:14PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
>>> Hi,
>>>
>>> I'm seeing these i_reserved_data_blocks not cleared! messages when using ext4
>>> with nodelalloc, message added in:
>>>
>>>   commit 6fed83957f21eff11c8496e9f24253b03d2bc1dc
>>>   Author: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>   Date:   Mon Aug 23 14:13:58 2021 +0800
>>>
>>>       ext4: fix reserved space counter leakage
>>>
>>> I can quickly reproduce in 5.15.0-rc5-00041-g348949d9a444 by doing some
>>> filesystem I/O while toggling delalloc:
>>>
>>>
>>> while true; do mount -o remount,nodelalloc /; sleep 1; mount -o remount,delalloc /; sleep 1; done &
>>> git clone linux xxx; rm -rf xxx
>>
>> If I understand correctly, switching such option implies
>> sync inodes to write back exist delayed allocation blocks.
> 
> Well, no.  What it implies is that all writes after the remount into
> an unallocated portion of the file will be allocated at the time when
> the page is dirtied, instead of when the page is written back.  It's
> possible for some pages to be written using delayed allocation, and
> some other pages in the legacy "allocate on page dirty" mechanism.
> This can happen when the file system is remounted; it can also happen
> when the file system starts getting close to 100% full.  See the
> comment in ext4_nonda_switch:
> 
> 	/*
> 	 * switch to non delalloc mode if we are running low
> 	 * on free block. The free block accounting via percpu
> 	 * counters can get slightly wrong with percpu_counter_batch getting
> 	 * accumulated on each CPU without updating global counters
> 	 * Delalloc need an accurate free block accounting. So switch
> 	 * to non delalloc when we are near to error range.
> 	 */
> 

So it seems possible that s_dirtyclusters_counter/i_reserved_data_blocks
counters are not maintained anymore when filesystem gets remounted from
'delalloc' to 'nodelalloc', even when you're writing back a (previously)
delay allocated page cache (when it's still mounted as 'delalloc'). Thus
it is possible that s_dirtyclusters_counter/i_reserved_data_blocks
counters are non-zero when the inode is finally evicted and destroyed.

IMHO I think this inconsistency is problematic. For example, when
filesystem gets remounted from 'delalloc' to 'nodelalloc' and then runs
for a period, s_dirtyclusters_counter/i_reserved_data_blocks counters
already gets inconsistent. Then it's remounted back to 'delalloc', in
which case s_dirtyclusters_counter/i_reserved_data_blocks counters are
already incorrect.



-- 
Thanks,
Jeffle
