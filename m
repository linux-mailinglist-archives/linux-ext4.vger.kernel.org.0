Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC53BF7E1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhGHKEQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 06:04:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230079AbhGHKEQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jul 2021 06:04:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1689XaQW015920;
        Thu, 8 Jul 2021 06:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=D8k0wQmypBGrY2ui6/ImzN5ArMk87kifFOS5XABI/nI=;
 b=dJTAJ9d1QcQ1Zy1Me5N3/oTouq69v3ooNg0XuJe5DJOi34K+205zUZO52f2ROItUy9ad
 sJJ9iO5/b409IimmfrOBMWI2CbeEh9A6VjHURencXeS6X/w4bXa0Wh+5u9cJTWKkK01Z
 J2gMpcIsSlxq1zENzJ7aFUKvYpk21fXJgWyIYxSG6mxQom4UPxwXF1p7vnXne4iyponE
 gtMvLMyIwxYTvGYUWnLxs3O4FQPqIurU0I5W2zMYgUZvSs1pd6j7SYo3jfpwPoXRKyJb
 LiV9Gxg6FUUiGsvfx44AOdOU1UyELHlVrZOmphvMv0B1RZeyiCSfsJm2w14AQ+nu8vdW ug== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nhcav7c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 06:01:32 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1689sFMw007351;
        Thu, 8 Jul 2021 10:01:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 39jfh8h51t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 10:01:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168A1RFE29294986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 10:01:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A8FFA4051;
        Thu,  8 Jul 2021 10:01:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B8CA4040;
        Thu,  8 Jul 2021 10:01:27 +0000 (GMT)
Received: from localhost (unknown [9.77.197.191])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 10:01:27 +0000 (GMT)
Date:   Thu, 8 Jul 2021 15:31:26 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/9] generic/620: Remove -b blocksize option for ext4
Message-ID: <20210708100126.hpocb3ukarnzzdbh@riteshh-domain>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <8b3d5afe83ee6d1d35f57914a9b0cfa4b5bb4361.1623651783.git.riteshh@linux.ibm.com>
 <YNyku9CJ3YImhkMA@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyku9CJ3YImhkMA@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tAmfP4tHTdyQ4etP_4xhw3Ij8VCbrS9z
X-Proofpoint-GUID: tAmfP4tHTdyQ4etP_4xhw3Ij8VCbrS9z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_04:2021-07-06,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080052
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/06/30 01:07PM, Theodore Ts'o wrote:
> On Mon, Jun 14, 2021 at 11:58:11AM +0530, Ritesh Harjani wrote:
> > ext4 with 64k blocksize fails with below error for this given test which
> > requires dmhugedisk. Also since dax is not supported for this test, so
> > make sure to remove -b option, if set by config file for ext4 FSTYP for
> > the test to then use 4K blocksize by default.
> >
> > mkfs.ext4: Input/output error while writing out and closing file system
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Looking at this test, I'm not convinced it actually does the right
> thing when the block size is 64k, since the whole point is to test
> what happens when the block number > INT_MAX.  So we should be able to
> fix the block size to be 1k, which would allow us to use a smaller
> dmhugedisk, and then skip this test if dax is enabled.
>
> OTOH, generic/620 runs pretty quicky, so perhaps it's better to do
> thie quick fix: hardcode the block size to 4k, and then skip it if dax
> && page_size != 4k.

Ok, so it is time to implement _mkfs_dev_blocksized() something like how we have
for _scratch_mkfs_blocksized(). This is since we can have different way of
passing blocksize parameter for mkfs prog for different filesystems.

-ritesh
