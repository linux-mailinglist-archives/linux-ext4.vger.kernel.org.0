Return-Path: <linux-ext4+bounces-12946-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C6D379EE
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AC1D3016922
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD62325739;
	Fri, 16 Jan 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lltjdw23"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B91E0DE8
	for <linux-ext4@vger.kernel.org>; Fri, 16 Jan 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584100; cv=none; b=FGLnS+1yhXE5QyBbZyuvot11z/7kbG0ylknB5xo3Mjxu/P2NRCrwJu4Bs2PVzRJB83QxQuz09qK+5DHJxURM3Ds1KRqh/lXiv9zgjNvtpO2BssfXaExc/+fDXvGDuVPSw5WjZf3tNa230tEADD5AzmDS5vTWt4DV1CcvgXiVWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584100; c=relaxed/simple;
	bh=Nv/VAt+EAzdXSF7f9jN/6cBl1s/6kt/3mKwiGyrytBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKYB2n6UAmPUrsbU3t8MCKVxiO3rBWnqXK6BKjbdv6nzUjaC3NGugTIxWkg7TnTTzjTTrK8Kra/SoFVWDTcnLQCZPrzeXX0gbgANaZ0NsqbVyvCDVoRg2BRlZPnyDYg/TpQgPMI4gY2DbOnDTyVPSaVUe3tgHV5+EFXOWfR+O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lltjdw23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C003C116C6;
	Fri, 16 Jan 2026 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768584100;
	bh=Nv/VAt+EAzdXSF7f9jN/6cBl1s/6kt/3mKwiGyrytBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lltjdw239Rrz4dva9Lm0WJYS+1QsMLb7EgbzUJDNTUQWS8MQkiZg4lo65+vUiHtm5
	 gPLgT5NpynfHcAoW5pqTovMnEwvUBiIGzZ5ZX8eT4DdkdbTy+27kqEdOkdatmXUDm7
	 sgMQYxHddrAp7bAJBYjPecGG0fkN4bQ6NDS5hbC/kbI8NO36dyLwdIzWcoleUFXeoP
	 f/pRl6yg7XFc40VqYXnebNiWj27ZroE4SlU9uoAOHo1dLy4TL5+g6bXnl3Tpbrgr4x
	 eUD+eHMWzBeKRmFCvd5UnmccDEMaP2np7PiT2RsLP3fdcTCllhzfHRMYGf3JkYP4dq
	 d41zr4Oow5Flg==
Date: Fri, 16 Jan 2026 09:21:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] e4defrag inline data segfault fix
Message-ID: <20260116172139.GB15522@frogsfrogsfrogs>
References: <4378305.GUtdWV9SEq@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4378305.GUtdWV9SEq@daniel-desktop3>

On Fri, Jan 16, 2026 at 05:25:35AM -0500, Daniel Tang wrote:
> Please sign-off on, and apply, the patch at
> https://gist.github.com/tytso/609572aed4d3f789742a50356567e929 . It
> fixes the bug at https://github.com/tytso/e2fsprogs/issues/260 .

Perhaps that patch should get posted to the list for a proper review?

--D

