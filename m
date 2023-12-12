Return-Path: <linux-ext4+bounces-413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864E80F72B
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 20:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DB5B20E69
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4A63595;
	Tue, 12 Dec 2023 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWgVw7VH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD56358D
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 19:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A901CC433C8;
	Tue, 12 Dec 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702410572;
	bh=iRox8wBzt74waqIhkUBhPBSuffNObnSpo3yDqzOx3pE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LWgVw7VHq0Z3qmvqGZ6T9VLRTKZr9Ss9CLlXCjjnRYvfD0CdOB29ltGskVveASe4G
	 /grgx7mbx7FJeKwu8H6zpqhpkEhvinEtszX2qntUqeB5y78bUpNRvL3d7J8KF9ekXJ
	 /AiTo8rdN+Hp6YAmUNqB5GJ1DtmBUc6DZgEN5BsyQlqH3nlaqRK6kb4NO95/NXpjtr
	 4Npdg8wMA1mIq2QRNPXYPKHdWplF5ymarBtN36w3c2kHNyM8fO02OjmYGgrESVtNPd
	 tKc6qkDYImKBNuzz7yPOn2BZpIMu0gFzq0t6l0AQzhfuHa1kVg6l7w+NBav4Tz2Pc/
	 IP12CBqP3440A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97DADDFC906;
	Tue, 12 Dec 2023 19:49:32 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231212193303.GA154795@mit.edu>
References: <20231212193303.GA154795@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231212193303.GA154795@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc6
X-PR-Tracked-Commit-Id: 6c02757c936063f0631b4e43fe156f8c8f1f351f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf52eed70e555e864120cfaf280e979e2a035c66
Message-Id: <170241057261.17345.424030301237809121.pr-tracker-bot@kernel.org>
Date: Tue, 12 Dec 2023 19:49:32 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Dec 2023 14:33:03 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf52eed70e555e864120cfaf280e979e2a035c66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

