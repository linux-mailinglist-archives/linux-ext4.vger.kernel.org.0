Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4C65637A
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Dec 2022 15:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLZOix (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Dec 2022 09:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLZOiq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Dec 2022 09:38:46 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7026C8;
        Mon, 26 Dec 2022 06:38:45 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQEU0nO028865;
        Mon, 26 Dec 2022 06:31:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=IshxhtlSnyCL5O8xZwcyOXGGGBA63RqRdErQaGSn5a4=;
 b=acvZznAkym3+fX7zskzF6uAXS08r9ootJry0bIMmoVRjDpJRowRs+FKzjM9NB+pwzGjt
 LK7jmt0MvfoyWwqOowoZZMQF1Hx62lMZMU7B9anc8Oxqg4VMcgVKaSk10pxV8xQyfswj
 +ozyWnoZVEJxydSvDUxiZaigAA3wppSjVwsS56FNq7Ccli/UZVVgW/yma9QbKKYSZCwl
 cXUA7gWlC63H/LiWS5C9iMKPzBt3jHhKzrxEW9Cos2+P7UX/E76OLMhfP0CAZ+05EPd4
 B54Jd3FSHN507ZBA1gOHxrkP0kUvzz2/XcUU9zetWrKMqRGaJCD55m+EkYEjgHk9PKlG zQ== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3mnwk8941v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Dec 2022 06:31:22 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 26 Dec 2022 06:31:24 -0800
Received: from pek-lpd-ccm4.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 26 Dec 2022 06:31:21 -0800
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <mail@anirudhrb.com>
CC:     <adilger.kernel@dilger.ca>, <akpm@osdl.org>, <alex@clusterfs.com>,
        <gregkh@linuxfoundation.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <shaggy@austin.ibm.com>,
        <syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com>,
        <tytso@mit.edu>
Subject: How can this fix prevent information from leaking to user space and prevent the kernel from crashing?
Date:   Mon, 26 Dec 2022 22:31:19 +0800
Message-ID: <20221226143119.3719096-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20210506185655.7118-1-mail@anirudhrb.com>
References: <20210506185655.7118-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SPQ9vl3mT4fnrN82mEfX-A8yj0IzfWGe
X-Proofpoint-ORIG-GUID: SPQ9vl3mT4fnrN82mEfX-A8yj0IzfWGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_11,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212260126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Anirudh Rayabharam

I verify this patch in the following environment, using reproducer: https://syzkaller.appspot.com/x/repro.c?x=122870ff800000

1. kernel version:  kernel version 5.15.72 
2. gcc 11.3
3. libc 2.35

Because the kernel version 5.15.72 already contains this patch ce3aba43599f0b50adbebff133df8d08a3d5fffe, 
So I deleted this patch to make a kernel image to reproduce the problem,
On the other hand, I reserve this patch to verify that the problem has been fixed,
The result of the experiment is that no matter whether this patch is applied or not, 
this problem cannot be reproduced in kernel version 5.15.72.

In addition, I am also very confused. There are three places to initialize "eh_generation". 
There is no other reference to the parameter "eh_generation" in all the source code of the kernel,
At the same time, there is no indirect operation on the parameter "eh_generation" in reproducer,
How can this fix prevent information from leaking to user space and prevent the kernel from crashing?

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 77c84d6f1af6..677d4821bcc1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -825,6 +825,7 @@ void ext4_ext_tree_init(handle_t *handle, struct inode *inode)
>  	eh->eh_entries = 0;
>  	eh->eh_magic = EXT4_EXT_MAGIC;
>  	eh->eh_max = cpu_to_le16(ext4_ext_space_root(inode, 0));
> +	eh->eh_generation = 0;
>  	ext4_mark_inode_dirty(handle, inode);
>  }
>  
> @@ -1090,6 +1091,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
>  	neh->eh_max = cpu_to_le16(ext4_ext_space_block(inode, 0));
>  	neh->eh_magic = EXT4_EXT_MAGIC;
>  	neh->eh_depth = 0;
> +	neh->eh_generation = 0;
>  
>  	/* move remainder of path[depth] to the new leaf */
>  	if (unlikely(path[depth].p_hdr->eh_entries !=
> @@ -1167,6 +1169,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
>  		neh->eh_magic = EXT4_EXT_MAGIC;
>  		neh->eh_max = cpu_to_le16(ext4_ext_space_block_idx(inode, 0));
>  		neh->eh_depth = cpu_to_le16(depth - i);
> +		neh->eh_generation = 0;
>  		fidx = EXT_FIRST_INDEX(neh);
>  		fidx->ei_block = border;
>  		ext4_idx_store_pblock(fidx, oldblock);
> -- 
> 2.26.2

