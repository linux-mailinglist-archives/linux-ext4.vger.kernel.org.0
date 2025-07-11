Return-Path: <linux-ext4+bounces-8939-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF1B0209F
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42FC1CA2F89
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470532ED17D;
	Fri, 11 Jul 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fRGgJjMP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A402ED17B
	for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248440; cv=none; b=pC8ljpFA6c6rYolZlRdu+25w+yFauU/eWn/YGB8kh86A78hFIkexTsZm6OLIw02nE0+nXMFJnm0j1u5NSjFd1tYRIKp2Qwsf68nxdzjLlr8FRhQY78oUpcWrc7isWpyk1DWkX27wdWsvzKxoa4QngfZDeJ9YpJ9X1y9zVnxKd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248440; c=relaxed/simple;
	bh=ipRUvdUowFyjsUXcjsJUitmsicp1KjlTeOhAk7EiMg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtDtJbTSKjjLElQNdbLPW9p5tlVQ3dlMwPMLB9hPfo7fR/i0+Xf9uatIL0eeYX72cgN3tG1QnNS3PrDLmp+2NIvRf/rndjhIcCkcG9r4pfrzVXwHnl/ifLkAGpbzTvFZbOWDS3GL20qJr/lFtZ+u9eak18FPrAVe3RlbQ3Se1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fRGgJjMP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (guestnat-104-133-8-96.corp.google.com [104.133.8.96] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56BFeDSM020486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 11:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752248416; bh=iTL2UHKW3ViWvf+aTD0RINRmlqsnOxPQG1T969x9ROs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fRGgJjMPhNpICVpDcCEEojC5g68kjJkQ84Xg5y6aRod22iNE8jwfFmVUvd7umdad2
	 gbrBrj1hg+1cZfn6tDX/D0PB8UjpyFpUjsdiyJfkNSALVAiT3cZirvHmaO4mR35E0D
	 yqJySjhxqOI62in7769ZBMVBWSjFfGjKLEu9NzpL9Hv1xlBAaT9O6MgW0evms4GQpj
	 NpiBR5RXsBobNPjSBNuEM6YnZ+WQKogxSM+i/HwnEx2GbJI5P9D1fAMjwHqG7aJWC1
	 cSNXWBUA8RO10FLg6cwzjg1JQGDrE6XLq9Ui5iF2UGUmaI7wd4oNkIIDDeO18LyW+5
	 D57YwksuQ/Z8g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id F2F803406BB; Fri, 11 Jul 2025 11:40:12 -0400 (EDT)
Date: Fri, 11 Jul 2025 11:40:12 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiany Wu <wujianyue000@gmail.com>
Cc: yi.zhang@huawei.com, jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
Message-ID: <20250711154012.GB4040@mit.edu>
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu>
 <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>

On Fri, Jul 11, 2025 at 05:56:18PM +0800, Jiany Wu wrote:
> Hello, Ted,
> 
> Thanks indeed for the help, really appreciated!
> BTW, is it proper to fallocate whole disk space to exhaust disk?

I'm not sure what do you mean by "proper".  It depends on what you are
trying to do, I suppose.

The other thing here is I think you are seriously confusing yourself
(and others) by using a loopback file image which si mounted.  That's
because now you need worry about failures at two levels; at the level
of the storage device containing the image (e.g., /tmp for the image
/tmp/mydisk) and the loopback file system (e.g., /mnt/tmp when
/tmp/mydisk is mounted on top of /mnt/tmp).  You could potentially
have ENOSPC errors at either level.

> I see even fallocate full disk size, seems file size equal to avail
> size still can be allocated.
> i.e. When /tmp availability space is 26G, but fallocate requests 32G
> (total disk space), we see it finally allocated a 26G file, but exit
> code is 1.

You're being ambiguous here.  When you say "full disk sice", which
level are you talking about?  /tmp or /mnt/test?  And when you
fallocate, which are you fallocating.

What I would recommend is to fallocate *first* at the /mnt/mydisk
level.  So do this:

# fallocate -l 32G /tmp/mydisk
# mkfs.ext4 /tmp/mydisk

If /tmp only has 26GB of free space, then the fallocate will fail ---
but that's fine.  That tells you that you don't have enough free space
to fully allocate the file system image.  So *stop*, and do this
somewhere you have enough free space:

# fallocate -l 32G /mnt/huge-10TB-disk-with-lots-of-free-space/mydisk
# mkfs.ext4 /mnt/huge-10TB-disk-with-lots-of-free-space/mydisk

Now you know that no matter what, when you mount mydisk, you don't
need to worry about I/O errors when writing to mydisk.  And you can
proceed with your experimentation.


Now, what if you don't have that huge 10TB disk.  Can you use
/tmp/mydisk to create a 32TB file system even though /tmp only has
26GB of free space.  You *can*. but you need to be careful, because
eventually when you start writing to the mounted file system, you will
eventually run out of space in /tmp.

For example:

% cp /dev/null /tmp/test.img
% ls -lsh /tmp/test.img
0 -rw-r--r-- 1 tytso tytso 0 Jul 11 11:19 /tmp/test.img
% mkfs.ext4 -q /tmp/test.img 32G
% ls -lsh /tmp/test.img
6.4M -rw-r--r-- 1 tytso tytso 32G Jul 11 11:19 /tmp/test.img

So you can see here that we have created a test file system which is
32 GiB in size, but so far, the actual amount of *space* consumed in
/tmp is 6.4 MiB.  The i_size of the file is 32 GiB, but it is a sparse
file, which means not all of the blocks between logical offset 0 and
32 GiB have been allocated.

Now, if we mount the file system, as we start writing into the file,
we will allocate space in /tmp.  Now, the way fallocate works in the
mounted file system is that it guarantees space in the file system,
but it won't write the data blocks, so space confusmed in /tmp by
/tmp/mydisk will grow only by the space needed when we updated the
metadata blocks in the file system contained in /tmp/mydisk.

% sudo mount /tmp/test.img /mnt/test
% df -h /mnt/test
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1       32G  2.1M   30G   1% /mnt/test
% sudo fallocate -l 16G /mnt/test/testfile
1093% df -h /mnt/test
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1       32G   17G   14G  55% /mnt/test
% ls -lsh /mnt/test/testfile
17G -rw-r--r-- 1 root root 16G Jul 11 11:25 /mnt/test/testfile
% ls -lsh /tmp/test.img
7.5M -rw-r--r-- 1 tytso tytso 32G Jul 11 11:25 /tmp/test.img

So here, we fallocated 16GB in the file system in /tmp/test.img.  You
can see that it created a file which is 16GB in size, but which is a
bit more than 16GB once you include the metadata blocks for
/tmp/test/testfile.  That's why the space used is 17GB (the ls program
rounded up) but the i_size is 16GB.

