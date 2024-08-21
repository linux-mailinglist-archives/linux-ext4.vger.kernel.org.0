Return-Path: <linux-ext4+bounces-3826-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E196959E49
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F631F22E10
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B619ABD2;
	Wed, 21 Aug 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CKj5YCsJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738C19ABA6
	for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245949; cv=none; b=sywxtTCd7/dFRDbFFD3yryf8KZOmInRuoJg/CWSmd6qRpZEHB0+jbw9IA/LdxGsPO2cb82nokHMlAFCAsL40kVKyNSOh7RcUTRd9o7Nf+H9SBc3PHrYOTW26dK9CF0W7RfXNJbX6iVLL+acCjYEW31PVxJiu7g03CPY1a6/lrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245949; c=relaxed/simple;
	bh=1hWSfkuDvCCgzyJWEPIuUmNXb4LdRo7Zv0iC4AskkO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsqmdv51lEAVcWvnsGc7HN+tWXl+L9LG71/jriiWYvl5YisA2PzQnUeNQtYnKnpNTgIvNcPqDzdXHPm/fC8ytU4Do1gCtOhE7oW1TKtXEwD97vXSZHFxAYtpNxqa+n7wLPX3BedHHM7Oh/5zkgsGVRBVMVKMs91H94I6t4E3FwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CKj5YCsJ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724245943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkjVWgifWNDmOyCQoEG2PBMR+4xjF0nUCR+RTDSSzHk=;
	b=CKj5YCsJnOZulatF/45o/OO7JgtmSwb46NEdcnct2keM4S3jBXEghIHMexYEslL43XS2JM
	KuOKOEneqfNmXXWbPpxKFLlweQBNi3Dt4u0dUgyoe6d+/hihI1I1fl59F3YrsZAT24xvRJ
	6n58PhZUao1DsiIKJXiOn6anP7nq3u8=
From: Luis Henriques <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>,  linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] e2fsck: make sure orphan files are cleaned-up
In-Reply-To: <20240611142704.14307-1-luis.henriques@linux.dev> (Luis
	Henriques's message of "Tue, 11 Jun 2024 15:27:02 +0100")
References: <20240611142704.14307-1-luis.henriques@linux.dev>
Date: Wed, 21 Aug 2024 14:12:14 +0100
Message-ID: <8734myrpe9.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11 2024, Luis Henriques (SUSE) wrote:

> Hi!
>
> I'm sending a fix to e2fsck that forces the filesystem checks to happen
> when the orphan file is present in the filesystem.  This patch resulted f=
rom
> a bug reported in openSUSE Tumbleweed[1] where e2fsck doesn't clean-up th=
is
> file and later the filesystem  fails to be mounted read-only (because it
> still requires recovery).
>
> I'm also sending a new test to validate this scenario.

I know it's holidays season, but since I've sent this a while ago I
believe it's time for a ping.

Cheers,
--=20
Lu=C3=ADs


> [1] https://bugzilla.suse.com/show_bug.cgi?id=3D1226043
>
> Luis Henriques (SUSE) (2):
>   e2fsck: don'k skip checks if the orphan file is present in the
>     filesystem
>   tests: new test to check that the orphan file is cleaned up
>
>  e2fsck/unix.c                      |   4 ++++
>  tests/f_clear_orphan_file/expect.1 |  35 +++++++++++++++++++++++++++++
>  tests/f_clear_orphan_file/expect.2 |   7 ++++++
>  tests/f_clear_orphan_file/image.gz | Bin 0 -> 12449 bytes
>  tests/f_clear_orphan_file/name     |   1 +
>  tests/f_clear_orphan_file/script   |   2 ++
>  6 files changed, 49 insertions(+)
>  create mode 100644 tests/f_clear_orphan_file/expect.1
>  create mode 100644 tests/f_clear_orphan_file/expect.2
>  create mode 100644 tests/f_clear_orphan_file/image.gz
>  create mode 100644 tests/f_clear_orphan_file/name
>  create mode 100644 tests/f_clear_orphan_file/script
>

