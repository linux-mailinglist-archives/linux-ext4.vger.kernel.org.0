Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8B26DA4F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIQLdx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 07:33:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQLds (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Sep 2020 07:33:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDE1AAD07;
        Thu, 17 Sep 2020 10:45:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 80F121E12E1; Thu, 17 Sep 2020 12:44:40 +0200 (CEST)
Date:   Thu, 17 Sep 2020 12:44:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@hikvision.com>
Cc:     Jan Kara <jack@suse.cz>, changfengnan <changfengnan@qq.com>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] jbd2: avoid
 transaction reuse after reformatting
Message-ID: <20200917104440.GC16097@quack2.suse.cz>
References: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
 <20200911100603.GA26589@quack2.suse.cz>
 <2fa90e4995e0403f91f3290207618f35@hikvision.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fa90e4995e0403f91f3290207618f35@hikvision.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 14-09-20 11:50:04, 常凤楠 wrote:
> Thank you for your review comments, there are indeed some problems.
> Let's discuss the function problems first, and I will modify the code style later.
> 1. About add two members in struct recovery_info, it can be just local variables in do_one_pass().
> 2. About is_same_journal(), I indded I did not consider the situation of serverl
> descriptor blocks in a transaction,I have moved the work of is_same_journal() outside to do it as you suggest.
> 3. You suggest add jbd2_has_feature_checksum() judge in PASS_SCAN, But jbd2_has_feature_checksum() only check checksum
> VER1, not include VER2 and VER3. And I don't understand why lazy journal init cannot happen without journal checksumming being used,
> so i didn't add jbd2_has_feature_checksum() for now.
> 4. The pass == PASS_REVOKE case, this is a low-level error, my previous test did not cover it. I have changed it now.

Please, send the patch as an attachment if your mailer is mangling
whitespace like this. The patch is very hard to read in this form. Thanks!

								Honza

> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a4967b27ffb6..f7702e14077f 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -417,7 +417,7 @@ static int do_one_pass(journal_t *journal,
>  struct recovery_info *info, enum passtype pass)
>  {
>  unsigned intfirst_commit_ID, next_commit_ID;
> -unsigned longnext_log_block;
> +unsigned longnext_log_block, ri_commit_block = 0;
>  interr, success = 0;
>  journal_superblock_t *sb;
>  journal_header_t *tmp;
> @@ -428,7 +428,9 @@ static int do_one_pass(journal_t *journal,
>  __u32crc32_sum = ~0; /* Transactional Checksums */
>  intdescr_csum_size = 0;
>  intblock_error = 0;
> -
> +boolneed_check_commit_time = false;
> +__be64last_trans_commit_time;
> +
>  /*
>   * First thing is to establish what we expect to find in the log
>   * (in terms of transaction IDs), and where (in terms of log
> @@ -514,18 +516,18 @@ static int do_one_pass(journal_t *journal,
>  switch(blocktype) {
>  case JBD2_DESCRIPTOR_BLOCK:
>  /* Verify checksum first */
> +if(pass == PASS_SCAN)
> +ri_commit_block = 0;
> +
>  if (jbd2_journal_has_csum_v2or3(journal))
>  descr_csum_size =
>  sizeof(struct jbd2_journal_block_tail);
>  if (descr_csum_size > 0 &&
>      !jbd2_descriptor_block_csum_verify(journal,
>         bh->b_data)) {
> -printk(KERN_ERR "JBD2: Invalid checksum "
> -       "recovering block %lu in log\n",
> -       next_log_block);
> -err = -EFSBADCRC;
> -brelse(bh);
> -goto failed;
> +need_check_commit_time = true;
> +jbd_debug(1, "invalid descriptor block found in %lu, continue recovery first.\n",next_log_block);
> +
>  }
> 
>  /* If it is a valid descriptor block, replay it
> @@ -535,6 +537,7 @@ static int do_one_pass(journal_t *journal,
>  if (pass != PASS_REPLAY) {
>  if (pass == PASS_SCAN &&
>      jbd2_has_feature_checksum(journal) &&
> +    !need_check_commit_time &&
>      !info->end_transaction) {
>  if (calc_chksums(journal, bh,
>  &next_log_block,
> @@ -688,6 +691,36 @@ static int do_one_pass(journal_t *journal,
>   * are present verify them in PASS_SCAN; else not
>   * much to do other than move on to the next sequence
>   * number. */
> +if(pass == PASS_SCAN) {
> +struct commit_header *cbh =
> +(struct commit_header *)bh->b_data;
> +if(need_check_commit_time) {
> +__be64 commit_time = be64_to_cpu(cbh->h_commit_sec);
> +if(commit_time >= last_trans_commit_time) {
> +printk(KERN_ERR "JBD2: Invalid checksum found in log, %d\n",
> +next_commit_ID);
> +err = -EFSBADCRC;
> +brelse(bh);
> +goto failed;
> +}
> +else
> +{
> +/*it's not belong to same journal, just end this recovery with success*/
> +jbd_debug(1, "JBD2: Invalid checksum found in block in log, but not same journal %d\n",
> +next_commit_ID);
> +err = 0;
> +brelse(bh);
> +goto done;
> +}
> +}
> +if(ri_commit_block) {
> +jbd_debug(1, "invalid commit block found in %lu, stop here.\n",next_log_block);
> +brelse(bh);
> +goto done;
> +}
> +ri_commit_block = next_log_block;
> +last_trans_commit_time = be64_to_cpu(cbh->h_commit_sec);
> +}
>  if (pass == PASS_SCAN &&
>      jbd2_has_feature_checksum(journal)) {
>  int chksum_err, chksum_seen;
> @@ -755,6 +788,12 @@ static int do_one_pass(journal_t *journal,
>  continue;
> 
>  case JBD2_REVOKE_BLOCK:
> +if (pass == PASS_SCAN &&
> +ri_commit_block) {
> +jbd_debug(1, "invalid revoke block found in %lu, stop here.\n",next_log_block);
> +brelse(bh);
> +goto done;
> +}
>  /* If we aren't in the REVOKE pass, then we can
>   * just skip over this block. */
>  if (pass != PASS_REVOKE) {
> 
> -----邮件原件-----
> 发件人: Jan Kara <jack@suse.cz>
> 发送时间: 2020年9月11日 18:06
> 收件人: changfengnan <changfengnan@qq.com>
> 抄送: adilger@dilger.ca; darrick.wong@oracle.com; jack@suse.com; linux-ext4@vger.kernel.org; tytso@mit.edu; 常凤楠 <changfengnan@hikvision.com>
> 主题: Re: [PATCH] jbd2: avoid transaction reuse after reformatting
> 
> On Thu 10-09-20 19:55:21, changfengnan wrote:
> > From: Fengnan Chang <changfengnan@hikvision.com>
> >
> > When format ext4 with lazy_journal_init=1, the previous transaction is
> > still on disk, it is possible that the previous transaction will be
> > used again during jbd2 recovery.Because the seed is changed, the CRC
> > check will fail.
> >
> > Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>
> 
> Thanks for the patch! I have a few functional comments below, also on a coding style side your patch contains lines a lot longer than 80 characters. Although that is not a strict requirement anymore it is still prefered that lines are wrapped to fit 80 columns to make code more easily readable...
> 
> > ---
> >  fs/jbd2/recovery.c | 60
> > +++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 54 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c index
> > a4967b27ffb6..8a6bc322a06d 100644
> > --- a/fs/jbd2/recovery.c
> > +++ b/fs/jbd2/recovery.c
> > @@ -33,6 +33,8 @@ struct recovery_info
> >  intnr_replays;
> >  intnr_revokes;
> >  intnr_revoke_hits;
> > +unsigned long  ri_commit_block;
> > +__be64  last_trans_commit_time;
> 
> Is there a need for these in recovery_info? They are needed only in PASS_SCAN AFAICT so they can be as well just local variables in do_one_pass()...
> 
> >  };
> >
> >  enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY}; @@ -412,7
> > +414,27 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
> >  else
> >  return tag->t_checksum == cpu_to_be16(csum32);  }
> > +/*
> > + * We check the commit time and compare it with the commit time of
> > + * the previous transaction, if it's smaller than previous,
> > + * We think it's not belong to same journal.
> > + */
> > +static bool is_same_journal(journal_t *journal, struct buffer_head
> > +*bh, unsigned long blocknr, __u64 last_commit_sec) {
> > +unsigned long commit_block = blocknr + count_tags(journal, bh) + 1;
> > +struct buffer_head *nbh;
> > +struct commit_header *cbh;
> > +__u64commit_sec;
> > +int err = jread(&nbh, journal, commit_block);
> 
> So there are two flaws in this logic. First, the computed commit_block may be beyond end of the journal. You need to wrap the computed value using
> wrap() macro. Second, you seem to assume that each transaction has only a single descriptor block. That is definitely not true. There can be arbitrary number (well, up to a maximum transaction size which depends on the total size of the journal) of descriptor blocks in a transaction before a commit block. So to locate commit block, you need to read the block, check its type (it can be another descriptor block, revoke block, or commit
> block) and then decide accordingly what to do. And you have to be rather careful when going through the journal like this because you cannot check checksums and blocks can be containing arbitrary garbage. Probably the cleanest way how to implement this would be to use the scanning loop in do_one_pass(), just indicate in some state variable that "we are now searching for next commit block to determine whether a checksum failure is due to lazy init or storage error". In this state we will continue PASS_SCAN, just not checking checksums anymore until we find a commit block or reach end of journal and then based on what we found decide whether to report checksum error or just silently end PASS_SCAN pass...
> 
> >
> > +if (err)
> > +return true;
> > +
> > +cbh = (struct commit_header *)nbh->b_data;
> > +commit_sec = be64_to_cpu(cbh->h_commit_sec);
> > +
> > +return commit_sec >= last_commit_sec; }
> >  static int do_one_pass(journal_t *journal,
> >  struct recovery_info *info, enum passtype pass)  { @@ -514,18
> > +536,29 @@ static int do_one_pass(journal_t *journal,
> >  switch(blocktype) {
> >  case JBD2_DESCRIPTOR_BLOCK:
> >  /* Verify checksum first */
> > +if (pass == PASS_SCAN)
> > +info->ri_commit_block = 0;
> > +
> >  if (jbd2_journal_has_csum_v2or3(journal))
> >  descr_csum_size =
> >  sizeof(struct jbd2_journal_block_tail);
> >  if (descr_csum_size > 0 &&
> >      !jbd2_descriptor_block_csum_verify(journal,
> >         bh->b_data)) {
> > -printk(KERN_ERR "JBD2: Invalid checksum "
> > -       "recovering block %lu in log\n",
> > +if (is_same_journal(journal, bh, next_log_block-1, info->last_trans_commit_time)) {
> > +printk(KERN_ERR "JBD2: Invalid checksum recovering block %lu in
> > +log\n",
> >         next_log_block);
> > -err = -EFSBADCRC;
> > -brelse(bh);
> > -goto failed;
> > +err = -EFSBADCRC;
> > +brelse(bh);
> > +goto failed;
> > +} else {
> > +/*it's not belong to same journal, just end this recovery with success*/
> > +jbd_debug(1, "JBD2: Invalid checksum found in block %lu in log, but not same journal %d\n",
> > +       next_log_block, next_commit_ID);
> > +err = 0;
> > +brelse(bh);
> > +goto done;
> > +}
> >  }
> >
> >  /* If it is a valid descriptor block, replay it @@ -688,6 +721,17
> > @@ static int do_one_pass(journal_t *journal,
> >   * are present verify them in PASS_SCAN; else not
> >   * much to do other than move on to the next sequence
> >   * number. */
> > +if (pass == PASS_SCAN) {
> > +struct commit_header *cbh =
> > +(struct commit_header *)bh->b_data;
> > +if (info->ri_commit_block) {
> > +jbd_debug(1, "invalid commit block found in %lu, stop here.\n", next_log_block);
> > +brelse(bh);
> > +goto done;
> > +}
> > +info->ri_commit_block = next_log_block;
> > +info->last_trans_commit_time = be64_to_cpu(cbh->h_commit_sec);
> > +}
> 
> I don't think you need to update ri_commit_block and last_trans_commit_time if we are not checking checksums (lazy journal init cannot happen without journal checksumming being used). So I'd just move this into the
> 
>                         if (pass == PASS_SCAN &&
>                             jbd2_has_feature_checksum(journal)) {
> 
> branch below. Also we could validate the commit block the same way (using
> timestamp) as the descriptor block. Then you will not need the 'ri_commit_block' logic and things will be nicely uniform...
> 
> >  if (pass == PASS_SCAN &&
> >      jbd2_has_feature_checksum(journal)) {
> >  int chksum_err, chksum_seen;
> > @@ -761,7 +805,11 @@ static int do_one_pass(journal_t *journal,
> >  brelse(bh);
> >  continue;
> >  }
> > -
> > +if (pass != PASS_SCAN && info->ri_commit_block) {
> 
> I don't understand this. We get here only if "pass == PASS_REVOKE" so "pass != PASS_SCAN" is guaranteed to be true. But also info->ri_commit_block will likely be != 0 from the previous PASS_SCAN pass. So this will always skip revoke block handling?
> 
> > +jbd_debug(1, "invalid revoke block found in %lu, stop here.\n", next_log_block);
> > +brelse(bh);
> > +goto done;
> > +}
> >  err = scan_revoke_records(journal, bh,
> >    next_commit_ID, info);
> >  brelse(bh);
> 
> Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
> ________________________________
> 
> CONFIDENTIALITY NOTICE: This electronic message is intended to be viewed only by the individual or entity to whom it is addressed. It may contain information that is privileged, confidential and exempt from disclosure under applicable law. Any dissemination, distribution or copying of this communication is strictly prohibited without our prior permission. If the reader of this message is not the intended recipient, or the employee or agent responsible for delivering the message to the intended recipient, or if you have received this communication in error, please notify us immediately by return e-mail and delete the original message and any copies of it from your computer system. For further information about Hikvision company. please see our website at www.hikvision.com<http://www.hikvision.com>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
