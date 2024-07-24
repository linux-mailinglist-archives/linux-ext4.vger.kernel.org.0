Return-Path: <linux-ext4+bounces-3417-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C716293B1BE
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D6282C1A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C9158D8C;
	Wed, 24 Jul 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgrJUIoJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0822089;
	Wed, 24 Jul 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828339; cv=none; b=VpTVO0vfvX2ssgnm+vZrtBzF5AMnvSTMkzLm7+35f7qmBq08rwNGsFhnLCgHZKAd6ycnrk2H6aI3FG0oZ5BpGWmAy4TDzdoyPsfkfyahb3B7d2vEPILt36u1PE15vJztgUVqQZV3/U2yaafUOEpCNJBf19T09t2Rfp15lXZ9ZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828339; c=relaxed/simple;
	bh=U2dMso0RNgKQJE/trFq1+2B/fDDhy5ta709oEtlJuxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6HGP6DIh9DwP2c+Sgj0fOL2xWDRfxibi15AmMH45yzT3fIAmQHGsQfOhvorggEX+Tdw0NF+FoIk/uEMkL6MoyvLan9MxGHLPbn7s+dvHeTrFLZ8kDEZSAtQ6d1Hm5cMCmIf2hlpNrvsiQ2hf921OZvDZCE+OO1aKvycPj6SW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgrJUIoJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721828335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jwu4O1noStkC4X4np4q4sU28j7BxPe4Bdwv08a+nBUI=;
	b=xgrJUIoJU18jOpOfG7ldderZ6S4cdrTMvg4Jsy00rgtK6YJWE6YYOk3QPRHc5PLQcL1EyJ
	NBhv0Bi1TYF+Xp8V8vlcB/M7WVOkopvGltuCgOPHo0sLt6HqoCZjVBV3HRXfhyG/Llk/ga
	GW8xGJOao2OHdYXaYW3wdafa2uJTHRk=
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ext4: fix incorrect tid assumption in
 jbd2_journal_shrink_checkpoint_list()
In-Reply-To: <20240724092954.gw3hwyax7u5kpn5o@quack3> (Jan Kara's message of
	"Wed, 24 Jul 2024 11:29:54 +0200")
References: <20240723154402.21125-1-luis.henriques@linux.dev>
	<20240723154402.21125-4-luis.henriques@linux.dev>
	<20240724092954.gw3hwyax7u5kpn5o@quack3>
Date: Wed, 24 Jul 2024 14:38:51 +0100
Message-ID: <87zfq6kiz8.fsf@linux.dev>
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

> On Tue 23-07-24 16:44:01, Luis Henriques (SUSE) wrote:
>> Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
>> valid value for transaction IDs, which is incorrect.  Don't assume that =
and
>> use two extra boolean variables to control the loop iterations and keep
>> track of the first and last tid.
>>=20
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>>  fs/jbd2/checkpoint.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
>> index 77bc522e6821..f5a594237b7a 100644
>> --- a/fs/jbd2/checkpoint.c
>> +++ b/fs/jbd2/checkpoint.c
>> @@ -410,6 +410,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(jo=
urnal_t *journal,
>>  	tid_t tid =3D 0;
>>  	unsigned long nr_freed =3D 0;
>>  	unsigned long freed;
>> +	bool is_first =3D true, is_last =3D false;
>>=20=20
>>  again:
>>  	spin_lock(&journal->j_list_lock);
>> @@ -429,8 +430,10 @@ unsigned long jbd2_journal_shrink_checkpoint_list(j=
ournal_t *journal,
>>  	else
>>  		transaction =3D journal->j_checkpoint_transactions;
>>=20=20
>> -	if (!first_tid)
>> +	if (is_first) {
>>  		first_tid =3D transaction->t_tid;
>> +		is_first =3D false;
>> +	}
>>  	last_transaction =3D journal->j_checkpoint_transactions->t_cpprev;
>>  	next_transaction =3D transaction;
>>  	last_tid =3D last_transaction->t_tid;
>> @@ -455,12 +458,13 @@ unsigned long jbd2_journal_shrink_checkpoint_list(=
journal_t *journal,
>>  	} else {
>>  		journal->j_shrink_transaction =3D NULL;
>>  		next_tid =3D 0;
>> +		is_last =3D true;
>>  	}
>>=20=20
>>  	spin_unlock(&journal->j_list_lock);
>>  	cond_resched();
>>=20=20
>> -	if (*nr_to_scan && next_tid)
>> +	if (*nr_to_scan && !is_last)
>
> I'd make this:
>
> 	if (*nr_to_scan && journal->j_shrink_transaction)
> 		goto again;
>
> and just remove is_last. Also we might rename is_first to first_set? At
> least to me it would be more comprehensible. Thanks!

Sure, both suggestions make sense.  I'll update the patches for v2.

Cheers,
--=20
Lu=C3=ADs

>
> 								Honza
>
>>  		goto again;
>>  out:
>>  	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


