Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6C3DE601
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 07:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhHCFGs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 01:06:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233647AbhHCFGq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 01:06:46 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17354aCM019926;
        Tue, 3 Aug 2021 01:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JKnaNnz5NYnoZhmqZRyo+N4Q6un/C+uMKyoUxNEOrjM=;
 b=L6q58r1sa2japnCgnKOzjtRUKeoW0hBTQOMuDNUJCyNvOO04/WR1suEY1pLeDDwECPc4
 9URxUQ5km1vB/dArpJgnNnN8KoRu+BIGjkKOG3iOm+trt3odEFpGGy4ALIZIC+N9PPOf
 KCc0/mDs0wPkM5TUz7giRP6LyAoyGiqTLcXT8KnKWsNt53aBDardGgQ+Pq+9PRWbP8s8
 a017ePDYGelG/QhHk8ZhUYS3PZyndstuz+CkJVoHAYBOQGJSf8orvf7Gkl+Gnz2gsUSR
 S58jpFdVCvdW7LdalgwVHeJzIar6rWDvDLeSeKif3lYredJKZjZ9c7VtGKDvHfwOGM8s 2A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a5pdn812k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 01:06:29 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17353AO1019643;
        Tue, 3 Aug 2021 05:06:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3a4x58nq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 05:06:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17353Wf818547186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 05:03:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA275A4066;
        Tue,  3 Aug 2021 05:06:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E4FCA4065;
        Tue,  3 Aug 2021 05:06:24 +0000 (GMT)
Received: from localhost (unknown [9.85.100.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 05:06:23 +0000 (GMT)
Date:   Tue, 3 Aug 2021 10:36:22 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv2 7/9] generic/620: Use _mkfs_dev_blocksized to use 4k bs
Message-ID: <20210803050622.yh2wn2fhzxn4jjbv@riteshh-domain>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
 <a7d863771ec7187a1d89e0e33aa36bb6aaa5a2a7.1626844259.git.riteshh@linux.ibm.com>
 <YQbF38FWSLX+eUm6@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQbF38FWSLX+eUm6@desktop>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: beTdnRpjDG7P1Bq0ua9Mi757PECZ9qWT
X-Proofpoint-ORIG-GUID: beTdnRpjDG7P1Bq0ua9Mi757PECZ9qWT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_10:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030031
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/08/02 12:03AM, Eryu Guan wrote:
> On Wed, Jul 21, 2021 at 10:58:00AM +0530, Ritesh Harjani wrote:
> > ext4 with 64k blocksize (passed by user config) fails with below error for
> > this given test which requires dmhugedisk. Since this test anyways only
> > requires 4k bs, so use _mkfs_dev_blocksized() to fix this.
> >
> > <error log with 64k bs>
> > mkfs.ext4: Input/output error while writing out and closing file system
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  tests/generic/620 | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/generic/620 b/tests/generic/620
> > index b052376f..444e682d 100755
> > --- a/tests/generic/620
> > +++ b/tests/generic/620
> > @@ -42,7 +42,9 @@ sectors=$((2*1024*1024*1024*17))
> >  chunk_size=128
> >
> >  _dmhugedisk_init $sectors $chunk_size
> > -_mkfs_dev $DMHUGEDISK_DEV
> > +
> > +# Use 4k blocksize.
> > +_mkfs_dev_blocksized 4096 $DMHUGEDISK_DEV
>
> We run the test by forcing 4k blocksize, which could be tested in 4k
> blocksize setup. Maybe it's another case that should _notrun in 64k
> blocksize setup.

So for testing that, first I should mkfs and mount a scratch device with the
passed mount/mkfs options and then see if the blocksize passed is 64K, if yes
I should _notrun this case.

Isn't the current approach of (_mkfs_dev_blocksized 4096) is better then above
approach?

-ritesh

> Thanks,
> Eryu
>
> >  _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
> >  testfile=$SCRATCH_MNT/testfile-$seq
> >
> > --
> > 2.31.1
