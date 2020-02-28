Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDE1735CF
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2020 12:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB1LGS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Feb 2020 06:06:18 -0500
Received: from apollo.dupie.be ([51.15.19.225]:46604 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgB1LGS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Feb 2020 06:06:18 -0500
Received: from [10.10.1.146] (systeembeheer.combell.com [217.21.177.69])
        by apollo.dupie.be (Postfix) with ESMTPSA id 7E55680AC3C;
        Fri, 28 Feb 2020 12:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
        t=1582887974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0Pa7cpRLuMV2NYp/M4q6fJc7IXZYTneRZvDCVuvqsA=;
        b=fvnlVGHpWXCJjzkyonoyKLnA2YaPyqON6A/KnAVvqeM2ZvReBGaNz+SBDfdeq9CHp5jUnd
        YGAVbm4OAEeDTNrcBlV97lMuF8fhgx8puN0Za8Gsv3L8TFVzKnWCdyoPqFeh3isKloX922
        fx6hIG47X6mgDAqf8kmVOdP7cIdk7AzZKIAAXUvhQwHLJhYLAV1FA7NTDarvS2dqls800x
        4QJyov2jINvSR4hsyLfEtrDcI0cBSXB0CVHimJNnzxTDTxWYXgH1adqGc1eyXU08n/g3VP
        rw9Kld5Wifm4KR2ZO6qF9aG2lH759MBwreEpkZHWbaluqmTecMedWIoKcNAJzg==
Subject: Re: Filesystem corruption after unreachable storage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
 <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
 <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
 <20200225172355.GA14617@mit.edu>
From:   Jean-Louis Dupond <jean-louis@dupond.be>
Message-ID: <d19e44af-585f-e4a2-5546-7a3345a0ee66@dupond.be>
Date:   Fri, 28 Feb 2020 12:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225172355.GA14617@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 25/02/2020 18:23, Theodore Y. Ts'o wrote:
> On Tue, Feb 25, 2020 at 02:19:09PM +0100, Jean-Louis Dupond wrote:
>> FYI,
>>
>> Just did same test with e2fsprogs 1.45.5 (from buster backports) and kernel
>> 5.4.13-1~bpo10+1.
>> And having exactly the same issue.
>> The VM needs a manual fsck after storage outage.
>>
>> Don't know if its useful to test with 5.5 or 5.6?
>> But it seems like the issue still exists.
> This is going to be a long shot, but if you could try testing with
> 5.6-rc3, or with this commit cherry-picked into a 5.4 or later kernel:
>
>     commit 8eedabfd66b68a4623beec0789eac54b8c9d0fb6
>     Author: wangyan <wangyan122@huawei.com>
>     Date:   Thu Feb 20 21:46:14 2020 +0800
>
>         jbd2: fix ocfs2 corrupt when clearing block group bits
>         
>         I found a NULL pointer dereference in ocfs2_block_group_clear_bits().
>         The running environment:
>                 kernel version: 4.19
>                 A cluster with two nodes, 5 luns mounted on two nodes, and do some
>                 file operations like dd/fallocate/truncate/rm on every lun with storage
>                 network disconnection.
>         
>         The fallocate operation on dm-23-45 caused an null pointer dereference.
>         ...
>
> ... it would be interesting to see if fixes things for you.  I can't
> guarantee that it will, but the trigger of the failure which wangyan
> found is very similar indeed.
>
> Thanks,
>
> 						- Ted
Unfortunately it was a too long shot :)

Tested with a 5.4 kernel with that patch included, and also with 5.6-rc3.
But both had the same issue.

- Filesystem goes read-only when the storage comes back
- Manual fsck needed on bootup to recover from it.

It would be great if we could make it not corrupt the filesystem on 
storage recovery.
I'm happy to test some patches if they are available :)

Thanks
Jean-Louis
