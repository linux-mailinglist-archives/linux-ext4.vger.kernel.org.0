Return-Path: <linux-ext4+bounces-3906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53433960AF2
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 14:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00F11F2197F
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9971C2DC9;
	Tue, 27 Aug 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NWBDdajh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2371BFE16
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762876; cv=none; b=Yv1gtXVu4HkaAQwA+bq1lSKmBDh+7Ak5dqZLU0NDulAI40jrH2ElrnZByHaOznpIQTZrBNprXYWn65KAYp3MEAnhfdoudNAY1A4gip6yGYQFW6NhPFSpJbj5yvA8bGwjeGYyndA3YqR1vY7Yi9iipQ15maUKghwMafMvI1+rGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762876; c=relaxed/simple;
	bh=9tEouNA51z43LCLVflWg/9lAy+GYZyS6g17VcMAdXbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3QXCqdjET5+6qECmNpaHWKuYrHnmi87l2T+IVYQ0o46e1A14SJ/wflMgYidqypt3kUa1eXScidYfMgpNIJDE7xl40NUa85PeIDMKhAVudPxGH7qPjMjhZehuxLA3b1TNwLdi+SJD6fuVJZGm7XELs35J66JZKsFA+AGCB0XxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NWBDdajh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClcQ4021448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762860; bh=h3SDb6VQneSRFjXMKyLtXqVsh+UppbIVj+mvFf7itNE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NWBDdajh5piwnLD95rkjR/RK9JwQXadjDSH7IT/C6Y57QvOGVkwFFmAOiBUkmW8Do
	 xpOr0S7iM0S5cB07TZtipzafwxrQ4v2ifbsfN7zfkW0nOOuUqHZRENYhLGx6lOO5wE
	 4RGBNUZFwCrn1pUcqtlkArxCeYRPQi0eqdF2yOz64ELHkkRN/GIYNTpynSSKvLFcMQ
	 RD4IxwT5AHtW5u5YbbNJjHWyBg1XftPG8+EJthNgOezmOUiYsCI8gQ7KFU+kpNfJHv
	 BSmNOyNsaDkzMoxV9wXGG1qbC5LNjwgimR1xcHtZajGiNJdXVYZ8yySJUbWlwSqMnN
	 Ut/Rs0t2PhTQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B062215C02C2; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Date: Tue, 27 Aug 2024 08:47:22 -0400
Message-ID: <172476284023.635532.9064427382024981891.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805201241.27286-1-jack@suse.cz>
References: <20240805201241.27286-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 05 Aug 2024 22:12:41 +0200, Jan Kara wrote:
> When the filesystem is mounted with errors=remount-ro, we were setting
> SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> proper locking (sb->s_umount) and does not go through proper filesystem
> remount procedure but it has been the way this worked since early ext2
> days and it was good enough for catastrophic situation damage
> mitigation. Recently, syzbot has found a way (see link) to trigger
> warnings in filesystem freezing because the code got confused by
> SB_RDONLY changing under its hands. Since these days we set
> EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> stop doing that.
> 
> [...]

Applied, thanks!

[1/1] ext4: don't set SB_RDONLY after filesystem errors
      commit: d3476f3dad4ad68ae5f6b008ea6591d1520da5d8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

