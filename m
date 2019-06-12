Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37E542A3F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439912AbfFLPFZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 11:05:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36432 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437202AbfFLPFZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 11:05:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CEwkpM093493;
        Wed, 12 Jun 2019 15:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Yxa375AGz/GAh1Ki7TsbASzU+jAVN6KmGZPeP06unXc=;
 b=oOWzu2+9u5KC1Os6jF1mQLeZUrqlqlif7OKXFEbTTl+a7o07uBA7VQlGP2jYI2u2p77Z
 n1NZIpO1sQfKCssrwuURB8PpMPLl3Cm8n3pIcClLL43LFxBbwr4KFUcjlvmpE0cvVa+y
 reCluOnhPuRRqCEnqmimXkXgn/ZYlDJkGN3GU7XMo2XCh0PN5KCn5wugkVbVV4fKxkUx
 Y+XDHjOKUzC2nDwAz9FOtqVenWTwgR0jdyumByUSgdpSNzrid3g7cLumDbXr880ezszQ
 aJu1sCBs38BVh1yQPb1ZjI6QmNe7RDWPFK3PXwnMnGM0Nxllb8U1uaKb77+bs76QnSdV 2w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2t02hev8ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:05:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CF3Knh067638;
        Wed, 12 Jun 2019 15:05:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t024v1byc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:05:10 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CF58v0024480;
        Wed, 12 Jun 2019 15:05:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 08:05:08 -0700
Date:   Wed, 12 Jun 2019 08:05:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] generic: test statfs on project quota directory
Message-ID: <20190612150507.GB3773859@magnolia>
References: <20190513014951.4357-1-zlang@redhat.com>
 <01F47CA1-E737-4F52-8FF2-A3E0DCD8EB1B@dilger.ca>
 <20190612073213.GA30864@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612073213.GA30864@dhcp-12-102.nay.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120101
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 03:32:13PM +0800, Zorro Lang wrote:
> On Tue, May 14, 2019 at 09:28:38AM -0600, Andreas Dilger wrote:
> > On May 12, 2019, at 7:49 PM, Zorro Lang <zlang@redhat.com> wrote:
> > > 
> > > There's a bug on xfs cause statfs get negative f_ffree value from
> > > a project quota directory. It's fixed by "de7243057 fs/xfs: fix
> > > f_ffree value for statfs when project quota is set". So add statfs
> > > testing on project quota block and inode count limit.
> > > 
> > > For testing foreign fs quota, change _qmount() function, turn on
> > > project if quotaon support.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > (Long time passed, re-send this patch again to get reviewing)
> > > 
> > > There's one thing I don't understand, so CC ext4 mail list. Please
> > > feel free to reply, if anyone knows that:
> > > 
> > > $ mkfs.ext4 $SCRATCH_DEV
> > > $ tune2fs -O quota,project $SCRATCH_DEV
> > > $ mount $SCRATCH_DEV $SCRATCH_MNT -o prjquota
> > > $ quotaon -P $SCRATCH_MNT
> > > $ mkdir $SCRATCH_MNT/t
> > > $ xfs_quota -f -x -c "project -p $SCRATCH_MNT/t -s 42" $SCRATCH_MNT
> > > $ xfs_quota -f -x -c "limit -p bsoft=100m answer" $SCRATCH_MNT
> > > $ df -k $SCRATCH_MNT/t
> > > Filesystem    1K-blocks  Used Available Use% Mounted on
> > > SCRATCH_DEV    102400     4    102396   1% SCRATCH_MNT
> > > 
> > > On XFS, the 'Used' field always shows '0'. But why ext4 always has
> > > more 4k? Is it a bug or expected.
> > 
> > Each directory in ext4 consumes a 4KB block, so setting the project
> > quota on a directory always consumes at least one block.
> 
> Ping fstests@vger.kernel.org.
> 
> One month passed. Is there anything else block this patch merge?

If this is a regression test for an xfs bug, why isn't this in
tests/xfs/ ?  Especially because ext4 has different behaviors that clash
with the golden output -- what happens if you run this with inline data
enabled?

