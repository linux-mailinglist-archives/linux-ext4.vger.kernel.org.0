Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B764F086C
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Apr 2022 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355545AbiDCIVt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Apr 2022 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiDCIVt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Apr 2022 04:21:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913329CA1;
        Sun,  3 Apr 2022 01:19:56 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2337dVhh022873;
        Sun, 3 Apr 2022 08:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=n8Q7DA80igswd9mKAp6vBJFB4q5UOuHLBoqeTfO1Ctk=;
 b=gDyF5rQ2ib8eNg8fH9ZoGZuEfkquZb3vVu2VuQv99Dg/JPJNoNTSyjAjd/ZOiiiZW3PM
 4yhjKbGmGAXznBJOm9N2p2F63c7ZYOZI44/buCKFesySB6rdrYXW/vEM49b7jBHpNj6a
 cd1QzX8lGPtJaMiFp4ED1b44WgqUUM0Yx93UCrhtAXgYizrOM0fdOX12gHFulbHHXmD3
 hbB7wtUhBA6eqzHi83LJJilT1MTWGsS+cShQliWoVJ+D9/7pfXowg+rR37leKfjMWZJC
 +9D0n6leGi+AfQmrC+KpiT/TWwhzhGCVL7CaY2CxDl4avCmCkB+pQfcLEc2nHnyWYuD2 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f6yycwsha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 08:19:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2338FKq6022242;
        Sun, 3 Apr 2022 08:19:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f6yycwsgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 08:19:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2338Iu8Y032137;
        Sun, 3 Apr 2022 08:19:53 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhhpem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 08:19:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2338Joar34603374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Apr 2022 08:19:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BD65A4053;
        Sun,  3 Apr 2022 08:19:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46C4CA404D;
        Sun,  3 Apr 2022 08:19:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.26.20])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  3 Apr 2022 08:19:47 +0000 (GMT)
Date:   Sun, 3 Apr 2022 13:49:35 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <YklYl/Nea05Mjz32@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220401055713.634842-1-ojaswin@linux.ibm.com>
 <20220401095436.oxdq2duhuudx2c4r@riteshh-domain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401095436.oxdq2duhuudx2c4r@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d_z1ElZTzukMh5DY99dB0AqSXB1ZUb8z
X-Proofpoint-GUID: 26IUSAXUqtZrLwa6Lo3HzGuf0ucLKEOb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-02_13,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=993 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204030051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 01, 2022 at 03:24:36PM +0530, Ritesh Harjani wrote:
> On 22/04/01 11:27AM, Ojaswin Mujoo wrote:
> > A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> > have a discard granularity as big as 42MB which makes it larger
> > than the group size of ext4 FS with 1k BS. This causes the FITRIM
> > IOCTL to fail on filesystems like ext4.
> >
> > This case was not correctly handle by "_require_batched_discard" as
> > it incorrectly interpreted the FITRIM failure as fs not supporting
> > the IOCTL. This caused the tests like generic/260 to incorectly
> > report "not run" instead of "failed" in case of large discard
> > granularity.
> 
> Ok, I looked at fstrim code and it does print [1]
> "the discard operation is not supported" in case of rc == 1.
> And if rc != 0 it will always returns EXIT_FAILURE.
> 
> So this patch looks good to me. Feel free to add:
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thank you for the review Ritesh.
> 
> 
> Although it will be good to check if we can add a generic test case
> using maybe lvm or dm device, where this device could report large
> discard_granularity for actually excercising this code path
> (rather then changing kernel code to test it).
You are correct, as I was not able to simulate a device with disc gran
of 40MB+ I tested this by hard coding the granularity in the kernel. 

That being said, I would appreciate if anyone has any insights on using 
LVM/DM to get that high a granularity so I can test it more accurately.

Regards,
Ojaswin
> 
> -ritesh
> 
> [1]: https://github.com/util-linux/util-linux/blob/master/sys-utils/fstrim.c
> 
> >
> > Fix "_require_batched_discard" to use a more accurate method
> > to determine if discard is supported.
> >
> > [1] commit 173b6e383d2
> >     ext4: avoid trim error on fs with small groups
> >
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/rc | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
