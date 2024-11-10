Return-Path: <linux-ext4+bounces-5014-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2BD9C31BB
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2024 12:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A4B1F21406
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2024 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A43145A07;
	Sun, 10 Nov 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dybdal.dk header.i=@dybdal.dk header.b="iCaK3wMC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailout1.arrowmail.co.uk (mailout1.arrowmail.co.uk [185.119.111.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD90146A6C
	for <linux-ext4@vger.kernel.org>; Sun, 10 Nov 2024 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.111.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731236538; cv=none; b=D/67lv5uquPOs94YWJ+AyXb+qWcq1NEk7RbUj42ewoB38BzqK5+a/bWagjcdjHpwn6+IMaB6OYss9j8PBZ2N3F79bBQbG7b0KvYi9p8bHxx10daHmPjTi1W3boT2z2L1vz3hvHqd/uvaiFYt21OgFGCpQCVcfAMYXiS3U2Bs84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731236538; c=relaxed/simple;
	bh=3z4t4hzRjCSLsXUwgmO0y0o1+tki17R+pMRl8pCJXfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vte9zEKGcLCo/ifK6mvNoOdTSdnM7b2/Tk+77CP2TNI1Vpt6IlZW36+s2NQMn1YJmTFxO6aJuWt10W5IwuL7wBgiXVkvlVLixtJuqiIPIpoJ2xG76a+l+6gutulKFFk64/+BPF4V8WC+TyC1YfCJK+B9bQOaVv9TKI4oHfLBtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dybdal.dk; spf=pass smtp.mailfrom=dybdal.dk; dkim=pass (2048-bit key) header.d=dybdal.dk header.i=@dybdal.dk header.b=iCaK3wMC; arc=none smtp.client-ip=185.119.111.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dybdal.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dybdal.dk
Received: from london1.hm by mailout1.arrowmail.co.uk with ESMTPA id md5001013139906.msg; 
	Sun, 10 Nov 2024 10:56:56 +0000
X-Spam-Processed: mailout1.arrowmail.co.uk, Sun, 10 Nov 2024 10:56:56 +0000
	(not processed: spam filter heuristic analysis disabled)
X-MDArrival-Date: Sun, 10 Nov 2024 10:56:56 +0000
X-Return-Path: jd-ext4@dybdal.dk
X-Envelope-From: jd-ext4@dybdal.dk
X-MDaemon-Deliver-To: linux-ext4@vger.kernel.org
Received: from londonsh1.arrowmail.co.uk (londonsh1.arrowmail.co.uk [185.119.111.203])
	by london1.hm with ESMTPSA
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
	; Sun, 10 Nov 2024 10:56:53 +0000
Received: from nuser.dybdal.dk [(212.60.124.34)] by londonsh1.arrowmail.co.uk with ESMTPSA id md5001017330669.msg; 
	Sun, 10 Nov 2024 10:56:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by nuser.dybdal.dk (Postfix) with ESMTP id 4XmV3g4TVMz3wYXc;
	Sun, 10 Nov 2024 11:56:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dybdal.dk; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received; s=
	dybdal-20171111; t=1731236190; x=1733050591; bh=fpiktcA3dEI+4c8P
	MT94K+Uslq4uMiXvDhrkO+OtcYo=; b=iCaK3wMCUnExRc6h1BCXEuH878TfQItB
	3Z9Yo3U8d9PtueytodQYFAx0BceEkL22ygTGfF8W794pn6qEYC7ceHpPzSGl4PhR
	arT/PJ4K70dXZL+WY6VldCH3Da90MErn4nNt/f8CZ640lGlRL32yfVoud9+zgKAh
	h/E4pK7MdbP264BOtdwP829aL51QB9bx0EpJTQ9d/QRraaYP54BvnDrXDUoFwS/b
	k/APAPgacpumEOt0gqh7w5yWiYFjmVzox6+DiqnWNtMvpeCTG8ckgHYNma/WeF30
	/9m4XDA31sdtFt7IEIBAOIyHZ2YjGkJ3lT0ne6osPXOLcWB53Zb/ZA==
