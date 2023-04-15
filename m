Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320326E2EBF
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Apr 2023 05:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDODHf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Apr 2023 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDODHe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Apr 2023 23:07:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EB1AC
        for <linux-ext4@vger.kernel.org>; Fri, 14 Apr 2023 20:07:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33F37Q6F005552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 23:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1681528048; bh=sud8ZK3HnbjNlbVlHr1MrzqDPhT3j/eoD5hu9STHv7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Dc0tHp9ggFQe9jY2GoNYV2v2Qgr/BVL6IBPxRumal9L1lp3ipnUgPIMj+YXzRg2jL
         yiO79Nd30Fbzl//LaIG4B4lh4ckFUK80srwBzWqPZMXFayYRH3eVhmSaCbX33V++Xn
         F/4JkJW/ak7+W1JX50Y/h0i1jwx6OjvSC4vQuejhsxP579iklxKX8pyMjKT1skE4qY
         IWQO99oGQgk0CJxicNAbqbfv7Lb+3r9YeP2RAsSz7TnXqhY/r1UIum8scY6CMvdG14
         zyYG0MjYApCGd2Isc4TJJGn4sltaQDesR/iAFwxmpeCu+syCRWUjHzhkytT/jtUQZQ
         unc9PdIG85UzQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D1CBA15C4935; Fri, 14 Apr 2023 23:07:26 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/13 v1] ext4: Make ext4_writepages() write all journalled data
Date:   Fri, 14 Apr 2023 23:07:26 -0400
Message-Id: <168152803794.512165.13094224758869262646.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Wed, 29 Mar 2023 17:49:31 +0200, Jan Kara wrote:
> These patches modify ext4 so that whenever inode with journalled data is
> written back we make sure we writeout all the dirty data the inode has.
> Previously this was not the case as pages with journalled data that were still
> part of running (or committing) transaction appeared as clean to the writeback
> code. As a result we can remove workarounds for inodes with journalled data
> from multiple places.
> 
> [...]

Applied, thanks!

[01/13] jdb2: Don't refuse invalidation of already invalidated buffers
        commit: bd159398a2d2234de07d310132865706964aaaa7
[02/13] ext4: Mark pages with journalled data dirty
        commit: d84c9ebdac1e39bc7b036c0c829ee8c1956edabc
[03/13] ext4: Keep pages with journalled data dirty
        commit: 265e72efa99fcc0959f8d33d346a7e0f2e3fe201
[04/13] ext4: Clear dirty bit from pages without data to write
        commit: 5e1bdea6391d09fde424a1406a04e01b208a04d2
[05/13] ext4: Commit transaction before writing back pages in data=journal mode
        commit: 1f1a55f0bf069799edd5f21a99ac1e3b10ebafee
[06/13] ext4: Drop special handling of journalled data from ext4_sync_file()
        commit: e360c6ed727401ad1a3b5080f06d2ec3a4b75f5b
[07/13] ext4: Drop special handling of journalled data from extent shifting operations
        commit: c000dfec7e88cee660cbc594c9716ecc979dc1f1
[08/13] ext4: Fix special handling of journalled data from extent zeroing
        commit: 783ae448b7a21ca59ffe5bc261c17d9c3ebfe2ad
[09/13] ext4: Drop special handling of journalled data from ext4_evict_inode()
        commit: 56c2a0e3d90d3822fab157883957523e327bc9ae
[10/13] ext4: Drop special handling of journalled data from ext4_quota_on()
        commit: 7c375870fdc5f50a001f8265cd8744a78d2d43ab
[11/13] ext4: Simplify handling of journalled data in ext4_bmap()
        commit: 951cafa6b80e55b966047b0c9cc5564df8b92145
[12/13] ext4: Update comment in mpage_prepare_extent_to_map()
        commit: ab382539adcb43f52d984abf58d8e3459cd707a2
[13/13] Revert "ext4: Fix warnings when freezing filesystem with journaled data"
        commit: d0ab8368c175f7b5ef0851283a2ba362a9ab327a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
