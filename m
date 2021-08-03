Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35C3DE5C6
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 07:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhHCFA5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 01:00:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229753AbhHCFA5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 01:00:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1734hRTo003205;
        Tue, 3 Aug 2021 01:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=SL6vi5WaHWZaEerF7HQ60qsuzS74lFHTIY3atdMYmtw=;
 b=TpCjMokSOVkNXJj8jlNtWSchG8dAhETcNAAs+5Sr51xqM+6xcm8H3mzbt8vJcRemThPs
 mamXuaeD2oauexgadVEMA6xknU6YbxVM/zG260vh4ae1nffNqAHWAszC841F+9UiQE0+
 UyMteDNPEK8hJoPJuw97ZLBZVc2RzeyvYpF4DGnH7rXSIp+oU5514iSBgbXEWwcGqWuk
 1PS2rhmHALlN+APchQk+UPjKLMlupdSBxYBGAI72v6l8Cwqok0zICebuTwuuEuo+wzP1
 pCAsYRN2oWAcrveDkH4WOXr6jlKk53szX4YjMTq+LlefpA+C0fAcJSUxxnsYnDEUUZqb Qw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a5rkxrb2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 01:00:40 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1734qcJL027640;
        Tue, 3 Aug 2021 05:00:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3a4x58nn2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 05:00:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17350ZGL56557920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 05:00:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54592A409A;
        Tue,  3 Aug 2021 05:00:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE58A4067;
        Tue,  3 Aug 2021 05:00:34 +0000 (GMT)
Received: from localhost (unknown [9.85.100.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 05:00:34 +0000 (GMT)
Date:   Tue, 3 Aug 2021 10:30:33 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv2 5/9] generic/031: Fix the test case for 64k blocksize
 config
Message-ID: <20210803050033.meopotfeooo6n4gu@riteshh-domain>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
 <c37a4cfb8a50d2df68369d66ef6e1ebf6533e3ea.1626844259.git.riteshh@linux.ibm.com>
 <YQbFDtq9aDA7Ql1j@desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQbFDtq9aDA7Ql1j@desktop>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s0zPvSkOjKv2r0BVXgUQNyHdVIl2xWV2
X-Proofpoint-ORIG-GUID: s0zPvSkOjKv2r0BVXgUQNyHdVIl2xWV2
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_10:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030027
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/08/02 12:00AM, Eryu Guan wrote:
> On Wed, Jul 21, 2021 at 10:57:58AM +0530, Ritesh Harjani wrote:
> > This test fails with blocksize 64k since the test assumes 4k blocksize
> > in fcollapse param. This patch fixes that and also tests for 64k
> > blocksize.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  tests/generic/031     | 14 +++++++++-----
> >  tests/generic/031.out | 16 ++++++++--------
> >  2 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/tests/generic/031 b/tests/generic/031
> > index 313ce9ff..11961c54 100755
> > --- a/tests/generic/031
> > +++ b/tests/generic/031
> > @@ -26,11 +26,16 @@ testfile=$SCRATCH_MNT/testfile
> >  _scratch_mkfs > /dev/null 2>&1
> >  _scratch_mount
> >
> > +# fcollapse need offset and len to be multiple of blocksize for filesystems
> > +# So let's make the offsets and len required for fcollapse multiples of 64K
> > +# so that it works for all configurations (including on dax on 64K page size
> > +# systems)
> > +fact=$((65536/4096))
> >  $XFS_IO_PROG -f \
> > -	-c "pwrite 185332 55756" \
> > -	-c "fcollapse 28672 40960" \
> > -	-c "pwrite 133228 63394" \
> > -	-c "fcollapse 0 4096" \
> > +	-c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \
>
> Where does this 12 come from?
A random number so that the offset and length are not bocksize aligned.
If you see the final .out file, you will see the offset of the writes
remains the same with and before this patch.

> And I'm wondering if this still reproduces the original bug.
I am not sure how to trigger this. I know that this test was intended for
bs < ps cases. If someone can help me / point me to the kernel fix for this,
I can try to reproduce the original bug too.

I found this link for this test patch series. Couldn't find the kernel fixes
link though.
https://www.spinics.net/lists/fstests/msg00340.html


>
> And looks like that the original test setups came from a specific
> fsstress or fsx run, and aimed to the specific bug, perhaps we could
> require the test with <= 4k block size, and _notrun in 64k case.

It would be good to know whether this code could trigger the original bug or
not. Then we need not make _notrun for 64k case.

>
> Thanks,
> Eryu
>
> > +	-c "fcollapse $((28672 * fact)) $((40960 * fact))" \
> > +	-c "pwrite $((133228 * fact + 12)) $((63394 * fact + 12))" \
> > +	-c "fcollapse 0 $((4096 * fact))" \
> >  $testfile | _filter_xfs_io
> >
> >  echo "==== Pre-Remount ==="
> > @@ -41,4 +46,3 @@ hexdump -C $testfile
> >
> >  status=0
> >  exit
> > -
> > diff --git a/tests/generic/031.out b/tests/generic/031.out
> > index 194bfa45..7dfcfe41 100644
> > --- a/tests/generic/031.out
> > +++ b/tests/generic/031.out
> > @@ -1,19 +1,19 @@
> >  QA output created by 031
> > -wrote 55756/55756 bytes at offset 185332
> > +wrote 892108/892108 bytes at offset 2965324
> >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -wrote 63394/63394 bytes at offset 133228
> > +wrote 1014316/1014316 bytes at offset 2131660
> >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >  ==== Pre-Remount ===
> >  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> >  *
> > -0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> > -0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> > +001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> > +001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> >  *
> > -0002fdc0
> > +002fdc18
> >  ==== Post-Remount ==
> >  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> >  *
> > -0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> > -0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> > +001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> > +001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> >  *
> > -0002fdc0
> > +002fdc18
> > --
> > 2.31.1
