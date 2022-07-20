Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3057B99D
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiGTPaR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiGTPaP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 11:30:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BA13FA1;
        Wed, 20 Jul 2022 08:30:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KFU2If014041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658331003; bh=yR//1PCZOueL9oa0bS2bXEyh1KSs07WjtQ+3bSpuZrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=alL0NNciAZMU8sVET/cEwEapA11axZJWnxtpdduA+JkuAcauCY7iIbiYqsoONecbq
         wTsEzEUkPnJV2sN0Dhu6DM0Pu4XwV2mME40iYScD47PZH33ulyLf1EEKUffvHTdsy9
         6F5FWFVX4l5WYwgBj/YOvcbtcucNSh+10f0G+6Q2xtNyhzeg0CB8nJfTyXDXyrEws5
         oZYrmgd8yJn4JmREwpkyeEoJ8cbUfd8y72W4D46O9kn/0ifsBf4SY8twYSCotZWPwE
         MD5JOFqJwo0B1ruweuoh/aHHesWmGutpvF9hboE0pncNNBZiLWxxXaS0FA44xqjNVL
         hugoFl9r5IMfA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1709115C3EBF; Wed, 20 Jul 2022 11:30:02 -0400 (EDT)
Date:   Wed, 20 Jul 2022 11:30:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <YtgfevC8CnGaZpQ5@mit.edu>
References: <20220720000256.239531-1-bongiojp@gmail.com>
 <20220720100949.dttc5qbmy4qziz65@zlang-mailbox>
 <YtfqIVEi7g4fFpqU@mit.edu>
 <20220720150636.cvd3ls2mbxbows27@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720150636.cvd3ls2mbxbows27@zlang-mailbox>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 11:06:36PM +0800, Zorro Lang wrote:
> > The kill -9 is needed, because otherwise the test will run for a
> > **very** long time.  The reason for it is because of the -n 999999 in
> 
> Sure, I mean:
> 
>   kill -9 $fsstress_pid 2>/dev/null
>   wait
> 
> Not remove the "kill" line :)

Ah yes, sorry, I misunderstood what you meant.

> > Also, Jeremy, it looks like you haven't updated your xfstests-dev
> > repository in a few weeks.  Since you started this project, ext4/056
> > has been assigned, and there has been some new helper programs added
> > which caused patch conflicts in src/Makefile and in .gitignore.  They
> > were pretty trivial to fix up the patch conflicts (which I've done in
> > my xfstests-dev tree), but it's best practice to rebase on top of
> > origin/for-next and re-test just to make sure there haven't been some
> > major change in the fstests common scripts that might catch your test
> > out.
> 
> Thanks for pointing out that, yes, better to rebase to latest fstests
> for-next branch.

Jeremy, for your convenience, my version of the change which is
rebased on for-next, fixes the merge conflicts and uses ext4/057
instead of ext4/056 can be found here:

https://github.com/tytso/xfstests/commit/330bf72dc67dd39e0fd413ecea78ab18b5405fb9

							- Ted
