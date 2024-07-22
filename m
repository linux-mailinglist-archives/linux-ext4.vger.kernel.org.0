Return-Path: <linux-ext4+bounces-3351-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A593899B
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 09:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D19B2228D
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90C18044;
	Mon, 22 Jul 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6ouTnn0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A5208A4;
	Mon, 22 Jul 2024 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632021; cv=none; b=c/jn2QpxIanMHvwOv7e8UpSG6XwJuEN0eIuddvGZAG60aYUEH++4F+Puxp2tLwJVIZLml/dQOOSQ9yoVsYToHQ9JBD7othObeVnSz6G2ZcNjsIdR6tFRm9ADs3de/6HdDjClbveucZVrSgrw9tzdAN5HVh0W0QKg5SKGGkG0kT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632021; c=relaxed/simple;
	bh=Ij2cO0q9FMHHVwhqlDYX/2GmqyF+N0IDQ5jk35GRLCs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YgYreK698FsEJrao2/dc7VsTXjXVHETtjjoNL8BiJXmiigU4k+kgrDGXo806JsgXYfQvZBSMxKiETCAro0PnWXWrQ2sML8bdKeRrgVEZS1wjKN7Cz5s1f2hNiJyNeiNOrwzPgodjRA/xczJ45PV/rQ9dqTcQWcBFEx7H1kgMyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6ouTnn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCBDC116B1;
	Mon, 22 Jul 2024 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721632021;
	bh=Ij2cO0q9FMHHVwhqlDYX/2GmqyF+N0IDQ5jk35GRLCs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=m6ouTnn0Xq2hcRZ/ka0LhyZKK1LGwJ0slzVu2AsxEYkPqlfJy2gkpAPt1CTKnkkN7
	 WtZpmC+I5TlB0cHcbG8qeAx9MdklLongjC9c/pgKLHTtkMHtX0PJqfaLRLXj3POB/S
	 XKo0KcgL9sLC8l90EzHqvc0UY58O7mUxmlz9HbVFyxakxOntfVddywcYSUxpRRqz1b
	 oEl6eroH3aR6TtDSsBfRDJ7OX0Q7xEurP2viC7UcCEybFU9nY58xPu8SiC3gl37HLj
	 SHYjBypeJIh0C0UXNLXnGrWr3BHMOYLNnvk9OPKYFsOcYjI/Tyuu/DVv2diqLAnAgl
	 vv3LuPnZZh8aA==
Date: Mon, 22 Jul 2024 00:06:59 -0700
From: Kees Cook <kees@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, "Artem S. Tashkinov" <aros@gmx.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-ext4@vger.kernel.org, xcreativ@gmail.com, madeisbaer@arcor.de,
 justinstitt@google.com, keescook@chromium.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Linux_6=2E10_regression_resulting_in?=
 =?US-ASCII?Q?_a_crash_when_using_an_ext4_filesystem?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240722041924.GB103010@frogsfrogsfrogs>
References: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com> <20240722041924.GB103010@frogsfrogsfrogs>
Message-ID: <BEEA84E0-1CF5-4F06-BC5C-A0F97240D76D@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 21, 2024 9:19:24 PM PDT, "Darrick J=2E Wong" <djwong@kernel=2Eorg>=
 wrote:
>On Sun, Jul 21, 2024 at 09:10:59PM +0000, Artem S=2E Tashkinov wrote:
>> Hello,
>>=20
>> There are now two bug reports containing very similar if not exactly th=
e
>> same backtraces=2E
>>=20
>> https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D219072
>> https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D219078
>>=20
>> Theodore, please take a look=2E
>
>[adding everyone involved in 744a56389f739 ("ext4: replace deprecated
>strncpy with alternatives") to cc]
>
>Is strscpy_pad appropriate if the @src parameter itself is a fixed
>length char[16] which isn't null terminated when the label itself is 16
>chars long?

Nope; it needed memtostr_pad()=2E I sent the fix back at the end of May, b=
ut it only just recently landed:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/?id=3Dbe27cd64461c45a6088a91a04eba5cd44e1767ef

-Kees

--=20
Kees Cook