--D

> Thanks,
> Zorro
> 
> > 
> > Cheers, Andreas
> > 
> > > common/quota          |  4 +++
> > > tests/generic/999     | 74 +++++++++++++++++++++++++++++++++++++++++++
> > > tests/generic/999.out |  3 ++
> > > tests/generic/group   |  1 +
> > > 4 files changed, 82 insertions(+)
> > > create mode 100755 tests/generic/999
> > > create mode 100644 tests/generic/999.out
> > > 
> > > diff --git a/common/quota b/common/quota
> > > index f19f81a1..315df8cb 100644
> > > --- a/common/quota
> > > +++ b/common/quota
> > > @@ -200,6 +200,10 @@ _qmount()
> > >    if [ "$FSTYP" != "xfs" ]; then
> > >        quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
> > >        quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
> > > +	# try to turn on project quota if it's supported
> > > +	if quotaon --help 2>&1 | grep -q '\-\-project'; then
> > > +		quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
> > > +	fi
> > >    fi
> > >    chmod ugo+rwx $SCRATCH_MNT
> > > }
> > > diff --git a/tests/generic/999 b/tests/generic/999
> > > new file mode 100755
> > > index 00000000..555341f1
> > > --- /dev/null
> > > +++ b/tests/generic/999
> > > @@ -0,0 +1,74 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 999
> > > +#
> > > +# Test statfs when project quota is set.
> > > +# Uncover de7243057 fs/xfs: fix f_ffree value for statfs when project quota is set
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	_scratch_unmount
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/quota
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch
> > > +_require_quota
> > > +_require_xfs_quota_foreign
> > > +
> > > +_scratch_mkfs >/dev/null 2>&1
> > > +_scratch_enable_pquota
> > > +_qmount_option "prjquota"
> > > +_qmount
> > > +_require_prjquota $SCRATCH_DEV
> > > +
> > > +# Create a directory to be project object, and create a file to take 64k space
> > > +mkdir $SCRATCH_MNT/t
> > > +$XFS_IO_PROG -f -c "pwrite 0 65536" -c sync $SCRATCH_MNT/t/file >>$seqres.full
> > > +
> > > +# Setup temporary replacements for /etc/projects and /etc/projid
> > > +cat >$tmp.projects <<EOF
> > > +42:$SCRATCH_MNT/t
> > > +EOF
> > > +
> > > +cat >$tmp.projid <<EOF
> > > +answer:42
> > > +EOF
> > > +
> > > +quota_cmd="$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
> > > +$quota_cmd -x -c 'project -s answer' $SCRATCH_MNT >/dev/null 2>&1
> > > +$quota_cmd -x -c 'limit -p isoft=53 bsoft=100m answer' $SCRATCH_MNT
> > > +
> > > +# The itotal and size should be 53 and 102400(k), as above project quota limit.
> > > +# The isued and used should be 2 and 64(k), as this case takes. But ext4 always
> > > +# shows more 4k 'used' space than XFS, it prints 68k at here. So filter the
> > > +# 6[48] at the end.
> > > +df -k --output=file,itotal,iused,size,used $SCRATCH_MNT/t | \
> > > +	_filter_scratch | _filter_spaces | \
> > > +	sed -e "/SCRATCH_MNT/s/6[48]/N/"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/999.out b/tests/generic/999.out
> > > new file mode 100644
> > > index 00000000..1bebabd4
> > > --- /dev/null
> > > +++ b/tests/generic/999.out
> > > @@ -0,0 +1,3 @@
> > > +QA output created by 999
> > > +File Inodes IUsed 1K-blocks Used
> > > +SCRATCH_MNT/t 53 2 102400 N
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index 9f4845c6..35da10a5 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -542,3 +542,4 @@
> > > 537 auto quick trim
> > > 538 auto quick aio
> > > 539 auto quick punch seek
> > > +999 auto quick quota
> > > --
> > > 2.17.2
> > > 
> > 
> > 
> > Cheers, Andreas
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > Cheers, Andreas
> > 
> > 
> > 
> > 
> > 
> 
> 
