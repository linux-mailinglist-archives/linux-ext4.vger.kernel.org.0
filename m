Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6254B54D
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jun 2022 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiFNQGN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245561AbiFNQGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 12:06:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D73ED2B
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jun 2022 09:06:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F8ED21B66;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655222764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WsMisGCQ9XbH7IR+LYKRkKwUqxoZ9UXP/XQYt4JUuNc=;
        b=GY/Ar5XbMiQF6zASanFcvsQ2v/B417t95qMKOuXNUMK/gVfGevHmUBwEE4Pz8A7anBRngU
        eNIU8fTQ1Qn0mOz6U39eh9pnP36PwAQIfSE9IA3O9cU3M7HltU1DhDSejBiikXpSEzkQGX
        nuoHqMMIG1XihkrlzElUtxmXeW14oQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655222764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WsMisGCQ9XbH7IR+LYKRkKwUqxoZ9UXP/XQYt4JUuNc=;
        b=W9phEljpCCBpe+DUw5aI+fwmDjOxLhQ1aSBEvmG6GOuj1KXlaHkU1qhQHH3+8JCtHMN428
        10cF2JxFhcQcoWCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27EDC2C145;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA519A062E; Tue, 14 Jun 2022 18:06:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/10 v2] ext4: Fix possible fs corruption due to xattr races
Date:   Tue, 14 Jun 2022 18:05:14 +0200
Message-Id: <20220614124146.21594-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; h=from:subject:message-id; bh=SyB1ws5qf1bx0kHKJmy9AR3JQuMyEZujvZqmWgvQWDM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqLG1Y5odJMriltAGiTy1dSt/DPB/mx1uduFblwBO dno1hlyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqixtQAKCRCcnaoHP2RA2UuuB/ 9mup78Pm7+3c2z9eV+zyxUKQoVk5UOdiYTH7AdoEmzgo+Wt/qQKXDriR+T6Pony2QSmwS4OH4rLXoE 47euoDhYWNLiIkNLtZTFL13ImSNtBSU82vq4K1AAQwYRSgkk/LAB4e6fYM1eRTjPnPMJUQ2s/qei4p GLjBD8VpxpL4fV2lJRPbRxh5eTdQ21TDKBlWEILD+mlylnkYCc0v4Kv327xbl2QzYpbb1M+yiA++NA 1a/VC68bcVjr0jd2+Cw6gVg4Khw5m7ylKzkdtTcwCEkwstik2Xcqun2e5XH9HqAkpCnkuUdgT0dr1f nxFM3vo/elUTgfSwsM7mLfwaZQxmRw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

this is the second version of my patches to fix the race in ext4 xattr handling
that led to assertion failure in jbd2 Ritesh has reported. The series is
completely reworked. This time it passes beating with "stress-ng --xattr 16".
Also I'm somewhat happier about the current solution because, although it is
still not trivial to use mbcache correctly, it is at least harder to use it
in a racy way :). Please let me know what you think about this series.

Changes since v1:
* Reworked the series to fix all corner cases and make API less errorprone.

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20220606142215.17962-1-jack@suse.cz # v1
