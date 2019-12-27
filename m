Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29212B4C5
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0NKb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 08:10:31 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54376 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfL0NKb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 08:10:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tm24V6j_1577452226;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tm24V6j_1577452226)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Dec 2019 21:10:27 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: Discussion: is it time to remove dioread_nolock?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20191226153118.GA17237@mit.edu>
Message-ID: <dc324872-9720-0590-5501-043c84d9ddc6@linux.alibaba.com>
Date:   Fri, 27 Dec 2019 21:10:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191226153118.GA17237@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,
After applying Ritesh's patches, from my test result, there is no
obvious performance difference between default mount options and
with dioread_lock (delalloc or nodelalloc).
I'm not sure if dioread_nolock was used for other purpose in the
scenario reported by Bo Liu. Maybe Xiaoguang could give some inputs.

Thanks,
Joseph


On 19/12/26 23:31, Theodore Y. Ts'o wrote:
> With inclusion of Ritesh's inode lock scalability patches[1], the
> traditional performance reasons for dioread_nolock --- namely,
> removing the need to take an exclusive lock for Direct I/O read
> operations --- has been removed.
> 
> [1] https://lore.kernel.org/r/20191212055557.11151-1-riteshh@linux.ibm.com
> 
> So... is it time to remove the code which supports dioread_nolock?
> Doing so would simplify the code base, and reduce the test matrix.
> This would also make it easier to restructure the write path when
> allocating blocks so that the extent tree is updated after writing out
> the data blocks, by clearing away the underbrush of dioread nolock
> first.
> 
> If we do this, we'd leave the dioread_nolock mount option for
> backwards compatibility, but it would be a no-op and not actually do
> anything.
> 
> Any objections before I look into ripping out dioread_nolock?
> 
> The one possible concern that I considered was for Alibaba, which was
> doing something interesting with dioread_nolock plus nodelalloc.  But
> looking at Liu Bo's explanation[2], I believe that their workload
> would be satisfied simply by using the standard ext4 mount options
> (that is, the default mode has the performance benefits when doing
> parallel DIO reads, and so the need for nodelalloc to mitigate the
> tail latency concerns which Alibaba was seeing in their workload would
> not be needed).  Could Liu or someone from Alibaba confirm, perhaps
> with some benchmarks using their workload?
> 
> [2] https://lore.kernel.org/linux-ext4/20181121013035.ab4xp7evjyschecy@US-160370MP2.local/
> 
>     	  	     	      	   	- Ted
> 
