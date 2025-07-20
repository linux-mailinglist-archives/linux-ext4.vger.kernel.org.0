Return-Path: <linux-ext4+bounces-9120-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11FB0B7CF
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Jul 2025 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF934189930A
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Jul 2025 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCA1C700C;
	Sun, 20 Jul 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciJf1Nk/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD099382
	for <linux-ext4@vger.kernel.org>; Sun, 20 Jul 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037496; cv=none; b=gIP87NU5hpSjB7HaqJBjgzILEq54gzzLkxpvcYh5ArV/d6S2In2SZm5fIuXdVcZuu4g56UYb35IfW6NYgR5B0GVRbwq3BFZ4FTHZ7SuxfnZEodvGl4AujqDRBeJcXJq4nTljnwJZq8vh7Rp8pFf4M3xiky0TAgTX8sPRgY3oRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037496; c=relaxed/simple;
	bh=htSqJViNvoop5zuONPRmW8u4+ilDPqbn0E04TQlcwzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j91/I81bHaiusEu281MRQ03KaNBCdMC5BuEda1R4LQzq0320P9KEGTCERzmsKkh05gIeOmvMZir3brwbgREV3r2NWl9JhQVRL9eNsTEWSnMME3c0Su8C6TdC++SQEDPY5IsHO6lPgUzPYHtIoWoEwSaFMXwloU6D7rsBeszZUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciJf1Nk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B646C4CEE7;
	Sun, 20 Jul 2025 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753037496;
	bh=htSqJViNvoop5zuONPRmW8u4+ilDPqbn0E04TQlcwzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciJf1Nk/LgIV+vSf2+nl+RlfhlMtMZ7Sg3e+x8g0ngfzlRv0u54FH3FHtZjCHhZnv
	 8St31I5M7UkOMHv3KMk40CD1TUxRMIbH7Orb5vd38e1O+ZARO5o+QINK2pk76GYK37
	 NoSsV56QMmfZZB+ER/HbDna+hJdOi0kHcDBfCPiWRfTKnI09KrPdL4VaqsITDXKvtK
	 bPKfyeKDm9+8kqNB3QHLxA5lD9R6GQy6bDU1tn6JSE7SqTpdpvP/p9aINyXrsKZaMV
	 9hzHlVond010clXeyBpaXFc8HuUsyibcWBKtC/X74m/bbwBgvo8fqsqC5ID30Nugme
	 b6AQOfCEk3lbw==
Date: Sun, 20 Jul 2025 11:51:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/5] fuse2fs: stop aliasing stderr with ff->err_fp
Message-ID: <20250720185135.GS2672070@frogsfrogsfrogs>
References: <174553064491.1160047.2269966041756188067.stgit@frogsfrogsfrogs>
 <87seirz2pu.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87seirz2pu.fsf@gentoo.org>

On Sun, Jul 20, 2025 at 09:27:41AM +0100, Sam James wrote:
> This seems to have introduced https://github.com/tytso/e2fsprogs/issues/235.

Heh, section 7.23.1 paragraph 4 of the latest C2y draft says that
stdin/stdout/stderr “are expressions of type "pointer to FILE" that
point to the FILE objects associated, respectively, with the standard
error, input, and output streams.”

The use of "expression" should have been the warning sign that a symbol
that can be mostly used as a pointer is not simply a pointer.

Later in footnote 318, they say [stdin/stdout/stderr] “need not be
modifiable lvalues to which the value returned by the fopen function
could be assigned.”

"need not be" is the magic phrasing that means musl and glibc are both
following the spec.  IOWs, every C programmer should reduce the amount
of brainpower they spend on their program's core algorithm so that they
can all be really smart about this quirk.

So yeah, you're right.

But we could also do:

	fd = open(logfile, O_WRONLY | O_CREAT | O_APPEND, 0666);
	dup2(fd, STDOUT_FILENO);
	dup2(fd, STDERR_FILENO);

and skip all this standards-worrying.  I would have just done that, but
for fear that somewhere there might be a library that actually *does* do
freopen and this trick won't work.

Yaaay, it's 2025 and we all still suuuuuuuck.

--D

