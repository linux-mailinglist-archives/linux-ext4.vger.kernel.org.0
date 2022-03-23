Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BE4E5156
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Mar 2022 12:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiCWLfj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 07:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiCWLfe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 07:35:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28457523A;
        Wed, 23 Mar 2022 04:34:04 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22N9g005008924;
        Wed, 23 Mar 2022 11:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dTXWgK5sxg+OV8Z4CHkXj0LY3ByBMtrgQTNq8SLCasw=;
 b=SFapMDuZgXt8Vqu1ROJ5T6elAQ27sBj39z3WgK2S79jomr1jdrgCoAhnqLNxGVDMDykX
 mCgs3ORrV1atfa2XwHCrempkhMGEbe+r7hVrd1MvpBCPOal2HMIr8L1YdbfDYHau9are
 +QSM3CHNJoKa8ERffaco3IYSvhNXCxoNYU13zaTzwUf4WtDvxMfS1aG0L0KuRJIcZcx9
 4zb+LRfM3C4v0eoLE9xg1LJbOfA2mDKrUpQ/q4Jb8itKNFFzO7KVAjuqxuWjwzxteIec
 k1CwWwRLDaZ5P1fSbvpCC+Xr3BhJSiMb07yWSNXJqgapIGGikr5cwVEhRtIdtdZCvCew DA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f014yj4j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:33:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22NBH4MM019266;
        Wed, 23 Mar 2022 11:33:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3ew6t8q822-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:33:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22NBXv4n45547856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 11:33:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E7504C046;
        Wed, 23 Mar 2022 11:33:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E7A4C040;
        Wed, 23 Mar 2022 11:33:52 +0000 (GMT)
Received: from localhost (unknown [9.43.48.214])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Mar 2022 11:33:52 +0000 (GMT)
Date:   Wed, 23 Mar 2022 17:03:51 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ext2: Fix duplicate included linux/dax.h
Message-ID: <20220323113351.sibsrr3qbpuegfm4@riteshh-domain>
References: <1648008123-32485-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648008123-32485-1-git-send-email-baihaowen@meizu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FkUFH6qZDgasMF7P6goF9oGYYcDK_hyI
X-Proofpoint-ORIG-GUID: FkUFH6qZDgasMF7P6goF9oGYYcDK_hyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_06,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=750 suspectscore=0
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

On 22/03/23 12:02PM, Haowen Bai wrote:
> Clean up the following includecheck warning:
>
> fs/ext2/inode.c: linux/dax.h is included more than once.
>


Checked "make includecheck"
This is the only warning coming from fs/ext2/

Thanks for the cleanup. Looks good to me.
Feel free to add -

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>



> No functional change.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  fs/ext2/inode.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 602578b..da4c301 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -36,7 +36,6 @@
>  #include <linux/iomap.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
> -#include <linux/dax.h>
>  #include "ext2.h"
>  #include "acl.h"
>  #include "xattr.h"
> --
> 2.7.4
>
