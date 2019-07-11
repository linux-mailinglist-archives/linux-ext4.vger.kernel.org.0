Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740FA65139
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2019 06:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGKEkX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 00:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbfGKEkM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:12 -0400
Subject: Re: [GIT PULL] ext4 updates for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820012;
        bh=+i2fFwAiP6MU1zOB0IsdKhzvzjgRdMUVZPn20s/G4ww=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l0oDuuTllDVoNvXbLYQFDG5dniO/SfsXOCgOoBDMhNRcRQjdTaSseT7lalirIAxG7
         BVpYGEMc2I8PgzwCpg5uPxVtgAt4VY+SWnRRbLW7W767n0QlV1jQAuNB9d4KgqTcir
         Pk6SdJjc7ZftO+c8JLqaflY/OyShPyXzKCsO4niM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709225547.GA27938@mit.edu>
References: <20190709225547.GA27938@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709225547.GA27938@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 96fcaf86c3cb9340015fb475d79ef0a6fcf858ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e756758e5cb4ea29cba5865d00fad476ce94a93
Message-Id: <156282001195.18259.12847518251698684552.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:11 +0000
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 18:55:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e756758e5cb4ea29cba5865d00fad476ce94a93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
