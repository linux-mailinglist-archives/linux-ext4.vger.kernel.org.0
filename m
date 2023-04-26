Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740C66EF8F4
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjDZRGn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjDZRGe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 13:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3247D84;
        Wed, 26 Apr 2023 10:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99DEE63068;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F8D6C433D2;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528793;
        bh=xbO5CCjdTR5OY20rNcqmQ1F5b+Fo9XJdxn5T+Gex6m4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iOelzbjrDM6IrXCHYj5RjkPwDqleoA6Ew3yX9LlwfTMgtYZ3JEJCnI62Cle7dL05g
         9YbBWNnKK1V/V0c0lUtB30+Ml5z554IyUJuiB/5+t2r+euUhvDBdOF85DsdkawGv/m
         zn7lm2x7N+wcJFzW0FuT4cOB7ZsbgjdYKkG26Lj++uE0dJ3uFpfTGYxbctNnEml/g9
         46IjD4+SrHDWcGuaviFCPqdxhpEt248Tq6dqIeF5YCBFK9XD0+Pk5CAkRS8nroA3HR
         ntX2vX0Zj6A5oqaLb8l5plNP39GUvzSQh/uAciGhRvvWypaRbtEoGYpqJH7NtUYLfX
         FJpSIqRfh+Ncg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2884C43158;
        Wed, 26 Apr 2023 17:06:32 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425041838.GA150312@mit.edu>
References: <20230425041838.GA150312@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425041838.GA150312@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 519fe1bae7e20fc4e7f179d50b6102b49980e85d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cfcde1fafc23068f57afa50faa3e69487b7cd30
Message-Id: <168252879298.19907.8093408805770238263.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:32 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 00:18:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cfcde1fafc23068f57afa50faa3e69487b7cd30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
