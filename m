Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B259ED60
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Aug 2022 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiHWUfX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Aug 2022 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiHWUfE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Aug 2022 16:35:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D32491CF
        for <linux-ext4@vger.kernel.org>; Tue, 23 Aug 2022 13:15:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B6C4336A3;
        Tue, 23 Aug 2022 20:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661285758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ylLNO1fgckMQ5w81w1kel4JxKH9A6EdW63n6gd8KoHE=;
        b=cUvZqq9x8zguNrUikQwVS/Vigz3Rjm1raZg80myaDuOPoQmzgzP3wZ2WCtqvSQa23+iLoM
        M+82sNwgadc7I/zT4f61s0DBI9xFBjE8ZEK8ZtZly+hvpPsVt2GNw66Crqp2iThbwINVPB
        d7RB45Hskxl4qqv2vUPZbf4N2lOATh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661285758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ylLNO1fgckMQ5w81w1kel4JxKH9A6EdW63n6gd8KoHE=;
        b=ZFGVAfO1nKInv/f130Wc60um+9hztgPNEABclC13LAXGkwgPoIUCMnS/JTjIX0k6ldRJ6a
        isfHs2mivapT9uCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 680EC13A89;
        Tue, 23 Aug 2022 20:15:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZlNjGX41BWPGAQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 Aug 2022 20:15:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DF4E5A067B; Tue, 23 Aug 2022 22:15:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] ext4: Fix performance regression with mballoc
Date:   Tue, 23 Aug 2022 22:15:52 +0200
Message-Id: <20220823134508.27854-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; h=from:subject:message-id; bh=6TD0Hniho0zrt3E1zoZv0H/hS0BhvhWUEtZ3IoG9V0E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjBTVyOY7S0aoenEcikcYosX1ydyc0sL4oZ42AUFg3 AgYn1BKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYwU1cgAKCRCcnaoHP2RA2VPbB/ sFn/0qmHE8iHDsZF+UMJOcSXCVdI3zqNwtFnqhf5SvnGKTywXTPoaUbXfxppWeDyqI9f1RqgnO1HUk qDgP0m5UmGxtgppb4IkqV5+M/P95BGfZUFuo1JuJbGitup4zdxhPwvAHthNdIm5PNm9mUuYhgPHNMS 2Zp40jqt7DEl1uR0esaf6JU23DKYseuCqthNuFgqaCvldHnNw/slgdj1MmcNa/S7112v5mF0HkPmGF pjfF6TGR/F7f7zjCoUBaJS+Jx9OYSwyTYfyBLdvGYzqO54gntrScvDNCSMJZmcMFZcNhD37ei54oHe pnAH3VGDT/eWS8hiNiA6Virn6mbhGE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

So I have implemented mballoc improvements to avoid spreading allocations
even with mb_optimize_scan=1. It fixes the performance regression I was able
to reproduce with reaim on my test machine:

                     mb_optimize_scan=0     mb_optimize_scan=1     patched
Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)

Stefan, can you please test whether these patches fix the problem for you as
well? Comments & review welcome.

								Honza
