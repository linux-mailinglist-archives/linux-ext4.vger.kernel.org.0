Return-Path: <linux-ext4+bounces-4403-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627098AFC1
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 00:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1024F1F23F31
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 22:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9E188704;
	Mon, 30 Sep 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dybdal.dk header.i=@dybdal.dk header.b="guUKqH8r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from londonsh2.arrowmail.co.uk (londonsh2.arrowmail.co.uk [185.119.111.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9117BB38
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.111.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734683; cv=none; b=C1veqZEeX4eQGSf1muSpOyqew1FVOrimcZMu1c/kSlbVTQw61GJblLmM6NnX45SpphelDhw8XY0cLAUicaw7qXiZEg8Ma6rFhh/33XAfrQa7XiY383lI+lHYHNrk5tt3t3VTWnVKVm2F3Ab0RcHhH9FLTX07spG/sf2s12ID0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734683; c=relaxed/simple;
	bh=LCV5A9bXi4WD4F8DludWQjYzpY4cExQkG96PZrKGqn4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VDOeA/Rb8tD8WHltuzj+dAFX8wGyFyIX1SNTAA1FLmpMRoapXqubZWc6Zj6+80jBtL16xUZHugKpWXS3i79LnoTfPfsBdmJPrUtpd1d/bb6314QNL2tPhz5keDdm9ET1g/cuMCAT62mpV9PCa53qvJ1OOQu97ytBN4tpxvKwDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dybdal.dk; spf=pass smtp.mailfrom=dybdal.dk; dkim=pass (2048-bit key) header.d=dybdal.dk header.i=@dybdal.dk header.b=guUKqH8r; arc=none smtp.client-ip=185.119.111.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dybdal.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dybdal.dk
Received: from nuser.dybdal.dk [(212.60.124.34)] by londonsh2.arrowmail.co.uk with ESMTPSA id md5001019085289.msg; 
	Mon, 30 Sep 2024 23:17:54 +0100
X-MDRemoteIP: 212.60.124.34
X-MDHelo: nuser.dybdal.dk
X-MDArrival-Date: Mon, 30 Sep 2024 23:17:54 +0100
X-Authenticated-Sender: sh1678@arrowmail.co.uk
X-Return-Path: jd-ext4@dybdal.dk
X-Envelope-From: jd-ext4@dybdal.dk
X-MDaemon-Deliver-To: linux-ext4@vger.kernel.org
Received: from localhost (localhost [127.0.0.1])
	by nuser.dybdal.dk (Postfix) with ESMTP id 4XHb6m4vMRz3wZY7;
	Tue,  1 Oct 2024 00:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dybdal.dk; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received; s=
	dybdal-20171111; t=1727734671; x=1729549072; bh=pD6UoLkuJ3WFOA6X
	7A00z26zD//c/xZ9nin416ikwtw=; b=guUKqH8rtlNqkvHtXHVZ/VUe1OIiSDKe
	haGZ8C9mcNf76TH6wdWLlkH2qVDTkVdXKjquzCuxpx9yi7sTCgQBetvctiG+q3cw
	JnX4yDG3oJ3TzwCqLTIf/LHmKcdSNA4C7WVsJSiVs3V5KeKDAGuXGfgWHrbBmo/G
	n5KFJEcC9ktYCodaTjftqdzsAZYWZcOdswKNfKRyuQ3oCGfU1fW1J8nsXl09nOoA
	gYK5iHMlF8i/PHyp21mEH3gnecNylCEpq/sOvRIBFFaQepEs/b1tzR40JzM8LhGb
	O8vRxkvZUbTSJFveQufHoEMMX+VcmbbgxUuZ3Cc9dU0JxPAWJbFMlw==
X-Virus-Scanned: Debian amavis at nuser.dybdal.dk
Received: from [10.148.46.2] (spir.h.dybdal.dk [10.148.46.2])
	(Authenticated sender: jdimap)
	by nuser.dybdal.dk (Postfix) with ESMTPSA id 4XHb6l40CZz3wZSS;
	Tue,  1 Oct 2024 00:17:51 +0200 (CEST)
