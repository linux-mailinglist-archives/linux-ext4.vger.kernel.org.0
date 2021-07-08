Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181623BF7CA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhGHJwG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 05:52:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230079AbhGHJwG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jul 2021 05:52:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1689XZmL149667;
        Thu, 8 Jul 2021 05:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=63Qlcat97rQGdaFlIxY4KXHq2i4mqZfosVjh2joBd8I=;
 b=R85yB30BJGRkEJTtMgQyLp3xGLWk1MrYF7nm2j32ou98OzMUzGyXFm3KN0dLhj/nN+Wj
 8RLkhkEdFla6LyNRNQcsWwS9wMF1QhBqnKZ4Rx8/43aQR5rnFk1muGj1HmUNGrjAM0bG
 BKQdXU0XWdUPM6ooa8XxZzcox9arm4WgtgJyA8060/FQFq3aVfg9mO1OMcoWJAxXfQLc
 iQq8fPuL5xtT+7Bpfj/r4cKI/OZoJ1UwDdCxh71anOKlTT4F4nRnGUYWfDxfHnEdn71x
 q/WV92jONjD9FJ4B3vfbvSjZeaTJllhzkoU0nwyOpgk26sFXRsvUr8qzhW8nTlzksyHS 9A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n28kd0vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 05:49:22 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1689gZZl023175;
        Thu, 8 Jul 2021 09:49:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8t4mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 09:49:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1689nHcw36307370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 09:49:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94D8442057;
        Thu,  8 Jul 2021 09:49:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 443504204B;
        Thu,  8 Jul 2021 09:49:17 +0000 (GMT)
Received: from localhost (unknown [9.77.197.191])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 09:49:17 +0000 (GMT)
Date:   Thu, 8 Jul 2021 15:19:16 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/9] generic/031: Fix the test case for 64k blocksize
 config
Message-ID: <20210708094916.gozxectacww6yrpr@riteshh-domain>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <efd1594eeec7b893c47865ce5a94c25dc94dac28.1623651783.git.riteshh@linux.ibm.com>
 <20210630155001.GA13743@locust>
 <YNyncumuIpVw/T1E@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyncumuIpVw/T1E@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ar3-0Jz5mjvxuroFXPrWhSS2Q88JzoWN
X-Proofpoint-ORIG-GUID: ar3-0Jz5mjvxuroFXPrWhSS2Q88JzoWN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_04:2021-07-06,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107080052
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/06/30 01:18PM, Theodore Ts'o wrote:
> On Wed, Jun 30, 2021 at 08:50:01AM -0700, Darrick J. Wong wrote:
> > > +# fcollapse need offset and len to be multiple of blocksize for filesystems
> > > +# hence make this test work with 64k blocksize as well.
> > ...
> >
> > What if the blocksize is 32k?
>
> ... or 8k?  or 16k?  (which might be more likely)
>
> How bout if we change the offsets and lengths in the test so they are
> all multiples of 64k, and adjusting 31.out appropriately?  That will
> allow the test to work for block sizes up to 64k without needing to
> having a special case for 031.out.64k.
>
> I don't know of architectures with a page size > 64k (yet), so this
> should hold us for a while.
>

yes, so I already had done the changes in such a way that we can adapt to any
blocksize.  I will make the changes such that we take fact=65536/4096 by
default. Then this should cover all the cases for all blocksizes and we don't
have to change 031.out file for different blocksizes.

And the test tries to test non-aligned writes, but since I am adding some
additional unaligned bytes and also I have kept the layout of the writes same
as before, so I think the test should still cover the regression it is meant
for.


fact=65536/4096
    $XFS_IO_PROG -f \
        -c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \
        -c "fcollapse $((28672 * fact)) $((40960 * fact))" \
        -c "pwrite $((133228 * fact + 12)) $((63394 * fact + 12))" \
        -c "fcollapse 0 $((4096 * fact))" \
    $testfile | _filter_xfs_io

-ritesh
