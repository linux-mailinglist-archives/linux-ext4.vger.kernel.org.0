Return-Path: <linux-ext4+bounces-2897-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0E90E504
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2571C2250F
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1A77110;
	Wed, 19 Jun 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G6PXRTYL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C28182DB
	for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783947; cv=none; b=DSdDLCG2KevswIvjhsEEejtR7Hu/h+MeAAPZkvEbKqebQzqa3ed3a6dD1tQMtALxxsD6VMTryP3i2a8MTG8bl7hInQjuO0xOrd/osFp677nG6vwQ5AbIYGmBlfeZddACyhYlx9mXZ/ZD+H8IkewImxHZl+5Acj9/4bABZhyrWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783947; c=relaxed/simple;
	bh=AKkYaOnJG/mF81MQXEUnG+piCl5S6Tm8+E/Lz4Os61Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PmpJcisvqAjtvE93A4vnM05Ia0N8K653aDBmECEzOhAeKE3EX/7Y0v6cAmnicUve28mhQy7IrroPi5dcOaJK6kkf8OGKeu2aJpmZholvWXsQg8oBta7AarmB9KrqvptUU19ZMwCaVRWKrsyr9X3Wip0e3at2FEeKyPIvMDVM2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G6PXRTYL; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ben@decadent.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718783940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IydHjmF9e45UuwHf35R8QeFk+1P/AQ1lQbU86rrkp9o=;
	b=G6PXRTYLpTTmz0SgfISS4/34mAoLxEe4ExszTjwxmlHAD0YYqWiNwy7NyNi54tftMYMwJX
	AnrY3MFmwIBuIj9mNmcKUC+IG3ZsiyDaoi3RDGfeOMHBKERbTz9HYAB//NKyFzyr3aakMw
	+7W847Mi4DV+McV0SxHb94cbTVaR7eM=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: 1039883@bugs.debian.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  1039883@bugs.debian.org
Subject: Re: [PATCH] ext4: don't track ranges in fast_commit if inode has
 inlined data
In-Reply-To: <47173a890acd8f92bcfa391263f86f73c2d37ec7.camel@decadent.org.uk>
	(Ben Hutchings's message of "Wed, 19 Jun 2024 00:30:38 +0200")
References: <20240618144312.17786-1-luis.henriques@linux.dev>
	<47173a890acd8f92bcfa391263f86f73c2d37ec7.camel@decadent.org.uk>
Date: Wed, 19 Jun 2024 08:58:51 +0100
Message-ID: <87r0ctbbyc.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Wed 19 Jun 2024 12:30:38 AM +02, Ben Hutchings wrote;

> On Tue, 2024-06-18 at 15:43 +0100, Luis Henriques (SUSE) wrote:
>> When fast-commit needs to track ranges, it has to handle inodes that have
>> inlined data in a different way because ext4_fc_write_inode_data(), in t=
he
>> actual commit path, will attempt to map the required blocks for the rang=
e.
>> However, inodes that have inlined data will have it's data stored in
>> inode->i_block and, eventually, in the extended attribute space.
>>=20
>> Unfortunately, because fast commit doesn't currently support extended
>> attributes, the solution is to mark this commit as ineligible.
>>=20
>> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1039883
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Reported-by: Herv=C3=A9 Werner <dud225@hotmail.com>
> Tested-by: Ben Hutchings <benh@debian.org>
>

Thanks a lot, Ben.

> I think this should also have:
>
> Fixes: 9725958bb75c ("ext4: fast commit may miss tracking unwritten range=
 during ftruncate")
>
> unless you think the problem is even older than that.

If my understanding is correct (hopefully someone will confirm that!), I
think the problem goes further back.  That commit just makes it more
likely to be visible, but handling of inlined data is incorrect since the
fast_commit merge.  So, I guess that's better to simply add:

Cc: stable@vger.kernel.org

Cheers,
--=20
Lu=C3=ADs


>
> Ben.
>
>> ---
>>  fs/ext4/fast_commit.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 87c009e0c59a..d3a67bc06d10 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -649,6 +649,12 @@ void ext4_fc_track_range(handle_t *handle, struct i=
node *inode, ext4_lblk_t star
>>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>>  		return;
>>=20=20
>> +	if (ext4_has_inline_data(inode)) {
>> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
>> +					handle);
>> +		return;
>> +	}
>> +
>>  	args.start =3D start;
>>  	args.end =3D end;
>>=20=20
>
> --=20
> Ben Hutchings
> For every complex problem
> there is a solution that is simple, neat, and wrong.
>

