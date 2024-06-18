Return-Path: <linux-ext4+bounces-2889-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A890C888
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 13:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DC51F2109B
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E75208270;
	Tue, 18 Jun 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpCLbN/Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73D208265
	for <linux-ext4@vger.kernel.org>; Tue, 18 Jun 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704398; cv=none; b=nWIcquYAgA1FjNf3Vfw3Nj66rXI/RsSU3qKOEaILEPixvFgR7yR66WgHL4CdN+/xgCqRy2+FP/gFlqqaL9rqD8ADRBevP8PbCJtBAbziOLvFn5ucpeD6ew54Mlc7vpcJ+6zQ7sTJ3EeswRHvSXZkO29DwEMmn2lNhFZkv3l0gwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704398; c=relaxed/simple;
	bh=09hkam/nqwrAGcaowZBCwir+mmfQWNWd103cCXeVM4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JaFRYl/oeuBPOV7hoBbSodhlHpUxCj1AXUk9g9g530azbD9fEOYigdfPi7EVKOfZaYjEjO9wc17L8o6WFOCKc0TFaP7w3UD5Uhb/HWD0llzUlY2RceLYiHJAOBc8pvQX+4MLEbBGSQk5KYxtUiL7W81AmhyzuTnASzRRvKZP4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpCLbN/Z; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: luis.henriques@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718704385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j6hoS5G7X7dgWyPYV251Wb7JZdRjSvPSvrKy5FQDNw=;
	b=LpCLbN/ZfYLu14RyqdxH3tUnNfVDMB3QV1wry6Y3uOqucWs1pyd4laD1thgqqK++FV+N2l
	Tif34OEDeCWZqNXRzkyKPw+iPnevMABaQOy8WsbL+6p9KQarkqg9bR67+lx5NrswK5Zkyk
	9Mzt1D/rHClng4TeUAhQSTO0vn/1Xrw=
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
In-Reply-To: <87plsj4hwa.fsf@brahms.olymp> (Luis Henriques's message of "Fri,
	14 Jun 2024 17:18:45 +0100")
References: <168802788716.2369531.1979971093539266086.reportbug@ariane.home>
	<ZL5DB7vU3GnIx588@eldamar.lan> <2002858.macj2W6JUv@bagend>
	<DB4PR02MB936085F4449207358A9943568FABA@DB4PR02MB9360.eurprd02.prod.outlook.com>
	<e6797603353b8162df6c29777ed5936af4d11b32.camel@decadent.org.uk>
	<87plsj4hwa.fsf@brahms.olymp>
Date: Tue, 18 Jun 2024 10:52:55 +0100
Message-ID: <87tthq37d4.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri 14 Jun 2024 05:18:45 PM +01, Luis Henriques wrote;
[...}
>>
>> I can also reproduce this error message using the above script and:
>>
>> - Linux 6.10-rc2
>> - A 2 GiB loopback devic instead of /dev/sdb
>>
>> I bisected this back to:
>>
>> commit 9725958bb75cdfa10f2ec11526fdb23e7485e8e4
>> Author: Xin Yin <yinxin.x@bytedance.com>
>> Date:   Thu Dec 23 11:23:37 2021 +0800
>>=20=20
>>     ext4: fast commit may miss tracking unwritten range during ftruncate
>>
>> It is still possible to cleanly revert that commit from 6.10-rc2, and
>> doing so removes the error message.
>
> Because I recently fixed an issue in the fast commit code[1] I was hoping
> that you were hitting the same bug.  I've executed the reproducer with the
> fix (which hasn't been merged yet) and realised it's definitely a
> different problem.
>
> Debugged the issue a bit, it seems to be related with the fact that
> ext4_fc_write_inode_data() isn't able to cope with the fact that
> 'ei->i_fc_lblk_len' is set to EXT_MAX_BLOCKS.

OK, I've looked into this again.  And something I didn't pay attention
before was that the filesystem was created with both fast_commit *and*
inline_data features.  And after some more debugging, I _think_ the patch
bellow should be the fix for this bug.

If I understand it correctly, when an inode has inlined data it means that
there's no inode data to be written and this case should be handled as if
the inode length was zero.

I'll send out a patch later after running a few more tests just to make
sure it doesn't break something else.  But it would awesome if you could
test it too.

Cheers,
--=20
Lu=C3=ADs

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..c56b39a51865 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -897,7 +897,7 @@ static int ext4_fc_write_inode_data(struct inode *inode=
, u32 *crc)
 	int ret;
=20
 	mutex_lock(&ei->i_fc_lock);
-	if (ei->i_fc_lblk_len =3D=3D 0) {
+	if ((ei->i_fc_lblk_len =3D=3D 0) || (ext4_has_inline_data(inode))) {
 		mutex_unlock(&ei->i_fc_lock);
 		return 0;
 	}