X-Virus-Scanned: Debian amavis at nuser.dybdal.dk
Received: from [10.148.46.2] (spir.h.dybdal.dk [10.148.46.2])
	(Authenticated sender: jdimap)
	by nuser.dybdal.dk (Postfix) with ESMTPSA id 4XmV3f3Z3zz3wYVg;
	Sun, 10 Nov 2024 11:56:30 +0100 (CET)
Message-ID: <6fb25d99-3a1f-456d-8b68-fc20d8ee80b9@dybdal.dk>
Date: Sun, 10 Nov 2024 11:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corrupted i_blocks field
Content-Language: en-US
To: linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger@dilger.ca>
References: <ec9c3d81-dd5e-4a80-9148-1e0b24cddd1e@dybdal.dk>
 <20F34363-9EA4-40D0-B06E-1B35406448EF@dilger.ca>
 <220ff9f5-2f0a-4ccc-aee3-9a2cac947e9c@dybdal.dk>
From: Jesper Dybdal <jd-ext4@dybdal.dk>
In-Reply-To: <220ff9f5-2f0a-4ccc-aee3-9a2cac947e9c@dybdal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AM-Processed: #bu-mo1# #sh-lsh1# 

On 2024-10-01 00:13, Jesper Dybdal wrote:
> On 2024-09-30 22:29, Andreas Dilger wrote:
>> On Sep 27, 2024, at 8:38 AM, Jesper Dybdal<jd-ext4@dybdal.dk> wrote:
>>> I have now a few times experienced a problem with the i_blocks field of a few inodes being corrupted (replaced by extremely large numbers).
>>>
>>> I don't believe that it is a disk error - the file system is on a RAID1 partition and the RAID consistency is checked regularly.
>>> I also find it hard to believe that it is a RAM error - the machine has run memtest86+ overnight without finding anything.
>>>
>>> The files I've seen corrupted are simple small text files that are modified only using an ordinary text editor (emacs).
>>>
>>> Fsck fixes it.
>>> The system is an up-to-date Debian Bookworm:
>>>      Linux nuser 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux
>>>
>>> I do one thing that is not the default for ext4: I use the "nodelalloc" option (because several years ago, there was a discussion about "delalloc or not" from which I got the impression that nodelalloc was probably slightly safer - if the resulting performance reduction is not a problem, which it is not for me):
>>>       /dev/md0 on / type ext4 (rw,relatime,nodelalloc,errors=remount-ro)
>>>
>>> Three examples follow below.  Note that the bad field values, when interpreted as 48-bit signed numbers, are numerically small negative numbers (-25, -9, -3, respectively).
>>>
>>> Excerpts from the fsck logs:
>>> root: Inode 10748715, i_blocks is 281474976710631, should be 5. FIXED.
>>> root: Inode 10751288, i_blocks is 281474976710647, should be 3. FIXED.
>>> root: Inode 10748542, i_blocks is 281474976710653, should be 1. FIXED.
>>>
>>> I don't know when the first two of these corruptions occurred, but the last one happened yesterday or the day before.  The file in question was /etc/fstab, and I discovered the problem after I had edited fstab on Wednesday and rebooted on Thursday.
>>>
>>> The corrupted files can be read and copied without problems.  I have not dared to delete any of those files before fsck had fixed them.
>>>
>>> What is going on here?
>> This looks like an underflow of the used blocks count on the inode:
>>
>>      281474976710631 = 0xffffffffffe7
>>      281474976710647 = 0xfffffffffff7
>>      281474976710653 = 0xfffffffffffd
>>
>> This is 2^48 blocks, which is the limit for the number of blocks that fit
>> into the available inode fields (32-bit i_blocks_lo, 16-bit i_blocks_hi).
>>
>> There is likely some kind of accounting error in the code.  Is anything
>> unusual with access patterns for those files (large xattrs/ACLs, are they
>> files or directories or special files. mmap, truncate, fallocate, etc.)?
> No.  They are all simple small text configuration files, and I edit 
> them using Emacs.  The only slightly unusual thing is, as I wrote 
> earlier, that the file system is mounted with the nodelalloc option.
>
> The files I have identified are fstab and  two postfix configuration 
> files: /etc/postfix/{main.cf,master.cf} .  The problem has actually 
> hit master.cf twice.
>
> I have verified that the only reboot that happened between the fstab 
> edit on Wednesday and  seeing the problem Thursday, was a clean 
> deliberate reboot - no power outage of similar.
>> If you are able to reproduce with the /etc/fstab editing, possibly strace
>> could help to identify if something unusual is being done to the file.
> I'll try, but I do not really expect Emacs to do strange things to the 
> file

