Return-Path: <linux-ext4+bounces-2627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B28CC23D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7764B1F225FA
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9FA13FD91;
	Wed, 22 May 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G46JFn8v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147913F44F
	for <linux-ext4@vger.kernel.org>; Wed, 22 May 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384987; cv=none; b=kFJWMcoorE8w11stzLwo859AFehX6nORWaa6lpBox5PuTFL36rPWcECH02Z9WmWDgI70LwileIShar22obb6SC6zxjjRin3ST1zW+y+iOK0ka0/qnPRBS2jbtIaSOe31MDd59wEycSeS/ygZEQhLiE825CLg95jolNn5TSC4O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384987; c=relaxed/simple;
	bh=X2q+erCbtf0RX//GWfLitE9ugYmfB1kEk0t5QNdVhLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0mxAL4OyjX/b60Zdn61+q9vplT/tDbyTTWHQJyijqC6fPTybVEZwEhRIJDDmExc6cHCseRZjtBlKeSgchzcuTvPloIsBi6pHZO48GfTlplYnZBQAdwEM9QoYkSpjFsw2mb4SAkmFjN3SNfW2H47HruKPsNh3GetEC3kRUgpJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G46JFn8v; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jack@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716384982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rf2l+EHzhy6R8RE6vUeAIdMlv+BvfdFWYb4Q53DjI38=;
	b=G46JFn8v39NdRGMGD8xcLanitZUpg1k4yR0eYud2rHt+Q0xg2M6dKHfTYqgI/S3JgVW7vo
	5GdO4vMb+e1/ks2hUAxLhy5QP3CUtyJu9+l8Yjm3pa5zI91xpoCj8rh38e345XrjQOfTgn
	pxTRFbutsFXl1eEvdWO4+Mf8QEnT+jM=
X-Envelope-To: jack@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Jan Kara
 <jack@suse.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] jbd2: reset fast commit offset only after fs
 cleanup is done
In-Reply-To: <20240522104500.z343a6xqfduuq5i3@quack3> (Jan Kara's message of
	"Wed, 22 May 2024 12:45:00 +0200")
References: <20240521154535.12911-1-luis.henriques@linux.dev>
	<20240521154535.12911-3-luis.henriques@linux.dev>
	<20240522104500.z343a6xqfduuq5i3@quack3>
Date: Wed, 22 May 2024 14:36:20 +0100
Message-ID: <87le42dl4b.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Wed 22 May 2024 12:45:00 PM +02, Jan Kara wrote;

> On Tue 21-05-24 16:45:35, Luis Henriques (SUSE) wrote:
>> When doing a journal commit, the fast journal offset (journal->j_fc_off) is
>> set to zero too early in the process.  Since ext4 filesystem calls function
>> jbd2_fc_release_bufs() in its j_fc_cleanup_callback (ext4_fc_cleanup()),
>> that call will be a no-op exactly because the offset is zero.
>> 
>> Move the fast commit offset further down in the journal commit code, until
>> it's mostly done, immediately before clearing the on-going commit flags.
>> 
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Did you see any particular failure because of this? Because AFAICS the
> buffers cleaned up by jbd2_fc_release_bufs() are only allocated during fast
> commit (from ext4_fc_reserve_space()). And the code in
> jbd2_journal_commit_transaction() is making sure fast commit isn't running
> before we set journal->j_fc_off to 0.

No, I did not see any failure caused by this, this patch is simply based
on my understanding of the code after spending some time reviewing it.

The problem I saw was that jbd2_journal_commit_transaction() will run the
clean-up callbacks, which includes ext4_fc_cleanup().  One of the first
things that this callback will do is to call jbd2_fc_release_bufs().
Because journal->j_fc_off is zero, this call is useless:

	j_fc_off = journal->j_fc_off;

	for (i = j_fc_off - 1; i >= 0; i--) {
		[...]
	}

(It's even a bit odd to start the loop with 'i = -1'...)

So the question is whether this call is actually useful at all.  Maybe the
thing to do is to simply remove the call to jbd2_fc_release_bufs()?  (And
in that case, remove the function too, as this is the only call site.)

Cheers,
-- 
Luis

>
> 								Honza
>
>> ---
>>  fs/jbd2/commit.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>> index 75ea4e9a5cab..88b834c7c9c9 100644
>> --- a/fs/jbd2/commit.c
>> +++ b/fs/jbd2/commit.c
>> @@ -435,7 +435,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>  			commit_transaction->t_tid);
>>  
>>  	write_lock(&journal->j_state_lock);
>> -	journal->j_fc_off = 0;
>>  	J_ASSERT(commit_transaction->t_state == T_RUNNING);
>>  	commit_transaction->t_state = T_LOCKED;
>>  
>> @@ -1133,6 +1132,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>  		  journal->j_commit_sequence, journal->j_tail_sequence);
>>  
>>  	write_lock(&journal->j_state_lock);
>> +	journal->j_fc_off = 0;
>>  	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
>>  	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
>>  	spin_lock(&journal->j_list_lock);
>> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

