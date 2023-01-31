Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D64682457
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 07:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAaGQM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 01:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAaGQJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 01:16:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979123B652
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 22:16:04 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30V6Fllp024372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 01:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675145749; bh=hLou58FOHENe/dNZmvXpv2PAJVqLzUyie6xQoHGmIf4=;
        h=From:To:Cc:Subject:Date;
        b=C4xVlxHsNEwjoJfi3bkvQiGToHVHMYgYY3iie3N2HlZ+merJYesJUuwzZsD4dKedy
         LSLD281kSUvLzbtKHhLrQ511eYFSinCbn7SiI9z0RwPyvNsVJOoNxW195TcO5zkzER
         V0x3YAsP2HhwzG9tVKKNv+TL9gvABZetnLcY07CVpbd0RincKBEu71Wq0aL5+NdbOd
         DQednXGm1QwaCvsUD3a4JJYm0k28Qcld+yBQtGI6Cbo2MHF7KCQ4y+9DmGgcIXz+AX
         JbZ7b0hJxsEHm8QLGVBfklyfBHtRmm2DxtQmSEV6axfnqXV1uzuw8a820EzT2k77Cd
         Sngohm/UgFk/w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC80915C359D; Tue, 31 Jan 2023 01:15:47 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     zhanchengbin1@huawei.com, linfeilong@huawei.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/3] e2fsprogs: fix deadlock issus in unix_io on write errors
Date:   Tue, 31 Jan 2023 01:15:39 -0500
Message-Id: <20230131061542.324172-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This problem was reported by [1] but the fix was incorrect.  The issue
is that when unix_io was made thread-safe, it was necessary that to
add a CACHE_MUTEX to protect multiple threads from potentially
colliding with the very simple writeback cache used by the unix_io I/O
manager.  The original I/O manager was purposefully kept simple, used
a fixed-size cache; accordingly, the locking used also kept simple,
and used a single global mutex.

[1] https://lore.kernel.org/r/310fb77f-dfed-1196-c4ee-30d5138ee5a2@huawei.com

The problem was that if an application (such as e2fsck) registers a
write error handler, that handler would be called with the CACHE_MUTEX
still held, and if that application tried to do any I/O --- for
example, closing the file system using ext2fs_close() and then exiting
--- the application would deadlock.

The fixes here are good enough for the use case found in e2fsprogs,
and in practice there are very few other users of the error handler
feature in libext2fs.





*** BLURB HERE ***

Theodore Ts'o (3):
  libext2fs: unix_io: add flag which suppresses calling the write error
    handler
  libext2fs: unix_io: fix potential error path deadlock in reuse_cache()
  libext2fs: unix_io: fix_potential error path deadlock in
    flush_cached_blocks()

 lib/ext2fs/unix_io.c | 151 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 25 deletions(-)

-- 
2.31.0

