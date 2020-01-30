Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7114E632
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2020 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgA3XuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jan 2020 18:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgA3XuR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:17 -0500
Subject: Re: [GIT PULL] ext4 changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428216;
        bh=q9mn1FfMiKVKZPXSs9GnfDX4utx5V83YBgWvfVNNg9Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ABXFMiwwgpBEjY8xx5OM4hzzbs4qbXIUzu+7FNz0l+4LJ7rzRkt6l7rZNtikxvHH/
         EWLbUjDXe9xbDiQZG16GBEuhTSbUSrYOT7K+NSE9wY2ieejnQKmKVeOrODLTCtDRAj
         P7RWl15bJGqvJr9bFz74+z+iQpbErvU8YslAVLA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130005817.GA331314@mit.edu>
References: <20200130005817.GA331314@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130005817.GA331314@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 7f6225e446cc8dfa4c3c7959a4de3dd03ec277bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5da4c933c50d98d7990a7c1ca0bbf8946e80c4a
Message-Id: <158042821678.30792.14650350060155285879.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:16 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 19:58:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5da4c933c50d98d7990a7c1ca0bbf8946e80c4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