*But* the space consumed by the file /tmp/test.img only went up from
6.4 MiB to 7.5 MiB.  That's because although we reserved space in the
file system /tmp/test.img, we didn't reserve any space in /tmp.

This is working as intended; and if what you are doing is "thin
provisioning", this is a feature, but a bug.

But what it means is that if /tmp only has 26GB of space, eventually
if you keep writing to /tmp/test.img, there will be block level errors
in the loop device when /tmp runs out of space.  That was what you saw
in your original example:

Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset 274432, length 1024.

As soon as there are block I/O errors in the underlying file system,
all bets are off.  There could be data loss (if you had been writing
to a data block when /tmp ran out of space) or file system corruption
(if the kernel had been trying to write a metadata block when /tmp ran
out of space), or possibly both.  So as soon as you see block I/O
errors, don't assume that file system is unscathed, because you
probably *will* have lost data or have a corrupted file sytem.

> Is it legal usage or will it trigger some unknown issue? I'm a newbie
> on fallocate:)

So it's *legal* to do thin provisioning; if you are trying to test a
very large file system, and you don't have enough space, then you
might not have a choice.  Or if you are trying to be more efficient,
it mgiht allow you to allow users to *think* they have more space than
you actually have purchased, since very often, users don't artually
use; they just want to feel good that they have the space.

And if you have a large number of users, thin provisioning might make
sense because it saves money.  But it's much like a bank which has
lent out money that depositors have on deposit, relying on the fact
that it is very rare that all of the depositors will suddenly show up
and withdraw all of their money all at the same time.  If that
happens, then you have a run on the bank, and there could be civil
unrest, and things get ugly.  Which is why after bank runs, government
regulartors will demand that banks keep more money on reserve, which
lowers their profits and makes the bank's shareholders sad --- but
better that than angry bank customers.  :-)

So if you know what you are doing, it *can* work.  But it might
trigger an issue which is unknown/unexpected for you, even though for
soemone who understands how things work it makes perfect sense and is
the system working as designed.

If you have lots of disk space, then just use fallocate to allocate
space for /tmp/mydisk, and then you can use fallocate to allocate
space for the file system contained in /tmp/mydisk.  And it will all
work, but it will require more disk space to be available in /tmp.

Cheers,

						- Ted

