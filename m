Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBE296466
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369514AbgJVSFW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 14:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369501AbgJVSFR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Oct 2020 14:05:17 -0400
Subject: Re: [GIT PULL] ext4 changes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389917;
        bh=qDCZISBSki8pArjbIBxaglzAK6l87pa9t4S+RqEXsTQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sEo5TsT3Dzm6yufV/ldCv8kYFfdWUY64rxoYSjeCcQK2prc+rdD57fcetebE/0MVi
         tV40ChG/U5lfNsksGNaHTjUVniUtlS2BJUkYf73ovNKbFUtOBIMnGSJA4VgXpqu7xC
         5Sjak6TBxre7RS1Yncr/65boCewdglmw7NMWe/ZU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022165450.GA1172314@mit.edu>
References: <20201022165450.GA1172314@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022165450.GA1172314@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 1322181170bb01bce3c228b82ae3d5c6b793164f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96485e4462604744d66bf4301557d996d80b85eb
Message-Id: <160338991724.20886.9500475764133594426.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 18:05:17 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 12:54:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96485e4462604744d66bf4301557d996d80b85eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
