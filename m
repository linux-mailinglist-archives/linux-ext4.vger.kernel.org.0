Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C783C2893
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jul 2021 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhGIRoT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jul 2021 13:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhGIRoT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AA0F0613CA;
        Fri,  9 Jul 2021 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852495;
        bh=HxAxEZuMRhdfgDkTXXRXOfgjXkKwANM5AQj1yoTUImk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DjHeVdCa+ZrwGcSys7cO03c45jiqjZ0MIwWiDebaL3RHOaFC2NhiYD6/LbCjBiHyB
         Tm3zwfO/ov14Kg9hpsgm4zkVdsLcmwYqjGFXhFbXtZ+RQHdyhS8J+aSlDYELDZcJOM
         ckpLV4Vw7pl+FWQsyCIY2/Gl2JNXMOV8glZNubeVzD+4oOKaSNZx+NW6T3kjQPz036
         9lY9UacU+Qc2OPbxIpGlC2bhn7GlkOHYxhXWVovo3B7I4+1btOprJmqFMIo/o9QK9c
         uBskp++64QXbma6PZG6b//c4RzemFDuOd3MvAyT1RIjg5jx+flsJWNu+p9I/dliAL/
         nFRe7xL7JEMVw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A4662609B4;
        Fri,  9 Jul 2021 17:41:35 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 fixes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOdfoq/0eBHtjTht@mit.edu>
References: <YOdfoq/0eBHtjTht@mit.edu>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOdfoq/0eBHtjTht@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 0705e8d1e2207ceeb83dc6e1751b6b82718b353a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e49d68ce7cc5a865ce14c1e57938438ab01c3ce3
Message-Id: <162585249566.25269.13780808157547571779.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 17:41:35 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 16:27:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e49d68ce7cc5a865ce14c1e57938438ab01c3ce3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
