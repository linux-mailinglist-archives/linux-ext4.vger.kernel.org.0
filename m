Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDB3C5F6B
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhGLPnC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:43:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhGLPnB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:43:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 23A2621D89;
        Mon, 12 Jul 2021 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XvzFzSKYazzSH2gGVEjptXqglNSLwOtcVMXkjgPqQF4=;
        b=imLG3asjPfmcoByFiCHwTeo77M/U9TNmOalbl77nj9uJhbyeAu1nDdvV0B7RDksRdp7VRP
        /DqrqlnmhJ3nWbjwXTsrfcJ6pn1VIYH9USAbssJMQeArCS4RercJ/Pl030TJtbtGbe5SlH
        br8UcNSb3uvLvkrBX/XQzSLP7bJ3vh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XvzFzSKYazzSH2gGVEjptXqglNSLwOtcVMXkjgPqQF4=;
        b=r6JHTjPM7KcyQWP8EkPovVfsYOtrw9h+P9abTNYWlynWUB1uRDRQpELPyEaAva/OA59c+x
        dmjZ5yKVwTOFD5Cw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 160F9A3B85;
        Mon, 12 Jul 2021 15:40:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8A531F2AA9; Mon, 12 Jul 2021 17:40:11 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/5 v4] ext4: Speedup orphan file handling
Date:   Mon, 12 Jul 2021 17:40:04 +0200
Message-Id: <20210712154009.9290-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; h=from:subject; bh=6kdSX79KLIfFl+0UDrPMzP2q9coFVV/raMq4+NT53Nw=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGBLeJPkldDx1f/t8z//dt6o1JpmtSpr9+CrXxJPb50QpWZTk RxW6dDIaszAwcjDIiimyrI68qH1tnlHX1lANGZhBrEwgUxi4OAVgIgsusP+vzdL5dPikn16iaUWt9j lNHUZ7Pvf3TYH3bwlXBnhtE7I+FnhYhVdr0/yW7lYvRZGEgNsnFCXeWCycNN367n19yzkzyw9pWrO+ 3vDn4P9nvfzdgfEN8YezdPgDLt3Xvm9846zG58Adcoxn6loTzljWJDef7GCNPS8Ves/7zjpfZ4a38r uvzuvh5+SLzLRdMutu2YfFRYVqkiFljyrWWt1L0dxYpCFvlKH45W/DyUsV7ixhzPaLGlRFg5lXX751 3UQ66FuOzA3b6E0H0i+HKcdfEVqr+I7R/5ZySugcngS2DCe9d23LA2SDgxOe/gqP5+GJXXt65V1Gxa DZvH9lj7k94Tx5YVmf8cK6wHd/AA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  Hello,

Here is a fourth version of my series to speed up orphan inode handling in
ext4.

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
