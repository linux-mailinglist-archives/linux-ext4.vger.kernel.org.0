Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A10288E8E
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbgJIQQ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 12:16:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389410AbgJIQQ4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 12:16:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099G3Nap044513;
        Fri, 9 Oct 2020 12:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JNuctF4M5b+RvOxa5pL5fzGMfPke1suc1O0owAD6MwI=;
 b=L03PYvPtzL/L/8U1YM0NAkqA/6UbbBEeWIpD69e6lXHxXngh2lwhTsfCFV+pRcydbS47
 ZAxg90CBJpVmCPMA42Z+iBD477Ae6oCW2M7HUSd3Apf0iQREHS9ceJbFodRW2mG4ajkC
 HKauMKcXkRj315O7iZDx+r9+o4EzkiPdXyIMOkgiX3cBJRcgn2CrSQ6ZxCfaD5CaGwcW
 WV36m6hum1r5nIWwUfZ7df44F5m0JsfTHiuX9Y5SaT8qUJfkPpcpFqq4Ik07DBL9ohsv
 mD6E7Xt8T6x+R7uBuF9iHD5XJmNIRfGiZXI4wS6Aw65SRqCAQYT0efadzDIE1fcQm6Cs lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342u21gk9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 12:16:53 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099G3YTX048877;
        Fri, 9 Oct 2020 12:16:53 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342u21gk98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 12:16:53 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099GDBUx028889;
        Fri, 9 Oct 2020 16:16:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3429hs0dm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 16:16:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099GGnO529360466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 16:16:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE29D42045;
        Fri,  9 Oct 2020 16:16:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 146E04203F;
        Fri,  9 Oct 2020 16:16:48 +0000 (GMT)
