Return-Path: <linux-ext4+bounces-1848-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367DB897359
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDCF1F224D1
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C15149DF1;
	Wed,  3 Apr 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIu7MqSz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D52149DE8
	for <linux-ext4@vger.kernel.org>; Wed,  3 Apr 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156637; cv=none; b=UvERfKqfEWaXTTxdnCr+gUTItHq2AX/bEXy0VPJ7oIVqbnF7Vz00cXe+ZufMJCodMQ64m9D1S3aQmwMwARusshKUJdKm6S0HdQFIhWtAx0t0qTiT3Ud3wvgyBcFDomWa9EYfJXI8v3+yQr0y19UYrUCi/IaQUA/gxoFxnp0o86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156637; c=relaxed/simple;
	bh=74fO4i7bCDBQQ/4Fu684cBzhMVbFqrOBydZLe7udOC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oIIomnSCRgg0eCsH9HUnIPKVw8gzk2Gfs3cQ9zXOAgQsPVEQMtCfSwTANAULcvX0QQDX/e6YTubIBXl871K8hOcMq7RWOPGTGel6Dphx26voQ0KyW3hDRwKAhwjYNqNZrOl26+0ehrEeOuGqwG2I5XyIaQTLAZnERbjm8kjN9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIu7MqSz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712156632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLheOA3BO3UCe+2JAUm2izS75yYFLsQrkLBzSXO0jCI=;
	b=fIu7MqSzSJMQMsWgauEE1TLR+km07CdJRiDZs7U7xxKVpjUVEoL5JaAjz+5RWrEP8OOfPD
	bp/dStr9/68fEv+OJwLHgnwJpwi7+7deGGNkL3lm4r8yQaoguTrvFkR62ByrSLQqM4gMSK
	Ayn7UYK42NgRJJGkfrzPdT+ib+sot2U=
From: Luis Henriques <luis.henriques@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,  linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] tests: new test to check quota after directory
 optimization
In-Reply-To: <87il0zhms9.fsf@brahms.olymp> (Luis Henriques's message of "Tue,
	02 Apr 2024 15:17:10 +0100")
References: <20240328172940.1609-1-luis.henriques@linux.dev>
	<20240328172940.1609-4-luis.henriques@linux.dev>
	<D4FC7B67-F06B-493C-BCB7-29BD4A7D255F@dilger.ca>
	<87il0zhms9.fsf@brahms.olymp>
Date: Wed, 03 Apr 2024 16:03:49 +0100
Message-ID: <87r0fm5vze.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Luis Henriques <luis.henriques@linux.dev> writes:

> Andreas Dilger <adilger@dilger.ca> writes:
>
>> On Mar 28, 2024, at 11:29 AM, Luis Henriques (SUSE) <luis.henriques@linux.dev> wrote:
>>> 
>>> This new test validates e2fsck by verifying that quota data is updated
>>> after a directory optimization is performed.  It mimics fstest ext4/014
>>> by including a filesystem image where a file is created inside a new
>>> directory on the filesystem root and then root block 0 is wiped:
>>> 
>>>  # debugfs -w -R 'zap -f / 0' f_testnew/image
>>
>> I appreciate the test case, and I hate to be difficult, but IMHO this
>> test case is not ideal.  It is *still* reporting quota inconsistency
>> at the end, so it is difficult to see whether the patch is actually
>> improving anything or not?
>
> Maybe I misunderstood how the tests really work.  Here's what I
> understood:
>
> e2fsck is run twice.  During the first run the filesystem is recovered.
> And that's the output of expect.1 -- it reports the quota inconsistency
> because quota data needs to be fixed.  And it is fixed in that first run,
> where e2fsck returns '1' ("File system errors corrected").  The second
> time e2fsck is run (expect.2) it will do nothing, and '0' is returned
> because the filesystem hasn't been modified.
>
> Without the first patch in this series the second time e2fsck is executed
> it will still fail and report inconsistencies because the first time the
> fix wasn't correct.  (And after this second time the filesystem should
> actually be corrected, a third run of e2fsck should return '0'.)
>
>> This is because the image is testing a number of different things at
>> once (repairing the root inode, superblock, etc).  IMHO, it would be
>> better to have this test be specific to the directory shrink issue
>> (e.g. a large directory is created, many files are deleted from it,
>> then optimized), and ideally have a non-root user, group, and project
>> involved so that it is verifying that all of the quotas are updated.
>
> Right, that makes sense.  However, I'm failing to narrow the test to that
> specific case.  I've tried to create a bunch of files in a directory and
> used the debugfs 'kill_file' to remove files from that directory.
> However, in that case e2fsck isn't reporting quota inconsistencies as I
> would expect.  Which may hint at yet more quota-related bugs.  But I'm
> still looking.

OK, I _may_ have found a simple way to generate an image to test my patch.
Here's what I came up with:

    make testnew
    tune2fs -O quota f_testnew/image

    debugfs -w -R "ln lost+found foo" f_testnew/image
    debugfs -w -R "unlink lost+found" f_testnew/image

    echo "update quota on directory optimization" > f_testnew/name
    make testend
    mv f_testnew f_quota_shrinkdir

This will trigger a directory optimization after the recreation of the
lost+found directory.  Do you think this would be good enough?

Cheers,
-- 
Luis

