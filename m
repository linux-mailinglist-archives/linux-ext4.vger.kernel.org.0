Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4575F883CB
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHIUWm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 16:22:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHIUWm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 16:22:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so45411381plt.1
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VQFO4h8/gojq1GNqY7hNUJ8P4lKDxJmyyp0YjBvsDaE=;
        b=n9SYLWhZnq7Fb+slkEe/Fiu2VQ34mX+Khs/WxhXhW5N9O2V3b2p5tmnJbngI3MvRDY
         F5dMLPf03AQd85autWYp4kuvyca13iNcXGWfEaV7ZZWeAyU9eSc8nGBQhlkq+u8qr56D
         xn/SrImXLESsN8DfIyAX077WwC+QL9iy/owSkklxwZP56jKoE5A3eNcSejZy6NIo9hiL
         Khg2zhueAzQbPjc1ezNQ34GswEjwa/x+RqjAbT7XalDHhDjqLu9ozFl3KTVtM0TZqSjA
         06dULWanLetgEhrOLkH47pV1WvnYoJAZl6urO03jq5EtJ5pe99AaGQsUGT9xWqHbRJH7
         wAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VQFO4h8/gojq1GNqY7hNUJ8P4lKDxJmyyp0YjBvsDaE=;
        b=bo+/JexllqO6pNPX0bwdC9+HFYFlHoyEbYZONYMGaY54cSwElKQeM4Lpoc49kAk9nQ
         9oVKENoybuFpd2d5a8eaT5RpM3+BuyPGjnljU2pau175GzOg2xA0Ft/4owExLpSR0pJF
         5Ea2NlhOxuDzC9Qt06bbc57vyyg2czQaG1VKncbpIXaJVXZKENxIJqWtzVXdv7L2emwb
         YMMl7/o7vzB95U/KapYDQ4b5IeFCi9mdiOD2JXTPgHyNg2lX0cFmmVYJVbCJJb4TxBUB
         DMKl3xSO2brCwmxSa/S886D9s7Lt2rsZQN9XobgY3/G1gtma2mNtkwnvzFSD+VJ1a/Is
         Gs1Q==
X-Gm-Message-State: APjAAAUZ7CufjCvdCY0giDcB/Mr/jQX1kGLqPHRI0utCHzw1G8jHuRRv
        mEas5Dix0iUxONaYxVBsHAZtBZ0Drpx6Ww==
X-Google-Smtp-Source: APXvYqyCu4uv7AdHJ4NKRT5a39NRzcK9iKkLhSyvTips/aM0FjWrqGxxqR8LiEBfBF7jKMk2r2jZ4Q==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr20728197plp.61.1565382160802;
        Fri, 09 Aug 2019 13:22:40 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r137sm6402984pfc.145.2019.08.09.13.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 13:22:39 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <88620994-CC37-450F-9698-AF7EF8A388FC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0BD26E8D-F72B-4EC4-8BA0-4B8B88E49BEE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 04/12] jbd2: fast-commit commit path changes
Date:   Fri, 9 Aug 2019 14:22:37 -0600
In-Reply-To: <20190809034552.148629-5-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-5-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0BD26E8D-F72B-4EC4-8BA0-4B8B88E49BEE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds core fast-commit commit path changes. This patch also
> modifies existing JBD2 APIs to allow usage of fast commits. If fast
> commits are enabled and journal->j_do_full_commit is not set, the
> commit routine tries the file system specific fast commmit first. Only
> if it fails, it falls back to the full commit. Commit start and wait
> APIs now take an additional argument which indicates if fast commits
> are allowed or not.
>=20
> In this patch we also add a new entry to journal->stats which counts
> the number of fast commits performed.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

It would be better to rename the existing function something like
jbd2_log_start_commit_full() and add wrappers jbd2_log_start_commit()
and jbd2_log_start_commit_fast() to avoid to change all of the
callsites to add the same parameter:

int jbd2_log_start_commit_fast(journal_t *journal, tid_t tid)
{
	return jbd2_log_start_commit_full(journal, tid, false);
}
EXPORT_SYMBOL(jbd2_log_start_commit_fast);

int jbd2_log_start_commit(journal_t *journal, tid_t tid)
{
	return jbd2_log_start_commit_full(journal, tid, true);
}
EXPORT_SYMBOL(jbd2_log_start_commit);

