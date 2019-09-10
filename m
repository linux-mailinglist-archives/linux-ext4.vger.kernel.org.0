Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDBAF249
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfIJUcr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 16:32:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33822 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJUcr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 16:32:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so10335070pgc.1
        for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2019 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DtTDgtWjiEGV1WjHPEWFUJOEpkNW4rP9QU8XkQoZi7s=;
        b=rO6gOexDOOYeVEcspLuklVG5rSeb24bWi/CpSdVJ4wToda1Hcv6VlqhcmcFqtGVrpy
         Wa6Ci8zcRCQAC2PH8fNgzreOTDOa1kMU7pCIHC/KKjauoFdruHA9hdCGCmk2vhv/0cCC
         EF0Pk8iVp9SlSds3Pku/nktl/i62R1iCK9Zpt1NnqVgG5yD62K3Wlhj3WYTmTg13X45x
         ddg0L4RLqa1mJPlAMJEVD/AFo3UaFjFDUq0PFEg8mCJByDqbNlCnNDgnk7yAJBSoy5Dp
         rNtstj8PAzdTpJ76LP8FJb21dY7YfOo2n5HIdYNxDJus33TcgLUxGuFKYubPi2oss2AS
         joYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DtTDgtWjiEGV1WjHPEWFUJOEpkNW4rP9QU8XkQoZi7s=;
        b=XGu7Kk338eSZz7ugClhrJ0vvgCnpC//sqQRfj8hHSZ4KVxfu4y7tfZHlCV8MuwQYxW
         QMQXzaR4Tv/hWsgXx4rTEVFMaD9o7fccXIZKxICQMD2cwKemcVUL5JM8Z+4EVhS2Ezey
         0Tp6Fx8K4wjT0MtMKDyZjiA8i7VtxVFVgljwaEz9ORGjKAfnXc4YelpUVltMNBMq/fPM
         j6grejv0Qc4fv1XBKMeBXgQW/hRDkVX/EHQ62rcgAAqo7pmLyUq+RcOhTpQ0mYQaxwri
         2ONaUdHs47cZIhNAnhalyzY6ZvD8Fk06IzdHMDOgNN7cgVgaYTqTj3fPtUcvx9ZrVtNB
         05Yg==
X-Gm-Message-State: APjAAAVWxvqakozhD29oOSxguGgrQuTCwQzq8l4DTJCu1iUKaCIXn2aH
        pRwFXo5GWFv83i9cpARJvWur5G0JmRU=
X-Google-Smtp-Source: APXvYqwcwWXORWc363ayNkDZ7iZNKKfrvWMPtHqC8Qxzn7/J61DpDrT4+mi1dmwZt89kDPjvVri3gQ==
X-Received: by 2002:a62:61c5:: with SMTP id v188mr38129145pfb.194.1568147565859;
        Tue, 10 Sep 2019 13:32:45 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id bb7sm495074pjb.2.2019.09.10.13.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 13:32:44 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <13257F13-1017-489E-A822-69EC510C9EEC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4AF1C7A4-1F5A-454B-8E0A-27CCA54F4EC0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] jbd2: reclaim journal space asynchronously when free space
 is low
Date:   Tue, 10 Sep 2019 14:32:49 -0600
In-Reply-To: <8edec7d4-2b6e-cce3-1011-5189aca3e462@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20190826035459.4121-1-xiaoguang.wang@linux.alibaba.com>
 <8edec7d4-2b6e-cce3-1011-5189aca3e462@linux.alibaba.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4AF1C7A4-1F5A-454B-8E0A-27CCA54F4EC0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 9, 2019, at 12:10 AM, Xiaoguang Wang =
<xiaoguang.wang@linux.alibaba.com> wrote:
>=20
> Any suggestions to this patch? Though I also think this patch needs =
some
> more improvements and more performance tests :)

What we've done in the past is to increase the journal size until this =
is
no longer a problem.  For metadata-intensive filesystems we use a =
journal
size of up to 4GB, and default to 1GB for data servers.  One benefit of
this over forcing checkpoints is that it allows IO aggregation from the
dirty buffers before they are forced to disk, which reduces impact on =
the
foreground workload.  However, it does use a lot of RAM.

> Currently I have two other thoughts:
> 1, add codes to count the number of transactions to be checkpointted, =
with
> this information, we can make some better decisions, for example, when =
it's
> appropriate to reclaim journal space asynchronously.

You can check some stats about transactions and checkpointing like:

$ cat /proc/fs/jbd2/dm-12-8/info
6490 transaction, each up to 8192 blocks
average:
  0ms waiting for transaction
  5227ms running transaction
  0ms transaction was being locked
  0ms flushing data (in ordered mode)
  196ms logging transaction
  134327us average transaction commit time
  320 handles per transaction
  18 blocks per transaction
  19 logged blocks per transaction

