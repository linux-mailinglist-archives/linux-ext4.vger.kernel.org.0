Return-Path: <linux-ext4+bounces-11795-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 074FDC50198
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 370C74E66B0
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 23:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA212EDD50;
	Tue, 11 Nov 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pgyH4533"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43412E975F
	for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905372; cv=none; b=I17OQHUcE2BoKu8mGxlKO9Sae11ZwkR1PNt7wnD4YTdMITOJpVQhzH4nCBSokmi6y7BtKYRr7njxZgHvAcweZIKiXWxCADdQc8PKeqUvvZxZohDagZw4R6SU+wzouZteUdKPmOr4yDdm05ASNUFxV7AMNNcsS8xPRUJJhA4x4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905372; c=relaxed/simple;
	bh=V7lqaORY13jdcbkQEvKnjzzIQsMG1zkCaOpl643v+/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4j0NajmEy8aTaZqpjKsaZKAfqib0g05mXS2ODFLzycDj6qGYHqyPFWeAKjp7gDRh296+Vej/tG8EQC/ovf1pe76PZ8QvGuLumF4mMQGtn+D32hn6ovmqnKf4C87LhiKDbbgkSuemcJuxEAzjt7Wsoh69au1ew5ZdvVnyEWPtwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pgyH4533; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ABNsqN2007851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 18:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762905296; bh=IEhZCiRNjHSpJW4/0o8Nhs80bNQUsZLsSRSzAibyQAA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pgyH4533BOtMMzmYa869FZFPsJpE4tzycitYk07TtWVz7X44vyqiqVa9XNkc78dT1
	 rQjhZB095xKmjvI/Eo8N00oAK5bJo3DbFy/rmCxjSdPa0F44uwi5N0Wnc6jscfPnsm
	 iJMJUMqTQ42AutyUTgRw89djnyi3tgtiFUlYdoopsu/Bf2OrZsrQfxfam4YhidcZU/
	 KkCY83c0ui6uJwZ4OU6yxVN7CeTE/UqrAI4AoDPDgMm5qZmDeBWkuifycDA6PVZWMp
	 Agj5o/rD6byjbID6/1m1yVqKdIeLQTA41SnOARvX4x04H7HWd8g81HMNmUx2rqFE5m
	 2wNmVWpzn4aKQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5C7822E00D9; Tue, 11 Nov 2025 18:54:52 -0500 (EST)
Date: Tue, 11 Nov 2025 18:54:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Message-ID: <20251111235452.GM2988753@mit.edu>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-1-libaokun@huaweicloud.com>

On Fri, Nov 07, 2025 at 10:42:25PM +0800, libaokun@huaweicloud.com wrote:
> `kvm-xfstests -c ext4/all -g auto` has been executed with no new failures.
> `kvm-xfstests -c ext4/64k -g auto` has been executed and no Oops was
> observed, but allocation failures for large folios may trigger warn_alloc()
> warnings.

I'm seeing some new failures.  ext4/4k -g auto is running without any
failures, but when I tried to run ext4/64, I got:

ext4/64k: 607 tests, 16 failures, 101 skipped, 7277 seconds
  Failures: ext4/033 generic/472 generic/493 generic/494 generic/495
    generic/496 generic/497 generic/554 generic/569 generic/620
    generic/636 generic/641 generic/643 generic/759 generic/760
  Flaky: generic/251: 80% (4/5)
Totals: 671 tests, 101 skipped, 79 failures, 0 errors, 6782s

Some of the test failures may be because I was only using a 5G test
and scratch device, and with a 64k block sze, that might be too small.
But I tried using a 20G test device, and ext3/033 is still failing but
with a different error signature:

    --- tests/ext4/033.out      2025-11-06 22:04:13.000000000 -0500
    +++ /results/ext4/results-64k/ext4/033.out.bad      2025-11-11 17:57:31.149710364 -0500
    @@ -1,6 +1,8 @@
     QA output created by 033
     Figure out block size
     Format huge device
    +mount: /vdf: fsconfig() failed: Structure needs cleaning.
    +       dmesg(1) may have more information after failed mount system call.


I took a look at the generc/472 and that appears to be a swap on file failure:

root@kvm-xfstests:~# /vtmp/mke2fs.static -t ext4 -b 65536 -Fq /dev/vdc
Warning: blocksize 65536 not usable on most systems.
/dev/vdc contains a ext4 file system
        created on Tue Nov 11 18:02:13 2025
root@kvm-xfstests:~# mount /dev/vdc /vdc
root@kvm-xfstests:~# fallocate -l 1G /vdc/swap
root@kvm-xfstests:~# mkswap /vdc/swap
mkswap: /vdc/swap: insecure permissions 0644, fix with: chmod 0600 /vdc/swap
Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=a6298248-abf1-42a1-b124-2f6b3be7f597
root@kvm-xfstests:~# swapon /vdc/swap
swapon: /vdc/swap: insecure permissions 0644, 0600 suggested.
swapon: /vdc/swap: swapon failed: Invalid argument
root@kvm-xfstests:~# 

A number of the other tests (generic/493, generic/494, generic/495,
generic/496, generic/497, generic/554) are all swapfile tests.

I'm not sure why you're not seeing these issues; what version of
xfstests are you using?  I recently uploaded a new test appliance[1]
can you try rerunning your tests with the latest test appliance for
kvm-xfstests?

[1] https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests;

					- Ted

