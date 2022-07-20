Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8657B5B9
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 13:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGTLmt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 07:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbiGTLmr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 07:42:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CC54073;
        Wed, 20 Jul 2022 04:42:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KBgPb8017551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 07:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658317347; bh=kX9mWBLVRi0Al//6eocDcC1gCtqfYt5xvj3UZKDHk34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fdgLFTmU8vbaRpUjFzbvYj8M/1UNbVPQgibS7W8YJQNzN2rZkhHq7legPOVqvyq/M
         4SPyR2L74a0vYLbgKYsMI53S0dvIYVWtmuheTsFoKw/He8aUhEtp//Y2JoCmlYcQz6
         1y3aHE2Dhisc2ayavNphPNhfdqnOTLBFak0vJg2iyl3anjg2w3ZzN9ACZrBBxtr2vj
         frbfrHa4Ks8mCrHyxjag1anW3Ry+ZxaXz4aN8zowVFbrB/K9oq8OGzmLP8D2SVgjrG
         dKAenOz1I4a4LRHAaz+SzDNKuMGUOPknfK+J7dAlUmO2zKB98lbJz9FZG/Eoz59Zlc
         p4oJrm8MueDLQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A2AC415C3EBF; Wed, 20 Jul 2022 07:42:25 -0400 (EDT)
Date:   Wed, 20 Jul 2022 07:42:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
Message-ID: <YtfqIVEi7g4fFpqU@mit.edu>
References: <20220720000256.239531-1-bongiojp@gmail.com>
 <20220720100949.dttc5qbmy4qziz65@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720100949.dttc5qbmy4qziz65@zlang-mailbox>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 06:09:49PM +0800, Zorro Lang wrote:
> On Tue, Jul 19, 2022 at 05:02:56PM -0700, Jeremy Bongio wrote:
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +        cd /
> > +        rm -r -f $tmp.*
> > +        kill -9 $fsstress_pid 2>/dev/null;
> > +        wait $fsstress_pid > /dev/null 2>&1
> 
> I think "wait" is enough. With this change, it's good to me.

The kill -9 is needed, because otherwise the test will run for a
**very** long time.  The reason for it is because of the -n 999999 in
fstress_args:

> > +# Begin fsstress while modifying UUID
> > +fsstress_args=$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 999999)
> > +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
> > +fsstress_pid=$!

We could adjust the number of loops to a more reasonable number, but
then test becomes less reliable, since depending on the storage device
(e.g., cheap USB thumb drive found in the checkout counter at a
convenience store, vs. a high-end NVMe SSD) and the overall speed of
the system, a different number of loops will be needed.

Given that we're *only* using the fsstress as an antogonist while we
are changing the UUID of the file system 20 times, killing the
fsstress once we're done with the UUID runs is sufficient, I would
argue.

Also, Jeremy, it looks like you haven't updated your xfstests-dev
repository in a few weeks.  Since you started this project, ext4/056
has been assigned, and there has been some new helper programs added
which caused patch conflicts in src/Makefile and in .gitignore.  They
were pretty trivial to fix up the patch conflicts (which I've done in
my xfstests-dev tree), but it's best practice to rebase on top of
origin/for-next and re-test just to make sure there haven't been some
major change in the fstests common scripts that might catch your test
out.

Also, feel free to add my:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Cheers,

						- Ted
