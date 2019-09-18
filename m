Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0ABB5921
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 02:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfIRA6X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 20:58:23 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60844 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfIRA6X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 20:58:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TceEJSu_1568768297;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TceEJSu_1568768297)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Sep 2019 08:58:18 +0800
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
To:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, adilger@dilger.ca,
        mbobrowski@mbobrowski.org, rgoldwyn@suse.de
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <40e8fc50-db5b-83e3-8a06-620253b6c10b@linux.alibaba.com>
Date:   Wed, 18 Sep 2019 08:58:17 +0800
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

Sure, will post the result ASAP.

Thanks,
Joseph

> Branch for this is hosted at below tree.
> 
> https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC
> 
> [1]: https://lore.kernel.org/linux-ext4/20190910215720.GA7561@quack2.suse.cz/
> [2]: https://lwn.net/Articles/799184/
> [3]: https://lore.kernel.org/linux-fsdevel/20190911103117.E32C34C044@d06av22.portsmouth.uk.ibm.com/
> [4]: https://lore.kernel.org/linux-ext4/1566871552-60946-4-git-send-email-joseph.qi@linux.alibaba.com/
> 
> 
> Ritesh Harjani (2):
>   ext4: Add ext4_ilock & ext4_iunlock API
>   ext4: Improve DIO writes locking sequence
> 
>  fs/ext4/ext4.h    |  33 ++++++
>  fs/ext4/extents.c |  16 +--
>  fs/ext4/file.c    | 253 ++++++++++++++++++++++++++++++++--------------
>  fs/ext4/inode.c   |   4 +-
>  fs/ext4/ioctl.c   |  16 +--
>  fs/ext4/super.c   |  12 +--
>  fs/ext4/xattr.c   |  16 +--
>  7 files changed, 244 insertions(+), 106 deletions(-)
> 
