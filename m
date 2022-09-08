Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A75B1887
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIHJXe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiIHJXN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:23:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2EEE126C
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:21:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6A831FA95;
        Thu,  8 Sep 2022 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662628896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HLsO7kNea/ZPllJuIGUm5eeyvHOkZ4P6VFk2t1Xyfzc=;
        b=Z5P3L4GfBaCXPMg5ygyz5KtTyYhXYXnkYBUSB17dMP419p4leQmKS43hR/7IX+xPtT7A3g
        3HkVgPCKid/5WzSBWU6CJa+iAkUhYgXQQEIygdgUON/uyQj99mVa8yhyDhRGcMitqIIsEE
        iQ+V+s8eMUYcw5xj48Gsgi603ogrhwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662628896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HLsO7kNea/ZPllJuIGUm5eeyvHOkZ4P6VFk2t1Xyfzc=;
        b=lLCCB2hnM0BL9jr0ww68zX4gA+boeSWksFeRlw2T+YhrR2KCgbm4+t80le4c8Gx0H+3esb
        h/3fxMe4pMlVhdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B89A213B5E;
        Thu,  8 Sep 2022 09:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wfEKLSC0GWO0RAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:21:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F0D8A067E; Thu,  8 Sep 2022 11:21:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v3] ext4: Fix performance regression with mballoc
Date:   Thu,  8 Sep 2022 11:21:23 +0200
Message-Id: <20220908091301.147-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096; h=from:subject:message-id; bh=yFEXB/lrsmhhdUOeaq3O6/9Z2nFMTjgU96U6QVEZhaU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjGbQNJl4PyGv72BP2186vItijdYkKbXwnrrWVvdzr FzXJKpeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxm0DQAKCRCcnaoHP2RA2XSkB/ wIsggCJHhXf4BLJLdibLulBiu7tI7XCy61YuTIkabUeYFbTRoJDByMW9HtIGOIzfBVx6owF81CHF+h WJjQ+wGWhoUPdkDhuv3F6PXChlLtS8CuQ6jz1qfvSTw1vNyB7mPVPk/pyFoW7igu36IjrcwfTG0YJB KJxa3HvuP8yH9jO4pvlgEqQZcDkEoXCvrZbdVQyjVwFpaT64ZtlhcKNfKUxp6mP6dChoaNn0UTAKg0 t4LTYkAtT2Sofwd2w6/m/MD/ydrVhiYVqn2qJi/mLfKoblbsalmRLekthm4Bd1pKnGa+sVIYqFTpDh 8BmWEVyAATD2NA0a6AJeEMXDaVeptX
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

Here is the third version of my mballoc improvements to avoid spreading
allocations with mb_optimize_scan=1. Since v2 there are only small changes and
fixes found during review and testing. Overall the series looks mostly ready to
go, I just didn't see any comments regarding patch 3 - a fix of metabg handling
in the Orlov allocator which is kind of independent, I've just found it when
reading the code. Also patch 5 needs final review after all the fixes.

Changes since v1:
- reworked data structure for CR 1 scan
- make small closed files use locality group preallocation
- fix metabg handling in the Orlov allocator

Changes since v2:
- whitespace fixes
- fix outdated comment
- fix handling of mb_structs_summary procfs file
- fix bad unlock on error recovery path

Original cover letter:

The patches fix the performance regression I was able to reproduce with reaim
on my test machine:

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

The changes also significanly reduce spreading of allocations for small /
moderately sized files. I'm not able to measure a performance difference
resulting from this but on eMMC storage this seems to be the main culprit
of reduced performance. Untarring of raspberry-pi archive touches following
numbers of groups:

	mb_optimize_scan=0	mb_optimize_scan=1	patched
groups	4			22			7

To achieve this I have added two more changes on top of v1 - patches 4 and 5.
Patch 4 makes sure we use locality group preallocation even for files that are
not likely to grow anymore (previously we have disabled all preallocations for
such files, however locality group preallocation still makes a lot of sense for
such files). This patch reduced spread of a small file allocations but larger
file allocations were still spread significantly because they avoid locality
group preallocation and as they are not power-of-two in size, they also
immediately start with cr=1 scan. To address that I've changed the data
structure for looking up the best block group to allocate from (see patch 5
for details).

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20220823134508.27854-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20220906150803.375-1-jack@suse.cz # v2
