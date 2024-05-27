Return-Path: <linux-ext4+bounces-2653-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27F8D068A
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 17:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8351C221A7
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5461FF9;
	Mon, 27 May 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yf7gDT7j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839F61FD8
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824911; cv=none; b=BpShT3sAQsrJNT4UuVoRnqXm99yjX1EZGSrOcVHLLX4YEeYy0zXI5lkmFLjt125Tc49Urgz1vEBa9OiotsVGMWy1EojxFLuMh6+csLSbO2+wvBtvt7Q48qFD7O7vQsVIqWiTvxZLbbFu3c6gbE5pj8zZdjL5dtNln0V21hVYfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824911; c=relaxed/simple;
	bh=j6fD/Ci1a9FwE2Y3sJBitvVUfGGI6XIHk1L7eCzZkBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9fj5UO5RDNZNiT1T90qc5MU2tPSp0ThWqjqOhXeX4dRaNZn2YMLU9JNWjwGaJaI/BZyO7UsC+sfI25Z9H4pnBrMgXld4aPXOW0Sammi7Zy0RXnD1/64BB78bqb8WthvBn1wX3AtyjLPOP27UAJ4JQDKBHFNlNtdGCqk+c1nlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yf7gDT7j; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-ext4@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716824907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yigDgYzxDm/YXTY6BSYFXprUHJId2yNbt73KT7rVnq0=;
	b=Yf7gDT7jmS3/ywn6gpmEEvyen4NW9G0f2YQlmmbNZjpllAmD4XfEZT2qsnoMAJLZYOgA6O
	uOeoKQWMg3hubEw5otwmuiIxoCNzrn2Zul42DoZmgSO4HrLRReeh4kwK5+YTW6yy2/euVk
	lqAnws11tV5V7Xa7ESPTU6l0QK7qr+g=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: adilger@dilger.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
In-Reply-To: <87h6ej64jv.fsf@brahms.olymp> (Luis Henriques's message of "Mon,
	27 May 2024 09:29:40 +0100")
References: <20240523111618.17012-1-luis.henriques@linux.dev>
	<20240524162231.l5r4niz7awjgfju6@quack3> <87h6ej64jv.fsf@brahms.olymp>
Date: Mon, 27 May 2024 16:48:24 +0100
Message-ID: <87msob45o7.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon 27 May 2024 09:29:40 AM +01, Luis Henriques wrote;

<snip>

>>> +	/*
>>> +	 * Used to flag an inode as part of the next fast commit; will be
>>> +	 * reset during fast commit clean-up
>>> +	 */
>>> +	tid_t i_fc_next;
>>> +
>>
>> Do we really need new tid in the inode? I'd be kind of hoping we could u=
se
>> EXT4_I(inode)->i_sync_tid for this - I can see we even already set it in
>> ext4_fc_track_template() and used for similar comparisons in fast commit
>> code.
>
> Ah, true.  It looks like it could be used indeed.  We'll still need a flag
> here, but a simple bool should be enough for that.

After looking again at the code, I'm not 100% sure that this is actually
doable.  For example, if I replace the above by

	bool i_fc_next;

and set to to 'true' below:

>>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>>> index 87c009e0c59a..bfdf249f0783 100644
>>> --- a/fs/ext4/fast_commit.c
>>> +++ b/fs/ext4/fast_commit.c
>>> @@ -402,6 +402,8 @@ static int ext4_fc_track_template(
>>>  				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>>>  				&sbi->s_fc_q[FC_Q_STAGING] :
>>>  				&sbi->s_fc_q[FC_Q_MAIN]);
>>> +	else
>>> +		ei->i_fc_next =3D tid;

		ei->i_fc_next =3D true;

Then, when we get to the ext4_fc_cleanup(), the value of iter->i_sync_tid
may have changed in the meantime from, e.g., ext4_do_update_inode() or
__ext4_iget().  This would cause the clean-up code to be bogus if it still
implements a the logic below, by comparing the tid with i_sync_tid.
(Although, to be honest, I couldn't see any visible effect in the quick
testing I've done.)  Or am I missing something, and this is *exactly* the
behaviour you'd expect?

Cheers,
--=20
Luis

>>>  	spin_unlock(&sbi->s_fc_lock);
>>>=20=20
>>>  	return ret;
>>> @@ -1280,6 +1282,15 @@ static void ext4_fc_cleanup(journal_t *journal, =
int full, tid_t tid)
>>>  	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>>>  				 i_fc_list) {
>>>  		list_del_init(&iter->i_fc_list);
>>> +		if (iter->i_fc_next =3D=3D tid)
>>> +			iter->i_fc_next =3D 0;
>>> +		else if (iter->i_fc_next > tid)
>> 			 ^^^ careful here, TIDs do wrap so you need to use
>> tid_geq() for comparison.
>>
>
> Yikes!  Thanks, I'll update the code to do that.
>
>>> +			/*
>>> +			 * re-enqueue inode into STAGING, which will later be
>>> +			 * splice back into MAIN
>>> +			 */
>>> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
>>> +				      &sbi->s_fc_q[FC_Q_STAGING]);
>>>  		ext4_clear_inode_state(&iter->vfs_inode,
>>>  				       EXT4_STATE_FC_COMMITTING);
>>>  		if (iter->i_sync_tid <=3D tid)
>> 				     ^^^ and I can see this is buggy as
>> well and needs tid_geq() (not your fault obviously).
>
> Yeah, good point.  I can that too in v3.
>
> Again, thanks a lot for your review!
>
> Cheers,
> --=20
> Lu=C3=ADs