It happened again, and this time it affected no less than 30 files. And 
this time, the bad i_blocks values (when interpreted as a signed number) 
were not all negative.  Also, this time it did not affect only very 
small files.  There is a list at the end of this message.

It happened early this morning when the Debian "unattended upgrade" 
functionality upgraded the system to Debian 12.8 and automatically 
rebooted.  So it seems that it happens in connection with reboots 
(automatic or manual), and mostly affects files that have been modified 
recently - the earliest modification time was October 18. I had some 
time ago turned delalloc on in order to use settings that most people 
use, so it should be a perfectly normal ext4 file system with default 
settings.

For some reason it only affects files on the md0 file system - there is 
also an md1 on the same disks which seems to have no such problems.

I have now set the mount count of the md0 partition to 1, so it will be 
checked on every boot.

But I would really appreciate it if somebody who knows the ext4 code 
could explain what is happening - and tell me whether these incorrect 
i_blocks values are dangerous.

The kernel versions before and after the upgrade were:
6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 (2024-09-30) 
x86_64 GNU/Linux
6.1.0-27-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.115-1 (2024-11-01) 
x86_64 GNU/Linux

Thanks,
Jesper

Here is a list of the 30 files, with fsck log lines merged with info 
about the files:

root: Inode 10748775, i_blocks is 281474976710654, should be 1. FIXED.
  10748775      4 -rw-r--r--   1 root     root         2238 Oct 24 23:56 
/etc/fail2ban/jail.local

root: Inode 10749866, i_blocks is 281474976710628, should be 1. FIXED.
  10749866      4 -rw-r--r--   1 root     root            5 Nov 10 06:41 
/etc/letsencrypt/webroot/.well-known/acme-challenge/test

root: Inode 10750308, i_blocks is 281474976710651, should be 5. FIXED.
  10750308     20 -rw-r--r--   1 root     root        17145 Oct 18 12:30 
/etc/postfix/main.cf

root: Inode 10750322, i_blocks is 0, should be 24.  FIXED.
  10750322     12 -rw-r--r--   1 root     root        10782 Oct 17 23:57 
/etc/postfix/master.cf

root: Inode 10751867, i_blocks is 281474976710652, should be 1. FIXED.
  10751867      4 -rw-r--r--   1 root     root         1827 Oct 27 18:52 
/etc/postfix/sender_access

root: Inode 13503081, i_blocks is 0, should be 8.  FIXED.
  13503081      4 -rwxr-xr-x   1 root     staff          43 Oct 20 13:13 
/usr/local/bin/di

root: Inode 13506953, i_blocks is 281474976710653, should be 1. FIXED.
  13506953      4 -rwx------   1 root     root          283 Oct 20 13:32 
/usr/local/sbin/mailspamstatus

root: Inode 13514123, i_blocks is 281474976710655, should be 1. FIXED.
  13514123      4 -rwxr-xr-x   1 root     staff          66 Oct 20 13:14 
/usr/local/sbin/dmarcdig

root: Inode 20709497, i_blocks is 281474976710642, should be 1. FIXED.
  20709497      4 -rw-r--r--   1 root     root          627 Nov 10 04:25 
/root/.wget-hsts

root: Inode 20710430, i_blocks is 281474976710654, should be 1. FIXED.
  20710430      4 -rw-r--r--   1 root     root          273 Nov 10 01:00 
/root/relays/relays-all.txt

root: Inode 20710440, i_blocks is 281474976710654, should be 1. FIXED.
  20710440      4 -rw-r--r--   1 root     root          183 Nov 10 01:01 
/root/relays/relays-em.txt

root: Inode 20710442, i_blocks is 281474976710654, should be 1. FIXED.
  20710442      4 -rw-r--r--   1 root     root          170 Nov 10 01:01 
/root/relays/relays-ak.txt

root: Inode 26738965, i_blocks is 9472, should be 9760.  FIXED.
  26738965   4880 -rw-r--r--   1 root     root      4990910 Nov 10 10:47 
