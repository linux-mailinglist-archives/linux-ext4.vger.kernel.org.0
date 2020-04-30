Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF571C08B7
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD3VE0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 17:04:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgD3VE0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 17:04:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UL4E5D011668;
        Thu, 30 Apr 2020 17:04:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cm1esa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 17:04:22 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UL4JJ0011898;
        Thu, 30 Apr 2020 17:04:21 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cm1ehc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 17:04:21 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UL0xqA002185;
        Thu, 30 Apr 2020 21:02:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu52yna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 21:02:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UL2BoR34275642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 21:02:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA465AE057;
        Thu, 30 Apr 2020 21:02:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A2A0AE04D;
        Thu, 30 Apr 2020 21:02:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 21:02:10 +0000 (GMT)
Subject: Re: [PATCH 1/4] ext4: remove dead GET_BLOCKS_ZERO code
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200430185320.23001-1-enwlinux@gmail.com>
 <20200430185320.23001-2-enwlinux@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 1 May 2020 02:32:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200430185320.23001-2-enwlinux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200430210211.2A2A0AE04D@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_12:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300152
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 5/1/20 12:23 AM, Eric Whitney wrote:
> There's no call to ext4_map_blocks() in the current ext4 code with a
> flags argument that combines EXT4_GET_BLOCKS_CONVERT and
> EXT4_GET_BLOCKS_ZERO.  Remove the code that corresponds to this case
> from ext4_ext_handle_unwritten_extents().
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

As I see it. Yes, this flag was mainly added for DAX handling at two 
places but mostly with below purpose.

Purpose:- Since DAX earlier using PRE_IO flag and then to convert
unwritten to written, it added this extra functionality to zero out.
Since ext4_map_blocks already implements the unwritten to written
functionality, so PRE_IO along with below combination of flags was
removed from DAX path.

Now none of that DAX code path uses below code anyways. So your patch
justifies killing below code snip.


Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/extents.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b315a0..59a90492b9dd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3826,14 +3826,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>   	}
>   	/* IO end_io complete, convert the filled extent to written */
>   	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> -		if (flags & EXT4_GET_BLOCKS_ZERO) {
> -			if (allocated > map->m_len)
> -				allocated = map->m_len;
> -			err = ext4_issue_zeroout(inode, map->m_lblk, newblock,
> -						 allocated);
> -			if (err < 0)
> -				goto out2;
> -		}
>   		ret = ext4_convert_unwritten_extents_endio(handle, inode, map,
>   							   ppath);
>   		if (ret >= 0)
> 
