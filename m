Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3477F869
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjHQOLl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351713AbjHQOL3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 10:11:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17816E55
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 07:11:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HEBD17022639
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692281474; bh=eI5iwLD+Rh+XFX9ETReHNUzYFVrcBjINzAovyc+Y4co=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=RTOPhOJv5wfuRaSkpBMquLOH8EdEe6vojljx5NCdmJl0plgNFGzGkyxasHi/F/F9W
         +ktXBWD9eGJzyOq9oK8a9dpbzyXs4KOQFRCOQ6+mS1bFoKxnNQ/idWHLBzeYVD6jbx
         UArUIMttV9VtvaHjpHmsNsq9sDUiquhykZguqmg2miiO6Ws+7jMzA+StmZHWMiDKfI
         vjbN1CbplmxfzfoRO42k6qzlB+852ZQNFDw5wCKwO6Ae/h4zPhRCCqCF5VyBLeX+dj
         GfAZhghxYvv2uLpgCujoKlrTvg31DlhCe8D2vunyq4hc7pij4f1tJjQNAJ6PJYDC9t
         i3k7PzwABeemg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E4FA315C0501; Thu, 17 Aug 2023 10:11:12 -0400 (EDT)
Date:   Thu, 17 Aug 2023 10:11:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] ext4: remove unnecessary check for avoiding
 multiple update_backups in ext4_flex_group_add
Message-ID: <20230817141112.GZ2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-13-shikemeng@huaweicloud.com>
 <20230816034730.GT2247938@mit.edu>
 <2a0c45d9-29f0-10a3-fc40-d48e101c8d91@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0c45d9-29f0-10a3-fc40-d48e101c8d91@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 17, 2023 at 11:53:52AM +0800, Kemeng Shi wrote:
> 
> 
> on 8/16/2023 11:47 AM, Theodore Ts'o wrote:
> > On Thu, Jun 29, 2023 at 08:00:43PM +0800, Kemeng Shi wrote:
> >> Commit 0acdb8876fead ("ext4: don't call update_backups() multiple times
> >> for the same bg") add check in ext4_flex_group_add to avoid call
> >> update_backups multiple times for block group descriptors in the same
> >> group descriptor block. However, we have already call update_backups in
> >> block step, so the added check is unnecessary.
> > 
> > I'm having trouble understaind this comit.  What do you mean by the
> > "block step" in the last paragraph?
> > 
> Sorry for the confusing stuff. I mean we foreach in group descriptor block
> step instead of foreach in group descriptor step to update backup.
> So there is no chance to call update_backups for different descriptors
> in the same bg.

I'm still confused.  This commit is not so much removing an
unnecessary check as much as forcing update_backups() to be called for
every single block group.  Right?

So either we're doing extra work, or (b) we're fixing a problem
because we actually *need* to call update_backups() for every single
block group.

More generally, this whole patch series is making it clear that the
online resize code is hard to understand, because it's super
complicated, leading to potential bugs, and very clearly code which is
very hard to maintain.  So this may mean we need better comments to
make it clear *when* the backup block groups are going to be
accomplished, given the various different cases (e.g., no flex_bg or
meta_bg, with flex_bg, or with meat_bg).

							- Ted
