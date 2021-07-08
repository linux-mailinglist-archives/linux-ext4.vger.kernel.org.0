Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0110D3BF58B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGHG1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 02:27:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11356 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhGHG1d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jul 2021 02:27:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1686Ivrq108660;
        Thu, 8 Jul 2021 02:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=e+dWm4Wk2XbuKXB792X95kY0g+zLKwKACIvnGTaAgaM=;
 b=Y4HnFV3V4ZuNHQW4rn3nm8FTIzJii0+TujF/VLs1FsFkeN3pB8432KkyCqxYy6cEdmT7
 Cq17WfLavKnf8+XsohYMN+B9O4TT+GhrXX9AyCsRCy6gms625WYT5zhfn+oc96y9MThM
 5rI7YAsfwwQk+vXftZ1QhL4UCcw+D+SwKRlKWtYbcKeXnq7muk3bpxxKqAvW2OmF76jV
 5Rar2YTvlIsBfx/XyqTaFeILApP+mhCr2mqEeGoGyyBYNI0y+ypj1XySgMsBKqURl89p
 hJf+AtxInzlduVdgB2aXeWSKXkkjCeWG0JU6RqDb+qYPRAJDVEb0i+OEF3Kd4V3HI/o8 HQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mc16r11y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 02:24:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1686Eq3V025058;
        Thu, 8 Jul 2021 06:24:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 39jfh8t1wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 06:24:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1686OklE31719918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 06:24:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5764911C069;
        Thu,  8 Jul 2021 06:24:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03FF611C052;
        Thu,  8 Jul 2021 06:24:46 +0000 (GMT)
Received: from localhost (unknown [9.77.197.191])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 06:24:45 +0000 (GMT)
Date:   Thu, 8 Jul 2021 11:54:45 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] ext4/003: Fix this test on 64K platform for dax
 config
Message-ID: <20210708062445.xnoij6ya7huedqcv@riteshh-domain>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <fda7d76b27234a46c3e7165fbdfc4154708c227d.1623651783.git.riteshh@linux.ibm.com>
 <YNybadzpnZZdwtzR@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNybadzpnZZdwtzR@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TseHRBqcgk5u01S-BrbKlYCdLF9vxhgK
X-Proofpoint-GUID: TseHRBqcgk5u01S-BrbKlYCdLF9vxhgK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_03:2021-07-06,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080033
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/06/30 12:27PM, Theodore Ts'o wrote:
> On Mon, Jun 14, 2021 at 11:58:05AM +0530, Ritesh Harjani wrote:
> > mkfs.ext4 by default uses 4K blocksize which doesn't mount when testing
> > with dax config and the test fails. This patch fixes it.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  tests/ext4/003 | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/ext4/003 b/tests/ext4/003
> > index 00ea9150..1ddb3063 100755
> > --- a/tests/ext4/003
> > +++ b/tests/ext4/003
> > @@ -31,7 +31,8 @@ _require_scratch_ext4_feature "bigalloc"
> >
> >  rm -f $seqres.full
> >
> > -$MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
> > +BLOCK_SIZE=$(get_page_size)
> > +$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
> >  	>> $seqres.full 2>&1
> >  _scratch_mount
>
> Thanks for the patch!

Thanks for the review, sorry about the delay (- Last week was short a week for
me).

>
> If the block size is 64k, then the cluster_size == block_size at which
> point ext4/003 won't be able to test for the regression its designed
> to test.  So we probably need to scale the cluster size and file
> system size relative to the block size.

Yes, thanks for catching it. I think if make below change, i.e. scale cluster
size, we should be good. Since this will make blocks_per_group = 4096 and
clusters_per_group = 256. This is the condition, which I guess the original
kernel patch fixed it for. So, we need not increase the filesystem size.

$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $((BLOCK_SIZE * 16))  -g 256 $SCRATCH_DEV 512m \

-ritesh






>
> 					- Ted
