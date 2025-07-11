Return-Path: <linux-ext4+bounces-8934-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E68B012B1
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 07:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D07A39B2
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B41C3C14;
	Fri, 11 Jul 2025 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="S8B+Wy3k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8C14A60F
	for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211765; cv=none; b=pepKZl+OQX2kh/Loss0bUaytLiIPLE39/f9a3WLf2Cgaqf6Co2DmVKGsuATPY1c+D9Sz1vLAKy1j1VzVfp1gL+k/Ikr8KIQAPI/drJW3L2AmTFRbHfULm1ht2iXjh+RF4wQTYZZ8eNRLl+HLhkQ2URqUPPkemwXZF0MAa5RRpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211765; c=relaxed/simple;
	bh=B1wLL9eJ+JWmUSLYd4dQCYCR1bSC2QpwA2hlyKt2exo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhvZ6kh1zF6wbwbMygj+wJwRaJTxDnguhXANXhPco3Z+UUIbI4Uy1qB4E+dl/dutzPKIep9aoFkpvpj7FLZqkhsNkM8fP1HDwXQPGre4TaERQndx7uvbqS9fHmI8tWmxpvKkvO7RgMHVaGpnH2BjfWcojJNmSQA/qXU4Fbo0gIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=S8B+Wy3k; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.0.67.227])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56B5T6x7028787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 01:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752211749; bh=TpbIwDMo6YwUROOaCLvTTRHvr9H84FDUOl4YEOeVGIk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=S8B+Wy3k2/ggw9TTHW+qwsCDBSsGFkjGjVZcUkLzVLCK81URy1/NG5qe27DMS+cbI
	 4+YmxD0VlKb1GItZZWpQl8OwQfVAQDQNN4yqq2MJSIPvirDmWMcWBHLIbIkxrNxOBb
	 /JcyEcxhCAgFtnUUIpa7UxClT5fZoL9uvKS/Z4/P8y43sk6Vk9upIZLXWk3UL2ZRjN
	 vI0z7cVakiUO1kGJ1+GNGoj3CBC61XujAPWSD0JO8sgDo5UJwQ48qU2KncUAhJx+8w
	 qciX9ZkWlXHAME/io/UM8lOZxbZqy4hYybMYJZSgSChOO8LIhTlYvmGEvKrFZ7/18L
	 c1i/XaBkg19WQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E94A2341A7F; Fri, 11 Jul 2025 01:29:05 -0400 (EDT)
Date: Fri, 11 Jul 2025 01:29:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiany Wu <wujianyue000@gmail.com>
Cc: yi.zhang@huawei.com, jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
Message-ID: <20250711052905.GC2026761@mit.edu>
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>

On Fri, Jul 11, 2025 at 11:20:32AM +0800, Jiany Wu wrote:
> Hello,
> 
> Recently I encountered an issue in kernel 6.1.123, when writing to a
> file after disk exhaustion, it will report EFSCORRUPTED. I think it is
> un-expected behavior.

What you did was created a file system in /tmp/mydisk by creating a
sparse image file:

> root@testbed:/tmp# touch mydisk
> root@testbed:/tmp# ls -l mydisk
> -rw-r--r-- 1 root root 0 Jul  8 05:36 mydisk
> root@testbed:/tmp# truncate -s 128M mydisk
> root@testbed:/tmp# mkfs.ext4 mydisk

The potential problem is this assumes that /tmp had enough space to
write 128M of space.  But it's clear that it didn't have enough space.
Do not only did you exhaust the space in the file system, you *also*
exhausted space in /tmp.  You can see this because of the I/O errors
when writing to /dev/loop2:

> root@testbed:/tmp# mount mydisk /mnt/test_fs/
> root@testbed:/tmp# findmnt /mnt/test_fs
> TARGET       SOURCE     FSTYPE OPTIONS
> /mnt/test_fs /dev/loop2 ext4   rw,relatime
> ...
> root@testbed:/mnt/test_fs# fallocate -l 32716560K /mnt/test_fs/test_file
> fallocate: fallocate failed: No space left on device
> root@testbed:/mnt/test_fs# journalctl -f
> Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
> 9178112, length 1024.
> Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset
> 274432, length 1024.

These error messages are write errors in /dev/loop2, which were almost
certainly caused by ENOSPC errors when trying to write to /tmp/mydisk.

This is the moral equivalent of buying a fradulent USB thumb drive
from the back alleys of Shenzhen, where the USB thumb drive was
*labelled* as having 128MB of storage, but which only had 16MB of
flash, such that writes after the first 16MB would fail (or overwrite
other disk blocks).

If /tmp had enough space, then you wouldn't have see these errors.

One alternative way you could create the image would have been to replace 

> root@testbed:/tmp# touch mydisk
> root@testbed:/tmp# ls -l mydisk
> -rw-r--r-- 1 root root 0 Jul  8 05:36 mydisk
> root@testbed:/tmp# truncate -s 128M mydisk

with:

root@testbed:/tmp# dd if=/dev/zero of=mydisk bs=1M count=128

This allocates 128MB to /tmp/mydisk, and if there isn't enough space
in /tmp, the dd will fail with an error.  If it succeeds, then when
you create the file system and mount it, you won't see the error
messages writing to /dev/loopN.

The bottom line is that the bug is a PEBCAK ("probem exists between
chair and keyboard") which is another way of saying, it's a failure in
the system admisitrator not understanding that they had done something
bad.  It is not a kernel bug, but rather a bug in your procedure /
system setup.

Cheers,

						- Ted

