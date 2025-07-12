Return-Path: <linux-ext4+bounces-8944-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3EB0295E
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 06:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D401D4A8407
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A071F2B88;
	Sat, 12 Jul 2025 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shUTryzB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2702C9D
	for <linux-ext4@vger.kernel.org>; Sat, 12 Jul 2025 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752294439; cv=none; b=cte10JGj2EKpLh8W1mLRDEqDurvLvHyU5LLa7bNs7SkSAGjGucfKQtba5qNV3vNCB1Pa4AHv4824SKINvaJoHkX2XT17QpxzAulzk2jR+NXNSoNyhLEJ6TMllLRM2RBcJunSy/aWZHq5faKvER/6Iatx//adEDMSTzPUVmuPGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752294439; c=relaxed/simple;
	bh=inn7fyxpO7Md0SIm7c6ektwOBL9mYCa6AAuG97SIU9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYxacxnvAQ1shqDifBQlN8Y4KXVB9kJlGP9M4Rf34Qx6eqWsM5vHDADgACVLqkvn8QGU3r/nxw6Met6OojaSNXscUi7bmOPdftoMdn/v+JLVELPOTFaJF4JuVUe4Q3ShVyTphIv/nC8nZdf7Otbcg6cJzYGp0Gg6C1dHnq5DemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shUTryzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F39FC4CEEF;
	Sat, 12 Jul 2025 04:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752294435;
	bh=inn7fyxpO7Md0SIm7c6ektwOBL9mYCa6AAuG97SIU9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shUTryzB0SOErHnbSo41pdyJHyjP9tnkUARbFkd8IDWFKQP8n6cYslnuEwYGzMEJj
	 W7pSXPSPsqL6cRF8CEHAqBmKG0ipMYT4yr8oaFy8dZdahNBocXtgxdAx1QLJKwjGqD
	 IZ3N5ArTAw6dJNcjzl1/HxN4uRjGDMBOrSdoNKWfktO58NlycVJNi+C5RiTvd8AasD
	 JZQBqgyiWauuODfePNAxRUDtOxA17JiFyLaBFZA+bfSIUDQ8VOOCxAHuwWVTC08vGs
	 VJPhKnzxwAI+QmrdOmbE3LhNWFq7IKIrKJuRaT+CZZVH8gGzEJ6flAkav48brAWGUB
	 hvKPENttZx6/Q==
Date: Fri, 11 Jul 2025 21:27:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jiany Wu <wujianyue000@gmail.com>, yi.zhang@huawei.com, jack@suse.cz,
	linux-ext4@vger.kernel.org
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
Message-ID: <20250712042714.GG2672022@frogsfrogsfrogs>
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu>
 <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
 <20250711154012.GB4040@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711154012.GB4040@mit.edu>

On Fri, Jul 11, 2025 at 11:40:12AM -0400, Theodore Ts'o wrote:
> On Fri, Jul 11, 2025 at 05:56:18PM +0800, Jiany Wu wrote:
> > Hello, Ted,
> > 
> > Thanks indeed for the help, really appreciated!
> > BTW, is it proper to fallocate whole disk space to exhaust disk?
> 
> I'm not sure what do you mean by "proper".  It depends on what you are
> trying to do, I suppose.
> 
> The other thing here is I think you are seriously confusing yourself
> (and others) by using a loopback file image which si mounted.  That's
> because now you need worry about failures at two levels; at the level
> of the storage device containing the image (e.g., /tmp for the image
> /tmp/mydisk) and the loopback file system (e.g., /mnt/tmp when
> /tmp/mydisk is mounted on top of /mnt/tmp).  You could potentially
> have ENOSPC errors at either level.

Honestly it's really too bad that there's no way for an fs to ask the
block device how much space it thinks is available, and then teach its
own statfs method to return min(fs space available, bdev space
availble).

Then at least df could report that your 500T ramdisk filesystem on a 4G
/tmp really only has 4G of space available.

