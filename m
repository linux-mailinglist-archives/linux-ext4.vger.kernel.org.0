Return-Path: <linux-ext4+bounces-8782-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9872AF65B7
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 00:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BB91C257CF
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654DD24DCEE;
	Wed,  2 Jul 2025 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="J3dHg68m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6821D7989;
	Wed,  2 Jul 2025 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497165; cv=none; b=o7/V9TKJPYD99m+ug4mWND8e1d1U+vH9n5fKzG5laKOJ1lNOzG2+p0ayC+eZhRMrsV/wHjfCQXQrZ6AI+b8+grcSQtT8tdczJHAWfEQpLfI3ZVd03pzMFnnzjGJoyKbOKtNL6qffVOyuunMUyFtR8N34NDw6DWGM44waaJrArhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497165; c=relaxed/simple;
	bh=h/5ux6cDiu4o+OyiOw2UsteSU+KlOgS9Vn5nFxjAIFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBKlbXXMAIt3+q9VzlX63oY5QebQFJOZv1nJs71vEQmfDDmCuN0o/n/YB15u1OiohH3oX0oKe645A0xHiYEFK/3jjEsRd8kTRqbzCCohFhYkC6PXdaqgqufL/SUZeXPQKjxKuKFo4inMNa93GHKQ+qoeChLCjkOmG4bkLtElxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=J3dHg68m; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EDBF3406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751497163; bh=h/5ux6cDiu4o+OyiOw2UsteSU+KlOgS9Vn5nFxjAIFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J3dHg68mGFe6mKKbDxYm6dJpD7/bRb7hZY0ok/6ZNb65BCTrcBiS0wLpQZjQXfT34
	 snN55Gb7Z7HK0oJU18glzjtlu97O183T/lgpCTvWXkGNy+Mu8kMnYYkJw/mTziYhGQ
	 gv8vPlptg9aEohY9nmfpLT/zm3gMpITFOZoYARYa0TW6a9Qcxeqe1tywHMH4nqv8tH
	 x4eTpgtNgYXbGoX2GsHWdqdcxVL9cOStc+MhqliIVa4w1IVhLhdGx05k8XB1vwfgvW
	 VGnQkE9EFlqNLIFp0TdTDcuaicNDugZ/D+ZvMHJOHloRF76TlMLOjP+W6K7amnAEJY
	 iUyBKgPENxrQQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EDBF3406FC;
	Wed,  2 Jul 2025 22:59:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux ext4 <linux-ext4@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, Bagas
 Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Date: Wed, 02 Jul 2025 16:59:22 -0600
Message-ID: <874ivunqr9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi Jon, hi Ted,
>
> While discussing on my previous ext4 docs reorganization attempt
> by merging contents [1], Jon suggested that considering current docs
> file structure, a proper toctree would be ideal [2]. So, here's
> the patchset that does exactly that.
>
> Actual conversion to toctree structure is in [1/5], while the rest
> is cleanups to make the resulting toctree nicer.
>
> This patchset is based on docs-next tree.

Applied, thanks.

jon

