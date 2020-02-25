Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3720116C1FC
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgBYNTJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 08:19:09 -0500
Received: from apollo.dupie.be ([51.15.19.225]:37696 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgBYNTJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Feb 2020 08:19:09 -0500
Received: from [10.10.1.141] (systeembeheer.combell.com [217.21.177.69])
        by apollo.dupie.be (Postfix) with ESMTPSA id C97EE80A9BA;
        Tue, 25 Feb 2020 14:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
        t=1582636747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiaT6grkcrVKG+eCFYwNFETk5vroLG4d3H4bch6WW5A=;
        b=ktjayhjYGT7XHWbW3efFTdcYhpQ3zvo0frsxnWmRIwqDJVTQSIhZajHpeq93sEiQ5sgGvj
        Rb2EW2IWtXonRMrAqKwiWfhd/YSC529zG3/4nRAM48GHNwSn8xQolP6tB0Q/+sKtFKrOP6
        wpfgKQAiXaiWTilcb/HlwQqzBxjlmV5lbojcfJRI/L0MPYNY7Gu9kU30Sbv1ghJMZ9MJLm
        V8v6qDBUQPRQbdCUhbzxQFm0x+JHYdwATFBFJKg1h0G2noMJQkn3ab/luWkPFBzX2Ko3U6
        /pEoV6jtbOMcZxQceOH/hn3URcV0B80JI1ApSbx7oqzKn8RTVcRa7ggrv/N+lg==
Subject: Re: Filesystem corruption after unreachable storage
From:   Jean-Louis Dupond <jean-louis@dupond.be>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
 <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
Message-ID: <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
Date:   Tue, 25 Feb 2020 14:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

FYI,

Just did same test with e2fsprogs 1.45.5 (from buster backports) and 
kernel 5.4.13-1~bpo10+1.
And having exactly the same issue.
The VM needs a manual fsck after storage outage.

Don't know if its useful to test with 5.5 or 5.6?
But it seems like the issue still exists.

Thanks
Jean-Louis

On 20/02/2020 17:14, Jean-Louis Dupond wrote:
>
> On 20/02/2020 16:50, Theodore Y. Ts'o wrote:
>> On Thu, Feb 20, 2020 at 10:08:44AM +0100, Jean-Louis Dupond wrote:
>>> dumpe2fs -> see attachment
>> Looking at the dumpe2fs output, it's interesting that it was "clean
>> with errors", without any error information being logged in the
>> superblock.  What version of the kernel are you using?  I'm guessing
>> it's a fairly old one?
> Debian 10 (Buster), with kernel 4.19.67-2+deb10u1
>>> Fsck:
>>> # e2fsck -fy /dev/mapper/vg01-root
>>> e2fsck 1.44.5 (15-Dec-2018)
>> And that's a old version of e2fsck as well.  Is this some kind of
>> stable/enterprise linux distro?
> Debian 10 indeed.
>>> Pass 1: Checking inodes, blocks, and sizes
>>> Inodes that were part of a corrupted orphan linked list found.  Fix? 
>>> yes
>>>
>>> Inode 165708 was part of the orphaned inode list.  FIXED.
>> OK, this and the rest looks like it's relating to a file truncation or
>> deletion at the time of the disconnection.
>>
>>   > > > On KVM for example there is a unlimited timeout (afaik) until 
>> the
>>>>> storage is
>>>>> back, and the VM just continues running after storage recovery.
>>>> Well, you can adjust the SCSI timeout, if you want to give that a 
>>>> try....
>>> It has some other disadvantages? Or is it quite safe to increment 
>>> the SCSI
>>> timeout?
>> It should be pretty safe.
>>
>> Can you reliably reproduce the problem by disconnecting the machine
>> from the SAN?
> Yep, can be reproduced by killing the connection to the SAN while the 
> VM is running, and then after the scsi timeout passed, re-enabled the 
> SAN connection.
> Then reset the machine, and then you need to run an fsck to have it 
> back online.
>>                         - Ted