That makes it much more clear for the few callsites that need the
"fast" variant what is being done, unlike a "true" or "false"
argument to a function that isn't very clear what meaning it has.

Cheers, Andreas

> ---
>=20
> Changelog:
>=20
> V2: JBD2 commit routine passes stats to the fast commit callbac. Also,
>    added a new entry to journal->stats and its tracking.
> ---
> fs/ext4/super.c       |  2 +-
> fs/jbd2/checkpoint.c  |  2 +-
> fs/jbd2/commit.c      | 47 +++++++++++++++++++++++--
> fs/jbd2/journal.c     | 81 +++++++++++++++++++++++++++++++++++--------
> fs/jbd2/transaction.c |  6 ++--
> fs/ocfs2/alloc.c      |  2 +-
> fs/ocfs2/super.c      |  2 +-
> include/linux/jbd2.h  |  9 +++--
> 8 files changed, 124 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81c3ec165822..6bab59ae81f7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5148,7 +5148,7 @@ static int ext4_sync_fs(struct super_block *sb, =
int wait)
> 		    !jbd2_trans_will_send_data_barrier(sbi->s_journal, =
target))
> 			needs_barrier =3D true;
>=20
> -		if (jbd2_journal_start_commit(sbi->s_journal, &target)) =
{
> +		if (jbd2_journal_start_commit(sbi->s_journal, &target, =
true)) {
> 			if (wait)
> 				ret =3D =
jbd2_log_wait_commit(sbi->s_journal,
> 							   target);
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index a1909066bde6..6297978ae3bc 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -277,7 +277,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>=20
> 			if (batch_count)
> 				__flush_batch(journal, &batch_count);
> -			jbd2_log_start_commit(journal, tid);
> +			jbd2_log_start_commit(journal, tid, true);
> 			/*
> 			 * jbd2_journal_commit_transaction() may want
> 			 * to take the checkpoint_mutex if JBD2_FLUSHED
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 132fb92098c7..9281814606e7 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -351,8 +351,12 @@ static void jbd2_block_tag_csum_set(journal_t *j, =
journal_block_tag_t *tag,
>  *
>  * The primary function for committing a transaction to the log.  This
>  * function is called by the journal thread to begin a complete =
commit.
> + *
> + * fc is input / output parameter. If fc is non-null and is set to =
true, this
> + * function tries to perform fast commit. If the fast commit is =
successfully
> + * performed, *fc is set to true.
>  */
> -void jbd2_journal_commit_transaction(journal_t *journal)
> +void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)
> {
> 	struct transaction_stats_s stats;
> 	transaction_t *commit_transaction;
> @@ -380,6 +384,7 @@ void jbd2_journal_commit_transaction(journal_t =
*journal)
> 	tid_t first_tid;
> 	int update_tail;
> 	int csum_size =3D 0;
> +	bool full_commit;
> 	LIST_HEAD(io_bufs);
> 	LIST_HEAD(log_bufs);
>=20
> @@ -413,6 +418,40 @@ void jbd2_journal_commit_transaction(journal_t =
*journal)
> 	J_ASSERT(journal->j_running_transaction !=3D NULL);
> 	J_ASSERT(journal->j_committing_transaction =3D=3D NULL);
>=20
> +	read_lock(&journal->j_state_lock);
> +	full_commit =3D journal->j_do_full_commit;
> +	read_unlock(&journal->j_state_lock);
> +
> +	/* Let file-system try its own fast commit */
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		if (!full_commit && fc && *fc =3D=3D true &&
> +		    journal->j_fc_commit_callback &&
> +		    !journal->j_fc_commit_callback(
> +			journal, journal->j_running_transaction->t_tid,
> +			journal->j_subtid, &stats.run)) {
> +			jbd_debug(3, "fast commit success.\n");
> +			if (journal->j_fc_cleanup_callback)
> +				journal->j_fc_cleanup_callback(journal);
> +			write_lock(&journal->j_state_lock);
> +			journal->j_subtid++;
> +			if (fc)
> +				*fc =3D true;
> +			write_unlock(&journal->j_state_lock);
> +			goto update_overall_stats;
> +		}
> +		if (journal->j_fc_cleanup_callback)
> +			journal->j_fc_cleanup_callback(journal);
> +		write_lock(&journal->j_state_lock);
> +		journal->j_fc_off =3D 0;
> +		journal->j_subtid =3D 0;
> +		journal->j_do_full_commit =3D false;
> +		write_unlock(&journal->j_state_lock);
> +	}
> +
> +	jbd_debug(3, "fast commit not performed, trying full.\n");
> +	if (fc)
> +		*fc =3D false;
> +
> 	commit_transaction =3D journal->j_running_transaction;
>=20
> 	trace_jbd2_start_commit(journal, commit_transaction);
> @@ -1129,8 +1168,12 @@ void jbd2_journal_commit_transaction(journal_t =
*journal)
> 	/*
> 	 * Calculate overall stats
> 	 */
> +update_overall_stats:
> 	spin_lock(&journal->j_history_lock);
> -	journal->j_stats.ts_tid++;
> +	if (fc && *fc =3D=3D true)
> +		journal->j_stats.ts_num_fast_commits++;
> +	else
> +		journal->j_stats.ts_tid++;
> 	journal->j_stats.ts_requested +=3D stats.ts_requested;
> 	journal->j_stats.run.rs_wait +=3D stats.run.rs_wait;
> 	journal->j_stats.run.rs_request_delay +=3D =
stats.run.rs_request_delay;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 59ad709154a3..ab05e47ed2d4 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -160,7 +160,13 @@ static void commit_timeout(struct timer_list *t)
>  *
>  * 1) COMMIT:  Every so often we need to commit the current state of =
the
>  *    filesystem to disk.  The journal thread is responsible for =
writing
> - *    all of the metadata buffers to disk.
> + *    all of the metadata buffers to disk. If fast commits are =
allowed,
> + *    journal thread passes the control to the file system and file =
system
> + *    is then responsible for writing metadata buffers to disk (in =
whichever
> + *    format it wants). If fast commit succeds, journal thread won't =
perform
> + *    a normal commit. In case the fast commit fails, journal thread =
performs
> + *    full commit as normal.
> + *
>  *
>  * 2) CHECKPOINT: We cannot reuse a used section of the log file until =
all
>  *    of the data in that part of the log has been rewritten elsewhere =
on
> @@ -172,6 +178,7 @@ static int kjournald2(void *arg)
> {
> 	journal_t *journal =3D arg;
> 	transaction_t *transaction;
> +	bool fc_flag =3D true, fc_flag_save;
>=20
> 	/*
> 	 * Set up an interval timer which can be used to trigger a =
commit wakeup
> @@ -209,9 +216,14 @@ static int kjournald2(void *arg)
> 		jbd_debug(1, "OK, requests differ\n");
> 		write_unlock(&journal->j_state_lock);
> 		del_timer_sync(&journal->j_commit_timer);
> -		jbd2_journal_commit_transaction(journal);
> +		fc_flag_save =3D fc_flag;
> +		jbd2_journal_commit_transaction(journal, &fc_flag);
> 		write_lock(&journal->j_state_lock);
> -		goto loop;
> +		if (!fc_flag) {
> +			/* fast commit not performed */
> +			fc_flag =3D fc_flag_save;
> +			goto loop;
> +		}
> 	}
>=20
> 	wake_up(&journal->j_wait_done_commit);
> @@ -235,16 +247,18 @@ static int kjournald2(void *arg)
>=20
> 		prepare_to_wait(&journal->j_wait_commit, &wait,
> 				TASK_INTERRUPTIBLE);
> -		if (journal->j_commit_sequence !=3D =
journal->j_commit_request)
> +		if (!fc_flag &&
> +		    journal->j_commit_sequence !=3D =
journal->j_commit_request)
> 			should_sleep =3D 0;
> 		transaction =3D journal->j_running_transaction;
> 		if (transaction && time_after_eq(jiffies,
> -						transaction->t_expires))
> +						 =
transaction->t_expires))
> 			should_sleep =3D 0;
> 		if (journal->j_flags & JBD2_UNMOUNT)
> 			should_sleep =3D 0;
> 		if (should_sleep) {
> 			write_unlock(&journal->j_state_lock);
> +			jbd_debug(1, "%s sleeps\n", __func__);
> 			schedule();
> 			write_lock(&journal->j_state_lock);
> 		}
> @@ -259,7 +273,10 @@ static int kjournald2(void *arg)
> 	transaction =3D journal->j_running_transaction;
> 	if (transaction && time_after_eq(jiffies, =
transaction->t_expires)) {
> 		journal->j_commit_request =3D transaction->t_tid;
> +		fc_flag =3D false;
> 		jbd_debug(1, "woke because of timeout\n");
> +	} else {
> +		fc_flag =3D true;
> 	}
> 	goto loop;
>=20
> @@ -517,11 +534,17 @@ int __jbd2_log_start_commit(journal_t *journal, =
tid_t target)
> 	return 0;
> }
>=20
> -int jbd2_log_start_commit(journal_t *journal, tid_t tid)
> +int jbd2_log_start_commit(journal_t *journal, tid_t tid, bool =
full_commit)
> {
> 	int ret;
>=20
> 	write_lock(&journal->j_state_lock);
> +	/*
> +	 * If someone has already requested a full commit,
> +	 * we have to honor it.
> +	 */
> +	if (!journal->j_do_full_commit)
> +		journal->j_do_full_commit =3D full_commit;
> 	ret =3D __jbd2_log_start_commit(journal, tid);
> 	write_unlock(&journal->j_state_lock);
> 	return ret;
> @@ -556,7 +579,7 @@ static int __jbd2_journal_force_commit(journal_t =
*journal)
> 	tid =3D transaction->t_tid;
> 	read_unlock(&journal->j_state_lock);
> 	if (need_to_start)
> -		jbd2_log_start_commit(journal, tid);
> +		jbd2_log_start_commit(journal, tid, true);
> 	ret =3D jbd2_log_wait_commit(journal, tid);
> 	if (!ret)
> 		ret =3D 1;
> @@ -603,11 +626,14 @@ int jbd2_journal_force_commit(journal_t =
*journal)
>  * if a transaction is going to be committed (or is currently already
>  * committing), and fills its tid in at *ptid
>  */
> -int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
> +int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid, bool =
full_commit)
> {
> 	int ret =3D 0;
>=20
> 	write_lock(&journal->j_state_lock);
> +	if (!journal->j_do_full_commit)
> +		journal->j_do_full_commit =3D full_commit;
> +
> 	if (journal->j_running_transaction) {
> 		tid_t tid =3D journal->j_running_transaction->t_tid;
>=20
> @@ -675,7 +701,7 @@ EXPORT_SYMBOL(jbd2_trans_will_send_data_barrier);
>  * Wait for a specified commit to complete.
>  * The caller may not hold the journal lock.
>  */
> -int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
> +int __jbd2_log_wait_commit(journal_t *journal, tid_t tid, tid_t =
subtid)
> {
> 	int err =3D 0;
>=20
> @@ -702,12 +728,25 @@ int jbd2_log_wait_commit(journal_t *journal, =
tid_t tid)
> 	}
> #endif
> 	while (tid_gt(tid, journal->j_commit_sequence)) {
> -		jbd_debug(1, "JBD2: want %u, j_commit_sequence=3D%u\n",
> -				  tid, journal->j_commit_sequence);
> +		if ((!journal->j_do_full_commit) &&
> +		    !tid_geq(subtid, journal->j_subtid))
> +			break;
> +		jbd_debug(1, "JBD2: want full commit %u %s %u, ",
> +			  tid, journal->j_do_full_commit ?
> +			  "and ignoring fast commit request for " :
> +			  "or want fast commit",
> +			  journal->j_subtid);
> +		jbd_debug(1, "j_commit_sequence=3D%u, j_subtid=3D%u\n",
> +			  journal->j_commit_sequence, =
journal->j_subtid);
> 		read_unlock(&journal->j_state_lock);
> 		wake_up(&journal->j_wait_commit);
> -		wait_event(journal->j_wait_done_commit,
> -				!tid_gt(tid, =
journal->j_commit_sequence));
> +		if (journal->j_do_full_commit)
> +			wait_event(journal->j_wait_done_commit,
> +				   !tid_gt(tid, =
journal->j_commit_sequence));
> +		else
> +			wait_event(journal->j_wait_done_commit,
> +				   !tid_gt(tid, =
journal->j_commit_sequence) ||
> +				   !tid_geq(subtid, journal->j_subtid));
> 		read_lock(&journal->j_state_lock);
> 	}
> 	read_unlock(&journal->j_state_lock);
> @@ -717,6 +756,13 @@ int jbd2_log_wait_commit(journal_t *journal, =
tid_t tid)
> 	return err;
> }
>=20
> +int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
> +{
> +	journal->j_do_full_commit =3D true;
> +	return __jbd2_log_wait_commit(journal, tid, 0);
> +}
> +
> +
> /* Return 1 when transaction with given tid has already committed. */
> int jbd2_transaction_committed(journal_t *journal, tid_t tid)
> {
> @@ -751,7 +797,7 @@ int jbd2_complete_transaction(journal_t *journal, =
tid_t tid)
> 		if (journal->j_commit_request !=3D tid) {
> 			/* transaction not yet started, so request it */
> 			read_unlock(&journal->j_state_lock);
> -			jbd2_log_start_commit(journal, tid);
> +			jbd2_log_start_commit(journal, tid, true);
> 			goto wait_commit;
> 		}
> 	} else if (!(journal->j_committing_transaction &&
> @@ -996,6 +1042,8 @@ static int jbd2_seq_info_show(struct seq_file =
*seq, void *v)
> 		   "each up to %u blocks\n",
> 		   s->stats->ts_tid, s->stats->ts_requested,
> 		   s->journal->j_max_transaction_buffers);
> +	seq_printf(seq, "%lu fast commits performed\n",
> +		   s->stats->ts_num_fast_commits);
> 	if (s->stats->ts_tid =3D=3D 0)
> 		return 0;
> 	seq_printf(seq, "average: \n  %ums waiting for transaction\n",
> @@ -1020,6 +1068,9 @@ static int jbd2_seq_info_show(struct seq_file =
*seq, void *v)
> 	    s->stats->run.rs_blocks / s->stats->ts_tid);
> 	seq_printf(seq, "  %lu logged blocks per transaction\n",
> 	    s->stats->run.rs_blocks_logged / s->stats->ts_tid);
> +	seq_printf(seq, "  %lu logged blocks per commit\n",
> +	    s->stats->run.rs_blocks_logged /
> +	    (s->stats->ts_tid + s->stats->ts_num_fast_commits));
> 	return 0;
> }
>=20
> @@ -1741,7 +1792,7 @@ int jbd2_journal_destroy(journal_t *journal)
>=20
> 	/* Force a final log commit */
> 	if (journal->j_running_transaction)
> -		jbd2_journal_commit_transaction(journal);
> +		jbd2_journal_commit_transaction(journal, NULL);
>=20
> 	/* Force any old transactions to disk */
>=20
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 990e7b5062e7..87f6627d78aa 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -154,7 +154,7 @@ static void wait_transaction_locked(journal_t =
*journal)
> 	need_to_start =3D !tid_geq(journal->j_commit_request, tid);
> 	read_unlock(&journal->j_state_lock);
> 	if (need_to_start)
> -		jbd2_log_start_commit(journal, tid);
> +		jbd2_log_start_commit(journal, tid, true);
> 	jbd2_might_wait_for_commit(journal);
> 	schedule();
> 	finish_wait(&journal->j_wait_transaction_locked, &wait);
> @@ -708,7 +708,7 @@ int jbd2__journal_restart(handle_t *handle, int =
nblocks, gfp_t gfp_mask)
> 	need_to_start =3D !tid_geq(journal->j_commit_request, tid);
> 	read_unlock(&journal->j_state_lock);
> 	if (need_to_start)
> -		jbd2_log_start_commit(journal, tid);
> +		jbd2_log_start_commit(journal, tid, true);
>=20
> 	rwsem_release(&journal->j_trans_commit_map, 1, _THIS_IP_);
> 	handle->h_buffer_credits =3D nblocks;
> @@ -1822,7 +1822,7 @@ int jbd2_journal_stop(handle_t *handle)
> 		jbd_debug(2, "transaction too old, requesting commit for =
"
> 					"handle %p\n", handle);
> 		/* This is non-blocking */
> -		jbd2_log_start_commit(journal, transaction->t_tid);
> +		jbd2_log_start_commit(journal, transaction->t_tid, =
true);
>=20
> 		/*
> 		 * Special case: JBD2_SYNC synchronous updates require =
us
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 0c335b51043d..df41c43573b7 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -6117,7 +6117,7 @@ int ocfs2_try_to_free_truncate_log(struct =
ocfs2_super *osb,
> 		goto out;
> 	}
>=20
> -	if (jbd2_journal_start_commit(osb->journal->j_journal, &target)) =
{
> +	if (jbd2_journal_start_commit(osb->journal->j_journal, &target, =
true)) {
> 		jbd2_log_wait_commit(osb->journal->j_journal, target);
> 		ret =3D 1;
> 	}
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 8b2f39506648..60ecc51759ae 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -410,7 +410,7 @@ static int ocfs2_sync_fs(struct super_block *sb, =
int wait)
> 	}
>=20
> 	if (jbd2_journal_start_commit(osb->journal->j_journal,
> -				      &target)) {
> +				      &target, true)) {
> 		if (wait)
> 			jbd2_log_wait_commit(osb->journal->j_journal,
> 					     target);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 153840b422cc..535f88dff653 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -742,6 +742,7 @@ struct transaction_run_stats_s {
>=20
> struct transaction_stats_s {
> 	unsigned long		ts_tid;
> +	unsigned long		ts_num_fast_commits;
> 	unsigned long		ts_requested;
> 	struct transaction_run_stats_s run;
> };
> @@ -1364,7 +1365,8 @@ int __jbd2_update_log_tail(journal_t *journal, =
tid_t tid, unsigned long block);
> void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long =
block);
>=20
> /* Commit management */
> -extern void jbd2_journal_commit_transaction(journal_t *);
> +extern void jbd2_journal_commit_transaction(journal_t *journal,
> +					    bool *full_commit);
>=20
> /* Checkpoint list management */
> void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool =
destroy);
> @@ -1571,9 +1573,10 @@ extern void	=
jbd2_clear_buffer_revoked_flags(journal_t *journal);
>  * transitions on demand.
>  */
>=20
> -int jbd2_log_start_commit(journal_t *journal, tid_t tid);
> +int jbd2_log_start_commit(journal_t *journal, tid_t tid, bool =
full_commit);
> int __jbd2_log_start_commit(journal_t *journal, tid_t tid);
> -int jbd2_journal_start_commit(journal_t *journal, tid_t *tid);
> +int jbd2_journal_start_commit(journal_t *journal, tid_t *tid,
> +			      bool full_commit);
> int jbd2_log_wait_commit(journal_t *journal, tid_t tid);
> int jbd2_transaction_committed(journal_t *journal, tid_t tid);
> int jbd2_complete_transaction(journal_t *journal, tid_t tid);
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>=20


