Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACF36ABBA
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Apr 2021 07:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhDZFGj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Apr 2021 01:06:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhDZFGi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Apr 2021 01:06:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13Q52WWq077692;
        Mon, 26 Apr 2021 01:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WLH5V13t+J++eN7nmEl8ThQX2/hBAhMy5xmoM6LjjbQ=;
 b=VDKbXMZyNUaikE3uPh6LJK+Vdl3AQ8Eq2Q1n6k7eHQotY9ZqiYmltMnXstCJ13ua2EwS
 /bGYEYexmh/bglR4AdjTiCroDuZlJf4LavmkTsOzo+HADiTGnyzJGyOHMRI2FJleJ/OW
 dwEMCEx0auvs4Ad2+DXVl00acafJK6vfZp39FeVgYP8tUlNL4trLIlL4i81FQr866UfW
 Jk7swIikIEwMLOXI7USq+I9rmPZK68/M8qrcmiBTDNtOHLhdKGIR5pjUa/iqbOsJ6yWx
 cQb4QUc4xH7lK/mjwHLTl9M1rlBwkkhBKir3yMkEcnhpYeSrpmFaPCHN1wCnIukqO31a 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385mc5judk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 01:05:55 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13Q53arc086065;
        Mon, 26 Apr 2021 01:05:55 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385mc5jud2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 01:05:54 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13Q53Lb3008874;
        Mon, 26 Apr 2021 05:05:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80akr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 05:05:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13Q55Q3Y32047368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 05:05:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EA725204F;
        Mon, 26 Apr 2021 05:05:50 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDCBF52051;
        Mon, 26 Apr 2021 05:05:46 +0000 (GMT)
Date:   Mon, 26 Apr 2021 10:35:45 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove redundant check buffer_uptodate()
Message-ID: <20210426050545.m3fbtlwdf32lgqvu@riteshh-domain>
References: <1619407399-72280-1-git-send-email-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619407399-72280-1-git-send-email-joseph.qi@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m6KK_TwKnhgczkZ_jZjjQWdDrzk0OGTW
X-Proofpoint-GUID: wqJlAY8RZraWxOqVgvhEHQQal-ljq2oe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_11:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104260035
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/04/26 11:23AM, Joseph Qi wrote:
> Now set_buffer_uptodate() will test first and then set, so we don't have
> to check buffer_uptodate() first, remove it to simplify code.

Maybe we can change below function as well then.
No need to check same thing twice since set_buffer_uptodate() is already doing
the check.
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b258e8279266..856bd9981409 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3749,7 +3749,7 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
         * have to read the block because we may read the old data
         * successfully.
         */
-       if (!buffer_uptodate(bh) && buffer_write_io_error(bh))
+       if (buffer_write_io_error(bh))
                set_buffer_uptodate(bh);
        return buffer_uptodate(bh);
 }

With that pls feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ext4/inode.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0948a43..9e02538 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1065,10 +1065,8 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
>  	    block++, block_start = block_end, bh = bh->b_this_page) {
>  		block_end = block_start + blocksize;
>  		if (block_end <= from || block_start >= to) {
> -			if (PageUptodate(page)) {
> -				if (!buffer_uptodate(bh))
> -					set_buffer_uptodate(bh);
> -			}
> +			if (PageUptodate(page))
> +				set_buffer_uptodate(bh);
>  			continue;
>  		}
>  		if (buffer_new(bh))
> @@ -1092,8 +1090,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
>  			}
>  		}
>  		if (PageUptodate(page)) {
> -			if (!buffer_uptodate(bh))
> -				set_buffer_uptodate(bh);
> +			set_buffer_uptodate(bh);
>  			continue;
>  		}
>  		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
> --
> 1.8.3.1
>
