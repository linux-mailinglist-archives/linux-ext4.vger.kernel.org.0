Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449AA1A6236
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Apr 2020 06:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgDMEiV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Apr 2020 00:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgDMEiV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Apr 2020 00:38:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F61C0A3BE0
        for <linux-ext4@vger.kernel.org>; Sun, 12 Apr 2020 21:38:21 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D4YVTf135606
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 00:38:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30b81s35su-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 00:38:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 13 Apr 2020 05:38:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Apr 2020 05:37:58 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03D4cEof63045708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 04:38:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63B144C040;
        Mon, 13 Apr 2020 04:38:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FA0F4C058;
        Mon, 13 Apr 2020 04:38:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.22])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Apr 2020 04:38:13 +0000 (GMT)
Subject: Re: [PATCH] ext4: remove unnecessary test_opt for DIOREAD_NOLOCK
To:     xiakaixu1987@gmail.com, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1586751862-19437-1-git-send-email-kaixuxia@tencent.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 13 Apr 2020 10:08:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1586751862-19437-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20041304-0012-0000-0000-000003A37AF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041304-0013-0000-0000-000021E0AC90
Message-Id: <20200413043813.4FA0F4C058@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_01:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=918
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130035
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/13/20 9:54 AM, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The DIOREAD_NOLOCK flag has been cleared when doing the test_opt
> that is meaningless, so remove the unnecessary test_opt for DIOREAD_NOLOCK.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Make sense.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/super.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9728e7b0e84f..855874ea4b29 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3973,17 +3973,13 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> 
>   	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
>   		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!\n");
> +		/* can't mount with both data=journal and dioread_nolock. */
>   		clear_opt(sb, DIOREAD_NOLOCK);
>   		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
>   			ext4_msg(sb, KERN_ERR, "can't mount with "
>   				 "both data=journal and delalloc");
>   			goto failed_mount;
>   		}
> -		if (test_opt(sb, DIOREAD_NOLOCK)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "both data=journal and dioread_nolock");
> -			goto failed_mount;
> -		}
>   		if (test_opt(sb, DAX)) {
>   			ext4_msg(sb, KERN_ERR, "can't mount with "
>   				 "both data=journal and dax");
> 

