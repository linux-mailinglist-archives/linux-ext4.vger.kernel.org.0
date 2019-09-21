Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9CBB9FCF
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2019 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfIUVuY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Sep 2019 17:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfIUVuY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 21 Sep 2019 17:50:24 -0400
Subject: Re: [GIT PULL] ext4 updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569102623;
        bh=c7YA1/Vng4BpJGQFV0of9o0HhJIA4f7Ju3nwdGDs/AM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PdEvwGIlMcglrIC0oQXj8ApwOXneZRmmBu8Nx/PcuO+tDOAU1iuOQwmjwx6n5NBBI
         T5VuQE6UsqWmiiOvJrHHa7DkeAA1lC9Qp6rKFdpzGjW5DwJ+jQqIjEhdTJ1hlXeXVz
         8/q7KyeocioBKLLy3q7edGUc4MKDBUCjWl2RXO8Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919205641.GA23449@mit.edu>
References: <20190919205641.GA23449@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919205641.GA23449@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 040823b5372b445d1d9483811e85a24d71314d33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70cb0d02b58128db07fc39b5e87a2873e2c16bde
Message-Id: <156910262382.18589.3090864205440048270.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 21:50:23 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 16:56:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70cb0d02b58128db07fc39b5e87a2873e2c16bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
