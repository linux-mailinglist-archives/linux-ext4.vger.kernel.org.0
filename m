Return-Path: <linux-ext4+bounces-5157-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708139C8C33
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D621F22C0F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD693FBB3;
	Thu, 14 Nov 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="o3sRW0JP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572A1DFE8
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592438; cv=none; b=hH2G5VuTCgK+8HUe49Ntt+fzjrC3Q0AhEFGnwuXYTYKtq+eR9FPfQ/IXuQzwh3XtpYIRBi9083TmM5s1v/hLpIKgLQrrf9J5GBAZcvPz7rEIAcLDWTbPGXG3/nDZtjy4GHE3hH0ujgykJzd2Ut59YUbyfmP9VIJwSrkaqtUktwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592438; c=relaxed/simple;
	bh=Hsnfag2yvfmxi96icq+UxixAXAu9t30q+lmVHZuFVcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcI00+5vderPYzLSvda4ENjp7+rfUIxvjDAohVBCOEpRPknFPkW9vmCP8kOnRKzcHB5aw1zdIvgNGpmOVlBZsz4o2w+JhrXhjfequyFMbwdxP6jFpVKPnAv12oGDToqxkJ2q+R1SE6JxOLe1LAE+jU9PDq6B4Xi3WXmqrvmW3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=o3sRW0JP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrhYJ001787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592425; bh=JOCeY+EJ4icaRk50gK7n0dQCHR+VIRbmQCyFly9i+dQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=o3sRW0JPQh0jW52wuv/lEux5uSNoT/GVFZcKh6CRrGX536D1Sxe4Rdz+BfkC3D5v4
	 B/Dwy/iXKLjlom9BKgDdQ9Fdz8vyFwVqWUO9D6tludXymvw7mZZ3KQBeltDUA/FSXz
	 AUhz32xYoXt6uYpY5ExqeSJeHpOhT2rNxnw4PtkSctVydDqCAaMeHK7Kinja4ChC6A
	 RY6YWToqMBSgcsUCUrdmfwQ0YHnl49IktksfB6DvEoOOL8vvelvAhVWwVe31XR+ycT
	 ciF6FscCFkqF4s5YXo26ppFHmcOMWQyknEH98Gvy02m8wMHWNJm5E+Y42OkUMp4Tdd
	 cogR/ZAYiJAhA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4414815C1311; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?UTF-8?q?Daniel=20Mart=C3=ADn=20G=C3=B3mez?= <dalme@riseup.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Fix comment describing journal_init_common()
Date: Thu, 14 Nov 2024 08:53:34 -0500
Message-ID: <173159220758.521904.7231961435577628717.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107144538.3544-1-dalme@riseup.net>
References: <20241107144538.3544-1-dalme@riseup.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Nov 2024 15:45:38 +0100, Daniel Martín Gómez wrote:
> The code indicates that journal_init_common() fills the journal_t object
> it returns while the comment incorrectly states that only a few fields are
> initialised. Also, the comment claims that journal structures could be
> created from scratch which isn't possible as journal_init_common() calls
> journal_load_superblock() which loads and checks journal superblock from
> disk.
> 
> [...]

Applied, thanks!

[1/1] jbd2: Fix comment describing journal_init_common()
      commit: 3e7c69cdb053f9edea95502853f35952ab6cbf06

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

