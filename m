Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3836162022
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 06:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgBRFSX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 00:18:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbgBRFSW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Feb 2020 00:18:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I5Duqh111398
        for <linux-ext4@vger.kernel.org>; Tue, 18 Feb 2020 00:18:22 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cu2hx15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 18 Feb 2020 00:18:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 18 Feb 2020 05:18:19 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 05:18:16 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01I5IF6N14745616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 05:18:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D861352050;
        Tue, 18 Feb 2020 05:18:15 +0000 (GMT)
Received: from [9.199.158.131] (unknown [9.199.158.131])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 854505204E;
        Tue, 18 Feb 2020 05:18:14 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] jbd2: do not clear the BH_Mapped flag when
 forgetting a metadata buffer
To:     "zhangyi (F)" <yi.zhang@huawei.com>, jack@suse.cz, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, luoshijie1@huawei.com,
        zhangxiaoxu5@huawei.com
References: <20200213063821.30455-1-yi.zhang@huawei.com>
 <20200213063821.30455-3-yi.zhang@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 18 Feb 2020 10:48:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200213063821.30455-3-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021805-0028-0000-0000-000003DBF9A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021805-0029-0000-0000-000024A1015B
Message-Id: <20200218051814.854505204E@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_14:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002180042
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2/13/20 12:08 PM, zhangyi (F) wrote:
> Commit 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from
> an older transaction") set the BH_Freed flag when forgetting a metadata
> buffer which belongs to the committing transaction, it indicate the
> committing process clear dirty bits when it is done with the buffer. But
> it also clear the BH_Mapped flag at the same time, which may trigger
> below NULL pointer oops when block_size < PAGE_SIZE.
> 
> rmdir 1             kjournald2                 mkdir 2
>                      jbd2_journal_commit_transaction
> 		    commit transaction N
> jbd2_journal_forget
> set_buffer_freed(bh1)
>                      jbd2_journal_commit_transaction
>                       commit transaction N+1
>                       ...
>                       clear_buffer_mapped(bh1)
>                                                 ext4_getblk(bh2 ummapped)
>                                                 ...
>                                                 grow_dev_page
>                                                  init_page_buffers
>                                                   bh1->b_private=NULL
>                                                   bh2->b_private=NULL
>                       jbd2_journal_put_journal_head(jh1)
>                        __journal_remove_journal_head(hb1)
> 		       jh1 is NULL and trigger oops
> 
> *) Dir entry block bh1 and bh2 belongs to one page, and the bh2 has
>     already been unmapped.
> 
> For the metadata buffer we forgetting, we should always keep the mapped
> flag and clear the dirty flags is enough, so this patch pick out the
> these buffers and keep their BH_Mapped flag.
> 
> Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

This should be a stable candidate I guess.

-ritesh

> ---
>   fs/jbd2/commit.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 6396fe70085b..27373f5792a4 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -985,12 +985,29 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   		 * pagesize and it is attached to the last partial page.
>   		 */
>   		if (buffer_freed(bh) && !jh->b_next_transaction) {
> +			struct address_space *mapping;
> +
>   			clear_buffer_freed(bh);
>   			clear_buffer_jbddirty(bh);
> -			clear_buffer_mapped(bh);
> -			clear_buffer_new(bh);
> -			clear_buffer_req(bh);
> -			bh->b_bdev = NULL;
> +
> +			/*
> +			 * Block device buffers need to stay mapped all the
> +			 * time, so it is enough to clear buffer_jbddirty and
> +			 * buffer_freed bits. For the file mapping buffers (i.e.
> +			 * journalled data) we need to unmap buffer and clear
> +			 * more bits. We also need to be careful about the check
> +			 * because the data page mapping can get cleared under
> +			 * out hands, which alse need not to clear more bits
> +			 * because the page and buffers will be freed and can
> +			 * never be reused once we are done with them.
> +			 */
> +			mapping = READ_ONCE(bh->b_page->mapping);
> +			if (mapping && !sb_is_blkdev_sb(mapping->host->i_sb)) {
> +				clear_buffer_mapped(bh);
> +				clear_buffer_new(bh);
> +				clear_buffer_req(bh);
> +				bh->b_bdev = NULL;
> +			}
>   		}
> 
>   		if (buffer_jbddirty(bh)) {
> 

