Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5F4E5160
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Mar 2022 12:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiCWLjr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 07:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCWLjq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 07:39:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F82D1E4;
        Wed, 23 Mar 2022 04:38:16 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NAg8Y2029253;
        Wed, 23 Mar 2022 11:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jhwkhdUDcOq/euCdwH/0me6LYzlaCT5CWi62J2Vu2qU=;
 b=E44WqKkXNO8nQAam5HvYDlq1b7hn9nY0MSSnTTjj8vrFszu/A3776q4gxF4/YGZjsZjD
 RtdAdNVU+mV5ldxfuTPiQFHDBU/pa7TajekB6RwDeDlS81BQgGH84CQNm39S58KofQGX
 laPzN315FW+ssDgAdSBVoMC2//oJeeoZmCYD/T1jsV7z+sd9bBRQ0UIwDGOF+KYonh4j
 HCGdDR8t6ABXz4as4mrseN1USqsEw35H8HzJp2oMD75ROImdbahy+l70pEQDLroR48i0
 NebCNcHkGn4KavXWqpfYLcsKHL2waSfsHN0x9kO0nMtVMxYGqaFW6TnKzTWNym7AB0XC Sw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f021b90yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:38:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22NBH2si002461;
        Wed, 23 Mar 2022 11:33:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ew6t8q7e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:33:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22NBX5rf32440690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 11:33:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2CBAA4040;
        Wed, 23 Mar 2022 11:33:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225A2A4053;
        Wed, 23 Mar 2022 11:33:05 +0000 (GMT)
Received: from localhost (unknown [9.43.48.214])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Mar 2022 11:33:04 +0000 (GMT)
Date:   Wed, 23 Mar 2022 17:03:04 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ext4: Fix duplicate included linux/dax.h
Message-ID: <20220323113304.5nqa2fmvge7g5vms@riteshh-domain>
References: <1648007370-31984-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648007370-31984-1-git-send-email-baihaowen@meizu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2B-FPYOuBiY0F2bSUWAeznUoM7cDZ4YT
X-Proofpoint-GUID: 2B-FPYOuBiY0F2bSUWAeznUoM7cDZ4YT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_06,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=876
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203230066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/23 11:49AM, Haowen Bai wrote:
> Clean up the following includecheck warning:
>
> fs/ext4/inode.c: linux/dax.h is included more than once.

Checked "make includecheck"
This is the only warning coming from fs/ext4/

Thanks for fixing that. Looks good to me.
Feel free to add -

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>



>
> No functional change.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  fs/ext4/inode.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 01c9e4f..6738ea7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -41,7 +41,6 @@
>  #include <linux/bitops.h>
>  #include <linux/iomap.h>
>  #include <linux/iversion.h>
> -#include <linux/dax.h>
>
>  #include "ext4_jbd2.h"
>  #include "xattr.h"
> --
> 2.7.4
>
