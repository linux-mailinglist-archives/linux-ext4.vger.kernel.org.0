Return-Path: <linux-ext4+bounces-3568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 773FD942D0B
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 13:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12670B23F4A
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A108C1AC42F;
	Wed, 31 Jul 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spornkuller.de header.i=@spornkuller.de header.b="xjdUgq4Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from spornkuller.de (spornkuller.de [89.58.8.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296F18DF9F
	for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.8.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424590; cv=none; b=WYXmO+Wd7wS4HEMNG7aK7ZbuG5SqBzm7RGN130ZDtkP5rdY+kIyYNnr9XBmjKos/cCLYcRXqlDOpBa8eVehW4Kw/dLI/SUvN0XykcW1MgRkJEj+xzkxB/8J9VynJ7HQyMe0OX3pmTclNHbo9ZKivi/sw5k2dFx2IqPBwM67M9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424590; c=relaxed/simple;
	bh=zbEjxCZVGBUmwA87aZbZaTk4s+I0CsrucyYxqk3bWK0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aT/AjeP1w9QcEOn9R4ZTfFj3kBOIJT353xgCfrGi15ELDbi4H0hc0AhOws5DQXOPHf+Xo2qYnCuPG4LWQYmQHD0c1ZLCqbA/4JVOQxxj0GDXgm0TFWRc3dsNLa5F+GE6FbDPLndyJYT72FKYDRLP0yCJfhs8zo6eT8mFQ/AhwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spornkuller.de; spf=pass smtp.mailfrom=spornkuller.de; dkim=pass (2048-bit key) header.d=spornkuller.de header.i=@spornkuller.de header.b=xjdUgq4Y; arc=none smtp.client-ip=89.58.8.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spornkuller.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spornkuller.de
Received: from [IPV6:2a00:79c0:768:fd01:b3aa:d19e:128f:14c] (unknown [IPv6:2a00:79c0:768:fd01:b3aa:d19e:128f:14c])
	by spornkuller.de (Postfix) with ESMTPSA id B170C636FCB
	for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 13:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spornkuller.de;
	s=dkim202204; t=1722424586;
	bh=zbEjxCZVGBUmwA87aZbZaTk4s+I0CsrucyYxqk3bWK0=;
	h=Date:To:From:Subject:From;
	b=xjdUgq4Y3kVIYr4LknFXjc843JCinPL1DxRGUeT95UJR4a0OfGhIRMB7efNXLVwIG
	 a5G0bi0qyUIk+jR5PslNEcWCNIDcW4bHttgUk3WETnm+5V3lPKSTEzvCIQPtKx/BFm
	 hY0IsUai6sYdH1tlFxnHZ/zUXGvB0slG894fk08ysEj3OuaKOE6/lrDFeCaK9VayPp
	 eEMnurakbW3Q5FBLW0rqk+mh458HrbH1I9RVO8p5BonidpBpRC/gc9ClhUBInlA3Wh
	 5KOlg+Cz+g2mN9mBMIxM5scQipTSKaL7DffYFeQIl2TzR8hznG4nrp665MmzlF/djr
	 qDqQHeeJgjmpg==
Message-ID: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>
Date: Wed, 31 Jul 2024 13:16:26 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ext4@vger.kernel.org
Content-Language: en-US
From: Johannes Bauer <canjzymsaxyt@spornkuller.de>
Subject: Modification of block device by R/O mount
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear list,

I'm a little bit puzzled by behavior of ext4 I've been seeing initially 
on aarch64 Linux 6.1 but can reproduce easily on my machine:

Linux reliant 6.5.0-28-generic #29-Ubuntu SMP PREEMPT_DYNAMIC Thu Mar 28 
23:46:48 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

The behavior I'm seeing is that a R/O mount modifies a device mapper 
block device (or loopback device), which is unsettling. That change is 
not propagated back to the original source, but it is causing massive 
problems nevertheless. For example:

reliant [/tmp/ext4test]: dd if=/dev/null bs=1M seek=64 count=0 of=image.img
0+0 records in
0+0 records out
0 bytes copied, 2,2172e-05 s, 0,0 kB/s


reliant [/tmp/ext4test]: mkfs.ext4 image.img
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done
Creating filesystem with 16384 4k blocks and 16384 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done



reliant [/tmp/ext4test]: losetup --read-only --show -f image.img
/dev/loop28


reliant [/tmp/ext4test]: md5sum /dev/loop28 image.img
34d7cd8eb4abb1943aabe078b8fb3c74  /dev/loop28
34d7cd8eb4abb1943aabe078b8fb3c74  image.img


reliant [/tmp/ext4test]: mkdir mnt; mount -o ro /dev/loop28 mnt


reliant [/tmp/ext4test]: md5sum /dev/loop28 image.img
9145654c1e6a5855c1db239815a05198  /dev/loop28
34d7cd8eb4abb1943aabe078b8fb3c74  image.img


reliant [/tmp/ext4test]: cmp /dev/loop28 image.img
/dev/loop28 image.img differ: byte 61484, line 5


reliant [/tmp/ext4test]: umount mnt; losetup -d /dev/loop28


reliant [/tmp/ext4test]: md5sum image.img
34d7cd8eb4abb1943aabe078b8fb3c74  image.img


As you can see, the original image was never modified (MD5 34d7... 
remains the same) but /dev/loop28 changes once R/O mounted. This 
behavior is shocking to me and I've not observed this with other file 
systems (I tried btrfs) so this seems to be ext4-specific.

Is this expected behavior? Is there a way to mitigate it?

Thanks and best regards,
Johannes

-- 
"A PC without Windows is like a chocolate cake without mustard."


