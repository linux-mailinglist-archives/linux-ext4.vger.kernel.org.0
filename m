Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA744CE9E
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Nov 2021 02:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhKKBKq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Nov 2021 20:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhKKBKp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Nov 2021 20:10:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D70C7613B3;
        Thu, 11 Nov 2021 01:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636592876;
        bh=u6nZZNxTaFfPuid6+MAjKRrtv3XZhldRV8IVVImOuJw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mtF2ixFC9y7SsRndaS4kx+CoaEAj6l5WOF6yZYfpbcFIT8bCj2O+n5jNnJ5IpDY9Q
         ZWhyH0hhdFzHNEc1MLUj6tU80A7/towD/b5hkdKP89EdL+RlWwGio0hMrYlCUyX2sv
         h1Liwia39CerFt/mrNYNWVs4a15WY8u5Xy6/TNFLanO94PeDOGbJmmmIB5isLgaPOe
         4V+JAImMxzbHUEd7V/fZIJ5v38wYzGi/GjGXwswcFNlpYHeMi7wJOWOqx5owwfqJVv
         jX9XdUmIe8+T0LYqB3t0XcQQbYpshjRqaOmfJ+nTXBtEoP1Lz3hwWdEgBY9H/ONZwD
         5y+zZhUXBBK2w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D1BA560965;
        Thu, 11 Nov 2021 01:07:56 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYxLdGu1Lkcl9HzP@mit.edu>
References: <YYxLdGu1Lkcl9HzP@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYxLdGu1Lkcl9HzP@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 124e7c61deb27d758df5ec0521c36cf08d417f7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: debe436e77c72fcee804fb867f275e6d31aa999c
Message-Id: <163659287685.32583.796849278586568089.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 01:07:56 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 17:45:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/debe436e77c72fcee804fb867f275e6d31aa999c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
