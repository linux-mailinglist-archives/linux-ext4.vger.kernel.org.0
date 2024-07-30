Return-Path: <linux-ext4+bounces-3531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCF9414E7
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D361C209EC
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25401A257A;
	Tue, 30 Jul 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bsgod2Oo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9B1A0AFA
	for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351366; cv=none; b=L96HGBGKC3OxqJpyjgajIjOSuqSmE/5GCjxzVeY+KZFWLKsz/wb2EL41xRqGvHI4IFJDhlBzGZD0hZOJOW6NZH7CL0WnL23DpaywRjpcq31kXuabDE2zuC7mSomPfAYEx4Lz0mrx6/Vkx0XOHy4KOJGLtFZr7F/X/u/rBMU4GoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351366; c=relaxed/simple;
	bh=pRnwFF1DBYPuHIUWK7WpL/leuce84Sg78hOMGMTG7uE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jG3+jUHLtNqT724cV0PmEzI54c5qtpFDwc5XtN3dVjxO4vnjjdctFcnVIbBt7WpB8V7DAtzDrzYUuyG3uZ4PeSy0wumKev+jYBTSj1OGF15FPM7xuIugjVgLt+BnYpaslrY1JnlL+HeAl1Nspp3cRcuaZTXjjT9HtO6lZO/zZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bsgod2Oo; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722351360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggwthiFQ/X7fBJQwMR1MmGMAUCHRrlc0veNg6zHF7rA=;
	b=Bsgod2OoO7yXRVvzqYpfrtbe2Y9UkMqDP+ocPAmN5J9/eQlnEc2eQqWBH2tOyrMVMMctTi
	mE/jCwpD5Zpcfzb8xFF/jCa78x5wnjZVBM+szeCjjdsdHQ93yFeoDK51kl/9ei8Xpl+jrB
	Nvg3IUjFJ4PSkbHFYi7LXYYyvXv+d4E=
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,  tytso@mit.edu,  jack@suse.com,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] jbd2: correctly compare tids with tid_geq function
 in jbd2_fc_begin_commit
In-Reply-To: <20240730132159.opjknn477owojkrq@quack3> (Jan Kara's message of
	"Tue, 30 Jul 2024 15:21:59 +0200")
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
	<20240730113335.2365290-2-shikemeng@huaweicloud.com>
	<20240730132159.opjknn477owojkrq@quack3>
Date: Tue, 30 Jul 2024 15:55:52 +0100
Message-ID: <87sevrylmv.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 30 2024, Jan Kara wrote:

> On Tue 30-07-24 19:33:29, Kemeng Shi wrote:
>> Use tid_geq to compare tids to work over sequence number wraps.
>>=20
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/jbd2/journal.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Indeed, Luis seems to have missed this when fixing these bugs recently.

Ah! It looks like I did missed it.  Thanks!

Cheers,
--=20
Lu=C3=ADs

> Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
>
>>=20
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 1ebf2393bfb7..da5a56d700f1 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -710,7 +710,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t t=
id)
>>  		return -EINVAL;
>>=20=20
>>  	write_lock(&journal->j_state_lock);
>> -	if (tid <=3D journal->j_commit_sequence) {
>> +	if (tid_geq(journal->j_commit_sequence, tid)) {
>>  		write_unlock(&journal->j_state_lock);
>>  		return -EALREADY;
>>  	}
>> --=20
>> 2.30.0
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


