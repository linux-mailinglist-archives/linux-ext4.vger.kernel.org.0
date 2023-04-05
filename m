Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BAF6D8533
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDERuv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDERuu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 13:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBBE4EFF;
        Wed,  5 Apr 2023 10:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E57063EFD;
        Wed,  5 Apr 2023 17:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EE0C433D2;
        Wed,  5 Apr 2023 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717048;
        bh=8RyRFaPwlCx6/LOIIjBet5SjJyIkLiaizKSwCarmDik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5ckeWaOWk8DYRS/vHEJFODUdFDterIWk0v6dwVPSI9Eqo5M3E9e4grJyjnLkrviz
         dmFQfemBW4Yipr4UCkQqWu/G0jjSFPpIfLv1Je78AwwHLIERp0PH1/vRe80YL6RRYZ
         JHue6126dFHFUdI0jGeczDDfabiD0M1vLyQEPVfbHZX3zYTjLfOHFds9uxGxs3TRQA
         4MnoQS7XV3DutZNo5CjWayJ9Vw8uMHLtIdvQkc3cGo0pogH7TUG6lTRLj5yrPGYu4M
         tKZPz4nQeJIMNPgpgrINAMfcVgJNK3JNCa+gggxvfOkDxw9yi9kDdMaMWz6bTaOSji
         hhrgnfYs6HsxA==
Date:   Wed, 5 Apr 2023 17:50:46 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>, djwong@kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <ZC209lS6vrEGqDhx@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
 <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
 <ZC2X5YlHMxzZQzhx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2X5YlHMxzZQzhx@infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 08:46:45AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 05, 2023 at 12:36:42PM +0200, Andrey Albershteyn wrote:
> > Hi Christoph,
> > 
> > On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> > > On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > > > Not the whole folio always need to be verified by fs-verity (e.g.
> > > > with 1k blocks). Use passed folio's offset and size.
> > > 
> > > Why can't those callers just call fsverity_verify_blocks directly?
> > > 
> > 
> > They can. Calling _verify_folio with explicit offset; size appeared
> > more clear to me. But I'm ok with dropping this patch to have full
> > folio verify function.
> 
> Well, there is no point in a wrapper if it has the exact same signature
> and functionality as the functionality being wrapped.
> 
> That being said, right now fsverity_verify_folio, so it might make sense
> to either rename it, or rename fsverity_verify_blocks to
> fsverity_verify_folio.  But that's really a question for Eric.

I thought it would be confusing for fsverity_verify_folio() to not actually
verify a whole folio.  So, for now we have:

    fsverity_verify_page: verify a whole page
    fsverity_verify_folio: verify a whole folio
    fsverity_verify_blocks: verify a range of blocks in a folio

IMO that makes sense.  Note: fsverity_verify_folio() is currently unused, but
ext4 might use it.

So, just use fsverity_verify_blocks().

- Eric
