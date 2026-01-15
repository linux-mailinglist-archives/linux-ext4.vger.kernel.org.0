Return-Path: <linux-ext4+bounces-12862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC1D2597E
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2BBE3020829
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749B2BFC85;
	Thu, 15 Jan 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Jg7BCuWh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB62BD5B9
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492951; cv=none; b=gVm3gCrU4kCBw37hHhU1X1iWr4Q6UUtVheGM7dH5hLdKunrVNVdangZwgdzpdwE4TJ/Nxv2O/2JRnTSqKHEPowhusn/4vfzmaWjF4twcsaSnFJToG49OqwvvG7HslrrCAKXSsj/dILNE2gkTS723p9JkLq3nTL3dMF4rMLuDhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492951; c=relaxed/simple;
	bh=crB80UqPsCW4n453zIIcOea2kSSOgIt0ZlnOc4hSUgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJJKmXG/LKn1heVEbJ08ZBIvobDiHnw6rdezaoeqzMR24zCMnJWks3nWA9krkBDpJGvCt8HWgWOjDtGTAM7aI0fFQCv5yDR9nAjUtCBjZhHg4EX5gzWOCA6DrheEqyL4p3pWh1apK3wsRKuyCN4sLb3vUXVPwVLYsueHnSdXpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Jg7BCuWh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60FG1x53018687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 11:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768492922; bh=DUa+SGWAvz5LaCLG0Hp1f3XdZf4R6o/ANNgybU8EDXU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Jg7BCuWhQpMeF0ROefPLK3TaKobRWUy5I6gcTK2uM2qZ0drpR77PFlZ/PAPmqyNTr
	 xJ6vRzj8I1yUbOZ2SIrGb8GiBnihEZkCB/OeZyp7klmfhNB/lPRo5GJFXN6C+wnxh0
	 mju3fNT54MvCQQzb5c3giexfRo6gmdDApsZnd1HLeBx1Mi0fw6T/vLGGUfP8hfi+T1
	 0Kg/GQmWXQSdgIaVMTS+gxwMf7MqGb0VvdVST3DRmajstVfxwBHvaHyJecyDH8/yMu
	 rSdn5lW538ujkSyaOUVyzCtucYa2jn56YKmC2O5qx9UM/ZaNlE0Hu1eWzyDBHbaKA7
	 ROaEZ4Ku9ldXg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3DE0E2E00D7; Thu, 15 Jan 2026 10:37:48 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
Date: Thu, 15 Jan 2026 10:37:39 -0500
Message-ID: <176849145606.443151.7035030523059714855.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204101914.1037148-1-arnd@kernel.org>
References: <20251204101914.1037148-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 04 Dec 2025 11:19:10 +0100, Arnd Bergmann wrote:
> The padding at the end of struct ext4_tune_sb_params is architecture
> specific and in particular is different between x86-32 and x86-64,
> since the __u64 member only enforces struct alignment on the latter.
> 
> This shows up as a new warning when test-building the headers with
> -Wpadded:
> 
> [...]

Applied, thanks!

[1/1] ext4: fix ext4_tune_sb_params padding
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

