Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4095B45D4
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Sep 2022 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIJJzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Sep 2022 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIJJzv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 10 Sep 2022 05:55:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5AA4F67C;
        Sat, 10 Sep 2022 02:55:41 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28A6fhtn010684;
        Sat, 10 Sep 2022 09:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AekO7LXMiPMPHj0e9wm7kfhcKGcZ34ewjOjwBfQ7ZaU=;
 b=VvtRt/MowH6cY3yl1C+WzqIbxHLK86v4PfE75Wn73eBs2fA4dM4OLfb+aTgbv9+/eISq
 wdys9lV4o3RNJ72ruqpY006FN6g0Ih/hublRdF2JT67VpGCK2RxGjwFqn00At3H/fZBz
 H9kwCwGjQKs0CUUk3rrJQtYdK/rjvAmiP31yV0bqoreAFnMFjkrYEabb1orvlJ6Nhfkm
 tos70He0HgfpJeQWCP9q1CwTFZWRrsE8RX/iykyXpgDJrE7AOyKlbckkpifRe3pGck++
 LAZ3rbXUqnwMWMnGgPeAVdloVjLb3iMYROlndPzxKJLYUuGLiaL2eIytIDMGqXts+cp3 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jgkt9d75u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 09:55:39 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28A9qtjj029962;
        Sat, 10 Sep 2022 09:55:38 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jgkt9d75e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 09:55:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28A9oLTp015821;
        Sat, 10 Sep 2022 09:55:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3jghuj89ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 09:55:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28A9tYdU24772888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 09:55:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91D934C044;
        Sat, 10 Sep 2022 09:55:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A27F74C040;
        Sat, 10 Sep 2022 09:55:32 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.2.106])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Sep 2022 09:55:32 +0000 (GMT)
Date:   Sat, 10 Sep 2022 15:25:29 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, tytso@mit.edu
Subject: Re: [PATCH v1] fs/ext4/xattr: check the return value of
 ext4_xattr_inode_dec_ref()
Message-ID: <Yxxe/X14BiltT352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220909044727.2622256-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909044727.2622256-1-floridsleeves@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cpa2Xstm04l5aXD2HFpm79tEqViHX8uF
X-Proofpoint-ORIG-GUID: v5apK_AP8UWGTSS0YJNXml7_HDIzUaBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=624 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209100036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 08, 2022 at 09:47:27PM -0700, Li Zhong wrote:
> Check the return value of ext4_xattr_inode_dec_ref(), which could return
> error code and need to be warned.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  fs/ext4/xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 533216e80fa2..76141ed12bc2 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1540,7 +1540,9 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
>  
>  	err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
>  	if (err) {
> -		ext4_xattr_inode_dec_ref(handle, ea_inode);
> +		err = ext4_xattr_inode_dec_ref(handle, ea_inode);
Hey Li,

My only concern here is in case ext4_xattr_inode_dec_ref() fails, we
overwrite the err value and the actual err from ext4_xattr_inode_write() 
is lost.

I feel the ext4_xattr_inode_write() error code would be more valuable
for the calling function hence that is the one we should propogate.  
Maybe we can just print the warning without overwriting err? 

Regards,
Ojaswin
> +		if (err)
> +			ext4_warning_inode(ea_inode, "cleanup dec ref error %d", err);
>  		iput(ea_inode);
>  		return err;
>  	}
> -- 
> 2.25.1
> 
