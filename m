Return-Path: <linux-ext4+bounces-2635-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C9C8CCEA1
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A91C20F5D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151ED13CFB7;
	Thu, 23 May 2024 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VHb0oO4z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56C13CA89
	for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454364; cv=none; b=NtoCjFOmAeT4IkVoaZwYU5H8OmHo4eKVt+v5O1gb9rSVsXp3LNWvwa+yCmib6WQFoo+khu1Ee8QyUYoSmcAAKAvkyff4v3/0NnTof+e7/6FWhPRCxL0I6rQmrSQzV4I/CtPASrvFBMSpcj9nV8QxfeOsMAo9tRNkj0AGHinHjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454364; c=relaxed/simple;
	bh=Ne8K3aZIklrSsnXiC2eKNCa51ju/79uUNxOtDo/KL88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=np3P6ozvSEpqEjBIHm6a1LedUq1YKcS+xP1W7OcBMoUfxtR6wjb56hz0gZntjcrABdJHnz4siXoA6PUUfkMZONE+N3toYbp32au6hWdRjxPzpTWyYC2JdPW2GkI4NDhjIP7oWaUbmssHXkVhzHbjd+A9mPRiH6jQxtMPeY/l4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VHb0oO4z; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716454360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wET50NqYkTKouiyULS5A8Rly72qStBQjSusl5+Kp6g=;
	b=VHb0oO4ziDGfLYG2tedWj5KU0fXc704vWqP3wZ0XLeVkY861wUWrGV4FZp3PC+Vx9rSqZ1
	SAgO6AUSMPYqWo6fteQbx36X6BV8xO1FAL7gH4dS9pDLm/x6e77efP/Tq30q2XuFfny2RA
	5wqX8MEWED6HAW9hxLEcNrZB8xUXM/Y=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: jack@suse.com
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Luis Henriques <luis.henriques@linux.dev>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Jan Kara
 <jack@suse.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] jbd2: reset fast commit offset only after fs
 cleanup is done
In-Reply-To: <20240523074434.xdpyso46v5l6qvze@quack3> (Jan Kara's message of
	"Thu, 23 May 2024 09:44:34 +0200")
References: <20240521154535.12911-1-luis.henriques@linux.dev>
	<20240521154535.12911-3-luis.henriques@linux.dev>
	<20240522104500.z343a6xqfduuq5i3@quack3> <87le42dl4b.fsf@brahms.olymp>
	<20240523074434.xdpyso46v5l6qvze@quack3>
Date: Thu, 23 May 2024 09:52:32 +0100
Message-ID: <87wmnk3o6n.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Thu 23 May 2024 09:44:34 AM +02, Jan Kara wrote;

> On Wed 22-05-24 14:36:20, Luis Henriques wrote:
>> On Wed 22 May 2024 12:45:00 PM +02, Jan Kara wrote;
>> 
>> > On Tue 21-05-24 16:45:35, Luis Henriques (SUSE) wrote:
>> >> When doing a journal commit, the fast journal offset (journal->j_fc_off) is
>> >> set to zero too early in the process.  Since ext4 filesystem calls function
>> >> jbd2_fc_release_bufs() in its j_fc_cleanup_callback (ext4_fc_cleanup()),
>> >> that call will be a no-op exactly because the offset is zero.
>> >> 
>> >> Move the fast commit offset further down in the journal commit code, until
>> >> it's mostly done, immediately before clearing the on-going commit flags.
>> >> 
>> >> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> >
>> > Did you see any particular failure because of this? Because AFAICS the
>> > buffers cleaned up by jbd2_fc_release_bufs() are only allocated during fast
>> > commit (from ext4_fc_reserve_space()). And the code in
>> > jbd2_journal_commit_transaction() is making sure fast commit isn't running
>> > before we set journal->j_fc_off to 0.
>> 
>> No, I did not see any failure caused by this, this patch is simply based
>> on my understanding of the code after spending some time reviewing it.
>> 
>> The problem I saw was that jbd2_journal_commit_transaction() will run the
>> clean-up callbacks, which includes ext4_fc_cleanup().  One of the first
>> things that this callback will do is to call jbd2_fc_release_bufs().
>> Because journal->j_fc_off is zero, this call is useless:
>> 
>> 	j_fc_off = journal->j_fc_off;
>> 
>> 	for (i = j_fc_off - 1; i >= 0; i--) {
>> 		[...]
>> 	}
>> 
>> (It's even a bit odd to start the loop with 'i = -1'...)
>> 
>> So the question is whether this call is actually useful at all.  Maybe the
>> thing to do is to simply remove the call to jbd2_fc_release_bufs()?  (And
>> in that case, remove the function too, as this is the only call site.)
>
> What is I guess confusing for you (and somewhat for me as well) is that
> journal->j_fc_cleanup_callback() gets called from __jbd2_fc_end_commit()
> *and* from jbd2_journal_commit_transaction(). I agree the
> jbd2_fc_release_bufs() is useless for the call from
> jbd2_journal_commit_transaction(), it is however needed for the call from
> __jbd2_fc_end_commit(). There are however other bits - namely the
> s_fc_dentry_q and s_fc_q list handling that need to happen both for normal
> and fast commit...

Oops!  I totally missed that second callback execution.  Yeah, it does
make sense now, of course.  Sorry for the noise and thank you for looking
into it.  I'll go back and focus on reworking on the other patch (and also
look into Harshad's patchset).

Cheers,
-- 
Luis

