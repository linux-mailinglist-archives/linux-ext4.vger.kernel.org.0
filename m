Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192BF3E3A38
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Aug 2021 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhHHMgd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 08:36:33 -0400
Received: from out20-109.mail.aliyun.com ([115.124.20.109]:54860 "EHLO
        out20-109.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHMgd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Aug 2021 08:36:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07566925|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.177431-0.00443938-0.818129;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Kx0Oam-_1628426171;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kx0Oam-_1628426171)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sun, 08 Aug 2021 20:36:12 +0800
Date:   Sun, 8 Aug 2021 20:36:11 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv2 5/9] generic/031: Fix the test case for 64k blocksize
 config
Message-ID: <YQ/PuznWmSgcTQiM@desktop>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
 <c37a4cfb8a50d2df68369d66ef6e1ebf6533e3ea.1626844259.git.riteshh@linux.ibm.com>
 <YQbFDtq9aDA7Ql1j@desktop>
 <20210803050033.meopotfeooo6n4gu@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803050033.meopotfeooo6n4gu@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 03, 2021 at 10:30:33AM +0530, Ritesh Harjani wrote:
> On 21/08/02 12:00AM, Eryu Guan wrote:
> > On Wed, Jul 21, 2021 at 10:57:58AM +0530, Ritesh Harjani wrote:
> > > This test fails with blocksize 64k since the test assumes 4k blocksize
> > > in fcollapse param. This patch fixes that and also tests for 64k
> > > blocksize.
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  tests/generic/031     | 14 +++++++++-----
> > >  tests/generic/031.out | 16 ++++++++--------
> > >  2 files changed, 17 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tests/generic/031 b/tests/generic/031
> > > index 313ce9ff..11961c54 100755
> > > --- a/tests/generic/031
> > > +++ b/tests/generic/031
> > > @@ -26,11 +26,16 @@ testfile=$SCRATCH_MNT/testfile
> > >  _scratch_mkfs > /dev/null 2>&1
> > >  _scratch_mount
> > >
> > > +# fcollapse need offset and len to be multiple of blocksize for filesystems
> > > +# So let's make the offsets and len required for fcollapse multiples of 64K
> > > +# so that it works for all configurations (including on dax on 64K page size
> > > +# systems)
> > > +fact=$((65536/4096))
> > >  $XFS_IO_PROG -f \
> > > -	-c "pwrite 185332 55756" \
> > > -	-c "fcollapse 28672 40960" \
> > > -	-c "pwrite 133228 63394" \
> > > -	-c "fcollapse 0 4096" \
> > > +	-c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \
> >
> > Where does this 12 come from?
> A random number so that the offset and length are not bocksize aligned.
> If you see the final .out file, you will see the offset of the writes
> remains the same with and before this patch.
> 
> > And I'm wondering if this still reproduces the original bug.
> I am not sure how to trigger this. I know that this test was intended for
> bs < ps cases. If someone can help me / point me to the kernel fix for this,
> I can try to reproduce the original bug too.
> 
> I found this link for this test patch series. Couldn't find the kernel fixes
> link though.
> https://www.spinics.net/lists/fstests/msg00340.html

I think it's a regression test for this patchset.

https://www.spinics.net/lists/xfs/msg29807.html

> 
> 
> >
> > And looks like that the original test setups came from a specific
> > fsstress or fsx run, and aimed to the specific bug, perhaps we could
> > require the test with <= 4k block size, and _notrun in 64k case.
> 
> It would be good to know whether this code could trigger the original bug or
> not. Then we need not make _notrun for 64k case.

Agreed, if we could make sure that updated test still triggers the
original bug, there's no reason _notrun for 64k case.

Thanks,
Eryu
