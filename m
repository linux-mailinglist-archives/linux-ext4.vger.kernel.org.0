Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6EBB1659F0
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 10:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBTJO3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 04:14:29 -0500
Received: from apollo.dupie.be ([51.15.19.225]:54846 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTJO3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 04:14:29 -0500
Received: from [10.10.1.155] (systeembeheer.combell.com [217.21.177.69])
        by apollo.dupie.be (Postfix) with ESMTPSA id CDC9C800F0F;
        Thu, 20 Feb 2020 10:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
        t=1582190066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HEEXbt8gxTKEQMl+ookK41y5dC59+MGND9EOKkz818=;
        b=ccm94mrGBVAl0XXlFaI1gyiv3PR2cSKN3JGCO5qPTB6OoDH3qyjlQkaE9AHj/lrYZJNdT6
        WzMFIysLLYk3XHmI8apDZYb08AcHDRElVCJfrCSEgWqIxC4O+eAzEEW1Fhulk0hhw/e+sQ
        /BWx7SjJQggM14BOKOBx363ptOGsg/J/EgE210OgpX4FEG7dNDR2x8nsDw5V0aFB5VypAV
        3xhVUodrwYQyQNTxbrki2eM7ZUrKCrq7juoTRnskiL/CzAtzNXC/Dn2MTN+guEtgICBaSs
        M+wbjEcGIDwCRuoEsuKqsHeVleBaDKFq7Rx/kzuDOSeoCpn6oSoeJbgyt2m6/A==
Subject: Re: Filesystem corruption after unreachable storage
From:   Jean-Louis Dupond <jean-louis@dupond.be>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
Message-ID: <5657c06a-df96-5cd9-eb99-f82447981d7d@dupond.be>
Date:   Thu, 20 Feb 2020 10:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: nl-BE
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The dumpe2fs seems to get blocked.
Uploaded it here: http://dupondje.be/dumpe2fs.txt

On 20/02/2020 10:08, Jean-Louis Dupond wrote:
> As the mail seems to have been trashed somewhere, I'll retry :)
>
> Thanks
> Jean-Louis
>
>
> On 24/01/2020 21:37, Theodore Y. Ts'o wrote:
>> On Fri, Jan 24, 2020 at 11:57:10AM +0100, Jean-Louis Dupond wrote:
>>> There was a short disruption of the SAN, which caused it to be 
>>> unavailable
>>> for 20-25 minutes for the ESXi.
>> 20-25 minutes is "short"? I guess it depends on your definition / 
>> POV. :-)
> Well more downtime was caused to recover (due to manual fsck) then the 
> time the storage was down :)
>>
>>> What worries me is that almost all of the VM's (out of 500) were 
>>> showing the
>>> same error.
>> So that's a bit surprising...
> Indeed, that's were I thought, something went wrong here!
> I've tried to simulate it, and were able to simulate the same error 
> when we let the san recover BEFORE VM is shutdown.
> If I poweroff the VM and then recover the SAN, it does an automatic 
> fsck without problems.
> So it really seems it breaks when the VM can write again to the SAN.
>>
>>> And even some (+-10) were completely corrupt.
>> What do you mean by "completely corrupt"? Can you send an e2fsck
>> transcript of file systems that were "completely corrupt"?
> Well it was moving a tons of files to lost+found etc. So that was 
> really broken.
> I'll see if I can recover some backup of one in broken state.
> Anyway this was only a very small percentage, so worries me less then 
> the rest :)
>>
>>> Is there for example a chance that the filesystem gets corrupted the 
>>> moment
>>> the SAN storage was back accessible?
>> Hmm... the one possibility I can think of off the top of my head is
>> that in order to mark the file system as containing an error, we need
>> to write to the superblock. The head of the linked list of orphan
>> inodes is also in the superblock. If that had gotten modified in the
>> intervening 20-25 minutes, it's possible that this would result in
>> orphaned inodes not on the linked list, causing that error.
>>
>> It doesn't explain the more severe cases of corruption, though.
> If fixing that would have left us with only 10 corrupt disks instead 
> of 500, would be a big win :)
>>
>>> I also have some snapshot available of a corrupted disk if some 
>>> additional
>>> debugging info is required.
>> Before e2fsck was run? Can you send me a copy of the output of
>> dumpe2fs run on that disk, and then transcript of e2fsck -fy run on a
>> copy of that snapshot?
> Sure:
> dumpe2fs -> see attachment
>
> Fsck:
> # e2fsck -fy /dev/mapper/vg01-root
> e2fsck 1.44.5 (15-Dec-2018)
> Pass 1: Checking inodes, blocks, and sizes
> Inodes that were part of a corrupted orphan linked list found. Fix? yes
>
> Inode 165708 was part of the orphaned inode list.  FIXED.
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Block bitmap differences:  -(863328--863355)
> Fix? yes
>
> Free blocks count wrong for group #26 (3485, counted=3513).
> Fix? yes
>
> Free blocks count wrong (1151169, counted=1151144).
> Fix? yes
>
> Inode bitmap differences:  -4401 -165708
> Fix? yes
>
> Free inodes count wrong for group #0 (2489, counted=2490).
> Fix? yes
>
> Free inodes count wrong for group #20 (1298, counted=1299).
> Fix? yes
>
> Free inodes count wrong (395115, counted=395098).
> Fix? yes
>
>
> /dev/mapper/vg01-root: ***** FILE SYSTEM WAS MODIFIED *****
> /dev/mapper/vg01-root: 113942/509040 files (0.2% non-contiguous), 
> 882520/2033664 blocks
>
>>
>>> It would be great to gather some feedback on how to improve the 
>>> situation
>>> (next to of course have no SAN outage :)).
>> Something that you could consider is setting up your system to trigger
>> a panic/reboot on a hung task timeout, or when ext4 detects an error
>> (see the man page of tune2fs and mke2fs and the -e option for those
>> programs).
>>
>> There are tradeoffs with this, but if you've lost the SAN for 15-30
>> minutes, the file systems are going to need to be checked anyway, and
>> the machine will certainly not be serving. So forcing a reboot might
>> be the best thing to do.
> Going to look into that! Thanks for the info.
>>> On KVM for example there is a unlimited timeout (afaik) until the 
>>> storage is
>>> back, and the VM just continues running after storage recovery.
>> Well, you can adjust the SCSI timeout, if you want to give that a 
>> try....
> It has some other disadvantages? Or is it quite safe to increment the 
> SCSI timeout?
>>
>> Cheers,
>>
>> - Ted
>
>
