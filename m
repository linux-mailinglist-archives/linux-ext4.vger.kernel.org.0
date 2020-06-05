Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0420B1F03A8
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jun 2020 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgFEXuR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 19:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgFEXuP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 19:50:15 -0400
Subject: Re: [GIT PULL] ext4 changes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591401015;
        bh=uBa3OT3XhSBCnCDg1Z6lxzf8+XtuS389W5kChDSZAj4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V2ZCNogGXNMqA4Ar85Sg8qHbUoWtaOg+/Hf2IKO+5v1j+2ViSxRPN3sarWCHte80t
         y9XRlJGeLgOF7Rf6iaHd8V4nK7HupIWyCmFXarJvgRaH/yOsyRpiQhCYTqKx5x8Jcx
         r5yaYwpIWOaEWYpB1GESQlzQzX0yy2d/h6i3/838=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604231259.GA1992367@mit.edu>
References: <20200604231259.GA1992367@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604231259.GA1992367@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 6b8ed62008a49751fc71fefd2a4f89202a7c2d4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b166a57e6222666292a481b742af92b50c3ba50
Message-Id: <159140101531.11239.7586941874730554298.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 23:50:15 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 19:12:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b166a57e6222666292a481b742af92b50c3ba50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
