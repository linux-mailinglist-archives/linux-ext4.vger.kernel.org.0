Return-Path: <linux-ext4+bounces-1824-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A82895672
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536AF283331
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C48615C;
	Tue,  2 Apr 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ENyzKiD1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EF80BEE
	for <linux-ext4@vger.kernel.org>; Tue,  2 Apr 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067439; cv=none; b=N3U/d8rdEsdbO9vTzJK8y0xgfVuiKScmvRwqNy2M0/G7C8jvscMp1Bm+h3By1NXdK5TknC5A/lhwrhddpdb3U42Do1Oz5fR4F0hdEDX3tUUU8u1A7OCOurUEreBGpfEKitR/n7L36yXQnlqeX6rPLFKXum1Ih70yxXkZyJTrtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067439; c=relaxed/simple;
	bh=qdU1LPMTceUbpTDIyrS+WI7iP0WL7bUg/Qbw9gO2TAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qzobva9CMz6SIJOy5BuLl45cw7sUs8cyxJeQtCoGlucVJqwa0iHYBbt9kaYm4qMx1Dp/jPEOafbF8HwHD6N6Q2JQdrVRKBeH2AYvkhE3yjn9txYbslPRbOvxnHrRscDIWdrPKhcac6q5N/4reMm2tt2boguHal0vFXgDKK1FvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ENyzKiD1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712067434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDKfFI/MK59Eu0ZaaJodaZdy/viIMVvvTLPpgbuTNEQ=;
	b=ENyzKiD1nYXvLZiEOspnzvQ9JhGrWP5bfuVM2oKEpGg4pNvMIaaocTXhw4rnnKBxGF7lSg
	yPb4+i3877lztLgK3rr0fQmi9zN2VdjcqrQp/SbS0dfpe/JS/Z5jWpXWYOQe2J5f+k0ULj
	2yYssK48KQlIJ6t1LGH6ISmAAYQjhso=
From: Luis Henriques <luis.henriques@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,  linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] tests: new test to check quota after directory
 optimization
In-Reply-To: <D4FC7B67-F06B-493C-BCB7-29BD4A7D255F@dilger.ca> (Andreas
	Dilger's message of "Mon, 1 Apr 2024 15:01:33 -0600")
References: <20240328172940.1609-1-luis.henriques@linux.dev>
	<20240328172940.1609-4-luis.henriques@linux.dev>
	<D4FC7B67-F06B-493C-BCB7-29BD4A7D255F@dilger.ca>
Date: Tue, 02 Apr 2024 15:17:10 +0100
Message-ID: <87il0zhms9.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Andreas Dilger <adilger@dilger.ca> writes:

> On Mar 28, 2024, at 11:29 AM, Luis Henriques (SUSE) <luis.henriques@linux.dev> wrote:
>> 
>> This new test validates e2fsck by verifying that quota data is updated
>> after a directory optimization is performed.  It mimics fstest ext4/014
>> by including a filesystem image where a file is created inside a new
>> directory on the filesystem root and then root block 0 is wiped:
>> 
>>  # debugfs -w -R 'zap -f / 0' f_testnew/image
>
> I appreciate the test case, and I hate to be difficult, but IMHO this
> test case is not ideal.  It is *still* reporting quota inconsistency
> at the end, so it is difficult to see whether the patch is actually
> improving anything or not?

Maybe I misunderstood how the tests really work.  Here's what I
understood:

e2fsck is run twice.  During the first run the filesystem is recovered.
And that's the output of expect.1 -- it reports the quota inconsistency
because quota data needs to be fixed.  And it is fixed in that first run,
where e2fsck returns '1' ("File system errors corrected").  The second
time e2fsck is run (expect.2) it will do nothing, and '0' is returned
because the filesystem hasn't been modified.

Without the first patch in this series the second time e2fsck is executed
it will still fail and report inconsistencies because the first time the
fix wasn't correct.  (And after this second time the filesystem should
actually be corrected, a third run of e2fsck should return '0'.)

> This is because the image is testing a number of different things at
> once (repairing the root inode, superblock, etc).  IMHO, it would be
> better to have this test be specific to the directory shrink issue
> (e.g. a large directory is created, many files are deleted from it,
> then optimized), and ideally have a non-root user, group, and project
> involved so that it is verifying that all of the quotas are updated.

Right, that makes sense.  However, I'm failing to narrow the test to that
specific case.  I've tried to create a bunch of files in a directory and
used the debugfs 'kill_file' to remove files from that directory.
However, in that case e2fsck isn't reporting quota inconsistencies as I
would expect.  Which may hint at yet more quota-related bugs.  But I'm
still looking.

Cheers,
-- 
Luis


