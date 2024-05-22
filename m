Return-Path: <linux-ext4+bounces-2626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D08CC200
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090EF28542E
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2024 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D013F011;
	Wed, 22 May 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vOt2aZ2Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D313E8A0
	for <linux-ext4@vger.kernel.org>; Wed, 22 May 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384115; cv=none; b=nE6B7AX9W5FCcSIE+wg4+UiJlF9w/+XlYVJPF+9OIKc/JAdp4USUycNX3jH3VGsuGSG1iX8cwiGjzBrPYwveoiiW1V6hr+p8iKQJU8iS6acF+HbaY7N5/hVT9skiEREOjPu+ul/sKQi6XlQXoknXgZkmB2aEOtUVMGETAxO0hFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384115; c=relaxed/simple;
	bh=mYSAmhsQtJ0PDxq3WdA7gK5lRtv9WoXaj1HB0gLlhTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzxRFINaIEUE7ej6/IdWuevOgiMlaKHianuUfL+GW8FzNxjOW7zdC+HC3WQM0lb9i4Y6XUMELq/uHloe6LqGnlbUmye25vxoxpqmKK7Ud3IRKfpX89/QdLHbyDDH97ADYJ7ywtZbUGVItvVo4XfKpUyfKYkWEiqPA1IIGB2p8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vOt2aZ2Y; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jack@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716384110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3U75sxnOeZdFGOwo1OVSElYeJTqXT6eZMDMxenHS3Y=;
	b=vOt2aZ2Y9/UJ1YxmIkQijMwxaEiEiRznlwvMdfhDBB9j0LYCWaPqhK4XOPVPyJVG36jIwT
	ahgBcq3oeBLlOJuBfd7AaWVeLe7jaxhxPsIDHOQygAFn/Snna7Zcb4HsplYNZSoch7vFpI
	y7JHs0igR4dZm4KpBXYdwnUAGxyp1F4=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: jack@suse.com
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: linux-ext4@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Jan Kara
 <jack@suse.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
In-Reply-To: <20240522103545.ypmmoyxvls52i6yl@quack3> (Jan Kara's message of
	"Wed, 22 May 2024 12:35:45 +0200")
References: <20240521154535.12911-1-luis.henriques@linux.dev>
	<20240521154535.12911-2-luis.henriques@linux.dev>
	<20240522103545.ypmmoyxvls52i6yl@quack3>
Date: Wed, 22 May 2024 14:21:47 +0100
Message-ID: <87pltedlsk.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Wed 22 May 2024 12:35:45 PM +02, Jan Kara wrote;

> On Tue 21-05-24 16:45:34, Luis Henriques (SUSE) wrote:
>> When a full journal commit is on-going, any fast commit has to be enqueued
>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
>> is done only once, i.e. if an inode is already queued in a previous fast
>> commit entry it won't be enqueued again.  However, if a full commit starts
>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
>> be done into FC_Q_STAGING.  And this is not being done in function
>> ext4_fc_track_template().
>
> Ah, good catch.
>
>> This patch fixes the issue by simply re-enqueuing the inode from the MAIN
>> into the STAGING queue.
>> 
>> This bug was found using fstest generic/047.  This test creates several 32k
>> bytes files, sync'ing each of them after it's creation, and then shutting
>> down the filesystem.  Some data may be loss in this operation; for example a
>> file may have it's size truncated to zero.
>> 
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>>  fs/ext4/fast_commit.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>> 
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 87c009e0c59a..337b5289cf11 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -396,12 +396,19 @@ static int ext4_fc_track_template(
>>  		return ret;
>>  
>>  	spin_lock(&sbi->s_fc_lock);
>> -	if (list_empty(&EXT4_I(inode)->i_fc_list))
>> -		list_add_tail(&EXT4_I(inode)->i_fc_list,
>> -				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>> -				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>> -				&sbi->s_fc_q[FC_Q_STAGING] :
>> -				&sbi->s_fc_q[FC_Q_MAIN]);
>> +	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>> +	    sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
>> +		if (list_empty(&EXT4_I(inode)->i_fc_list))
>> +			list_add_tail(&EXT4_I(inode)->i_fc_list,
>> +				      &sbi->s_fc_q[FC_Q_STAGING]);
>> +		else
>> +			list_move_tail(&EXT4_I(inode)->i_fc_list,
>> +				       &sbi->s_fc_q[FC_Q_STAGING]);
>
> So I'm not sure this is actually safe. I'm concerned about the following
> race:
>
> Task1					Task2
>
> 					handle = ext4_journal_start(..)
> modify inode_X
>   ext4_fc_track_inode(inode_X)
> ext4_fsync(inode_X)
>   ext4_fc_commit()
>     jbd2_fc_begin_commit()
>       journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
>       ...
>       jbd2_journal_lock_updates()
>         blocks waiting for handle of Task2
> 					modify inode_X
> 					  ext4_fc_track_inode(inode_X)
> 					    - moves inode out of FC_Q_MAIN
> 					ext4_journal_stop()
>     fast commit proceeds but skips inode_X...

Hmm... I see, the problem is deeper that I thought.

> How we deal with a similar issue in jbd2 for ordinary buffers is that we
> just mark the buffer as *also* belonging to the next transaction (by
> setting jh->b_next_transaction) and during commit cleanup we move the bh to
> the appropriate list of the next transaction. Here, we could mark the inode
> as also being part of the next fast commit and during fastcommit cleanup we
> could move it to FC_Q_STAGING which is then spliced back to FC_Q_MAIN.

Yeah, I guess that would work.  I'll need to add a new field to flag the
'next commit' in struct ext4_inode_info.  I'll need to play a bit with it
and see what I can came up with.  Thanks for the suggestion.

> Also Harshad has recently posted changes to fast commit code that modify
> how fast commits are serialized (in particular jbd2_journal_lock_updates()
> is gone). I didn't read them yet but your change definitely needs a careful
> verification against those changes to make sure we don't introduce new data
> integrity issues.
>

Right, I saw his patchset only after sending my RFC (and I should have
probably included him on the CC as well; probably get_maintainer.pl isn't
picking his email).

I'll need to look at those changes too, which will probably take me some
time as most of that code isn't familiar to me.

Thanks a lot for your review, Jan.  Much appreciated.

Cheers,
-- 
Luis

>> +	} else {
>> +		if (list_empty(&EXT4_I(inode)->i_fc_list))
>> +			list_add_tail(&EXT4_I(inode)->i_fc_list,
>> +				      &sbi->s_fc_q[FC_Q_MAIN]);
>> +	}
>>  	spin_unlock(&sbi->s_fc_lock);
>>  
>>  	return ret;
>
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

