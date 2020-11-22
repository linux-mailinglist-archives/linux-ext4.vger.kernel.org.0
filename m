Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43232BC97E
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Nov 2020 22:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKVVJS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Nov 2020 16:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgKVVJM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Nov 2020 16:09:12 -0500
Subject: Re: [GIT PULL] ext4 bug fixes for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606079351;
        bh=e7mD/1wefUD3QtT3Lj8vmKKot9MfGApnoPdJU2kClBM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JAQ1dmuI+zTRC547gxgxFSOymQmoMdWNQ6z9M+F5sB2psXmDRG94EoOZtDBmpWT13
         0hSMdqGcAKpzjPHxklZPj/1i65kiI/EFQXvF3WHVxp9QsnTWMDrmsJENubP2239ALf
         EuKTzKlOesOOW7u0uMyZjPB1l8cW5By+CIP+JVuk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201122190743.GA198093@mit.edu>
References: <20201122190743.GA198093@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201122190743.GA198093@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_fixes2
X-PR-Tracked-Commit-Id: f902b216501094495ff75834035656e8119c537f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7f07fc14f06f98fc5fe1208bac5f6f5bcda2c10
Message-Id: <160607935162.25428.7387049215065365904.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:09:11 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 14:07:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7f07fc14f06f98fc5fe1208bac5f6f5bcda2c10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
