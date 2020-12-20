Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3B2DF5EB
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Dec 2020 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgLTPjw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Dec 2020 10:39:52 -0500
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:36277 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbgLTPjw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Dec 2020 10:39:52 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.074958|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0155462-0.00128685-0.983167;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.J9OH26p_1608478746;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J9OH26p_1608478746)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 20 Dec 2020 23:39:06 +0800
Date:   Sun, 20 Dec 2020 23:39:06 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCHv2 1/2] common/rc: Add whitelisted FS support in
 _require_scratch_swapfile()
Message-ID: <20201220153906.GC3853@desktop>
References: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
 <3bd1f738-93b7-038d-6db9-7bf6a330b1ea@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd1f738-93b7-038d-6db9-7bf6a330b1ea@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 16, 2020 at 10:53:45AM +0530, Ritesh Harjani wrote:
> 
> 
> On 12/16/20 10:47 AM, Ritesh Harjani wrote:
> > Filesystems e.g. ext4 and XFS supports swapon by default and an error
> > returned with swapon should be treated as a failure. Hence
> > add ext4/xfs as whitelisted fstype in _require_scratch_swapfile()
> > 
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> > v1->v2: Addressed comments from Eryu @[1]
> > [1]: https://patchwork.kernel.org/project/fstests/cover/cover.1604000570.git.riteshh@linux.ibm.com/
> > 
> >   common/rc | 20 ++++++++++++++++----
> >   1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 33b5b598a198..635b77a005c6 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2380,6 +2380,7 @@ _format_swapfile() {
> >   # Check that the filesystem supports swapfiles
> >   _require_scratch_swapfile()
> >   {
> > +	local fstyp=$FSTYP
> >   	_require_scratch
> >   	_require_command "$MKSWAP_PROG" "mkswap"
> > 
> > @@ -2401,10 +2402,21 @@ _require_scratch_swapfile()
> >   	# Minimum size for mkswap is 10 pages
> >   	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> > 
> > -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> > -		_scratch_unmount
> > -		_notrun "swapfiles are not supported"
> > -	fi
> > +	# For whitelisted fstyp swapon should not fail.
> > +	case "$fstyp" in
> > +	ext4|xfs)
> > +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> > +			_scratch_unmount
> > +			_fail "swapon failed for $fstyp"
> 
> @Eryu,
> As of now I added _fail() if swapon failed for given whitelisting fstype.
> Do you think this is alright, or should I just ignore the error in

I think it's reasonable.

But I'd like to leave the patchset on the list for review for another
week, to see if ext4 and/or xfs folks will chime in and have different
thoughts.

Thanks,
Eryu

> case of such FS?
> 
> 
> 
> > +		fi
> > +		;;
> > +	*)
> > +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> > +			_scratch_unmount
> > +			_notrun "swapfiles are not supported"
> > +		fi
> > +		;;
> > +	esac
> > 
> >   	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> >   	_scratch_unmount
> > --
> > 2.26.2
> > 
