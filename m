Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44BA5AEFD9
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Sep 2022 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiIFQGJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Sep 2022 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiIFQFt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Sep 2022 12:05:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB3B30B
        for <linux-ext4@vger.kernel.org>; Tue,  6 Sep 2022 08:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FDE6337A8;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662478161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=I6JQ9u6yHsBzD2pZi5j0TdiC5AGXGPlLxviu4Pm85XA=;
        b=SjixE10JdT84xrqs06NKdbwciq8PWIknqtrqqFXWCrBMfk3+ZLMikoZ8yDaRJ1bjKqJ7Wb
        YzSCVI5DnwW98am9R17EMdY2cAA5QkIkch972SXt/Mn7OPxz7sz89GRZup/GSVnb5Omb+6
        ONvPy+FXaBLlcxxnnLMOsT/YNM0KeaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662478161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=I6JQ9u6yHsBzD2pZi5j0TdiC5AGXGPlLxviu4Pm85XA=;
        b=h0018szmzhy5EeXTuR9hm5Suzj8juEhHHs2a1r0cN4orC2PLRvEMoQrS2F0+8YJavUSR+8
        u88K1c2m8qHfWcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2204913A19;
        Tue,  6 Sep 2022 15:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b6QCCFFnF2NPHAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Sep 2022 15:29:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 748D0A067E; Tue,  6 Sep 2022 17:29:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v2] ext4: Fix performance regression with mballoc
Date:   Tue,  6 Sep 2022 17:29:06 +0200
Message-Id: <20220906150803.375-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; h=from:subject:message-id; bh=WEBWJ/VkydxI16UeCZ7CAidzHkoi1Ra5PFL3ZsA42es=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjF2cr7vsBf27YjkbxmhBJZ4HneECGM0+xQNCy0CMt DpKCY0mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxdnKwAKCRCcnaoHP2RA2bisB/ wMqWwAn8pyjA4euW1FIvjARUi5mhhUnb9HnKT4PK60h5cnOJ0hcHLTMdY1osW8tO0UWflflJU+ceb2 KdJyvscZQj9dL7GufgTj4NQj8GslWkZfvWMeho6QUnSwJH1ZoTGaMg36F4wXpZnrMXi+aECglYdl96 qY0b6kcrYfXKE2gxpdcpIiGTwbMR5sw/PYLAs/iQCcXsZRwjrqEHQRauQx4h+UY/MVUioizEl55umT EDfw1r/CIcvvjJJ11J7yndmARJBcJKV8GSWMJMc0MAyRJluvbDvLaPyIse/IOtwSgtCc8xLBXgIenJ tv6RChM3fcWrcC+LLoFyxIEIML2mFh
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

Here is a second version of my mballoc improvements to avoid spreading
allocations with mb_optimize_scan=1. The patches fix the performance
regression I was able to reproduce with reaim on my test machine:

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

Stefan, can you please test whether these patches fix the problem for you as
well? Comments & review welcome.

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20220823134508.27854-1-jack@suse.cz # v1
