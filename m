Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C14D148E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbiCHKRi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbiCHKRg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:17:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0742EC8;
        Tue,  8 Mar 2022 02:16:39 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2289dNhQ032405;
        Tue, 8 Mar 2022 10:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=RsFA/k1GhLsgH0gA+uxs2PxF13w2tO4hI2UNmEaIDdA=;
 b=jrEnxwUxom9xeDwI3wh4yOQ4QvrDpC67IgT97F/T+03mCQhyP19UHhGjYYtZl3jjQ69U
 75aTvB37Vpytq9qTVtMEIv5EcbmKEvmHopmmJ7lTtfp0W2QD6ew7uaPBiDxQ79uXVqyd
 x0g6eaWlIMdY05RgdqKX5MISDgztYLBqfUM7igcOgckmmPSs3+A9HPRlPDTZisvuAMtt
 qJW52sJwISQ7pSXCO7tvp4iAImrF2h0a7Z693GBxqATAIcVKuk/jDDB9bg+OOXvuEWzZ
 kDd6H9sflCj/foLnCW5sje8NVoM7besQpjOhjb2zDMfBzQF8zOIZZThBjd7arnHsds8V Uw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enxryymdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:16:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228ADKxq005708;
        Tue, 8 Mar 2022 10:16:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3ekyg9641k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:16:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228AGXJb48365968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 10:16:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2071342047;
        Tue,  8 Mar 2022 10:16:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9B474203F;
        Tue,  8 Mar 2022 10:16:31 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.83.182])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Mar 2022 10:16:31 +0000 (GMT)
Date:   Tue, 8 Mar 2022 15:46:28 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: Re: [PATCH v2 0/2] tests/ext4: Ensure resizes with sparse_super2 are
 handled correctly
Message-ID: <Yics/N8zx8PgVhhr@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1645549521.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645549521.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IyfPMr3C8xEkvGZRfo2M-U0AWmsNmrSl
X-Proofpoint-ORIG-GUID: IyfPMr3C8xEkvGZRfo2M-U0AWmsNmrSl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=461 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Greetings,

Just a gentle reminder to kindly let me know if any changes are 
needed in this patchset.

Thank you,
Ojaswin

On Tue, Feb 22, 2022 at 11:20:51PM +0530, Ojaswin Mujoo wrote:
> As detailed in the patch [1], kernel currently does not support resizes
> with sparse_super2 enabled.  Before the above patch, if we used the
> EXT4_IOC_RESIZE_FS ioctl directly, wiht sparse_super2 enabled, the
> kernel used to still try the resize and ultimatley leave the fs in an
> inconsistent state. This also led to corruption and kernel BUGs.
> 
> This patchset adds a test for ext4 to ensure that the kernel handles
> resizes with sparse_super2 correctly, and returns -EOPNOTSUPP. 
> 
> Summary:
> 
>   Patch 1: Fix the src/ext4_resize.c script to return accurate error
>            codes.
>   Patch 2: Add the ext4 test for checking resize functionality
> 
> Changes since v1 [2]
> 
>   *  In patch 2, don't iterate if the expected errno is returned
>   *  Code cleanup and additional comments for clarity (also see extra
>      note in patch 2)
>   *  No changes in patch 1
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> [2] https://lore.kernel.org/fstests/cover.1644217569.git.ojaswin@linux.ibm.com/ 
> 
> Ojaswin Mujoo (2):
>   src/ext4_resize.c: Refactor code and ensure accurate errno is returned
>   ext4: Test to ensure resize with sparse_super2 is handled correctly
> 
>  src/ext4_resize.c  |  46 +++++++++++++------
>  tests/ext4/056     | 108 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  3 files changed, 142 insertions(+), 14 deletions(-)
>  create mode 100755 tests/ext4/056
>  create mode 100644 tests/ext4/056.out
> 
> -- 
> 2.27.0
> 
