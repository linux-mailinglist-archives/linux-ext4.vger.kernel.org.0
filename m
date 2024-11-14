Return-Path: <linux-ext4+bounces-5159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7D9C8C39
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 14:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44991F21448
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C192C182;
	Thu, 14 Nov 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CVbX3jKs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892520B20
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592457; cv=none; b=unanTcWHlZd8j5SHfyCF5L5MydXPrwoSxJER1x5sYrKs+eFG9EDaaCqM080Bu52fWU81PS53L2t2e3t1XPeVshIW43wHnhpAZkKcM7B908s9+k1KH+nXterLTT5DkqhHSUqKJ+6w905Whnb4Eq07BHMQKluQxO6Ck4TLziBs32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592457; c=relaxed/simple;
	bh=jNxc/YNXVLv9GMvRMQsXofvRMh9ptc13+13RL4iN23g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrjhjfTw1ud13wxLQ9ekFa85uc8rDa/6jCY70DjaDRpgA1oL3KTHjkO4zB3KIRomOM9SJs2H+zUSS1umYeX7OwTPACcK+7HjEY2F7sMItoej7DUNe5CPKXn7AHJyhp5vNVt1Qk6nrLV6NMX1Wk6eUcqEOz44YqOuy3ObY4XWqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CVbX3jKs; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrjxD001835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592427; bh=D0AAAvqZx7+5fRAYSOHJ+swO2Elyd+tG1w+ita9HvSw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CVbX3jKsbvkN+9OhGwkCfzUNbs69q52Y6Vn7jnGEELkCU5Ipa0lolM0vkLAgM20cu
	 /YuH7dL4OUxT1j/KzFd/zeBrz89/kMcfv2CiTle/Ugxhn/JJ5fXMsh6Dn+7YYne7mI
	 Xy4yDKgteIQfOnBOTxhIB5D8X1uCo5u0lz1YAI44ficHxK3EmxOqWj1Yh83xg/hvGa
	 Fbz1Mf8A94ZqlmBckJrCwNqJXT9qdJFW0mZC9zDkJY+KCJTM7QUK6GQFT//duOLxT9
	 jsLUekqCpTe5R+3X2ydfIwZO/sTmLa1tgZHFdQIH1mfs8xdEB7TBw9V3E+V1dCLgZC
	 lKCHGXyANyHHw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5016515C1E39; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Annotate struct fname with __counted_by()
Date: Thu, 14 Nov 2024 08:53:40 -0500
Message-ID: <173159220757.521904.13348650494002839092.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105101813.10864-2-thorsten.blum@linux.dev>
References: <20241105101813.10864-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Nov 2024 11:18:14 +0100, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> 

Applied, thanks!

[1/1] ext4: Annotate struct fname with __counted_by()
      commit: de183b2baf90f0acc1854a3998c14b8b228f9643

By the way, in general, you don't need to resend patches unless you
need to rebase them to fix patch conflicts; I track requested patches
using patchwork, and I tend to process and review patches in batches.

If you are concerned that I might have missed a patch, feel free to
reply to the original patch with a ping.  I'll see it in my inbox, and
even if it had gotten lost in my inbox, I can find the original patch
using lore.kernel.org or patchwork.

Thanks!


Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

