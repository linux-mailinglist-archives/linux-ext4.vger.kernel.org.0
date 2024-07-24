Return-Path: <linux-ext4+bounces-3416-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C293B1B1
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 15:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477581F2436D
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6D158862;
	Wed, 24 Jul 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i6nTjpl0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83F1586D5
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828159; cv=none; b=B2AFl9yzSbS20j8qw/uxpzOuZF5/ucim/hOSE8drTX9aeHMPcoUmqawXFQk+7MIZW4Vh+inrG9pF4lTBtBiftvlCyWv5ANpJquc199N/g+okn5s4zQS0AFdL9lBhG1Ke3LYN+MBIJVFDy7jpFuawjGPpmXvOG4WsSMcdRX/Eavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828159; c=relaxed/simple;
	bh=dYmcZR5fqMDTJKdKXosvurg4TOgeq7LfNW//LhtTK4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLUfn86HMgOvFqHbbfx9jKENe49dIlGwgMJFuXzoTxXbSID8Y+KImzAqmVhsQYQvCdsP0d4+kBe5mXOIQEzK7RpqsyLFSg1nC//08vH3sKsBrw1xGLayTiJOAhyj+WoefrovCXojfj0rVRarGRayGpAmb2MFS0NkzORNGnOlPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i6nTjpl0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721828154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYCNG2Ao9p2d8N2N01EfKOCr3d574k++M8lCYq+pXXA=;
	b=i6nTjpl0ZOUf6b2Scfg9JXH8g3behb55mApmJDbTbCpoGdGzf53kfiwhNLv/wZOvmjAw0Y
	5b8Th45QKD60l+D+Id3nOEmGEDn7XQxmpiJMd4K6ZnLlpoHECEy+FONbNuMZ7IIG5uQwm9
	+vaaIUnHhbgqdnvrgK8mbj2goRqHIxE=
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ext4: fix incorrect tid assumption in
 ext4_wait_for_tail_page_commit()
In-Reply-To: <20240724091713.e4w2hskcybulz27z@quack3> (Jan Kara's message of
	"Wed, 24 Jul 2024 11:17:13 +0200")
References: <20240723154402.21125-1-luis.henriques@linux.dev>
	<20240723154402.21125-2-luis.henriques@linux.dev>
	<20240724091713.e4w2hskcybulz27z@quack3>
Date: Wed, 24 Jul 2024 14:35:44 +0100
Message-ID: <874j8elxov.fsf@linux.dev>
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

> On Tue 23-07-24 16:43:59, Luis Henriques (SUSE) wrote:
>> Function ext4_wait_for_tail_page_commit() assumes that '0' is not a valid
>> value for transaction IDs, which is incorrect.  Don't assume that and in=
voke
>> jbd2_log_wait_commit() if the journal had a committing transaction inste=
ad.
>>=20
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>>  fs/ext4/inode.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 941c1c0d5c6e..e65fc2086701 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5279,8 +5279,9 @@ static void ext4_wait_for_tail_page_commit(struct =
inode *inode)
>>  {
>>  	unsigned offset;
>>  	journal_t *journal =3D EXT4_SB(inode->i_sb)->s_journal;
>> -	tid_t commit_tid =3D 0;
>> +	tid_t commit_tid;
>>  	int ret;
>> +	bool has_transaction =3D false;
>>=20=20
>>  	offset =3D inode->i_size & (PAGE_SIZE - 1);
>>  	/*
>> @@ -5305,12 +5306,13 @@ static void ext4_wait_for_tail_page_commit(struc=
t inode *inode)
>>  		folio_put(folio);
>>  		if (ret !=3D -EBUSY)
>>  			return;
>> -		commit_tid =3D 0;
>
> We should set "has_transaction =3D false" here to make things work proper=
ly
> when looping... Otherwise looks good.

Ah! Good point.  I'll fix that, thanks!

Cheers,
--=20
Lu=C3=ADs


>
> 								Honza
>
>>  		read_lock(&journal->j_state_lock);
>> -		if (journal->j_committing_transaction)
>> +		if (journal->j_committing_transaction) {
>>  			commit_tid =3D journal->j_committing_transaction->t_tid;
>> +			has_transaction =3D true;
>> +		}
>>  		read_unlock(&journal->j_state_lock);
>> -		if (commit_tid)
>> +		if (has_transaction)
>>  			jbd2_log_wait_commit(journal, commit_tid);
>>  	}
>>  }
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


