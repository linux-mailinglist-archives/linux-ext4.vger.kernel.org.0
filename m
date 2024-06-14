Return-Path: <linux-ext4+bounces-2882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA1908FF1
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2024 18:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345971F21B9F
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jun 2024 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9416B754;
	Fri, 14 Jun 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LIznCiiC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26016DEB7
	for <linux-ext4@vger.kernel.org>; Fri, 14 Jun 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381939; cv=none; b=Fl4MgknZL+OQmdQ0n7FpdQSpBqMr6MdYfjVAsZSitGK5JVHBYpCAVoYkluPZeJsqXVw0dwNAX/3xblBOiNqZKI4ba51T1Asce+XDzxfbNp30TUO213nxvnq131ELy7j/FmSHaZJwyfqZI7FA/z4NcEgz+PLdDqJUPlvfubqm6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381939; c=relaxed/simple;
	bh=sL5qNbMI5nhHVdLqt9dgMl39e+wZVlRNebJwBO3CTIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IasKck/CgnDyH10YygftRiLoqGTjxckAtJW14VAW8GCngSenXXUJXPGgv/Qbf5KZhay4Wo//T6VgvkeqIhp3sOKLzL1Cv4Iqbo6i12sEDjSk3FK1C6KCk7zQJBJpgtKl5Yyi32EIyY6atUX6vFKAUVOfDHSV/Q/CpGk9os2xjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LIznCiiC; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ben@decadent.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718381933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32tgD+O/VR9Uo5B9vfAvWlmOnfbd/u8hq8dXdPCtsJg=;
	b=LIznCiiC6LMo6ihRoHP52l8ukrQ50uiaVoR5BRQN2HIpqjPWzaobBOw7A3rC3K2YHXifDA
	JbSLxjaLpL466z+3H1nX1pGldoc73uKyHY4TmiU+WSkdXOTrOsrkrHoF6gBRcT2+eVJWJ5
	uilQTbHamHps5RbhiHvbGtfGsRbpxZU=
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: dud225@hotmail.com
X-Envelope-To: didi.debian@cknow.org
X-Envelope-To: 1039883@bugs.debian.org
X-Envelope-To: carnil@debian.org
X-Envelope-To: harshadshirwadkar@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-ext4@vger.kernel.org,  =?utf-8?Q?Herv=C3=A9?= Werner
 <dud225@hotmail.com>,
  Diederik de Haas <didi.debian@cknow.org>,  1039883@bugs.debian.org,
  Salvatore Bonaccorso <carnil@debian.org>, harshad shirwadkar
 <harshadshirwadkar@gmail.com>
Subject: Re: linux: ext4 corruption with symlinks
In-Reply-To: <e6797603353b8162df6c29777ed5936af4d11b32.camel@decadent.org.uk>
	(Ben Hutchings's message of "Mon, 10 Jun 2024 18:03:58 +0200")
References: <168802788716.2369531.1979971093539266086.reportbug@ariane.home>
	<ZL5DB7vU3GnIx588@eldamar.lan> <2002858.macj2W6JUv@bagend>
	<DB4PR02MB936085F4449207358A9943568FABA@DB4PR02MB9360.eurprd02.prod.outlook.com>
	<e6797603353b8162df6c29777ed5936af4d11b32.camel@decadent.org.uk>
Date: Fri, 14 Jun 2024 17:18:45 +0100
Message-ID: <87plsj4hwa.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon 10 Jun 2024 06:03:58 PM +02, Ben Hutchings wrote;

> On Sun, 5 Nov 2023 16:12:41 +0000 Herv=C3=A9 Werner <dud225@hotmail.com>
> wrote:
>> Hello
>>=20
>> I'm sorry for the delay.
>>=20
>> > Are you able to reliably preoeduce the issue and can bisect it to
>> > the introducing commit?
>> I faced this issue on real data but I struggled to find a reliable
>> scenario to reproduce it. Here is what I just came up with:
>>=C2=A0=C2=A0 sudo mkfs -t ext4 -O fast_commit,inline_data /dev/sdb
>>=C2=A0=C2=A0 sudo mount /dev/sdb /mnt/
>>=C2=A0=C2=A0 sudo install -d -o myuser /mnt/annex
>>=C2=A0=C2=A0 cd /mnt/annex
>>=C2=A0=C2=A0 git init && git annex init
>>=C2=A0=C2=A0 for i in {1..2}; do
>>=C2=A0=C2=A0=C2=A0=C2=A0 for i in {1..10000}; do
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dd if=3D/dev/urandom of=3Dfile-${i} =
bs=3D1K count=3D1 2>/dev/null
>>=C2=A0=C2=A0=C2=A0=C2=A0 done
>>=C2=A0=C2=A0=C2=A0=C2=A0 git annex add -J cpus . >/dev/null && git annex =
sync -J cpus && git annex fsck -J cpus >/dev/null
>>=C2=A0=C2=A0=C2=A0=C2=A0 git rm * && git annex sync=C2=A0 && git annex dr=
opunused all
>>=C2=A0=C2=A0 done
>>=20
>> Then at some point the following error appears:
>>=C2=A0=C2=A0 EXT4-fs error (device sdb): ext4_map_blocks:577: inode #3942=
343: block 4: comm git-annex:w: lblock 1 mapped to illegal pblock 4 (length=
 1)
> [...]
>
> I can also reproduce this error message using the above script and:
>
> - Linux 6.10-rc2
> - A 2 GiB loopback devic instead of /dev/sdb
>
> I bisected this back to:
>
> commit 9725958bb75cdfa10f2ec11526fdb23e7485e8e4
> Author: Xin Yin <yinxin.x@bytedance.com>
> Date:   Thu Dec 23 11:23:37 2021 +0800
>=20=20
>     ext4: fast commit may miss tracking unwritten range during ftruncate
>
> It is still possible to cleanly revert that commit from 6.10-rc2, and
> doing so removes the error message.

Because I recently fixed an issue in the fast commit code[1] I was hoping
that you were hitting the same bug.  I've executed the reproducer with the
fix (which hasn't been merged yet) and realised it's definitely a
different problem.

Debugged the issue a bit, it seems to be related with the fact that
ext4_fc_write_inode_data() isn't able to cope with the fact that
'ei->i_fc_lblk_len' is set to EXT_MAX_BLOCKS.

I'm CC'ing Harshad, maybe he has some idea.

[1] https://lore.kernel.org/all/20240529092030.9557-2-luis.henriques@linux.=
dev

Cheers,
--=20
Lu=C3=ADs

