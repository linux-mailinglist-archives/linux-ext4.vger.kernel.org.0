Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714003F7E38
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhHYWMe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 18:12:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhHYWMd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 18:12:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9011021F15;
        Wed, 25 Aug 2021 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629929506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u4kwlwzMH2R+er0Q112RVV+w+nR5liLrIBiDsB6t+ZU=;
        b=CjVb2J4g+7oMgtCS7j2Ozt/05A9mxPvumbGA7+QkhW3mon9B/3chSK4ElZlue4NgDO1BpP
        2T4oZHCPrwy0RSC0acRkaNCwUl7F74FobCE74yYFc1EFebC+dzp9yWMl3xPuzlk+wSOVcT
        5lbixjmX8ovFpw8o919EqvzxKTjb0Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629929506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u4kwlwzMH2R+er0Q112RVV+w+nR5liLrIBiDsB6t+ZU=;
        b=34N/u0DUG9P0lw6nkgUqn0PWF8yggzbQX2ti08msnmStIJ9qeH/zS2yat4qiXZtNQ4+mHw
        q5pmKjC6G/7Bm7Cg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7D498A3B87;
        Wed, 25 Aug 2021 22:11:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DAF301E0A8B; Thu, 26 Aug 2021 00:11:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v6] e2fsprogs: Support for orphan file feature
Date:   Thu, 26 Aug 2021 00:11:29 +0200
Message-Id: <20210825220922.4157-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; h=from:subject:message-id; bh=50OF7hsBSV5vsVVpOkA7VlIRONLhbo28rY8vejMxTpM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhJsANofB2PU6FrQK10nK8TjPIb9aMBlo+X/hDL9LK TqzKM++JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSbADQAKCRCcnaoHP2RA2fG1B/ 470Aea2PekS+eOzZ8NwIcJAQaYigOwUIpog3zRFk6BIfnLHzZ4F3TrX8TvsmqNEmJvfaUzFx1w+Q9q ryOYSeutNGrAFVAkD571iuLfCI94B7Lc4RYuaKglJHey3rW1hHNnoDTHNBysl6yAlmqT4EyFd0rF7C cWpNE34cb/VaadtMCmK/YHGWp8jR90mryCsxumFWfbEKUXr37raSw6TdJCYMaVDkpYWmnkhcgizF4z CK2KtQsfRMIxzLAg3BaKxyv8amWHdJ0bzMFu+hOm0hR6O/nrmEma7EsJdueE/VlmlLbzGBs2hxBcTa RSMRz5IKNMnkksZnZkGRFvy/Q01jr2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

  This is the fifth version of support for orphan file feature in e2fsprogs.
I've rebased it on top of maint branch as Ted already merged initial fixes.
I've also fixed up some issues Ted has already found.  I'm not aware of any
outstanding issue with the series, xfstests pass fine with it.

Changes since v5:
* Fix e2fsck handling of orphan file when metadata checksums are disabled

Changes since v4:
* Make sure we consistently speak about orphan_file and orphan_present feature,
  not flag, in error messages.
* Do not make orphan_file feature default yet
* Make sure mke2fs does not complain if orphan_file feature got enabled by the
  profile but user decided to disable journal.
* Fixed up value of ORPHAN_PRESENT feature
* Fixed several introduced -Wall warnings
* Fixed e2fsck errorcodes
* Rebased on top of current maint branch (some patches already merged)

Changes since v3:
* updated to compute checksum also from physical block

Changes since v2:
* rebased onto current master branch
* fixed various bugs I've spotted during testing
* added support for debugfs, dumpe2fs, e2image
* changed code to use dynamically allocated inode number instead of fixed one

								Honza

Previous versions:
Link: https://lore.kernel.org/linux-ext4/20210712154315.9606-1-jack@suse.cz/ # v4
Link: http://lore.kernel.org/r/20210811103054.7896-1-jack@suse.cz # v5
