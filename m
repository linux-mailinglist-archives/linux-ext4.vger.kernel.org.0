Return-Path: <linux-ext4+bounces-3382-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B85393A2D8
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 16:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95FAB23E56
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1141552ED;
	Tue, 23 Jul 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="ixJYvmLs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09D14C59A;
	Tue, 23 Jul 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745263; cv=none; b=P9rFrz76v9djmDeZg5b9q+yRwbcMPjo421Fkv5BqJfA9Huzmp6ahNJcuU1EFadMBS8J89ZRIamnRT6sb/hGJsu9xk/gBiN7G5QsnpaSRG6kM/ODQEz1AbDI/6FkjX2ROikfLEpBpPZj+9EydGJX1Fe6hwxhCaUljGUnOMcA2xpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745263; c=relaxed/simple;
	bh=1B6BsBDUtFfeVEALIeX4Iv8qeLMx4W7b1/biT1lFRn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NgNgbrId9Tvq9UbZnTvBHus0l0KUhAB6cypBpMzlZzaklJ/VCTpq5/khks0GoeULqH6G3nkMQ7PphsBzqPFkgU0PG/P2cRj31ZUZL0piXSNpwbYewcX18zgcVpEv48aHIMH/+20YcGa5mvi1UQL+RP9L45/KLwjWBBm2A9LRwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=ixJYvmLs; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89D0B240004;
	Tue, 23 Jul 2024 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1721745254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IoKig6xPx7s5cqLIWwCW1VLXu1C3mGlxSSzRtiuDkc=;
	b=ixJYvmLsYrtjIBStPK6eU8LhOXpkOrIjU5kHUvKu04nnfJEwg3SZSbNAdFqrsEP329pk0N
	R5g5EQr48TRdg9fIFKMPX3vn1tSua4WdJhzEFIvht0KTKlswh1kAV9RL5bNFaIrj/ot/rI
	BR4zMHSdSNRhQiXEO2VFEw7oER67mxaTtIfhp48sDeM7DGWSjvUHLKl7CsG59fq+0qmGLy
	VAmYj9xcW5NVZrqoYqgnTSmXR9cRNlgZacPl4tVbU4bdUDKRbD2iAgFI9IcJwygYX5/SAO
	kDorZzZDnKpwD+29hN2akJtGO4tHPrH8A4uTc3N6OmuameAapZU/8b6a0YJiRw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,  chuck.lever@oracle.com,
  gregkh@linuxfoundation.org,  jack@suse.cz,  krisman@collabora.com,
  patches@lists.linux.dev,  sashal@kernel.org,  stable@vger.kernel.org,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,  tytso@mit.edu,
  alexey.makhalov@broadcom.com,  vasavi.sirnapalli@broadcom.com,
  florian.fainelli@broadcom.com
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
In-Reply-To: <CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com>
	(Amir Goldstein's message of "Tue, 23 Jul 2024 12:20:39 +0300")
References: <20240618123422.213844892@linuxfoundation.org>
	<1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
	<CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 23 Jul 2024 10:34:08 -0400
Message-ID: <875xswtbxb.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Jul 23, 2024 at 10:06=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.=
com> wrote:
>> Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as:
>> fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel
>>
>> With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
>> timeout as no notification. To fix need to merge following two upstream
>> commit to v5.10:
>>
>> 124e7c61deb27d758df5ec0521c36cf08d417f7a:
>> 0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
>> https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kah=
er@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305
>>
>> 9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
>> 0001-ext4_Send_notifications_on_error.patch
>> Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-aj=
ay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53
>>
>> -Ajay
>
> I agree that this is the best approach, because the test has no other
> way to test
> if ext4 specifically supports FAN_FS_ERROR.
>
> Chuck,
>
> I wonder how those patches end up in 5.15.y but not in 5.10.y?

I wonder why this was backported to stable in the first place.  I get
there is a lot of refactoring in this series, which might be useful when
backporting further fixes. but 9709bd548f11 just enabled a new feature -
which seems against stable rules.  Considering that "anything is a CVE",
we really need to be cautious about this kind of stuff in stable
kernels.

Is it possible to drop 9709bd548f11 from stable instead?

> Gabriel, if 9abeae5d4458 has a Fixes: tag it may have been auto seleced
> for 5.15.y after c0baf9ac0b05 was picked up...

right.  It would be really cool if we had a way to append this
information after the fact.  How would people feel about using
git-notes in the kernel tree to support that?

--=20
Gabriel Krisman Bertazi

