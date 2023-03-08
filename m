Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B606AFDE1
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCHEdo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCHEdi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:33:38 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093495E0E
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:33:33 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284XTwP021501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678250011; bh=/ofLAobISyWG4eGB29qn5insCmJ/hmVFSzIUdpK3DbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bRFwSl4ib4NScGtn6+eY9ZK/v6iMoCRpOAb/1qbqaRXt7d8MhWdqkzKB34yEcommG
         VV49zF+tP8Twr769cnU9GNrxdtFlLq9ooWqVzIWTz2LHejWDdde4RU3fk30tnlLHOY
         BqeYMMWic74czZjxZE5pEbMYZymnhTPzfNF6Jg6dmyGWk7zbFzvgj8ZPkQUkaeo9It
         xvlIdAzdHic6HX7XAwSflIFHzTA2rr+9m/QxUO/S8Q8wn4OTkyF9iDJ/Ij0WVIgqp0
         Pv756b9Acxnh1L3Dd/4bFojknjuyWx/mUvmYVcvD2ugdvw4SMAKCeHd4m3H3sf1sGF
         GyLIaMxk6xtUA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D140015C3448; Tue,  7 Mar 2023 23:33:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: fix RENAME_WHITEOUT handling for inline directories
Date:   Tue,  7 Mar 2023 23:33:23 -0500
Message-Id: <167824999281.2129363.15378666529053966811.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230210173244.679890-1-enwlinux@gmail.com>
References: <20230210173244.679890-1-enwlinux@gmail.com>
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

On Fri, 10 Feb 2023 12:32:44 -0500, Eric Whitney wrote:
> A significant number of xfstests can cause ext4 to log one or more
> warning messages when they are run on a test file system where the
> inline_data feature has been enabled.  An example:
> 
> "EXT4-fs warning (device vdc): ext4_dirblock_csum_set:425: inode
>  #16385: comm fsstress: No space for directory leaf checksum. Please
> run e2fsck -D."
> 
> [...]

Applied, thanks!

[1/1] ext4: fix RENAME_WHITEOUT handling for inline directories
      commit: c9f62c8b2dbf7240536c0cc9a4529397bb8bf38e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
