Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE513A9841
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFPK7S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFPK7M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D49531FD49;
        Wed, 16 Jun 2021 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w4rHxGuCLUcJcWKH8pv/aCD65V2ltE6mlVmNfLsKBdw=;
        b=i0R7axcR4cRlnvN3vxYVta1vb/r/PihbAGx2QZhkW5h1cKrk6V6yOZ7ZprEcAHGQPSsjqn
        vXFHsIgqh/mwpb86TaGbrQwhzNjaSXOJvvXg1uO8zTrfE6nFmYZc/8JmPKOmNlF3dWlPaj
        EzA2JYTuYhZboY16bulzCctDrI9OxE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w4rHxGuCLUcJcWKH8pv/aCD65V2ltE6mlVmNfLsKBdw=;
        b=Im9oUEPZfkiOXQ44p7IvS1b870Drv99QOVXurAxPE5FC9JB9CoEY0dN6eU3cJgCbIO90OD
        XgIrVmgmJOlO73BQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C4103A3BB4;
        Wed, 16 Jun 2021 10:57:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 44F4A1F2C88; Wed, 16 Jun 2021 12:57:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4 v3] ext4: Speedup orphan file handling
Date:   Wed, 16 Jun 2021 12:56:51 +0200
Message-Id: <20210616105655.5129-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; h=from:subject; bh=siy6kasx2dWTwYjiVtxu8ZvDtux/1YgAnQp87p5BUWo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgydjWAqt/AQ4CXvrDTDDFy3ebXyiTIbaplD/N0Y2l mT6+j8uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYMnY1gAKCRCcnaoHP2RA2Sk0CA C6UJER93H6Od/KzBHKCVeOREHFn1I1i0/YFQAWsE5ba2fGIML1gid7kuWYe2UiVsCrJrNEA0JosRV4 OdcZMgkQKxRxNrZygYDfcwZUrNX4FmpRJg2c4rD+n3ss/j2hjYPBsCS5V2RbCb+RMfGxEW2s8Watj7 mXyt4cKPl+S+pj3zqUT0y4XSNxRpYptQ2SOCui+KH4Ti/xwK0zgyzhUX6l1wA9dWYTMybtO+mMChSr yVbGiX8bDMq3ECO9XFS5XKnJl4UL2vBicsJPod66iyLwpZNqjy0kBvHUYKjEUWydLSxo8eWpVpf9vR UK6orNuydalu/ZKOqnL9Nj87IWz3Lc
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

After six years, prompted by recent 0-day reports of performance issues with
orphan list handling [1], I'm sending a third revision of my series to speed up
orphan inode handling in ext4.

Orphan inode handling in ext4 is a bottleneck for workloads which heavily
excercise truncate / unlink of small files as they contend on global
s_orphan_mutex (when you have fast enough storage). This patch set implements
new way of handling orphan inodes - instead of using a linked list, we store
inode numbers of orphaned inodes in a file which is possible to implement in a
more scalable manner than linked list manipulations. See description of patch
3/4 for more details.

The patch set achieves significant gains both for a micro benchmark stressing
orphan inode handling (truncating file byte-by-byte, several threads in
parallel) and for reaim creat_clo workload. I'm happy for any review, thoughts,
ideas about the patches. I have also implemented full support in e2fsprogs
which I'll send separately.

								Honza

[1] https://lore.kernel.org/lkml/20210227120804.GB22871@xsang-OptiPlex-9020/

Changes since v2:
* Updated some comments
* Rebased onto 5.13-rc5
* Change orphan file inode from a fixed inode number to inode number stored
  in the superblock

Changes since v1:
* orphan blocks have now magic numbers
* split out orphan handling to a separate source file
* some smaller updates according to review
