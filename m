Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8948BBAC
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jan 2022 01:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbiALAN4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Jan 2022 19:13:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50048 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347343AbiALANu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Jan 2022 19:13:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB170CE1BC0;
        Wed, 12 Jan 2022 00:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25D21C36AF2;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=EBvMjxnpCZF35twFGLPobRtxt8N39W8LmEgBwmjUEUk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fnbWa5eJEqgSrFrx6fqYj8mf4rohBUdHZmTIr7LKE3UzA88PHPLslc2CsvNbyetag
         Zpi16pqnEbaOgEfyIQEOrpylLvLqX6bwG6XL+Do2VM9aQ9DgF0DJeONsU2ZdX+yuWP
         3VAjJdMN7YXt5Q7dmQFAFYdLiD9ULU+rC1+hEEwWugqt1xW8KTzFEHbT7nbnnmsDCY
         p6T9MUupSHXyw7ZhyxrPwVoHD03TNK8ww+a1uKBaYbzlpKXJihlFXifVyw9zN7SkC8
         1sBvVZjJj6hREjZEaYhW3//ODfdvzRPXzCWPqReuyZyc+vtJX0uur/haIwodBKx3EZ
         tBtU76NL84cMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1348BF60795;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdyxjTFaLWif6BCM@mit.edu>
References: <YdyxjTFaLWif6BCM@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdyxjTFaLWif6BCM@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 6eeaf88fd586f05aaf1d48cb3a139d2a5c6eb055
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dbfae0113f1423b42c304989a3cc8a7dd0ea53e
Message-Id: <164194642607.21161.11547739761346629485.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:46 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 17:22:05 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dbfae0113f1423b42c304989a3cc8a7dd0ea53e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
