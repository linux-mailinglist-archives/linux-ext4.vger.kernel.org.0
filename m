Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA169511F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjBMTzI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBMTzH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:55:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB81C7DF;
        Mon, 13 Feb 2023 11:55:07 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DINdVP021583;
        Mon, 13 Feb 2023 19:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ulLtmbNHAigUqXTTpYYke6cTZ9vdBlwYUqwfrLvZwZ4=;
 b=qFf4gaCM581cejP0lnFgRp3pttF1EH2fdU3qil1jhDpPTTCkidorOwPxOP6PkpyHRyiD
 CDlgfWKiohImSxQxN68lWwVOLibf1d1v8qxlt67NLD2Q/DHRr5phfxBHefbjda1eZeEC
 a4Q8pn5kn0nmmub+KGLQKsZnbx82Rer9pawN+aCiyFy7/ygD7h9zzV52Bc/l9A+XZ5ss
 kETTmOjSVTATigsrYuAVXlwEodlWztZKRjyDfRtE2A3Z24Cu0tSiCjioknLxSw56R11H
 Vw1ZQC55Jl19aq9T+zlfrJ3RrZrnCYF8DvJwaRJVMWtI+MxdRKlh+h39rMvGTfZe6UHr Xg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqtethxfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:54:59 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D7uPeC006567;
        Mon, 13 Feb 2023 19:54:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3np2n6a9kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:54:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJstu351118436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:54:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35F4220043;
        Mon, 13 Feb 2023 19:54:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D48B20040;
        Mon, 13 Feb 2023 19:54:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:54:53 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:24:50 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/21] ext4: remove unnecessary exit_meta_group_info tag
Message-ID: <Y+qVio3p82yuNb5d@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-17-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-17-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7JLeLkfT5KCikchkAIadJSI4vNl8ZnD9
X-Proofpoint-ORIG-GUID: 7JLeLkfT5KCikchkAIadJSI4vNl8ZnD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:20AM +0800, Kemeng Shi wrote:
> We goto exit_meta_group_info only to return -ENOMEM. Return -ENOMEM
> directly instead of goto to remove this unnecessary tag.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c684758d6dbb..289dcd81dd5a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3069,7 +3069,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
>  		if (meta_group_info == NULL) {
>  			ext4_msg(sb, KERN_ERR, "can't allocate mem "
>  				 "for a buddy group");
> -			goto exit_meta_group_info;
> +			return -ENOMEM;
>  		}
>  		rcu_read_lock();
>  		rcu_dereference(sbi->s_group_info)[idx] = meta_group_info;
> @@ -3123,7 +3123,6 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
>  		group_info[idx] = NULL;
>  		rcu_read_unlock();
>  	}
> -exit_meta_group_info:
>  	return -ENOMEM;
>  } /* ext4_mb_add_groupinfo */
>  
> -- 
> 2.30.0
> 
Looks good. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