In the situation you describe, where the journal is full, there should =
be
a non-zero "waiting for transaction".

If you are adding more stats (e.g. decaying average number of =
transactions
to be checkpointed), this is where it should go.


> 2, add a new mount option to control whether enable or disable this =
feature.

I think this is critical for any feature.  It is useful both for testing
(e.g. does it improve/hurt performance), but also in case there are bugs
seen in the field then the feature can be turned off without having to
patch, build, and install a new kernel.

Rather than just enable/disable the feature, the tunable should be the
number of pending transactions before checkpoint is started, or number
of free journal blocks (percentage if < 100?) at which to start =
checkpoint.

>> In current jbd2's implemention, jbd2 won't reclaim journal space =
unless
>> free journal space is lower than specified threshold, see logic in
>> add_transaction_credits():
>>         write_lock(&journal->j_state_lock);
>>         if (jbd2_log_space_left(journal) < =
jbd2_space_needed(journal))
>>             __jbd2_log_wait_for_space(journal);
>>         write_unlock(&journal->j_state_lock);
>> Indeed with this logic, we can also have many transactions queued to =
be
>> checkpointd, which means these transactions still occupy jbd2 space.
>> Recently I have seen some disadvantages caused by this logic:
>> Some of our applications will get stuck in below stack periodically:
>>         __jbd2_log_wait_for_space+0xd5/0x200 [jbd2]
>>         start_this_handle+0x31b/0x8f0 [jbd2]
>>         jbd2__journal_start+0xcd/0x1f0 [jbd2]
>>         __ext4_journal_start_sb+0x69/0xe0 [ext4]
>>         ext4_dirty_inode+0x32/0x70 [ext4]
>>         __mark_inode_dirty+0x15f/0x3a0
>>         generic_update_time+0x87/0xe0
>>         file_update_time+0xbd/0x120
>>         __generic_file_aio_write+0x198/0x3e0
>>         generic_file_aio_write+0x5d/0xc0
>>         ext4_file_write+0xb5/0x460 [ext4]
>>         do_sync_write+0x8d/0xd0
>>         vfs_write+0xbd/0x1e0
>>         SyS_write+0x7f/0xe0
>> Meanwhile I found io usage in these applications' machines are =
relatively
>> low, journal space is somewhat like a global lock, in high =
concurrency case,
>> if many tasks contend for journal credits, they will easily hit above =
stack
>> and be stuck in waitting for free journal space, so I wonder whether =
we can
>> reclaim journal space asynchronously when free space is lower than a =
specified
>> threshold, to avoid that all applications are stalled at the same =
time.
>> I think this will be more useful in high speed store, journal space =
will be
>> reclaimed in background quickly, and applications will less likely to =
be
>> stucked by above issue. To improve this case, we use workqueue to =
queue a
>> work in background to reclaim journal space.
>> I also construct a test case to verify improvement, test case will =
create
>> 1000000 directories, use 1, 2, 4, 8 and 16 tasks per test round. For =
example,
>> in 8 tasks case, create 8 processes and every process creates 125000 =
directories,
>> 16 tasks case, every process creates 62500 directories. Every test =
case run
>> 5 iterations.
>> Tested in my vm(16cores, 8G memory), count the run time per test =
round.
>> Without this patch,
>> 16 tasks:  35s 34s 33s 34s 34s total: 170s, avg: 34s
>> 8  tasks:  33s 35s 34s 35s 35s total: 172s, avg: 34.4s
>> 4  tasks:  36s 38s 39s 39s 41s total: 193s, avg: 38.6s
>> 2  tasks:  53s 54s 52s 55s 54s total: 268s, avg: 53.6s
>> 1  tasks:  65s 65s 65s 65s 64s total: 324s, avg: 64.8s
>> With this patch:
>> 16 tasks:  29s 32s 32s 31s 33s total: 157s, avg: 31.4s
>> 8  tasks:  30s 31s 30s 31s 30s total: 152s, avg: 30.4s
>> 4  tasks:  33s 34s 32s 33s 37s total: 169s, avg: 33.8s
>> 2  tasks:  47s 48s 46s 49s 48s total: 238s, avg: 47.6s
>> 1  tasks:  56s 55s 56s 54s 55s total: 276s, avg: 55.2s
>> =46rom above test, we can have 10% improvements.
>> Run same test in physical machine with nvme store, get such test =
results:
>> without patch(count the total time spending to create 5000000 =
sub-directories):
>> 64 tasks  32 tasks 16 tasks  8 tasks  4 tasks  2 tasks  1 tasks
>>      66s       64s      67s      71s      81s     108s     133s
>> with patch:
>> 64 tasks  32 tasks 16 tasks  8 tasks  4 tasks  2 tasks  1 tasks
>>     66s        64s      69s      72s      80s     103s     112s
>> Seems that improvements are only somewhat significant in low =
concurrency
>> case, I guess it's because that the checkpoint work in nvme is quick.
>> In high concurrency case, the overhead caused by waitting for log =
space
>> may not a big bottleneck, I'll look into this issue more.
>> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>> ---
>>  fs/jbd2/checkpoint.c  |  4 ++--
>>  fs/jbd2/journal.c     | 26 ++++++++++++++++++++++++++
>>  fs/jbd2/transaction.c | 12 +++++++++++-
>>  include/linux/jbd2.h  | 23 ++++++++++++++++++++++-
>>  4 files changed, 61 insertions(+), 4 deletions(-)
>> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
>> index a1909066bde6..da0920cbc1d3 100644
>> --- a/fs/jbd2/checkpoint.c
>> +++ b/fs/jbd2/checkpoint.c
>> @@ -105,12 +105,12 @@ static int __try_to_free_cp_buf(struct =
journal_head *jh)
>>   * Called under j-state_lock *only*.  It will be unlocked if we have =
to wait
>>   * for a checkpoint to free up some space in the log.
>>   */
>> -void __jbd2_log_wait_for_space(journal_t *journal)
>> +void __jbd2_log_wait_for_space(journal_t *journal, int scale)
>>  {
>>  	int nblocks, space_left;
>>  	/* assert_spin_locked(&journal->j_state_lock); */
>>  -	nblocks =3D jbd2_space_needed(journal);
>> +	nblocks =3D jbd2_space_needed(journal) * scale;
>>  	while (jbd2_log_space_left(journal) < nblocks) {
>>  		write_unlock(&journal->j_state_lock);
>>  		mutex_lock_io(&journal->j_checkpoint_mutex);
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 953990eb70a9..871c3d251fdb 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -1100,6 +1100,21 @@ static void jbd2_stats_proc_exit(journal_t =
*journal)
>>  	remove_proc_entry(journal->j_devname, proc_jbd2_stats);
>>  }
>>  +/*
>> + * Start to reclaim journal space asynchronously.
>> + */
>> +void jbd2_reclaim_log_space_async(struct work_struct *work)
>> +{
>> +	journal_t *journal =3D container_of(work, journal_t, =
j_reclaim_work);
>> +
>> +	write_lock(&journal->j_state_lock);
>> +	/* See comments in add_transaction_credits() */
>> +	if (jbd2_log_space_left(journal) < jbd2_space_needed(journal) * =
2)
>> +		__jbd2_log_wait_for_space(journal, 2);
>> +	journal->j_async_reclaim_run =3D 0;
>> +	write_unlock(&journal->j_state_lock);
>> +}
>> +
>>  /*
>>   * Management for journal control blocks: functions to create and
>>   * destroy journal_t structures, and to initialise and read existing
>> @@ -1142,6 +1157,15 @@ static journal_t *journal_init_common(struct =
block_device *bdev,
>>  	/* The journal is marked for error until we succeed with =
recovery! */
>>  	journal->j_flags =3D JBD2_ABORT;
>>  +	journal->j_reclaim_wq =3D alloc_workqueue("jbd2-reclaim-wq",
>> +					WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
>> +	if (!journal->j_reclaim_wq) {
>> +		pr_err("%s: failed to create workqueue\n", __func__);
>> +		goto err_cleanup;
>> +	}
>> +	INIT_WORK(&journal->j_reclaim_work, =
jbd2_reclaim_log_space_async);
>> +	journal->j_async_reclaim_run =3D 0;
>> +
>>  	/* Set up a default-sized revoke table for the new mount. */
>>  	err =3D jbd2_journal_init_revoke(journal, =
JOURNAL_REVOKE_DEFAULT_HASH);
>>  	if (err)
>> @@ -1718,6 +1742,7 @@ int jbd2_journal_destroy(journal_t *journal)
>>  	if (journal->j_running_transaction)
>>  		jbd2_journal_commit_transaction(journal);
>>  +	flush_workqueue(journal->j_reclaim_wq);
>>  	/* Force any old transactions to disk */
>>    	/* Totally anal locking here... */
>> @@ -1768,6 +1793,7 @@ int jbd2_journal_destroy(journal_t *journal)
>>  		jbd2_journal_destroy_revoke(journal);
>>  	if (journal->j_chksum_driver)
>>  		crypto_free_shash(journal->j_chksum_driver);
>> +	destroy_workqueue(journal->j_reclaim_wq);
>>  	kfree(journal->j_wbuf);
>>  	kfree(journal);
>>  diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index 990e7b5062e7..27f9d47c620e 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -247,6 +247,16 @@ static int add_transaction_credits(journal_t =
*journal, int blocks,
>>  		return 1;
>>  	}
>>  +	/*
>> +	 * If free journal space is lower than =
(jbd2_space_needed(journal) * 2),
>> +	 * let's reclaim some journal space early and do it =
asynchronously.
>> +	 */
>> +	if (journal->j_async_reclaim_run =3D=3D 0 &&
>> +	    jbd2_log_space_left(journal) < (jbd2_space_needed(journal) * =
2)) {
>> +		journal->j_async_reclaim_run =3D 1;
>> +		queue_work(journal->j_reclaim_wq, =
&journal->j_reclaim_work);
>> +	}
>> +
>>  	/*
>>  	 * The commit code assumes that it can get enough log space
>>  	 * without forcing a checkpoint.  This is *critical* for
>> @@ -264,7 +274,7 @@ static int add_transaction_credits(journal_t =
*journal, int blocks,
>>  		jbd2_might_wait_for_commit(journal);
>>  		write_lock(&journal->j_state_lock);
>>  		if (jbd2_log_space_left(journal) < =
jbd2_space_needed(journal))
>> -			__jbd2_log_wait_for_space(journal);
>> +			__jbd2_log_wait_for_space(journal, 1);
>>  		write_unlock(&journal->j_state_lock);
>>  		return 1;
>>  	}
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index df03825ad1a1..acc93597271b 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1152,6 +1152,27 @@ struct journal_s
>>  	 */
>>  	__u32 j_csum_seed;
>>  +	/**
>> +	 * @j_async_reclaim_run:
>> +	 *
>> +	 * Is there a work running asynchronously to reclaim journal =
space.
>> +	 */
>> +	int j_async_reclaim_run;
>> +
>> +	/**
>> +	 * @j_reclaim_work:
>> +	 *
>> +	 * Work_struct to reclaim journal space.
>> +	 */
>> +	struct work_struct j_reclaim_work;
>> +
>> +	/**
>> +	 * @j_reclaim_wq:
>> +	 *
>> +	 * Workqueue for reclaim journal space asynchronously.
>> +	 */
>> +	struct workqueue_struct *j_reclaim_wq;
>> +
>>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>  	/**
>>  	 * @j_trans_commit_map:
>> @@ -1498,7 +1519,7 @@ int jbd2_complete_transaction(journal_t =
*journal, tid_t tid);
>>  int jbd2_log_do_checkpoint(journal_t *journal);
>>  int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t =
tid);
>>  -void __jbd2_log_wait_for_space(journal_t *journal);
>> +void __jbd2_log_wait_for_space(journal_t *journal, int scale);
>>  extern void __jbd2_journal_drop_transaction(journal_t *, =
transaction_t *);
>>  extern int jbd2_cleanup_journal_tail(journal_t *);
>>=20


Cheers, Andreas






--Apple-Mail=_4AF1C7A4-1F5A-454B-8E0A-27CCA54F4EC0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl14CHIACgkQcqXauRfM
H+A48g/+KNPxT1SSdiAD8hUC3LfpxPC8c0lUaqql/Pl3DnNqZ0wDceKLvYixHvi2
Zr9NrGAOj25HORq/giJHCZV/MatNJp/jvxt3F8KG2Kcypc9CSZcJw7taY7hOtVYc
NO9TN0zW6J5v8y8CQHFvOq+bsteur/bOY5+R540sJCwDaVHnPvxrvyC7v9Mc+BQg
gbuIrSJFrgO5bhHCozzaHP9jMo3gh5WwriTxu1GSnNZ2004Yq24fn4M22CgYQOpn
k+XLvBQ1sBHQggleEe8tS4PXndx691AxvoRu7K8lCqqZEixt88moRy5IsOkJoWOC
9kckrm5vNGyjxTB2KRVMLf2N9M7uyGxOiVqquVv5uGAvT2CnpdmsHmwE14f2epj/
Qhqp6RumGXniMArygOxLJZNhZEaqYXznV7Dy2ckKF4kH0RnqKQyI8FFxcNF6jTOb
X6oSOQIF+ZUshuVgEM3OhKVkFr36U8sl52MRcfsRvqAJ4+NtjuvhI7RQQk5MttCZ
aRJeIc0dbgZmaOWcMOWD8erS+m7YhNTiMoi+gYNEhTxmEdytvzTq17WJlt0wIB3M
ukV+ovMhKmwsDxrnw6eenhR54uRc8Xxaxr0pePO4dUQHE4jg7Qr+i97Fsdfu9oK1
Q6MqM0ByuBXj6mhvkxADUPBDJxOr7pYc/O+dy6YkaS7YB0+IhUk=
=60Df
-----END PGP SIGNATURE-----

--Apple-Mail=_4AF1C7A4-1F5A-454B-8E0A-27CCA54F4EC0--
