Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3123E3A76
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Aug 2021 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHHNdX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 09:33:23 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:37046 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhHHNdL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Aug 2021 09:33:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07502286|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.265791-0.0208945-0.713315;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Kx179PM_1628429568;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kx179PM_1628429568)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sun, 08 Aug 2021 21:32:48 +0800
Date:   Sun, 8 Aug 2021 21:32:48 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv2 7/9] generic/620: Use _mkfs_dev_blocksized to use 4k bs
Message-ID: <YQ/dAFFDLp0edZUl@desktop>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
 <a7d863771ec7187a1d89e0e33aa36bb6aaa5a2a7.1626844259.git.riteshh@linux.ibm.com>
 <YQbF38FWSLX+eUm6@desktop>
 <20210803050622.yh2wn2fhzxn4jjbv@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803050622.yh2wn2fhzxn4jjbv@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 03, 2021 at 10:36:22AM +0530, Ritesh Harjani wrote:
> On 21/08/02 12:03AM, Eryu Guan wrote:
> > On Wed, Jul 21, 2021 at 10:58:00AM +0530, Ritesh Harjani wrote:
> > > ext4 with 64k blocksize (passed by user config) fails with below error for
> > > this given test which requires dmhugedisk. Since this test anyways only
> > > requires 4k bs, so use _mkfs_dev_blocksized() to fix this.

I don't see how this test always requires 4k blocksize, 1k blocksized
xfs also passes the test.

> > >
> > > <error log with 64k bs>
> > > mkfs.ext4: Input/output error while writing out and closing file system

Is this a bug in mkfs.ext4 or expected error (unsupported config)? If
it's an expected error, it'd be better to explain it in commit log as
well.

> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  tests/generic/620 | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tests/generic/620 b/tests/generic/620
> > > index b052376f..444e682d 100755
> > > --- a/tests/generic/620
> > > +++ b/tests/generic/620
> > > @@ -42,7 +42,9 @@ sectors=$((2*1024*1024*1024*17))
> > >  chunk_size=128
> > >
> > >  _dmhugedisk_init $sectors $chunk_size
> > > -_mkfs_dev $DMHUGEDISK_DEV
> > > +
> > > +# Use 4k blocksize.
> > > +_mkfs_dev_blocksized 4096 $DMHUGEDISK_DEV
> >
> > We run the test by forcing 4k blocksize, which could be tested in 4k
> > blocksize setup. Maybe it's another case that should _notrun in 64k
> > blocksize setup.
> 
> So for testing that, first I should mkfs and mount a scratch device with the
> passed mount/mkfs options and then see if the blocksize passed is 64K, if yes
> I should _notrun this case.
> 
> Isn't the current approach of (_mkfs_dev_blocksized 4096) is better then above
> approach?

If the test always requires 4k blocksize, forcing creating a 4k
blocksize filesystem doesn't increase any test coverage, I don't see any
point introducing a new _mkfs_dev_blocksized helper just to do so.

And even if we decide to force 4k blocksize config, I think it'd be
better to update _scratch_mkfs_blocksized() to take device as argument,
like what _check_scratch_fs() does, so we don't duplicate all the code
to create fs with specified blocksize.

Thanks,
Eryu

> 
> -ritesh
> 
> > Thanks,
> > Eryu
> >
> > >  _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
> > >  testfile=$SCRATCH_MNT/testfile-$seq
> > >
> > > --
> > > 2.31.1