Received: from [9.199.46.138] (unknown [9.199.46.138])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 16:16:47 +0000 (GMT)
Subject: Re: [PATCH v9 4/9] jbd2: add fast commit machinery
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-5-harshadshirwadkar@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <96e9210e-f0d1-eaf6-593b-7fae982a8df2@linux.ibm.com>
Date:   Fri, 9 Oct 2020 21:46:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919005451.3899779-5-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_08:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=843
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090120
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> This patch implements following APIs in JBD2 to allow for fast
> commits:
> 
> jbd2_fc_start(): Start a new fast commit. This function waits for any
> existing fast commit or full commit to complete.
> 
> jbd2_fc_stop(): Stop fast commit. This function ends current fast
> commit and wakes up either the journal thread or the other fast commit
> waiting for current fast commit to complete.
> 
> jbd2_fc_stop_do_commit(): Stop fast commit and perform a full
> commit. This is same as above but also performs a full commit.
> 
> This patch also adds a cleanup handler in journal_t that is called
> after every full and fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>   fs/ext4/fast_commit.c |  8 ++++++
>   fs/jbd2/commit.c      | 19 ++++++++++++
>   fs/jbd2/journal.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
>   include/linux/jbd2.h  | 21 ++++++++++++++
>   4 files changed, 115 insertions(+)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 0dad8bdb1253..f2d11b4c6b62 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -8,11 +8,19 @@
>    * Ext4 fast commits routines.
>    */
>   #include "ext4_jbd2.h"
> +/*
> + * Fast commit cleanup routine. This is called after every fast commit and
> + * full commit. full is true if we are called after a full commit.
> + */
> +static void ext4_fc_cleanup(journal_t *journal, int full)
> +{
> +}
> 
>   void ext4_fc_init(struct super_block *sb, journal_t *journal)
>   {
>   	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
>   		return;
> +	journal->j_fc_cleanup_callback = ext4_fc_cleanup;
>   	if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
>   		pr_warn("Error while enabling fast commits, turning off.");
>   		ext4_clear_feature_fast_commit(sb);
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 6d2da8ad0e6f..ba35ecb18616 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -413,6 +413,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   	J_ASSERT(journal->j_running_transaction != NULL);
>   	J_ASSERT(journal->j_committing_transaction == NULL);
> 
> +	write_lock(&journal->j_state_lock);
> +	journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;

Shouldn't we set this flag only after the while loop ends and before 
releasing the write lock()? Like how we are doing in jbd2_fc_start()?


> +	while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
> +		DEFINE_WAIT(wait);
> +
> +		prepare_to_wait(&journal->j_wait_fc, &wait,
> +				TASK_UNINTERRUPTIBLE);
> +		write_unlock(&journal->j_state_lock);
> +		schedule();
> +		write_lock(&journal->j_state_lock);
> +		finish_wait(&journal->j_wait_fc, &wait);
> +	}
> +	write_unlock(&journal->j_state_lock);
> +
>   	commit_transaction = journal->j_running_transaction;
> 
>   	trace_jbd2_start_commit(journal, commit_transaction);
> @@ -1119,12 +1133,16 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> 
>   	if (journal->j_commit_callback)
>   		journal->j_commit_callback(journal, commit_transaction);
> +	if (journal->j_fc_cleanup_callback)
> +		journal->j_fc_cleanup_callback(journal, 1);
> 
>   	trace_jbd2_end_commit(journal, commit_transaction);
>   	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
>   		  journal->j_commit_sequence, journal->j_tail_sequence);
> 
>   	write_lock(&journal->j_state_lock);
> +	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
> +	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
>   	spin_lock(&journal->j_list_lock);
>   	commit_transaction->t_state = T_FINISHED;
>   	/* Check if the transaction can be dropped now that we are finished */
> @@ -1136,6 +1154,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   	spin_unlock(&journal->j_list_lock);
>   	write_unlock(&journal->j_state_lock);
>   	wake_up(&journal->j_wait_done_commit);
> +	wake_up(&journal->j_wait_fc);
> 
>   	/*
>   	 * Calculate overall stats
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 736a1736619f..17a30a2c38f9 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -714,6 +714,72 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
>   	return err;
>   }
> 
> +/*
> + * Start a fast commit. If there's an ongoing fast or full commit wait for
> + * it to complete. Returns 0 if a new fast commit was started. Returns -EALREADY
> + * if a fast commit is not needed, either because there's an already a commit
> + * going on or this tid has already been committed. Returns -EINVAL if no jbd2
> + * commit has yet been performed.
> + */
> +int jbd2_fc_start(journal_t *journal, tid_t tid)
> +{
> +	/*
> +	 * Fast commits only allowed if at least one full commit has
> +	 * been processed.
> +	 */
> +	if (!journal->j_stats.ts_tid)
> +		return -EINVAL;
> +
> +	if (tid <= journal->j_commit_sequence)
> +		return -EALREADY;
> +
> +	write_lock(&journal->j_state_lock);
> +	if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> +	    (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
> +		DEFINE_WAIT(wait);
> +
> +		prepare_to_wait(&journal->j_wait_fc, &wait,
> +				TASK_UNINTERRUPTIBLE);
> +		write_unlock(&journal->j_state_lock);
> +		schedule();
> +		finish_wait(&journal->j_wait_fc, &wait);
> +		return -EALREADY;
> +	}
> +	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
> +	write_unlock(&journal->j_state_lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * Stop a fast commit. If fallback is set, this function starts commit of
> + * TID tid before any other fast commit can start.
> + */
> +static int __jbd2_fc_stop(journal_t *journal, tid_t tid, bool fallback)
> +{
> +	if (journal->j_fc_cleanup_callback)
> +		journal->j_fc_cleanup_callback(journal, 0);
> +	write_lock(&journal->j_state_lock);
> +	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
> +	if (fallback)
> +		journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
> +	write_unlock(&journal->j_state_lock);
> +	wake_up(&journal->j_wait_fc);
> +	if (fallback)
> +		return jbd2_complete_transaction(journal, tid);
> +	return 0;
> +}
> +
> +int jbd2_fc_stop(journal_t *journal)
> +{
> +	return __jbd2_fc_stop(journal, 0, 0);
> +}
> +
> +int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid)
> +{
> +	return __jbd2_fc_stop(journal, tid, 1);
> +}
> +
>   /* Return 1 when transaction with given tid has already committed. */
>   int jbd2_transaction_committed(journal_t *journal, tid_t tid)
>   {
> @@ -1140,6 +1206,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   	init_waitqueue_head(&journal->j_wait_commit);
>   	init_waitqueue_head(&journal->j_wait_updates);
>   	init_waitqueue_head(&journal->j_wait_reserved);
> +	init_waitqueue_head(&journal->j_wait_fc);
>   	mutex_init(&journal->j_abort_mutex);
>   	mutex_init(&journal->j_barrier);
>   	mutex_init(&journal->j_checkpoint_mutex);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 36f65a818366..aad986a9f3ff 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -858,6 +858,13 @@ struct journal_s
>   	 */
>   	wait_queue_head_t	j_wait_reserved;
> 
> +	/**
> +	 * @j_wait_fc:
> +	 *
> +	 * Wait queue to wait for completion of async fast commits.
> +	 */
> +	wait_queue_head_t	j_wait_fc;

If we follow the naming convention then j_fc_wait, will be more
convenient.

> +
>   	/**
>   	 * @j_checkpoint_mutex:
>   	 *
> @@ -1208,6 +1215,15 @@ struct journal_s
>   	 */
>   	struct lockdep_map	j_trans_commit_map;
>   #endif
> +
> +	/**
> +	 * @j_fc_cleanup_callback:
> +	 *
> +	 * Clean-up after fast commit or full commit. JBD2 calls this function
> +	 * after every commit operation.
> +	 */
> +	void (*j_fc_cleanup_callback)(struct journal_s *journal, int);
> +
>   };
> 
>   #define jbd2_might_wait_for_commit(j) \
> @@ -1292,6 +1308,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>   #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
>   						 * data write error in ordered
>   						 * mode */
> +#define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
> +#define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
> 
>   /*
>    * Function declarations for the journaling transaction and buffer
> @@ -1546,6 +1564,9 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
> 
>   /* Fast commit related APIs */
>   int jbd2_fc_init(journal_t *journal, int num_fc_blks);
> +int jbd2_fc_start(journal_t *journal, tid_t tid);
> +int jbd2_fc_stop(journal_t *journal);
> +int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid);
>   /*
>    * is_journal_abort
>    *
> 
