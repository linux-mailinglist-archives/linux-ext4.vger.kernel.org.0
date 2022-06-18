Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928065501E8
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiFRCMZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383832AbiFRCMY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:12:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A16AA40
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 19:12:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2CDG8005815
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655518335; bh=OlJF7fRwMb5iyCf8QksQjET6oiIhjD7Hx0bVtba5HBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KI3YyK65TzL61c9wJXj7YxPSj5fgkgsesbWP6mFwyBT9ixIPGuxhfIyV4E04WntdN
         18cUuMu9g1YjWbyt3pY8W15raS/3KEhtXg9acrGka3Wdcr2rY1NcNPUDFaJI89jyZm
         SV6c0cMMcDzitQn3YhebcoEMyjYbaX9eNVKSHYWo2sob3lbcL0t/rw5DcVNiJfSgwI
         XU5iNT/e9DvzxUu41lEwq0kAfh8nVJX+aNxdVcX4tdUI7f294ynWsXk4HAjgtWs06K
         RdBW3budzflxNNZgey0qhBC+WMp7Qlp4B7axnQ+oK/2IFrt0/WsHdd3/FfQhx4A+O2
         GTzllHbWCqQPQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B548215C42F4; Fri, 17 Jun 2022 22:12:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Improve write performance with disabled delalloc
Date:   Fri, 17 Jun 2022 22:12:05 -0400
Message-Id: <165551818831.612215.11479154639163365692.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220520111402.4252-1-jack@suse.cz>
References: <20220520111402.4252-1-jack@suse.cz>
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

On Fri, 20 May 2022 13:14:02 +0200, Jan Kara wrote:
> When delayed allocation is disabled (either through mount option or
> because we are running low on free space), ext4_write_begin() allocates
> blocks with EXT4_GET_BLOCKS_IO_CREATE_EXT flag. With this flag extent
> merging is disabled and since ext4_write_begin() is called for each page
> separately, we end up with a *lot* of 1 block extents in the extent tree
> and following writeback is writing 1 block at a time which results in
> very poor write throughput (4 MB/s instead of 200 MB/s). These days when
> ext4_get_block_unwritten() is used only by ext4_write_begin(),
> ext4_page_mkwrite() and inline data conversion, we can safely allow
> extent merging to happen from these paths since following writeback will
> happen on different boundaries anyway. So use
> EXT4_GET_BLOCKS_CREATE_UNRIT_EXT instead which restores the performance.
> 
> [...]

Applied, thanks!

[1/1] ext4: Improve write performance with disabled delalloc
      commit: 8d5459c11f548131ce48b2fbf45cccc5c382558f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
