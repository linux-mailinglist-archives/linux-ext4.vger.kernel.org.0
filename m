Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA9288DCB
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 18:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbgJIQKQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 12:10:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389144AbgJIQKQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 12:10:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099G3GXO030247;
        Fri, 9 Oct 2020 12:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qMHNv6HR4SHX5wJ34lw9eB0wI+Xh2WxPfrYpxAfDzZs=;
 b=BxoSHQ02NRMJ89MXt7Sa9Qr7vMmh5DHtXZGicb2XMFgyIY6smp0ySbTEbAwCp83e9L41
 lhdlTiw+ssZD35DD01QlF/PW5jIUUlbNug3kmg7sci/W7jQIErjUyXOQy9T//iDt+nhh
 yAW4buvqFsoDVP8VCN1aKyb25QQjPAyiVSpzXHbiCYocCJVE71GEfhDJGmUko2e0K5QL
 W0ZtJnsEt8uv4+qdDCUNHK5+h9Lr7K8iXi7W8amgLL7thLzOYNotA0iqV4Cjkc38j+3S
 F0fSmtZN7r6QANZKM1HKP1X2po44YzYZ/mTMYUpV9alfwFJ7jDoUtpzYRAKs5q2s0DhT zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342s61mx4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 12:10:12 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099G3lHq037663;
        Fri, 9 Oct 2020 12:10:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342s61mx25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 12:10:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099G7xI0022593;
        Fri, 9 Oct 2020 16:10:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3429hugt5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 16:10:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099GA6Wf20382012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 16:10:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADEC14204B;
        Fri,  9 Oct 2020 16:10:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB914203F;
        Fri,  9 Oct 2020 16:10:05 +0000 (GMT)
Received: from [9.199.46.138] (unknown [9.199.46.138])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 16:10:05 +0000 (GMT)
Subject: Re: [PATCH v9 3/9] ext4 / jbd2: add fast commit initialization
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-4-harshadshirwadkar@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <10591a3f-6dad-4e3d-f3f1-f10981cb4fe8@linux.ibm.com>
Date:   Fri, 9 Oct 2020 21:40:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919005451.3899779-4-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_08:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=2 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090120
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Sorry about the delay. Few comments below.

On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> This patch adds fast commit area trackers in the journal_t
> structure. These are initialized via the jbd2_fc_init() routine that
> this patch adds. This patch also adds ext4/fast_commit.c and
> ext4/fast_commit.h files for fast commit code that will be added in
> subsequent patches in this series.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>   fs/ext4/Makefile      |  2 +-
>   fs/ext4/ext4.h        |  4 ++++
>   fs/ext4/fast_commit.c | 20 +++++++++++++++++
>   fs/ext4/fast_commit.h |  9 ++++++++
>   fs/ext4/super.c       |  1 +
>   fs/jbd2/journal.c     | 52 ++++++++++++++++++++++++++++++++++++++-----
>   include/linux/jbd2.h  | 39 ++++++++++++++++++++++++++++++++
>   7 files changed, 121 insertions(+), 6 deletions(-)
>   create mode 100644 fs/ext4/fast_commit.c
>   create mode 100644 fs/ext4/fast_commit.h
> 
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index 2e42f47a7f98..49e7af6cc93f 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -10,7 +10,7 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
>   		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
>   		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
>   		super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
> -		xattr_user.o
> +		xattr_user.o fast_commit.o
> 
>   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
>   ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 82e889d5c2ed..9af3971dd12e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -964,6 +964,7 @@ do {									       \
>   #endif /* defined(__KERNEL__) || defined(__linux__) */
> 
>   #include "extents_status.h"
> +#include "fast_commit.h"
> 
>   /*
>    * Lock subclasses for i_data_sem in the ext4_inode_info structure.
> @@ -2679,6 +2680,9 @@ extern int ext4_init_inode_table(struct super_block *sb,
>   				 ext4_group_t group, int barrier);
>   extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
> 
> +/* fast_commit.c */
> +
> +void ext4_fc_init(struct super_block *sb, journal_t *journal);
>   /* mballoc.c */
>   extern const struct seq_operations ext4_mb_seq_groups_ops;
>   extern long ext4_mb_stats;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> new file mode 100644
> index 000000000000..0dad8bdb1253
> --- /dev/null
> +++ b/fs/ext4/fast_commit.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * fs/ext4/fast_commit.c
> + *
> + * Written by Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> + *
> + * Ext4 fast commits routines.
> + */
> +#include "ext4_jbd2.h"
> +
> +void ext4_fc_init(struct super_block *sb, journal_t *journal)
> +{
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> +		return;
> +	if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
> +		pr_warn("Error while enabling fast commits, turning off.");
> +		ext4_clear_feature_fast_commit(sb);
> +	}
> +}
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> new file mode 100644
> index 000000000000..8362bf5e6e00
> --- /dev/null
> +++ b/fs/ext4/fast_commit.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __FAST_COMMIT_H__
> +#define __FAST_COMMIT_H__
> +
> +/* Number of blocks in journal area to allocate for fast commits */
> +#define EXT4_NUM_FC_BLKS		256