> > I see even fallocate full disk size, seems file size equal to avail
> > size still can be allocated.
> > i.e. When /tmp availability space is 26G, but fallocate requests 32G
> > (total disk space), we see it finally allocated a 26G file, but exit
> > code is 1.
> 
> You're being ambiguous here.  When you say "full disk sice", which
> level are you talking about?  /tmp or /mnt/test?  And when you
> fallocate, which are you fallocating.
> 
> What I would recommend is to fallocate *first* at the /mnt/mydisk
> level.  So do this:
> 
> # fallocate -l 32G /tmp/mydisk
> # mkfs.ext4 /tmp/mydisk
> 
> If /tmp only has 26GB of free space, then the fallocate will fail ---
> but that's fine.  That tells you that you don't have enough free space
> to fully allocate the file system image.  So *stop*, and do this
> somewhere you have enough free space:
> 
> # fallocate -l 32G /mnt/huge-10TB-disk-with-lots-of-free-space/mydisk
> # mkfs.ext4 /mnt/huge-10TB-disk-with-lots-of-free-space/mydisk
> 
> Now you know that no matter what, when you mount mydisk, you don't
> need to worry about I/O errors when writing to mydisk.  And you can
> proceed with your experimentation.
> 
> 
> Now, what if you don't have that huge 10TB disk.  Can you use
> /tmp/mydisk to create a 32TB file system even though /tmp only has
> 26GB of free space.  You *can*. but you need to be careful, because
> eventually when you start writing to the mounted file system, you will
> eventually run out of space in /tmp.
> 
> For example:
> 
> % cp /dev/null /tmp/test.img
> % ls -lsh /tmp/test.img
> 0 -rw-r--r-- 1 tytso tytso 0 Jul 11 11:19 /tmp/test.img
> % mkfs.ext4 -q /tmp/test.img 32G
> % ls -lsh /tmp/test.img
> 6.4M -rw-r--r-- 1 tytso tytso 32G Jul 11 11:19 /tmp/test.img
> 
> So you can see here that we have created a test file system which is
> 32 GiB in size, but so far, the actual amount of *space* consumed in
> /tmp is 6.4 MiB.  The i_size of the file is 32 GiB, but it is a sparse
> file, which means not all of the blocks between logical offset 0 and
> 32 GiB have been allocated.
> 
> Now, if we mount the file system, as we start writing into the file,
> we will allocate space in /tmp.  Now, the way fallocate works in the
> mounted file system is that it guarantees space in the file system,
> but it won't write the data blocks, so space confusmed in /tmp by
> /tmp/mydisk will grow only by the space needed when we updated the
> metadata blocks in the file system contained in /tmp/mydisk.
> 
> % sudo mount /tmp/test.img /mnt/test
> % df -h /mnt/test
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop1       32G  2.1M   30G   1% /mnt/test
> % sudo fallocate -l 16G /mnt/test/testfile
> 1093% df -h /mnt/test
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop1       32G   17G   14G  55% /mnt/test
> % ls -lsh /mnt/test/testfile
> 17G -rw-r--r-- 1 root root 16G Jul 11 11:25 /mnt/test/testfile
> % ls -lsh /tmp/test.img
> 7.5M -rw-r--r-- 1 tytso tytso 32G Jul 11 11:25 /tmp/test.img
> 
> So here, we fallocated 16GB in the file system in /tmp/test.img.  You
> can see that it created a file which is 16GB in size, but which is a
> bit more than 16GB once you include the metadata blocks for
> /tmp/test/testfile.  That's why the space used is 17GB (the ls program
> rounded up) but the i_size is 16GB.
> 
> *But* the space consumed by the file /tmp/test.img only went up from
> 6.4 MiB to 7.5 MiB.  That's because although we reserved space in the
> file system /tmp/test.img, we didn't reserve any space in /tmp.
> 
> This is working as intended; and if what you are doing is "thin
> provisioning", this is a feature, but a bug.
> 
> But what it means is that if /tmp only has 26GB of space, eventually
> if you keep writing to /tmp/test.img, there will be block level errors
> in the loop device when /tmp runs out of space.  That was what you saw
> in your original example:
> 
> Jul 08 05:43:07 testbed kernel: loop: Write error at byte offset 274432, length 1024.
> 
> As soon as there are block I/O errors in the underlying file system,
> all bets are off.  There could be data loss (if you had been writing
> to a data block when /tmp ran out of space) or file system corruption
> (if the kernel had been trying to write a metadata block when /tmp ran
> out of space), or possibly both.  So as soon as you see block I/O
> errors, don't assume that file system is unscathed, because you
> probably *will* have lost data or have a corrupted file sytem.
> 
> > Is it legal usage or will it trigger some unknown issue? I'm a newbie
> > on fallocate:)
> 
> So it's *legal* to do thin provisioning; if you are trying to test a
> very large file system, and you don't have enough space, then you
> might not have a choice.  Or if you are trying to be more efficient,
> it mgiht allow you to allow users to *think* they have more space than
> you actually have purchased, since very often, users don't artually
> use; they just want to feel good that they have the space.
> 
> And if you have a large number of users, thin provisioning might make
> sense because it saves money.  But it's much like a bank which has
> lent out money that depositors have on deposit, relying on the fact
> that it is very rare that all of the depositors will suddenly show up
> and withdraw all of their money all at the same time.  If that
> happens, then you have a run on the bank, and there could be civil
> unrest, and things get ugly.  Which is why after bank runs, government
> regulartors will demand that banks keep more money on reserve, which
> lowers their profits and makes the bank's shareholders sad --- but
> better that than angry bank customers.  :-)

LOL SVB :(

--D

> So if you know what you are doing, it *can* work.  But it might
> trigger an issue which is unknown/unexpected for you, even though for
> soemone who understands how things work it makes perfect sense and is
> the system working as designed.
> 
> If you have lots of disk space, then just use fallocate to allocate
> space for /tmp/mydisk, and then you can use fallocate to allocate
> space for the file system contained in /tmp/mydisk.  And it will all
> work, but it will require more disk space to be available in /tmp.
> 
> Cheers,
> 
> 						- Ted
> 

