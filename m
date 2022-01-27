Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82549D9E0
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jan 2022 06:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiA0FNv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jan 2022 00:13:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235130AbiA0FNv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 Jan 2022 00:13:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R59SjM008893;
        Thu, 27 Jan 2022 05:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1/UxJrJzwCb+PoAiaPW5pQgvBrEH5fygufnzWdbeQww=;
 b=JIykwzVpMGXBOdAe/d8OtgmlXcRpFcmP4JeivKTS7m7vwGPTTdphxPXRGiSFfmk1pJ9V
 FkeVEMTQ6RRXJia1WEeo+CGLbV/KrT6oUFgd0CiIpg/DjbOro+cDpvtSrF1iUSQ/IKBm
 eyE64ExHvaJKuuGJYMMsX9//zNI3GE+0u/9er1n+kVfXOOdXQrff3BDDmd+sR8XhUuep
 OKs8ZKao0O/jZDZE83koU6alDDZZq70knhJr3MU4bVAkGXzMOtAeySZ7qbpuOo8pcd8x
 4FqN1kO1y438jVxwwekZ1pDu4nyNLpgryCdXoLxgl6kH7VKRS46xC17XswhngoPkokeX jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dumkurbsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 05:13:45 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20R5DdYn032122;
        Thu, 27 Jan 2022 05:13:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dumkurbs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 05:13:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20R58M4u023005;
        Thu, 27 Jan 2022 05:13:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3dr9j9sxwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 05:13:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20R5DdLn28377542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 05:13:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1CA111C058;
        Thu, 27 Jan 2022 05:13:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 302E311C064;
        Thu, 27 Jan 2022 05:13:39 +0000 (GMT)
Received: from localhost (unknown [9.43.59.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 05:13:38 +0000 (GMT)
Date:   Thu, 27 Jan 2022 10:43:37 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ext4: fix incorrect type issue during replay_del_range
Message-ID: <20220127051337.oc6ibems7mm6bhxp@riteshh-domain>
References: <20220126063146.2302-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126063146.2302-1-yinxin.x@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OWD-0bOb0wHVW8u55OX2s7Oev7CXas0Z
X-Proofpoint-ORIG-GUID: lSHeWMTH4OCw80k0rOnLIdeqL9jeHbY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_01,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=818 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270028
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/26 02:31PM, Xin Yin wrote:
> should not use fast commit log data directly, add le32_to_cpu().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 0b5b5a62b945 ("ext4: use ext4_ext_remove_space() for fast commit replay delete range")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Yes, a required change indeed.
Since the patch marked as fixes was cc'd to stable, so this might be requird as
well.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>  fs/ext4/fast_commit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index ccd2b216d6ba..488347b4c8b0 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1798,8 +1798,9 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>  	}
>
>  	down_write(&EXT4_I(inode)->i_data_sem);
> -	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
> -				lrange.fc_lblk + lrange.fc_len - 1);
> +	ret = ext4_ext_remove_space(inode, le32_to_cpu(lrange.fc_lblk),
> +				le32_to_cpu(lrange.fc_lblk) +
> +				le32_to_cpu(lrange.fc_len) - 1);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (ret) {
>  		iput(inode);
> --
> 2.25.1
>
