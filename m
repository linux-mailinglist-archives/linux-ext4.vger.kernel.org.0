Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5554BB731
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 11:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiBRKq4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 05:46:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiBRKqz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 05:46:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4513F77;
        Fri, 18 Feb 2022 02:46:39 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAH6kA011920;
        Fri, 18 Feb 2022 10:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=3QfnBNbtvsfT/us+WXyaCCapfpJQssFblYdRiMLuHIg=;
 b=ihqVEVsTR9wyULIitza+4g9YyomRkRgxOa7WFHC5ny7sqBwZGxwBXZ0qZFD+Z5Qube4H
 ZHld0NIXZHV7wp9/G3J1BfKplKIxyyIQ8XwigTcL+7aAkP+vY7T+1MsF1R6aaLbIPGHw
 nXz2mN61O25pzNX3wEiJI+uYEebAH1011kWqyCQxSy1ACqeFSJn14RgdsEH++2YZZohY
 ic7SG7/IUzN8LsysRc+O22b4K5Nfo7IPlG7ABTbFBmy0CyqgR29ZdJPiEBVxbI+4Yyz8
 ZUsYF7/0qVUp1nub7+fBrWjuPRhmMwcAH6fSGBzpSgSRhnFOsJSoG28T8NlBvPzTn7gD lg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ea9jqgj9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 10:46:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IAbwvU011111;
        Fri, 18 Feb 2022 10:46:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645khdt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 10:46:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IAkXMK43581848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 10:46:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 915C95207A;
        Fri, 18 Feb 2022 10:46:33 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.119.232])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4B7D052077;
        Fri, 18 Feb 2022 10:46:32 +0000 (GMT)
Date:   Fri, 18 Feb 2022 16:16:22 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: Re: [PATCH 0/2] tests/ext4: Ensure resizes with sparse_super2 are
 handled correctly
Message-ID: <Yg94/kUaJ05/7JwL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1644217569.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644217569.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C80NW8ApAbLBP_VWXSprgYGVvf0YkYvI
X-Proofpoint-ORIG-GUID: C80NW8ApAbLBP_VWXSprgYGVvf0YkYvI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_04,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=727 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Just wanted to send a gentle reminder to look into this patchset and let
me know if anyone has any suggestions or review comments. 

Thank you for your time,
Ojaswin

On Mon, Feb 07, 2022 at 01:55:32PM +0530, Ojaswin Mujoo wrote:
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
> Patch 1: Fix the src/ext4_resize.c script to return accurate error codes.
> Patch 2: Add the ext4 test for checking resize functionality
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1489186cc8391e0c1e342f9fbc3eedf6b944c61
> 
> Ojaswin Mujoo (2):
>   src/ext4_resize.c: Refactor code and ensure accurate errno is returned
>   ext4: Test to ensure resize with sparse_super2 is handled correctly
> 
>  src/ext4_resize.c  |  46 +++++++++++++-------
>  tests/ext4/056     | 102 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/056.out |   2 +
>  3 files changed, 136 insertions(+), 14 deletions(-)
>  create mode 100755 tests/ext4/056
>  create mode 100644 tests/ext4/056.out
> 
> -- 
> 2.27.0
> 
