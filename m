Return-Path: <linux-ext4+bounces-5155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B19C8C7A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB24FB2AD4E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8912BD1D;
	Thu, 14 Nov 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YYdEDfN5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33636A95C
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592435; cv=none; b=IxS4epsOWJPSzHHaguxYFF8Dtgc11EPxLoqeryacoSLyopAdbi8cCSft36NF1QgYS7YOvbdPN5SFyVBd/RyksKyq7D/XgdY3p4gkpBgNden+7XKNBRT/jKG/DoZN+aMCGdjtaNN6x2F7goVTM1XKKYno56gxrE7HwiKAVE7njJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592435; c=relaxed/simple;
	bh=5Ufs1trmbC3y4rXQz/iEI18w20t/4ZAiPLZsOMEN4Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVwgfyhgZb/cIpdyLkSnI0/oDBN9FAF8HZkYTvO4FnUaQudsYyqeyfjsgcztuIcLirJTUkdes5ZFiNqA8mny+sidoSe38m8T4z/OoNEK4Z+/pVXIa+Yyojs0KHBCNNM17KNLeVQTU8ubS38CFJq8Gdmd6zztlm7xaaQOG1cXMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YYdEDfN5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrjKR001821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592427; bh=s0S0NdEdBmejYEXMXsBpbXJhzF8I3A5IbRh5EVSyXXw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YYdEDfN5VO/Z+8VSOnFm9kcgAZ3oziPtKH9C/Mtv6pVGyB3nDEXsMXl8eYXID0XT8
	 3w2JcwChsPAJo86qeTxVDSZvMjzI2MKdmGJT0gEIs0J2YETJf55nulNl9AcHM8wGiP
	 5JuS98wxizfkXTF1le2YxnQ/YO3BU6Cr7zMk5/IehPlzXgDD8tlgO4OYIbtJUyRUc/
	 atKp/0GlHXiLSOkLxyLCoG28U0NEK0z6htk3+Usyf2+uhvHD6ZHCeMhzZAkTGFq+/Q
	 zzw8BjwfTj5/XP3VeKyrhi2W9GkV+tvtnyGYRFU9v4YOBb5kB5QVDKrTzALTO5U9fh
	 Rj1iotFL5zfAg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4A53615C1A13; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas.skupinski@landisgyr.com,
        anton.reding@landisgyr.com
Subject: Re: [PATCH 1/1] ext4: Prevent an infinite loop in the lazyinit thread.
Date: Thu, 14 Nov 2024 08:53:37 -0500
Message-ID: <173159220758.521904.15496365458938404053.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106134741.26948-2-othacehe@gnu.org>
References: <20241106134741.26948-1-othacehe@gnu.org> <20241106134741.26948-2-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Nov 2024 14:47:41 +0100, Mathieu Othacehe wrote:
> Use ktime_get_ns instead of ktime_get_real_ns when computing the lr_timeout
> not to be affected by system time jumps.
> 
> Use a boolean instead of the MAX_JIFFY_OFFSET value to determine whether
> the next_wakeup value has been set. Comparing elr->lr_next_sched to
> MAX_JIFFY_OFFSET can cause the lazyinit thread to loop indefinitely.
> 
> [...]

Applied, thanks!

[1/1] ext4: Prevent an infinite loop in the lazyinit thread.
      commit: e06a8c24f6445c2f1b5255caa4f63b38e31c43fa

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

