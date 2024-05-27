Return-Path: <linux-ext4+bounces-2651-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479A8CFB70
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 10:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F94B210CA
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CC53364;
	Mon, 27 May 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iTO5yAa5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AF1A2C13
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798589; cv=none; b=WDfpGU3NHLI7vwNds9g+30Z6tAXRs6//Z6QwHlDe9hzk1g7DAV//4OsxykwvW/HgskMKA/6/mPa8wWJRQprW/EL8gpW1cngi2f+H2ZHaIXDSOLtTsNAIpMIihZv2PzKz8akNDNxQ3aBsKVGc94o0KJ9280hq9uT9gCwYWnBk2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798589; c=relaxed/simple;
	bh=IRg1ZnY4ad7Grky6EACnYJ/1e7/wYjNVqwNwgDIfrEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LBFt1VJkbh8i2qrOQoLcwHzldMwfuUSQfcwiwp7FO9cR9smZjFXEeOPXOjsOl9yOAmV3fqSpY/ORShwA/FlxZbipD/O23ls/liUKCZGSIt3DzsE4EuRyyiQiHDSIctc0NmxorZ7RD611gCqoc2DB1DTSBGSmDnznamX3dJwkbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iTO5yAa5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716798585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RheZsmz5aig038SHC8M9U7tuJQE9AcezfFpXh6dMu0A=;
	b=iTO5yAa52j7cLFdsYMo7r2TiUkCcvzagZW+5ym6yCwLkyom22AOZUgDaOyflKWIJjWBWx/
	4XTyTmk+XdwWtZR/PUWpQuigNUM4Z8en53nC2KdtvgWlRdRvOlwwFn0ewFe8SIOn5S0H6D
	tmeeYR1uC8tA8mm+YokANQH5fJdOd/A=
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: jack@suse.cz
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: tytso@mit.edu
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
In-Reply-To: <20240524162231.l5r4niz7awjgfju6@quack3> (Jan Kara's message of
	"Fri, 24 May 2024 18:22:31 +0200")
References: <20240523111618.17012-1-luis.henriques@linux.dev>
	<20240524162231.l5r4niz7awjgfju6@quack3>
Date: Mon, 27 May 2024 09:29:40 +0100
Message-ID: <87h6ej64jv.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri 24 May 2024 06:22:31 PM +02, Jan Kara wrote;

> On Thu 23-05-24 12:16:18, Luis Henriques (SUSE) wrote:
>> When a full journal commit is on-going, any fast commit has to be enqueu=
ed
>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueue=
ing
>> is done only once, i.e. if an inode is already queued in a previous fast
>> commit entry it won't be enqueued again.  However, if a full commit star=
ts
>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs=
 to
>> be done into FC_Q_STAGING.  And this is not being done in function
>> ext4_fc_track_template().
>>=20
>> This patch fixes the issue by flagging an inode that is already enqueued=
 in
>> either queues.  Later, during the fast commit clean-up callback, if the
>> inode has a tid that is bigger than the one being handled, that inode is
>> re-enqueued into STAGING and the spliced back into MAIN.
>>=20
>> This bug was found using fstest generic/047.  This test creates several =
32k
>> bytes files, sync'ing each of them after it's creation, and then shutting
>> down the filesystem.  Some data may be loss in this operation; for examp=
le a
>> file may have it's size truncated to zero.
>>=20
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Thanks for the fix. Some comments below:
>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 983dad8c07ec..4c308c18c3da 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1062,9 +1062,18 @@ struct ext4_inode_info {
>>  	/* Fast commit wait queue for this inode */
>>  	wait_queue_head_t i_fc_wait;
>>=20=20
>> -	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
>> +	/*
>> +	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len,
>> +	 * i_fc_next
>> +	 */
>>  	struct mutex i_fc_lock;
>>=20=20
>> +	/*
>> +	 * Used to flag an inode as part of the next fast commit; will be
>> +	 * reset during fast commit clean-up
>> +	 */
>> +	tid_t i_fc_next;
>> +
>
> Do we really need new tid in the inode? I'd be kind of hoping we could use
> EXT4_I(inode)->i_sync_tid for this - I can see we even already set it in
> ext4_fc_track_template() and used for similar comparisons in fast commit
> code.

Ah, true.  It looks like it could be used indeed.  We'll still need a flag
here, but a simple bool should be enough for that.

>
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 87c009e0c59a..bfdf249f0783 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -402,6 +402,8 @@ static int ext4_fc_track_template(
>>  				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>>  				&sbi->s_fc_q[FC_Q_STAGING] :
>>  				&sbi->s_fc_q[FC_Q_MAIN]);
>> +	else
>> +		ei->i_fc_next =3D tid;
>>  	spin_unlock(&sbi->s_fc_lock);
>>=20=20
>>  	return ret;
>> @@ -1280,6 +1282,15 @@ static void ext4_fc_cleanup(journal_t *journal, i=
nt full, tid_t tid)
>>  	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>>  				 i_fc_list) {
>>  		list_del_init(&iter->i_fc_list);
>> +		if (iter->i_fc_next =3D=3D tid)
>> +			iter->i_fc_next =3D 0;
>> +		else if (iter->i_fc_next > tid)
> 			 ^^^ careful here, TIDs do wrap so you need to use
> tid_geq() for comparison.
>

Yikes!  Thanks, I'll update the code to do that.

>> +			/*
>> +			 * re-enqueue inode into STAGING, which will later be
>> +			 * splice back into MAIN
>> +			 */
>> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
>> +				      &sbi->s_fc_q[FC_Q_STAGING]);
>>  		ext4_clear_inode_state(&iter->vfs_inode,
>>  				       EXT4_STATE_FC_COMMITTING);
>>  		if (iter->i_sync_tid <=3D tid)
> 				     ^^^ and I can see this is buggy as
> well and needs tid_geq() (not your fault obviously).

Yeah, good point.  I can that too in v3.

Again, thanks a lot for your review!

Cheers,
--=20
Lu=C3=ADs