Message-ID: <7669753e-ec6c-421a-a132-3ae00b3b3db9@dybdal.dk>
Date: Tue, 1 Oct 2024 00:17:51 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jesper Dybdal <jd-ext4@dybdal.dk>
Subject: Re: Corrupted i_blocks field
To: linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger@dilger.ca>
References: <ec9c3d81-dd5e-4a80-9148-1e0b24cddd1e@dybdal.dk>
 <20F34363-9EA4-40D0-B06E-1B35406448EF@dilger.ca>
Content-Language: en-US
In-Reply-To: <20F34363-9EA4-40D0-B06E-1B35406448EF@dilger.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AM-Processed: #sh-lsh2# 

On 2024-09-30 22:29, Andreas Dilger wrote:
> On Sep 27, 2024, at 8:38 AM, Jesper Dybdal<jd-ext4@dybdal.dk>  wrote:
>> I have now a few times experienced a problem with the i_blocks field of a few inodes being corrupted (replaced by extremely large numbers).
>>
>> I don't believe that it is a disk error - the file system is on a RAID1 partition and the RAID consistency is checked regularly.
>> I also find it hard to believe that it is a RAM error - the machine has run memtest86+ overnight without finding anything.
>>
>> The files I've seen corrupted are simple small text files that are modified only using an ordinary text editor (emacs).
>>
>> Fsck fixes it.
>> The system is an up-to-date Debian Bookworm:
>>      Linux nuser 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux
>>
>> I do one thing that is not the default for ext4: I use the "nodelalloc" option (because several years ago, there was a discussion about "delalloc or not" from which I got the impression that nodelalloc was probably slightly safer - if the resulting performance reduction is not a problem, which it is not for me):
>>       /dev/md0 on / type ext4 (rw,relatime,nodelalloc,errors=remount-ro)
>>
>> Three examples follow below.  Note that the bad field values, when interpreted as 48-bit signed numbers, are numerically small negative numbers (-25, -9, -3, respectively).
>>
>> Excerpts from the fsck logs:
>> root: Inode 10748715, i_blocks is 281474976710631, should be 5. FIXED.
>> root: Inode 10751288, i_blocks is 281474976710647, should be 3. FIXED.
>> root: Inode 10748542, i_blocks is 281474976710653, should be 1. FIXED.
>>
>> I don't know when the first two of these corruptions occurred, but the last one happened yesterday or the day before.  The file in question was /etc/fstab, and I discovered the problem after I had edited fstab on Wednesday and rebooted on Thursday.
>>
>> The corrupted files can be read and copied without problems.  I have not dared to delete any of those files before fsck had fixed them.
>>
>> What is going on here?
> This looks like an underflow of the used blocks count on the inode:
>
>      281474976710631 = 0xffffffffffe7
>      281474976710647 = 0xfffffffffff7
>      281474976710653 = 0xfffffffffffd
>
> This is 2^48 blocks, which is the limit for the number of blocks that fit
> into the available inode fields (32-bit i_blocks_lo, 16-bit i_blocks_hi).
>
> There is likely some kind of accounting error in the code.  Is anything
> unusual with access patterns for those files (large xattrs/ACLs, are they
> files or directories or special files. mmap, truncate, fallocate, etc.)?
No.  They are all simple small text configuration files, and I edit them 
using Emacs.  The only slightly unusual thing is, as I wrote earlier, 
that the file system is mounted with the nodelalloc option.

The files I have identified are fstab and  two postfix configuration 
files: /etc/postfix/{main.cf,master.cf} .  The problem has actually hit 
master.cf twice.

I have verified that the only reboot that happened between the fstab 
edit on Wednesday and  seeing the problem Thursday, was a clean 
deliberate reboot - no power outage of similar.
> If you are able to reproduce with the /etc/fstab editing, possibly strace
> could help to identify if something unusual is being done to the file.
I'll try, but I do not really expect Emacs to do strange things to the file
> Cheers, Andreas

Thanks,
Jesper

-- 
Jesper Dybdal
https://www.dybdal.dk



