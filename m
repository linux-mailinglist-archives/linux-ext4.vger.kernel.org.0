Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62958550748
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiFRWWb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiFRWWa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 18:22:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93110FFD;
        Sat, 18 Jun 2022 15:22:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25IMM0lH021854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jun 2022 18:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655590923; bh=YrhDLwaCTlOrkF9IQHmzP4ZWIpSzEsV/ZK9FqdnlmMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=mRMGaJ66wKbsram2GYoiclVP8dJmHU8fr1LMeMO2Py7Uom+4zYY42vJjfsTEsO5tm
         sTq0/8hBDWuA3MZMGnMv4HdEfgnu5iLkV5YRM+FXFyQhf7fTM6/Ay+PVkhrUBSeFIR
         CtLqWwa3V+seP9fCFQXuzqC9ZV4y+fEq7QYFOXCU8xSYpqzLiGoQzNmDt+RUZgGSJ4
         bLUFg6GfYMK1uHKOmcleK5DsovEZ/lJCaZlEDt1dT6VeCNSAkRBLSFCy8mMgwdcwCs
         kADM6YvyNwwFGMVaL4D3oa+jClOjpuCirLmI+ILm0JLMkbp1KICkiknyOZwBiVxucE
         Da3uBjz7ob3tQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A6E3E15C430A; Sat, 18 Jun 2022 18:22:00 -0400 (EDT)
Date:   Sat, 18 Jun 2022 18:22:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     adilger.kernel@dilger.ca,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] ext4: change variable "count" to signed integer
Message-ID: <Yq5QCJI7qC80AtxL@mit.edu>
References: <20220530100047.537598-1-dingxiang@cmss.chinamobile.com>
 <165552108974.634564.2634497659089601268.b4-ty@mit.edu>
 <Yq2bzesQ5H+DrA47@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq2bzesQ5H+DrA47@kili>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 18, 2022 at 12:33:01PM +0300, Dan Carpenter wrote:
> On Fri, Jun 17, 2022 at 10:59:01PM -0400, Theodore Ts'o wrote:
> > On Mon, 30 May 2022 18:00:47 +0800, Ding Xiang wrote:
> > > Since dx_make_map() may return -EFSCORRUPTED now,
> > > so change "count" to signed integer.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/1] ext4: change variable "count" to signed integer
> >       commit: fefb759df063599ad483422eb07ef8e14c612cc2
> > 
> 
> There was some kind of process error here...
> 
> 1) That commit somehow never made it to linux-next.

That's I only pushed it out Friday night (US/Eastern), and Stephen
Rothwell creates new linux-next release based on snapshots taken
Monday through Friday in the Morning (AU/Canberra time).

Things have been crazy busy, so a last set of ext4 backports only
happened Friday starting around 10pm localtime.  (Yes, I have no
life.)


> 2) No Fixes tag.  Presumably Greg searches for Fixes tags before he back
> ports patches.  The original commit 46c116b920eb ("ext4: verify dir
> block before splitting it") has been back ported to stable already.

I did add a Fixes tag in what is in the ext4 tree.  I don't always
mention when I've rewritten since that requries manual editing of the
"b4 ty" generated acknowledgement.

In the ideal world when I rewrite the one-line snapshot, at the *very*
least it should show up in the Applied/thanks.  Maybe something like
this:

[1/1] ext4: change variable "count" to signed integer
      commit: fefb759df063599ad483422eb07ef8e14c612cc2
      rewritten summary: ext4: make variable "count" signed

... and if the commit description is rewritten, maybe the "b4 ty"
e-mail should mention it.  (Very often I end up rewriting commit
descriptions, especially when the original poster's first language is
not English.)

For the record, this is what is in the ext4 tree that I plan to push
to Linus is:

commit fefb759df063599ad483422eb07ef8e14c612cc2
Author: Ding Xiang <dingxiang@cmss.chinamobile.com>
Date:   Mon May 30 18:00:47 2022 +0800

    ext4: make variable "count" signed
    
    Since dx_make_map() may return -EFSCORRUPTED now, so change "count" to
    be a signed integer so we can correct check for an error code returned
    by dx_make_map().
    
    Fixes: 46c116b920eb ("ext4: verify dir block before splitting it")
    Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
    Link: https://lore.kernel.org/r/20220530100047.537598-1-dingxiang@cmss.chinamobile.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Cheers,

					- Ted
