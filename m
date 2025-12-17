Return-Path: <linux-ext4+bounces-12392-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F52CC936D
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED40310A71C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CB25A354;
	Wed, 17 Dec 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lpp+omV4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DC23E34C
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994671; cv=none; b=HQcYUxYf6qvaKa0AV1KROQFUbRs8bTxA+KOLb5wujY9wvg+kVWaROhCyR7N6KcC0VGjoX/yFloRAkUkhmzF6TR6ia3WNgpidiyV9iClllDppSKCPlnuj1pxjytlOKDD3uybrm/VxmVwnwCAvVTZq5b9cpVuq4hhffwE2vyi9AME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994671; c=relaxed/simple;
	bh=1uNdcnIsmOpSn8LrFdPUFIBBEcyNF9WTPowNAL8IYMs=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=dz1bw8Py252zPNaC9LIwQy7yaCxnAqrBQ48OX5Ri896ZSASDs6Nqsw5NQsuoNM8fvVm++/j0TXcGFvE3n/LgZDyODrBgzhNu5RelKLqhNZdER25Nd5ofexribvXD814zEGXfUWgZv81ey7dnPNhOKwNfmHb9bJ+GWhOTxkE04KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lpp+omV4; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1765994665; x=1766253865;
	bh=1uNdcnIsmOpSn8LrFdPUFIBBEcyNF9WTPowNAL8IYMs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lpp+omV4ypLGvD97/s5JU7R2hGUONLHpmKMG1lcOoxjFe+BlH7vr9q+MNKV0yYes1
	 pKa/rSRVHNxJuNyUl1Y1XF4/jhl4HR+rdpCZdEBY30Yln47Fj69naxkX4CUCd/GFfa
	 oMcnagcFfnH+bJQJJQ4wuo0bFiSXzuu4kACLCdHnSRmNZxJSmpCbuZP8CjiCXB2Vgh
	 LlGwCfXuzvcNuajnozhEtcEC4TorEVaAUJClZ4UF/xy75LrgpYTH9fRcsYr4C7QJyN
	 GvkvbB4ZDkrgROh0w/QICDNQtDibfApu22/1osbQL+4WM35XqE+1IkjitBhxVcRVPo
	 SEXVMxFleqXSA==
Date: Wed, 17 Dec 2025 18:04:22 +0000
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
From: Daniel Mazon <daniel.mazon@proton.me>
Subject: ext4: a tool to modify the inode count
Message-ID: <PAsXqba23hYRwwgFsaneY7Hmxe8-AmdAhSAUH2CW_vtTAi0Y8wVch4QrmW-gU2KahqhsxpxHesEDBZSXlM70jazF0yC-DaPfWgFckG6uzXo=@proton.me>
Feedback-ID: 172137602:user:proton
X-Pm-Message-ID: c1ffbb253c28d186462c68f26448fe2af512350c
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I wrote a small tool to modify the inode count of an existing ext4=20
filesystem. It is largely based on the resize2fs tool from e2fsprogs.=20
Previously, the inode count was selected at filesystem creation and=20
could not be modified afterwards.

It provides a way to increase or reduce the inode count. I developed it=20
because I had a 3.5 TiB ext4 partition created with a default 16384=20
bytes-per-inode ratio. This created over 200 million inodes, allocating=20
over 50GiB to inode tables. However, I was using less than 0.1% of=20
inodes, so I wanted to reallocate those unused GiB from inode tables to=20
free space.

To test the program, I created testcases trying to cover all possible=20
ext4 options that could be impacted by a change on the inode count.=20
After some time, I think it works well: no fsck errors after the=20
change, and all data is still there. Please bear in mind that this has=20
only been tested by one person.

I think this tool could be useful to someone else, as it adds=20
flexibility on a parameter which was previouly unmodifiable. The code=20
can be found here: https://github.com/danim7/inode_count_modifier

Please don't hesitate to let me know if you give it a try. I hope this=20
mailing list is the right place to communicate this, if not, please=20
excuse me for the noise.

Regards,
Daniel


