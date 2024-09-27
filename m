Return-Path: <linux-ext4+bounces-4363-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B01988744
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421C4B2283B
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5E18872D;
	Fri, 27 Sep 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dybdal.dk header.i=@dybdal.dk header.b="npoHMf5X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailout1.arrowmail.co.uk (mailout1.arrowmail.co.uk [185.119.111.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463913634C
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.111.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447916; cv=none; b=gPEpXpXgDpRFsU6tRvU41EPaaG8TxzyKhmS3S5XTzBqV+hWxlQwxAPCtfvuMj3ZzCsldcOImdtzTPvXSslycrhayASy1KC+r/GLZE6lD+MoWJrtSH09q8kOSQxi4Ox1g3Y+TNcZjJ3rfnqz/w7thvDpttfSj7AVMMG+p4wM/Mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447916; c=relaxed/simple;
	bh=WGE7JDrQppfvOMAG95f1OQhrqGYcemS7Y2QV9TNsiTs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ubOnW6TVIlGY3QXvJ9xGd9euLyKBcFTNwo/b0qSC+lMlOW4gnWXqy+Qjo8ukVHjUvIvzd0b9GJV7+zNCRksX+i3WpKQWUEYcm1VUnlFVm7xTTFKxvYM+hERJE836srQB8kIOnGul83oRfOl2OJ6J79xhM/7gOMgN40a+IhmrXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dybdal.dk; spf=pass smtp.mailfrom=dybdal.dk; dkim=pass (2048-bit key) header.d=dybdal.dk header.i=@dybdal.dk header.b=npoHMf5X; arc=none smtp.client-ip=185.119.111.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dybdal.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dybdal.dk
Received: from london1.hm by mailout1.arrowmail.co.uk with ESMTPA id md5001013058436.msg; 
	Fri, 27 Sep 2024 15:38:30 +0100
X-Spam-Processed: mailout1.arrowmail.co.uk, Fri, 27 Sep 2024 15:38:30 +0100
	(not processed: spam filter heuristic analysis disabled)
X-MDArrival-Date: Fri, 27 Sep 2024 15:38:30 +0100
X-Return-Path: jd-ext4@dybdal.dk
X-Envelope-From: jd-ext4@dybdal.dk
X-MDaemon-Deliver-To: linux-ext4@vger.kernel.org
Received: from seattle1.arrowmail.co.uk (seattle1.arrowmail.co.uk [162.253.155.68])
	by london1.hm with ESMTPSA
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
	; Fri, 27 Sep 2024 15:38:28 +0100
Received: from nuser.dybdal.dk [(212.60.124.34)] by seattle1.arrowmail.co.uk with ESMTPSA id md5001017166383.msg; 
	Fri, 27 Sep 2024 15:38:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by nuser.dybdal.dk (Postfix) with ESMTP id 4XFY3b1x4Jz3wZWh
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 16:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dybdal.dk; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received; s=dybdal-20171111; t=1727447882; x=
	1729262283; bh=QIxdLQSkuqCbrBNGWSOG0J/qEIl/2C3BbWNqf5KyoH8=; b=n
	poHMf5XxN9LBQhuxKc/sfTTh7sg0NpFheqxHY/9LNBnWmhoOcmaneIRF7x6KwaO3
	vBu6m19LzE0rQCz3l9OxNe0a9xBHizE5TogBtWzH2o+lVSPZNOoJ9JtNHGxGEXmO
	vaOuONXlP2dk63ke7fq6hek8b8RIUQza18PseO0+t/vct+cMDLsMZ0rojWQ6tLGg
	HDss/o820arquUe6/W93n/0PJkaZ64ZsIlnzltxTih69XUu9l3393v3l0Lwfk81M
	RskcFYU7YwggtgH0BhJYzosoqYi5fVGu8rjpGpdtYZmmqw5k7LZnxhFagD5K0pyk
	GTnGI+luSwe5y/sj2wy5w==
X-Virus-Scanned: Debian amavis at nuser.dybdal.dk
Received: from [10.148.46.2] (spir.h.dybdal.dk [10.148.46.2])
	(Authenticated sender: jdimap)
	by nuser.dybdal.dk (Postfix) with ESMTPSA id 4XFY3Z21Xkz3wZSS
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 16:38:02 +0200 (CEST)
Message-ID: <ec9c3d81-dd5e-4a80-9148-1e0b24cddd1e@dybdal.dk>
Date: Fri, 27 Sep 2024 16:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jesper Dybdal <jd-ext4@dybdal.dk>
Subject: Corrupted i_blocks field
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AM-Processed: #bu-mo1# #sh-stl1# 

I have now a few times experienced a problem with the i_blocks field of 
a few inodes being corrupted (replaced by extremely large numbers).

I don't believe that it is a disk error - the file system is on a RAID1 
partition and the RAID consistency is checked regularly.
I also find it hard to believe that it is a RAM error - the machine has 
run memtest86+ overnight without finding anything.

The files I've seen corrupted are simple small text files that are 
modified only using an ordinary text editor (emacs).

Fsck fixes it.
The system is an up-to-date Debian Bookworm:
     Linux nuser 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 
(2024-08-26) x86_64 GNU/Linux

I do one thing that is not the default for ext4: I use the "nodelalloc" 
option (because several years ago, there was a discussion about 
"delalloc or not" from which I got the impression that nodelalloc was 
probably slightly safer - if the resulting performance reduction is not 
a problem, which it is not for me):
      /dev/md0 on / type ext4 (rw,relatime,nodelalloc,errors=remount-ro)

Three examples follow below.  Note that the bad field values, when 
interpreted as 48-bit signed numbers, are numerically small negative 
numbers (-25, -9, -3, respectively).

Excerpts from the fsck logs:
root: Inode 10748715, i_blocks is 281474976710631, should be 5. FIXED.
root: Inode 10751288, i_blocks is 281474976710647, should be 3. FIXED.
root: Inode 10748542, i_blocks is 281474976710653, should be 1. FIXED.

I don't know when the first two of these corruptions occurred, but the 
last one happened yesterday or the day before.  The file in question was 
/etc/fstab, and I discovered the problem after I had edited fstab on 
Wednesday and rebooted on Thursday.

The corrupted files can be read and copied without problems.  I have not 
dared to delete any of those files before fsck had fixed them.

What is going on here?

Thanks,
Jesper

-- 
Jesper Dybdal
https://www.dybdal.dk





