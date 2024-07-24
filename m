Return-Path: <linux-ext4+bounces-3418-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6493B234
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF031F25815
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D5158D69;
	Wed, 24 Jul 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BT+esyDk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EECD51E
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829782; cv=none; b=E2o/Wijdhl9PR3QcENtjo6xkYgvHzytIx3EAyt9qDkrwdm7tkBxVS/GtVjn4eUrfcQJAzd7SJYakPO3CJtPNHN/S1CQaaOAl5QWFSjz3pOdAL0Ge9RxYHR6iI4n43aUHrhcifBwbdsK6eeVe5uPCuVN1v9H2cbkC58CrlWu2LP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829782; c=relaxed/simple;
	bh=TIm99oYWKHX/VKRM4PNSZyECrwI2jQiRJ3uFiKDKdS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gKjq4vZZLDYKyxeMZVqhJ4CPGbcDxxAHN7g5uerNzydMPTtSQvtd3jX9ZQdHM+bvBJ9F3RfFTUrsklbmZ/lLXy9PyEdVRIDkDQytpxbv/5gPzT/tTBaJj5lyqHYkZDiyFpLKMqCKuhGQJ49Ums9nMaMa19QlZFdZNRRuDL695yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BT+esyDk; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721829778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TCLNx0WZcTN2tXdFP0YiPVkgtpvc8uO6NeYuUaJhpQ=;
	b=BT+esyDkO2LspoV5FDaSYjksT3ExecpIRXxMNZIsBhhbqySUXFh7+2DIrVo/626zZT1cXu
	1ktfe1GA8qyTvzMzBIdYeJbX645aEWR82ElXiTUx2TRLJkGkekihGz3U1YPPvATNkZmB0k
	aAIYxYYQ6WWMB7SP8in0XZaO9GP/CVw=
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: fix incorrect tid assumption in
 ext4_fc_mark_ineligible()
In-Reply-To: <20240724101504.e2t4pvgw6td7rrmm@quack3> (Jan Kara's message of
	"Wed, 24 Jul 2024 12:15:04 +0200")
References: <20240723154402.21125-1-luis.henriques@linux.dev>
	<20240723154402.21125-5-luis.henriques@linux.dev>
	<20240724101504.e2t4pvgw6td7rrmm@quack3>
Date: Wed, 24 Jul 2024 15:02:49 +0100
Message-ID: <87ed7ikhva.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24 2024, Jan Kara wrote:

> On Tue 23-07-24 16:44:02, Luis Henriques (SUSE) wrote:
>> Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
>> valid value for transaction IDs, which is incorrect.
>>=20
>> Furthermore, the sbi->s_fc_ineligible_tid handling also makes the same
>> assumption by being initialised to '0'.  Fortunately, the sb flag
>> EXT4_MF_FC_INELIGIBLE can be used to check whether sbi->s_fc_ineligible_=
tid
>> has been previously set instead of comparing it with '0'.
>>=20
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Just one style nit below, otherwise looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> BTW, the ineligibility handling looks flaky to me, in particular the cases
> where we call ext4_fc_mark_ineligible() with NULL handle seem racy to me =
as
> fastcommit can happen *before* we mark the filesystem as ineligible.  But
> that's not really related to your changes, they just made me look at that
> code in detail and I couldn't resist complaining :)

Heh, fair enough.  Regarding this race, I may try to look into it but I'll
need to dig a bit more.  And yeah it's probably better to separate that
from this patch.

>
>> ---
>>  fs/ext4/fast_commit.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 3926a05eceee..3e0793cfea38 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -339,22 +339,29 @@ void ext4_fc_mark_ineligible(struct super_block *s=
b, int reason, handle_t *handl
>>  {
>>  	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>>  	tid_t tid;
>> +	bool has_transaction =3D true;
>> +	bool is_ineligible;
>>=20=20
>>  	if (ext4_fc_disabled(sb))
>>  		return;
>>=20=20
>> -	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>>  	if (handle && !IS_ERR(handle))
>>  		tid =3D handle->h_transaction->t_tid;
>>  	else {
>>  		read_lock(&sbi->s_journal->j_state_lock);
>> -		tid =3D sbi->s_journal->j_running_transaction ?
>> -				sbi->s_journal->j_running_transaction->t_tid : 0;
>> +		if (sbi->s_journal->j_running_transaction)
>> +			tid =3D sbi->s_journal->j_running_transaction->t_tid;
>> +		else
>> +			has_transaction =3D false;
>>  		read_unlock(&sbi->s_journal->j_state_lock);
>>  	}
>>  	spin_lock(&sbi->s_fc_lock);
>> -	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
>> +	is_ineligible =3D ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>> +	if (has_transaction &&
>> +	    ((!is_ineligible) ||
> 	     ^^ these extra braces look strange
>

They do, indeed.  I think my initial version had an explicit comparison
with 'false'.  v2 will have those removed.  And once again, thanks for
your review, Jan!

Cheers,
--=20
Lu=C3=ADs


>> +	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
>>  		sbi->s_fc_ineligible_tid =3D tid;
>> +	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>
> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


