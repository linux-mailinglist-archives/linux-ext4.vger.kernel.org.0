Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9014EDC4A
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiCaPEp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCaPEo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 11:04:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795A7206EEE
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 08:02:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22VF2pUG022575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 11:02:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 74BDC15C003E; Thu, 31 Mar 2022 11:02:51 -0400 (EDT)
Date:   Thu, 31 Mar 2022 11:02:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     adilger.kernel@dilger.ca,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: Re: [PATCH v2] ext4: truncate during setxattr leads to kernel panic
Message-ID: <YkXCm+2PKrlbgKJM@mit.edu>
References: <20220312231830.103920-1-artem.blagodarenko@gmail.com>
 <164823418309.637667.12757298463000030100.b4-ty@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164823418309.637667.12757298463000030100.b4-ty@mit.edu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 25, 2022 at 02:49:50PM -0400, Theodore Ts'o wrote:
> On Sat, 12 Mar 2022 18:18:30 -0500, Artem Blagodarenko wrote:
> > From: Andrew Perepechko <andrew.perepechko@hpe.com>
> > 
> > When changing a large xattr value to a different large xattr value,
> > the old xattr inode is freed. Truncate during the final iput causes
> > current transaction restart. Eventually, parent inode bh is marked
> > dirty and kernel panic happens when jbd2 figures out that this bh
> > belongs to the committed transaction.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] ext4: truncate during setxattr leads to kernel panic
>       commit: c7cded845fc192cc35a1ca37c0cd957ee35abdf8

I'm going to drop this patch from the dev branch for now, due to the
issue pointed out here[1].  The solution, as suggested in [2], is we
need to use our own subsystem workqueue.  Perhaps we can reuse
rsv_conversion_wq for that purpose (after renaming it, of course).

[1] https://lore.kernel.org/all/385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp/
[2] https://lore.kernel.org/all/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp/T/#u

						- Ted