Cheers, Andreas






--Apple-Mail=_0BD26E8D-F72B-4EC4-8BA0-4B8B88E49BEE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N1g4ACgkQcqXauRfM
H+CLORAAnqBsSsZgqRrK8dkvvnfG9ScCvN84V+wffaqYRnPEtt+1EPX8Pl/oF4Dz
VuJIBH8URPgCysEvPx3qL7DYE5PZ42A8irFLUUN912eJiixP4TI/QjgAFtIV66ye
PLk58nRENnSRLuRE0B97OG2Ix1Q82R0EIM+gvhyC/36NWQHtsvZ3PHN3IYFxbShi
K1RhQhvoHXidte2bPrPNjbCJki8rpaXdjx43vBybBbi0dy4nMEsscrIW1Q6eP2Wg
K/N8ypVTzMZIHf6bpq1OReHOcVhcPNvv/7WDZFl5p3bVX6vyt0ho97YzB0LXWHq6
lf33YizsCVUgaCyuwZCk2VhpHD3TuxDmeBZe2hagjEkOVPz3u4aQ3ymovF2fwO5a
WpMWq72KRAFQ14eTQ1hZw1T1tFvaVBO3avOMFtfSYWzprlWYEQZfFmBHtJDl2EPd
3+YObOmYNkCU1gqofoa9r6PljtpL1haV3D4ecvHM3XHhoK5GXG2MSt2JqBFeLGTq
C0XfhaWdbEuy6YtqXqpEylPumtNl8akYQMDlbNoI53f/GxC3rndQ0SFhVnODxcHH
7Ud3bai1WvvbPLyUTDHSVQRZnhGiYxtXZYtrKIttVmSFe9U+H6f4LGpB4YbhkhVf
XkbR+HqI7ADPpeh/vZdsZIsgEK2JBlAjD2oaapAzJ37jU4NIEG0=
=hUiA
-----END PGP SIGNATURE-----

--Apple-Mail=_0BD26E8D-F72B-4EC4-8BA0-4B8B88E49BEE--