Just wanted to understand how is this value determined?
Do you think this needs to be configurable?
Just thinking since, on some platforms blksz could be of 64K.

> +
> +#endif /* __FAST_COMMIT_H__ */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b62858ee420b..94aaaf940449 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4962,6 +4962,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
>   	journal->j_commit_interval = sbi->s_commit_interval;
>   	journal->j_min_batch_time = sbi->s_min_batch_time;
>   	journal->j_max_batch_time = sbi->s_max_batch_time;
> +	ext4_fc_init(sb, journal);
> 
>   	write_lock(&journal->j_state_lock);
>   	if (test_opt(sb, BARRIER))
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 17fdc482f554..736a1736619f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1179,6 +1179,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   	if (!journal->j_wbuf)
>   		goto err_cleanup;
> 
> +	if (journal->j_fc_wbufsize > 0) {
> +		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> +					sizeof(struct buffer_head *),
> +					GFP_KERNEL);
> +		if (!journal->j_fc_wbuf)
> +			goto err_cleanup;
> +	}
> +
>   	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
>   	if (!bh) {
>   		pr_err("%s: Cannot get buffer for journal superblock\n",
> @@ -1192,11 +1200,22 @@ static journal_t *journal_init_common(struct block_device *bdev,
> 
>   err_cleanup:
>   	kfree(journal->j_wbuf);
> +	kfree(journal->j_fc_wbuf);
>   	jbd2_journal_destroy_revoke(journal);
>   	kfree(journal);
>   	return NULL;
>   }
> 
> +int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> +{
> +	journal->j_fc_wbufsize = num_fc_blks;
> +	journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> +				sizeof(struct buffer_head *), GFP_KERNEL);
> +	if (!journal->j_fc_wbuf)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>   /* jbd2_journal_init_dev and jbd2_journal_init_inode:
>    *
>    * Create a journal structure assigned some fixed set of disk blocks to
> @@ -1314,11 +1333,20 @@ static int journal_reset(journal_t *journal)
>   	}
> 
>   	journal->j_first = first;
> -	journal->j_last = last;
> 
> -	journal->j_head = first;
> -	journal->j_tail = first;
> -	journal->j_free = last - first;
> +	if (jbd2_has_feature_fast_commit(journal) &&
> +	    journal->j_fc_wbufsize > 0) {
> +		journal->j_last_fc = last;
> +		journal->j_last = last - journal->j_fc_wbufsize;
> +		journal->j_first_fc = journal->j_last + 1;
> +		journal->j_fc_off = 0;
> +	} else {
> +		journal->j_last = last;
> +	}
> +
> +	journal->j_head = journal->j_first;
> +	journal->j_tail = journal->j_first;
> +	journal->j_free = journal->j_last - journal->j_first;
> 
>   	journal->j_tail_sequence = journal->j_transaction_sequence;
>   	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
> @@ -1663,9 +1691,18 @@ static int load_superblock(journal_t *journal)
>   	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
>   	journal->j_tail = be32_to_cpu(sb->s_start);
>   	journal->j_first = be32_to_cpu(sb->s_first);
> -	journal->j_last = be32_to_cpu(sb->s_maxlen);
>   	journal->j_errno = be32_to_cpu(sb->s_errno);
> 
> +	if (jbd2_has_feature_fast_commit(journal) &&
> +	    journal->j_fc_wbufsize > 0) {
> +		journal->j_last_fc = be32_to_cpu(sb->s_maxlen);
> +		journal->j_last = journal->j_last_fc - journal->j_fc_wbufsize;
> +		journal->j_first_fc = journal->j_last + 1;
> +		journal->j_fc_off = 0;
> +	} else {
> +		journal->j_last = be32_to_cpu(sb->s_maxlen);
> +	}
> +
>   	return 0;
>   }
> 
> @@ -1726,6 +1763,9 @@ int jbd2_journal_load(journal_t *journal)
>   	 */
>   	journal->j_flags &= ~JBD2_ABORT;
> 
> +	if (journal->j_fc_wbufsize > 0)
> +		jbd2_journal_set_features(journal, 0, 0,
> +					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
>   	/* OK, we've finished with the dynamic journal bits:
>   	 * reinitialise the dynamic contents of the superblock in memory
>   	 * and reset them on disk. */
> @@ -1809,6 +1849,8 @@ int jbd2_journal_destroy(journal_t *journal)
>   		jbd2_journal_destroy_revoke(journal);
>   	if (journal->j_chksum_driver)
>   		crypto_free_shash(journal->j_chksum_driver);
> +	if (journal->j_fc_wbufsize > 0)
> +		kfree(journal->j_fc_wbuf);
>   	kfree(journal->j_wbuf);
>   	kfree(journal);
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f438257d7f31..36f65a818366 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -915,6 +915,30 @@ struct journal_s
>   	 */
>   	unsigned long		j_last;
> 
> +	/**
> +	 * @j_first_fc:
> +	 *
> +	 * The block number of the first fast commit block in the journal
> +	 * [j_state_lock].
> +	 */
> +	unsigned long		j_first_fc;
> +
> +	/**
> +	 * @j_fc_off:
> +	 *
> +	 * Number of fast commit blocks currently allocated.
> +	 * [j_state_lock].
> +	 */
> +	unsigned long		j_fc_off;

I guess choosing a single naming convention for fast commit would be 
very helpful for grepping/searching.
So for e.g. we could have everything using j_fc_**
If you agree, then we may have to change other members of this structure
accordingly.

-ritesh

> +
> +	/**
> +	 * @j_last_fc:
> +	 *
> +	 * The block number one beyond the last fast commit block in the journal
> +	 * [j_state_lock].
> +	 */
> +	unsigned long		j_last_fc;
> +
>   	/**
>   	 * @j_dev: Device where we store the journal.
>   	 */
> @@ -1065,6 +1089,12 @@ struct journal_s
>   	 */
>   	struct buffer_head	**j_wbuf;
> 
> +	/**
> +	 * @j_fc_wbuf: Array of fast commit bhs for
> +	 * jbd2_journal_commit_transaction.
> +	 */
> +	struct buffer_head	**j_fc_wbuf;
> +
>   	/**
>   	 * @j_wbufsize:
>   	 *
> @@ -1072,6 +1102,13 @@ struct journal_s
>   	 */
>   	int			j_wbufsize;
> 
> +	/**
> +	 * @j_fc_wbufsize:
> +	 *
> +	 * Size of @j_fc_wbuf array.
> +	 */
> +	int			j_fc_wbufsize;
> +
>   	/**
>   	 * @j_last_sync_writer:
>   	 *
> @@ -1507,6 +1544,8 @@ void __jbd2_log_wait_for_space(journal_t *journal);
>   extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
>   extern int jbd2_cleanup_journal_tail(journal_t *);
> 
> +/* Fast commit related APIs */
> +int jbd2_fc_init(journal_t *journal, int num_fc_blks);
>   /*
>    * is_journal_abort
>    *
> 
