Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57022AC4B3
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgKITKT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 14:10:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgKITKT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 14:10:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EED8FAB95;
        Mon,  9 Nov 2020 19:10:17 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Tristate moount option comatibility fixup
Date:   Mon,  9 Nov 2020 20:10:07 +0100
Message-Id: <cover.1604948373.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

after the tristate dax option change some applications fail to detect
pmem devices because the dax option no longer shows in mtab when device
is mounted with -o dax.

At first it might seem stupid to detect pmem by looking at the mount
options.

However, if the application actually wants a mount point properly
configured for dax rather than just backed by pmem I do not see any
other easy way.

Also this happens during early installtion steps when the mounted
filesystem is typically empty and you want to perform non-destructive
detection.

If there are better ways to detect dax enabled mount poins I want to
hear all about it. In the meantime we have legacy applications to
support.

It also makes sense that when you mount a device with -o dax it actually
shows dax in the mount options. Not doind so is confusing for humans as
well.

Thanks

Michal

Michal Suchanek (2):
  xfs: show the dax option in mount options.
  ext4: show the dax option in mount options

References: bsc#1178366

 fs/ext4/super.c    | 2 +-
 fs/xfs/xfs_super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2

