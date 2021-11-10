Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3183C44BC97
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Nov 2021 09:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhKJILI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Nov 2021 03:11:08 -0500
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:53678 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJILH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Nov 2021 03:11:07 -0500
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id DB13910094B67;
        Wed, 10 Nov 2021 16:08:16 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id A0C67200B8926;
        Wed, 10 Nov 2021 16:08:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OGJ8dHnxl2iH; Wed, 10 Nov 2021 16:08:11 +0800 (CST)
Received: from [192.168.11.167] (unknown [202.120.40.82])
        (Authenticated sender: sunrise_l@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 74195200B89EA;
        Wed, 10 Nov 2021 16:07:58 +0800 (CST)
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
 <20211103002843.GC418105@dread.disaster.area>
 <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
 <20211104232226.GD418105@dread.disaster.area>
 <01e6abf4-3ae5-ecab-3b7f-876c8a3fcbb4@sjtu.edu.cn>
 <20211109045010.GG418105@dread.disaster.area>
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Message-ID: <4f00db60-478b-698c-fc5b-874d8255af57@sjtu.edu.cn>
Date:   Wed, 10 Nov 2021 16:07:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109045010.GG418105@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/9/21 12:50 PM, Dave Chinner wrote:
>>
>> Could we add IOMAP_REPORT_DIRTY flag in the flags field of
>> struct iomap_iter to indicate whether the IOMAP_F_DIRTY flag
>> needs to be set or not?
> 
> You can try. It might turn out OK, but you're also going to have to
> modify all the iomap code that current needs IOMAP_F_DIRTY to first
> set that flag, then change all the code that currently sets
> IOMAP_F_DIRTY to look at IOMAP_REPORT_DIRTY. i.e you now have to
> change iomap, ext4 and XFS to do this.
>
I will make a v2 patch with this implementation.

>> Currently the IOMAP_F_DIRTY flag is only checked in
>> iomap_swapfile_activate(), dax_iomap_fault() and iomap_dio_rw()
>> (To be more specific, only the write path in dax_iomap_fault() and
>> iomap_dio_rw()). So it would be unnecessary to set the IOMAP_F_DIRTY
>> flag in dax_iomap_rw() called in the previous tests.
> 
> I think you're trying to optimise the wrong thing - the API is not
> the problem, the problem is that the journal->j_state_lock is
> contended and the ext4 dirty inode check needs to take it. Fix the
> dirty check not to need the journal state lock and the ext4 problem
> goes away and there is no need to change the iomap infrastructure.

I'll try to fix it inside ext4, although it seems difficult to do dirty
check without journal->j_state_lock.

>> Other file systems that set the IOMAP_F_DIRTY flag efficiently
>> could ignore the IOMAP_REPORT_DIRTY flag.
> 
> No, that's just bad API design. If we are adding IOMAP_REPORT_DIRTY
> then the iomap infrastructure should only use that control flag when
> it needs to know if the inode is dirty. At this point, it really
> becomes mandatory for all filesystems using iomap to support it
> because the absence of IOMAP_F_DIRTY because a filesystem doesn't
> support it is not the same as "filesystem didn't set it because the
> inode is clean".
> 
Perhaps I have not made it clear that by "ignore" I mean other file
systems can set IOMAP_F_DIRTY regardless of whether the
IOMAP_REPORT_DIRTY flag is set or not, just like what they are doing
now. So we might not need to modify XFS.

I think even without the modification I made, the ambiguity that
the absence of IOMAP_F_DIRTY can either be file systems not supporting
it or be actually "clean inode" may exist since we do not have a flag
to indicate whether the file system supports setting IOMAP_F_DIRTY.

Best,

Zhongwei