/var/lib/smartmontools/attrlog.WDC_WD40EFZX_68AWUN0-WD_WX52D62RAX00.ata.csv

root: Inode 26738966, i_blocks is 9472, should be 9760.  FIXED.
  26738966   4880 -rw-r--r--   1 root     root      4990905 Nov 10 10:47 
/var/lib/smartmontools/attrlog.WDC_WD40EFZX_68AWUN0-WD_WX42D52AYR2E.ata.csv

root: Inode 26739233, i_blocks is 281474976710547, should be 4. FIXED.
  26739233     12 -rw-------   1 postfix  postfix     12288 Nov 10 10:42 
/var/lib/postfix/smtp_scache.db

root: Inode 26746338, i_blocks is 163264, should be 163312.  FIXED.
  26746338  81656 -rw-------   1 amavis   amavis   83611648 Nov 10 11:01 
/var/lib/amavis/.spamassassin/bayes_seen

root: Inode 26746343, i_blocks is 281474976710436, should be 1. FIXED.
  26746343      4 -rw-r--r--   1 amavis   amavis        999 Nov 10 06:38 
/var/lib/amavis/.razor/server.c302.cloudmark.com.conf

root: Inode 26746345, i_blocks is 281474976710427, should be 1. FIXED.
  26746345      4 -rw-r--r--   1 amavis   amavis        999 Nov 10 06:04 
/var/lib/amavis/.razor/server.c301.cloudmark.com.conf

root: Inode 26746346, i_blocks is 281474976709985, should be 1. FIXED.
  26746346      4 -rw-r--r--   1 amavis   amavis         57 Nov 10 06:38 
/var/lib/amavis/.razor/servers.catalogue.lst

root: Inode 26746347, i_blocks is 281474976710429, should be 1. FIXED.
  26746347      4 -rw-r--r--   1 amavis   amavis        999 Nov 10 06:04 
/var/lib/amavis/.razor/server.c303.cloudmark.com.conf

root: Inode 26746349, i_blocks is 281474976709981, should be 1. FIXED.
  26746349      4 -rw-r--r--   1 amavis   amavis         76 Nov 10 06:38 
/var/lib/amavis/.razor/servers.nomination.lst

root: Inode 27000902, i_blocks is 37344, should be 37384.  FIXED.
  27000902  18692 -rw-r--r--   1 minidlna minidlna 19136512 Nov 10 09:17 
/var/cache/minidlna/files.db

root: Inode 27001023, i_blocks is 1768, should be 1808.  FIXED.
  27001023    904 -rw-rw-r--   1 root     utmp       921600 Nov 10 09:17 
/var/log/wtmp

root: Inode 27001185, i_blocks is 56, should be 64.  FIXED.
  27001185     32 -rw-r--r--   1 root     root        25612 Oct 31 06:43 
/var/log/dpkg.log.1

root: Inode 27001253, i_blocks is 23720, should be 55152.  FIXED.
  27001253  27576 -rw-rw----   1 root     utmp     28232064 Oct 31 23:59 
/var/log/btmp.1

root: Inode 27001462, i_blocks is 400, should be 408.  FIXED.
  27001462    204 -rw-r--r--   1 root     root       204239 Nov 10 04:25 
/var/log/nuser-blocked

root: Inode 27001550, i_blocks is 112, should be 128.  FIXED.
  27001550     64 -rw-r--r--   1 root     root        58918 Nov 10 00:54 
/var/log/samba/log.samba-dcerpcd

root: Inode 27001552, i_blocks is 144, should be 168.  FIXED.
  27001552     84 -rw-r--r--   1 root     root        79569 Nov 10 00:54 
/var/log/samba/log.rpcd_winreg

root: Inode 27001579, i_blocks is 5664, should be 7656.  FIXED.
  27001579   3828 -rw-r--r--   1 root     root      3912616 Oct 18 00:00 
/var/log/atop/atop_20241017

root: Inode 27001641, i_blocks is 128, should be 160.  FIXED.
  27001641     80 -rw-r--r--   1 root     root        73910 Nov 10 00:54 
/var/log/samba/log.rpcd_classic

-- 
Jesper Dybdal
https://www.dybdal.dk





