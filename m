Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1911D5F032F
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiI3DUj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiI3DU2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2C2F3BA;
        Thu, 29 Sep 2022 20:20:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JoKc002472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507991; bh=9IW7UKTjzWKwFjvuBaAucT7vZyQ/XEVSURymv/PdDVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y1SBZHxsMwLTFZcZIRwc7WnTWcW5J5iDGx+nDyObWIHXBFtngJXWgUxg/9uzC8fig
         xyM5KrJUf/2627lxtv5MnDLq8keLD7nGsy4KCly8poAWwzg1NcCVnSoRPNrlLhN2wn
         pAaUnXJV7EldxBhPLzoDbYXH8PfXagkIMNknjjiDojZ+J+Jlp6BK9OhnEK14bLwU7o
         ekTsv+FkiCwNY2DhBi9KmlgAHVEwbgA7j0GaqsmxSjTZQDds/PFyCPKERBVC5ZwmIZ
         mP0gcyIp6D6yyR0CjkKk3Df9LbazTO+lGQqlXOeXjDw/JXv50lxCzbXp5I5KQGTVBY
         Yhd/nzLamvDAw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 99A4215C3536; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 0/3] fix potential out of bound read in ext4_fc_replay_scan()
Date:   Thu, 29 Sep 2022 23:19:40 -0400
Message-Id: <166450797717.256913.17353017901005305011.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220924075233.2315259-1-yebin10@huawei.com>
References: <20220924075233.2315259-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 24 Sep 2022 15:52:30 +0800, Ye Bin wrote:
> Ye Bin (3):
>   ext4: introduce EXT4_FC_TAG_BASE_LEN helper
>   ext4: factor out ext4_fc_get_tl()
>   ext4: fix potential out of bound read in ext4_fc_replay_scan()
> 
> fs/ext4/fast_commit.c | 122 ++++++++++++++++++++++++++++--------------
>  fs/ext4/fast_commit.h |   3 ++
>  2 files changed, 84 insertions(+), 41 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] ext4: introduce EXT4_FC_TAG_BASE_LEN helper
      commit: 8bbc7ccd1b2a58390ea6fe52d784c130cdea1b80
[2/3] ext4: factor out ext4_fc_get_tl()
      commit: 521502e8682f049895d2023dc50c23ebb9d68e07
[3/3] ext4: fix potential out of bound read in ext4_fc_replay_scan()
      commit: 536e190193671d5aa24446b60b151a5c90468266

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
