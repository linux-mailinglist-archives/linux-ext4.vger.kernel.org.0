Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8654C533
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiFOJ4R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiFOJ4Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 05:56:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBF49B59;
        Wed, 15 Jun 2022 02:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE8D6B81C62;
        Wed, 15 Jun 2022 09:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB5FC34115;
        Wed, 15 Jun 2022 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655286973;
        bh=ZhDBRgQU7ZcI9kZgJu86+5uy/cAyHPmmrrm4MdoMzic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZ18s2nlPinYpFsreuxH/N3n6o1GGraB0CtE35X727U/GrkcexK1hPokbY41+Eudm
         6EGsZKNg2YawcQPZMa6AclhI1nTS4+X2MsBG4XLI1yW2KqU9kReFbYu6ZX07MuFymB
         GwTIP1vawNFSEb+H4t4lHhNh+LsEmBmdecOGnieT5gZUnDX1p+xc89bapP2/w6ECKb
         9p5L28unvjqlcQ5TXO0ATnPLJFqdWA06mHUbzqGbdWXVXfcZFN8EDwcq2oM3UvlQYc
         211BuFbgvLu22KO9zNuYjMN1oah0N0epuNjAzOzdI20QnKhGTJ/2LfC8GjqyaoFPnp
         iUWiyf3nhc57Q==
Date:   Wed, 15 Jun 2022 17:56:07 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <20220615095607.zkvq2vnh4ebue3qi@zlang-mailbox>
References: <20220516084505.97655-1-ojaswin@linux.ibm.com>
 <Yqb21hTVUvob/sgc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqb21hTVUvob/sgc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 13, 2022 at 02:05:34PM +0530, Ojaswin Mujoo wrote:
> Greetings,
> 
> Please let me know if there are any reviews/suggestions on this
> patch.

This patch has been merged in fstests v2022.05.22, as below

  ee264b3f common/rc: Modify _require_batched_discard to improve test coverage

Is there anything wrong with that?

Thanks,
Zorro

> 
> Thank you!
> 
> On Mon, May 16, 2022 at 02:15:05PM +0530, Ojaswin Mujoo wrote:
> > A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> > have a discard granularity as big as 42MB which makes it larger
> > than the group size of ext4 FS with 1k BS.  This causes the FITRIM
> > IOCTL to fail.
> > 
> > This case was not correctly handled by this test since
> > "_require_batched_discard" incorrectly interpreted the FITRIM
> > failure as SCRATCH_DEV not supporting the IOCTL. This caused the test
> > to report "not run" instead of "failed" in case of large discard granularity.
> > 
> > Fix "_require_batched_discard" to use a more accurate method
> > to determine if discard is supported.
> > 
> > [1] commit 173b6e383d2
> >     ext4: avoid trim error on fs with small groups
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> > 
> > Changes since v2 [1] 
> > 
> > *  Eliminated redundant $ret variable
> > 
> > [1]
> > https://lore.kernel.org/all/20220516063951.87838-1-ojaswin@linux.ibm.com/
> 
