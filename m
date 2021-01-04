Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8332E9CFA
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jan 2021 19:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbhADS0e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jan 2021 13:26:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbhADS0e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jan 2021 13:26:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104IPXXv081980;
        Mon, 4 Jan 2021 18:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=r+syGqC3dl8Rt+Cy7QBT32dfOCs/oo1YPJD0Uivpapw=;
 b=atP6CL+flAF2aLgztyBjwcxMYWU4Doc1LG8MNkiMQCkVEeqQbuKGXO4c4uLGtJIdS0DP
 TwHrE4QVm8BHvr4ZwHimogyJPGsCYldqGjwWiF/khrajdD2tccQ+GU4ADzX1j2yBP6uL
 v9fk+NnXHMcd4QLr7jgk6M+LOUq9W3frBRy2kd+NHRx2sLgchTNAlQuQzFRCQvsQATQV
 6g8oSwWYjXDL1xQzE08r3N2CxlhJ0BVw7jszRStnWeXnb8fuC7C1kz85hhS3MToOwLd/
 vh6UaclP9N0GPc+FVMjY+tJdK7lNLk+aIEBhRFUd3EdbP6pEpc5tiRpfU7aMqUHTh6aA qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35tg8qwkgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 18:25:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104I0Qow103650;
        Mon, 4 Jan 2021 18:25:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35v4rag794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 18:25:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104IPkQF020490;
        Mon, 4 Jan 2021 18:25:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 10:25:46 -0800
Date:   Mon, 4 Jan 2021 10:25:45 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        anju@linux.vnet.ibm.com
Subject: Re: [PATCHv2 1/2] common/rc: Add whitelisted FS support in
 _require_scratch_swapfile()
Message-ID: <20210104182545.GF6908@magnolia>
References: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
 <3bd1f738-93b7-038d-6db9-7bf6a330b1ea@linux.ibm.com>
 <20201220153906.GC3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220153906.GC3853@desktop>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040119
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 20, 2020 at 11:39:06PM +0800, Eryu Guan wrote:
> On Wed, Dec 16, 2020 at 10:53:45AM +0530, Ritesh Harjani wrote:
> > 
> > 
> > On 12/16/20 10:47 AM, Ritesh Harjani wrote:
> > > Filesystems e.g. ext4 and XFS supports swapon by default and an error
> > > returned with swapon should be treated as a failure. Hence
> > > add ext4/xfs as whitelisted fstype in _require_scratch_swapfile()
> > > 
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > > v1->v2: Addressed comments from Eryu @[1]
> > > [1]: https://patchwork.kernel.org/project/fstests/cover/cover.1604000570.git.riteshh@linux.ibm.com/
> > > 
> > >   common/rc | 20 ++++++++++++++++----
> > >   1 file changed, 16 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 33b5b598a198..635b77a005c6 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2380,6 +2380,7 @@ _format_swapfile() {
> > >   # Check that the filesystem supports swapfiles
> > >   _require_scratch_swapfile()
> > >   {
> > > +	local fstyp=$FSTYP
> > >   	_require_scratch
> > >   	_require_command "$MKSWAP_PROG" "mkswap"
> > > 
> > > @@ -2401,10 +2402,21 @@ _require_scratch_swapfile()
> > >   	# Minimum size for mkswap is 10 pages
> > >   	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> > > 
> > > -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> > > -		_scratch_unmount
> > > -		_notrun "swapfiles are not supported"
> > > -	fi
> > > +	# For whitelisted fstyp swapon should not fail.

I would use a different phase than 'whitelisted', since that doesn't
tell us why ext4 and xfs are special:

# ext* and xfs have supported all variants of swap files since their
# introduction, so swapon should not fail.

> > > +	case "$fstyp" in

$FSTYP, not $fstyp

> > > +	ext4|xfs)

I would also add a few more FSTYPs here, since at least ext2 and ext3
supported swap files.  Are there other old fses that do?

--D

> > > +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> > > +			_scratch_unmount
> > > +			_fail "swapon failed for $fstyp"
> > 
> > @Eryu,
> > As of now I added _fail() if swapon failed for given whitelisting fstype.
> > Do you think this is alright, or should I just ignore the error in
> 
> I think it's reasonable.
> 
> But I'd like to leave the patchset on the list for review for another
> week, to see if ext4 and/or xfs folks will chime in and have different
> thoughts.
> 
> Thanks,
> Eryu
> 
> > case of such FS?
> > 
> > 
> > 
> > > +		fi
> > > +		;;
> > > +	*)
> > > +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> > > +			_scratch_unmount
> > > +			_notrun "swapfiles are not supported"
> > > +		fi
> > > +		;;
> > > +	esac
> > > 
> > >   	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> > >   	_scratch_unmount
> > > --
> > > 2.26.2
> > > 
