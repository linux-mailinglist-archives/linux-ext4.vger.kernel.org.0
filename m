Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C038B3ED161
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhHPJ5s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 05:57:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45346 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhHPJ5q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 05:57:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 19A841FEAA;
        Mon, 16 Aug 2021 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629107834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=704NxQfzwi9kSXuc2rhETD0mUR1MTk/HcJrCSHQqR44=;
        b=kLJGzoN2TFhS4bc45AyjSTRaY0muX5vMOWKpT03jdoR19y1gzkUb2Gxj5WFlFP8PUJPWQy
        ezHEN/IoNHjIoEh50J4L/YxO/6m+HUcavQfDdRaLKTQxndiYOS4+IAmd3PTfiV8HJ+gMEC
        CfQQWE+GZoMZTZFPDKtvBWK3DWhPaKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629107834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=704NxQfzwi9kSXuc2rhETD0mUR1MTk/HcJrCSHQqR44=;
        b=GbsxcaGjYJVFy/L2JDjxJPUCxuRQFRwsfjLWf/1KFgTHRad2G37O0UDs6+zcVL0tRlgXMT
        yQkBlCTCiqcCbbAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0D633A3B90;
        Mon, 16 Aug 2021 09:57:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D8ED61E0426; Mon, 16 Aug 2021 11:57:13 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Date:   Mon, 16 Aug 2021 11:57:03 +0200
Message-Id: <20210816093626.18767-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; h=from:subject:message-id; bh=b+RrBC6Oe8ucOXwRePSLKOyAc7JDvsUO5gRGdR9C4/0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhGjZvGd71PXz0m0+UZWcprXfOHQqU3yvocdPQaJwi pl7fn42JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYRo2bwAKCRCcnaoHP2RA2cXuB/ 978q/GMff1qYatTo3UKgCAE4mLrZCC5YyY7ZX5BM7pMzsv0yYANdFpnajXzfRjbuEwmrk2Ltx4NBM/ QqCPxfB/C94zYsWKo0YVfGfCkKrvrgx8nawam8DLvHI5Dto83Yp1u2Od89P6kQ55OqkJPLzKTzQq/V 5LVfhXc3yayTTyjS/JmwSB18pCEsNScG1taca6VsWC/copG0l4qYLYSZS9e/ApGmBNLiu9C3AQXMd0 WMsAcAhCMuqEl6c4F70mQQrQqpHZx1U7AB5mWQv66PgMCeFHWtaK61HVoQwb9fmjQNDWif/BcC3C9p ziOCxOFrLtNhhmVyPz1lKeHz8NM1qx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

Here is the seventh version of my series to speed up orphan inode handling in
ext4. I've forgot to add a check that orphan file is not exposed in directory
hierarchy. The only change in this version is addition of that fix.

Orphan inode handling in ext4 is a bottleneck for workloads which heavily
excercise truncate / unlink of small files as they contend on global
s_orphan_mutex (when you have fast enough storage). This patch set implements
new way of handling orphan inodes - instead of using a linked list, we store
inode numbers of orphaned inodes in a file which is possible to implement in a
more scalable manner than linked list manipulations. See description of patch
3/5 for more details.

The patch set achieves significant gains both for a micro benchmark stressing
orphan inode handling (truncating file byte-by-byte, several threads in
parallel) and for reaim creat_clo workload. I'm happy for any review, thoughts,
ideas about the patches. I have also implemented full support in e2fsprogs
which I'll send separately.

								Honza

[1] https://lore.kernel.org/lkml/20210227120804.GB22871@xsang-OptiPlex-9020/

Changes since v6:
* Rebased on top of v5.14-rc6 + patches fixing exposure of hidden inodes in
  directory hierarchy
* Added check orphan file cannot be linked from directory hierarchy
* Get orphan file inode with EXT4_IGET_SPECIAL flag

Changes since v5:
* Added Reviewed-by tags from Ted
* Fixed up sparse warning spotted by 0-day
* Fixed error handling path in ext4_orphan_add() to not leak orphan entry

Changes since v4:
* Rebased on top of v5.14-rc5
* Updated commit message of patch 1/5
* Added Reviewed-by tags from Ted

Changes since v3:
* Added documentation about on-disk format changes
* Add physical block number into orphan block checksum
* Improve some sanity checks, handling of corrupted orphan file
* Improved some changelogs

Changes since v2:
* Updated some comments
* Rebased onto 5.13-rc5
* Change orphan file inode from a fixed inode number to inode number stored
  in the superblock

Changes since v1:
* orphan blocks have now magic numbers
* split out orphan handling to a separate source file
* some smaller updates according to review

Previous versions:
Link: http://lore.kernel.org/r/20210816091810.16994-1-jack@suse.cz # v6
Link: http://lore.kernel.org/r/20210811101006.2033-1-jack@suse.cz # v5
Link: https://lore.kernel.org/linux-ext4/20210712154009.9290-1-jack@suse.cz/ #v4
Link: https://lore.kernel.org/linux-ext4/20210616105655.5129-1-jack@suse.cz/ #v3
Link: https://lore.kernel.org/linux-ext4/1432293717-24010-1-git-send-email-jack@suse.cz/ #v2
