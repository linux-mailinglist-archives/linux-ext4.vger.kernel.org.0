Return-Path: <linux-ext4+bounces-2890-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A201790D27D
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1411F2515F
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813A1ACE98;
	Tue, 18 Jun 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MbRwAsX0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2C15A860
	for <linux-ext4@vger.kernel.org>; Tue, 18 Jun 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716764; cv=none; b=lyjK7BO9zcm8W2tJeThcRNhI7/dXImnaIiWS78dXxnujDG+AkO4QXKFVV/QTly5ynjOVbW5leXupA3OHDGq1Ar7KKJEcsVU6NAsz3+y12tMv94O6BiJ5MBHMlcjsEZcB2I+N48T9j1Lfz+ka1doUdwkW061JR0UJN3nQK5zHLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716764; c=relaxed/simple;
	bh=iZ5Yx7Vtjm998sLqmxa6vNokJilMbcUpfZ7NxtH6/JU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rETYBBIuR6Uukuqo8V4G4hcS60GVL9OdSLi1Tpc3nof7rJ8JOjhCt6aSUuPwMxRWN5+bW8pMN/lNQeK4BMKmNdQ75k7udbSQHg5L/ZZDSHgZG1bZv23uyVs+ceA0Zf4B7Ja3+Xfqa9PLBLnVF2f/LGOBaTmZgaI4tvTcVUa24/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MbRwAsX0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: luis.henriques@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718716760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLOWGnQmt66uvPW2DSh+XMSF05BvhXuROpXn7iL/O+4=;
	b=MbRwAsX0Hx9PSXgUySL7h/vrEycUunAZD5skxm2FYAJQFjDahAWOkTes46400W2XEEmury
	YOTd5Mp44Ow2GroJ2LfJUBpR6DE091WrbRuKPxoXh6C9yNosE3VE20dhJwmbsvTdQ+B3eJ
	X178pnXD2wzwqdpMR61cKGCeF+259PQ=
X-Envelope-To: ben@decadent.org.uk
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: dud225@hotmail.com
X-Envelope-To: didi.debian@cknow.org
X-Envelope-To: 1039883@bugs.debian.org
X-Envelope-To: carnil@debian.org
X-Envelope-To: harshadshirwadkar@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Ben Hutchings <ben@decadent.org.uk>,  linux-ext4@vger.kernel.org,
  =?utf-8?Q?Herv=C3=A9?=
 Werner <dud225@hotmail.com>,  Diederik de Haas <didi.debian@cknow.org>,
  1039883@bugs.debian.org,  Salvatore Bonaccorso <carnil@debian.org>,
  harshad shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: linux: ext4 corruption with symlinks
In-Reply-To: <87tthq37d4.fsf@brahms.olymp> (Luis Henriques's message of "Tue,
	18 Jun 2024 10:52:55 +0100")
References: <168802788716.2369531.1979971093539266086.reportbug@ariane.home>
	<ZL5DB7vU3GnIx588@eldamar.lan> <2002858.macj2W6JUv@bagend>
	<DB4PR02MB936085F4449207358A9943568FABA@DB4PR02MB9360.eurprd02.prod.outlook.com>
	<e6797603353b8162df6c29777ed5936af4d11b32.camel@decadent.org.uk>
	<87plsj4hwa.fsf@brahms.olymp> <87tthq37d4.fsf@brahms.olymp>
Date: Tue, 18 Jun 2024 14:19:11 +0100
Message-ID: <877cem2xtc.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue 18 Jun 2024 10:52:55 AM +01, Luis Henriques wrote;

> On Fri 14 Jun 2024 05:18:45 PM +01, Luis Henriques wrote;
> [...}
>>>
>>> I can also reproduce this error message using the above script and:
>>>
>>> - Linux 6.10-rc2
>>> - A 2 GiB loopback devic instead of /dev/sdb
>>>
>>> I bisected this back to:
>>>
>>> commit 9725958bb75cdfa10f2ec11526fdb23e7485e8e4
>>> Author: Xin Yin <yinxin.x@bytedance.com>
>>> Date:   Thu Dec 23 11:23:37 2021 +0800
>>>=20=20
>>>     ext4: fast commit may miss tracking unwritten range during ftruncate
>>>
>>> It is still possible to cleanly revert that commit from 6.10-rc2, and
>>> doing so removes the error message.
>>
>> Because I recently fixed an issue in the fast commit code[1] I was hoping
>> that you were hitting the same bug.  I've executed the reproducer with t=
he
>> fix (which hasn't been merged yet) and realised it's definitely a
>> different problem.
>>
>> Debugged the issue a bit, it seems to be related with the fact that
>> ext4_fc_write_inode_data() isn't able to cope with the fact that
>> 'ei->i_fc_lblk_len' is set to EXT_MAX_BLOCKS.
>
> OK, I've looked into this again.  And something I didn't pay attention
> before was that the filesystem was created with both fast_commit *and*
> inline_data features.  And after some more debugging, I _think_ the patch
> bellow should be the fix for this bug.
>
> If I understand it correctly, when an inode has inlined data it means that
> there's no inode data to be written and this case should be handled as if
> the inode length was zero.
>
> I'll send out a patch later after running a few more tests just to make
> sure it doesn't break something else.  But it would awesome if you could
> test it too.

Hmm... looking closer, this patch seems to work with this specific test
script, but only because file data is probably small enough to fit in
inode->i_block.  However, it may actually truncate files that have inlined
data if the file data is also stored in the extended attribute space
(i.e. > 60 bytes).

So, the correct fix is probably something like the below patch (which I'll
send out soon).

Cheers,
--=20
Lu=C3=ADs

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..d3a67bc06d10 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -649,6 +649,12 @@ void ext4_fc_track_range(handle_t *handle, struct inod=
e *inode, ext4_lblk_t star
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
=20
+	if (ext4_has_inline_data(inode)) {
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
+		return;
+	}
+
 	args.start =3D start;
 	args.end =3D end;
=20

