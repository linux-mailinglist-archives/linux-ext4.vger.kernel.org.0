Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF43FF26A
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbhIBRiP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 13:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234504AbhIBRiO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DDCAA610E7;
        Thu,  2 Sep 2021 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604235;
        bh=2xm+18OybcggZ8NknSshjjbxsTWnPTVm8djTfpirJFg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B+VS0W4JWk5Vi6jDJWqituFL482EcIjPT165t8R2+jiDTYd8OYqnKyKu4arUn1Lky
         lP0QIfNsbHoS9edHytFc+sJX5EDnDBMAlhKpmM3IOCh0jo1KDAK/Y6mGMX8dytSYOO
         A/sz2tY9N1lxU5UDoSEQb4UzmFFNzXRoxsEdl1yry6ht5Qgf64PHqvET++i2bVQjpe
         oNqZKVh/aT8YrywUycnzmdRqpjd+2lmqrUtFPxF/afeihIsxTv97djiZEobsBf3ukJ
         DLugKAyYNVm9w9rdUJnrcICfX6TPJpVgV7+rIAVYRcMLwK40V8Yq9VQdqPX271oN4R
         iq0d9Ix7p7jCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CDE4A60982;
        Thu,  2 Sep 2021 17:37:15 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTDnt5RzyL+gOoHK@mit.edu>
References: <YTDnt5RzyL+gOoHK@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTDnt5RzyL+gOoHK@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: baaae979b112642a41b71c71c599d875c067d257
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 111c1aa8cad4a0069dfe98fc093507b5b2cdfda7
Message-Id: <163060423577.29568.3596244468595528780.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:15 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 2 Sep 2021 11:03:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/111c1aa8cad4a0069dfe98fc093507b5b2cdfda7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
