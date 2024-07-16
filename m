Return-Path: <linux-ext4+bounces-3294-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10193272C
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383F7283A8A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333F19AD5C;
	Tue, 16 Jul 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="prCdNrql"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE145345
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135500; cv=none; b=uNCjqJD+NaHg3MhwtOTtpV0kks4vGj23r175ajpUTOWTxbEjRhOHfwLfbHZvA+02rpNQRbIv6cHsHd7fwCbbBc6BgqleO8UG17TwspTsi+vfx9IWSxAu7pASWmaUF0O42/2iJSuin8Pl9c2iZiqKzQ6cCKrY/O+1Ex2Yg5MaJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135500; c=relaxed/simple;
	bh=ExTw1ifcqBIk4pnEeEdEBemsyUSeC33CCBhl/Uemgzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftf3JA6DXDEu3JAqymNLi5EdaZz1ASwCHiNn7h8hvFv+MjovUvyPo6DsCcrXUoaamRsaiQyY7Bf8cBa0hvquH2Aaf1aZ2WWbPuFbeDltfa2osMP+8kmqRbwwDs+CaJ5Wewb5ufBiA1BDkbtw2zFRLQJDBQPkAVq23BRG9lVJ+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=prCdNrql; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jack@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721135495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iQxLjS4a8Zfh0TO4hBQW9tA1hT0GSokUblGYOiit1o=;
	b=prCdNrqlzyslzD4X1onFxFMANwojouahTUwqBTmPfh7+cR57T9ajLXDUaDQPCJg7RIjOxN
	QbyRR3MHObjdbG9DLCYSKyybQjSQk6UZXUT1lo1+Sx+m+XBxF0J8qy7Y0XgF1HkrGAJFB/
	OfKFagRqRVU0J0KTISzqEY/74cArdZU=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: wangjianjian0@foxmail.com
X-Envelope-To: wangjianjian3@huawei.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Andreas Dilger <adilger@dilger.ca>,  Wang Jianjian
 <wangjianjian0@foxmail.com>,  "wangjianjian (C)"
 <wangjianjian3@huawei.com>,  Theodore Ts'o <tytso@mit.edu>,  Harshad
 Shirwadkar <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: make '0' an invalid transaction sequence
In-Reply-To: <20240716095201.o7kkrhfdy2bps3rw@quack3> (Jan Kara's message of
	"Tue, 16 Jul 2024 11:52:01 +0200")
References: <20240711083520.6751-1-luis.henriques@linux.dev>
	<4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
	<878qy8nem5.fsf@brahms.olymp>
	<tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
	<A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
	<87ed7znf8n.fsf@linux.dev> <87wmlrkkch.fsf_-_@linux.dev>
	<20240716095201.o7kkrhfdy2bps3rw@quack3>
Date: Tue, 16 Jul 2024 14:11:27 +0100
Message-ID: <87ikx5trb4.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 16 2024, Jan Kara wrote:

> On Fri 12-07-24 10:53:02, Luis Henriques wrote:
>> Since there's code (in fast-commit) that already handles a '0' tid as a
>> special case, it's better to ensure that jbd2 never sets it to that value
>> when journal->j_transaction_sequence increment wraps.
>>=20
>> Suggested-by: Andreas Dilger <adilger@dilger.ca>
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Well, sadly it isn't so simple. If nothing else, journal replay
> (do_one_pass()) will get broken by the skipped tid as we do check:
>
>                 if (sequence !=3D next_commit_ID) {
>                         brelse(bh);
>                         break;
>                 }
>
> So we'd abort journal replay too early. Secondly, there's also code
> handling journal replay in libext2fs which would need to be checked and
> fixed up. Finally, I've found code in mballoc which alternates between two
> lists based on tid & 1, so this logic would get broken by skipping 0 tid
> as well.
>
> Overall, I think we might be better off to go and fix places that assume
> tid 0 is not valid. I can see those assumptions in:
>
> ext4_fc_mark_ineligible()
> ext4_wait_for_tail_page_commit()
> __jbd2_log_wait_for_space()
> jbd2_journal_shrink_checkpoint_list()
>
> Now I don't see it as urgent to fix all these right now. Just for this
> series let's not add another place making tid 0 special. Later we can fix=
up
> the other places...

Yikes!  Looks like I haven't done my homework -- I should have caught at
least one of the three breakages you point out.  Obviously, because I've
seen this assumption in different places, I thought it would be OK.

Anyway, thanks a lot for point this out, Jan.  I'll add a new TODO to my
list to start looking at other places that need to be fixed.

Cheers,
--=20
Lu=C3=ADs

