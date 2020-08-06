Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5E23DDBB
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgHFROE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 13:14:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgHFRNq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Aug 2020 13:13:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0C25B596;
        Thu,  6 Aug 2020 14:20:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BFD0F1E12C9; Thu,  6 Aug 2020 16:20:29 +0200 (CEST)
Date:   Thu, 6 Aug 2020 16:20:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@hikvision.com>
Cc:     "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] jbd2: fix descriptor block checksum failed after format
 with lazy_journal_init=1
Message-ID: <20200806142029.GC1313@quack2.suse.cz>
References: <1a15c069e2a54d6caeceb6fb2ea6eafc@hikvision.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a15c069e2a54d6caeceb6fb2ea6eafc@hikvision.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 03-08-20 02:25:45, 常凤楠 wrote:
> We encountered a file system crash, it's quite easy to reproduces when format with lazy_journal_init=1, the dmesg follwed:
> [    2.366962] JBD2: Invalid checksum recovering block 5 in log
> [    2.372680] JBD2: recovery failed
> [    2.376015] EXT4-fs (mmcblk2p1): error loading journal
> 
> It's because of descriptor block checksum failed, We tested on linux-4.19.200 and linux-5.7.9 with e2fsprogs-1.45.6, and both failed.
> We found it only happened in format with lazy_journal_init=1, and the first mount time is a short time.
> After the analysis of jbd2, We think it's due to jbd2's super block just show first transaction id, but didn't show the nums of transaction.
> 
> if you format with lazy_journal_init=1 first time, after mount a short time, you reboot machine, the layout of jbd2 may be like this:
> 
> journal Superblock |descriptor_block | data_blocks | commmit_block | descriptor_block | data_blocks | commmit_block |  [more transactions...
> ---------------------|--------------------- transaction 1   --------------|---------------   transaction 2   -----------------|
> 
> and after reboot, you format with lazy_journal_init=1 second time, after mount a short time, you reboot machine again, the layout of jbd2 may be like this:
> 
> journal Superblock |descriptor_block | data_blocks|  commmit_block | descriptor_block |  data_blocks| commmit_block| [more transactions...
> ---------------------|----------------   transaction 1   -----------------|
> 
> and then you mount filesystem again, when jbd2 start recovery, it will think there is more transactions after transaction 1, and when check transaction 2, since the journal csum
> seed has changed, it will definitely fail.

Thanks for the report and the detailed analysis of the problem! I was
thinking how we could cleanly fix this since I don't quite like your
solution of comparing commit times - that seems rather fragile. In the end
I'd probably fix the problem in e2fsprogs:

Change mke2fs so that even with lazy_journal_init=1, it would zero-out
the first journal block after the superblock. That will be enough to stop
confusing journal recovery code with stale journal data but it will keep
reporting errors if the journal checksum mismatches.

What do people think?

								Honza

> You can reproduce with this simple script:
> 
>     #!/bin/sh
>     mount /dev/nvme0n1 /tmp
>     if [ "$?" != "0" ] ; then
>        echo "mount model failed"
>         exit 1
>     fi
>     file=/tmp/flag_file
>     if [ ! -f $file ]; then
>         echo "do not format............."
>         echo $file
>         #you may need to modify this time range, must be less than the time used by the ext4lazyinit thread
>         t=$((( RANDOM % 8 ) + 5 ))
>         echo $t
>         touch $file
>         dd if=/dev/zero of=/tmp/test bs=1M count=$t
>         sleep $t
>         reboot -n -f
>         exit 0
>     else
>         echo "do format............."
>         umount /tmp
>         mkfs.ext4 -F /dev/nvme0n1 -E lazy_journal_init=1
>         sync
>         reboot -n -f
>         exit 0
>     fi
> 
> We have an idea,  When jbd2 encountered a descriptor block checksum error during recovery, We check the commit time and compare it with the commit time of the previous transaction,
> if it's smaller than previous, We think it's not belong to same journal, then end this recovery, and return with success, otherwise return with failed just like before.
> 
> This is the patch, diff from linux-5.7.9:
> 
> 
> --- fs/jbd2/recovery.c.orig      2020-07-16 14:13:36.000000000 +0800
> +++ fs/jbd2/recovery.c   2020-07-21 10:00:46.828449500 +0800
> @@ -412,7 +412,27 @@ static int jbd2_block_tag_csum_verify(jo
>      else
>             return tag->t_checksum == cpu_to_be16(csum32);
> }
> +/*
> + * We check the commit time and compare it with the commit time of the previous transaction,
> + * if it's smaller than previous, We think it's not belong to same journal.
> + */
> +static int is_same_journal(journal_t *journal,struct buffer_head *bh, unsigned long blocknr, __u64 last_commit_sec)
> +{
> +     int commit_block_nr = blocknr + count_tags(journal, bh) + 1;
> +     struct buffer_head *  nbh;
> +
> +     int err = jread(&nbh, journal, commit_block_nr);
> +     if (err)
> +            return 1;
> +     struct commit_header *cbh = (struct commit_header *)nbh->b_data;
> +     __u64 commit_sec = be64_to_cpu(cbh->h_commit_sec);
> +
> +     if(commit_sec < last_commit_sec)
> +            return 0;
> +     else
> +            return 1;
> +}
> static int do_one_pass(journal_t *journal,
>                    struct recovery_info *info, enum passtype pass)
> {
> @@ -426,6 +446,7 @@ static int do_one_pass(journal_t *journa
>      int                 blocktype;
>      int                 tag_bytes = journal_tag_bytes(journal);
>      __u32                   crc32_sum = ~0; /* Transactional Checksums */
> +     __u64            last_commit_sec = 0;
>      int                 descr_csum_size = 0;
>      int                 block_error = 0;
> @@ -520,12 +541,22 @@ static int do_one_pass(journal_t *journa
>                    if (descr_csum_size > 0 &&
>                        !jbd2_descriptor_block_csum_verify(journal,
>                                                       bh->b_data)) {
> -                           printk(KERN_ERR "JBD2: Invalid checksum "
> +                          if(is_same_journal(journal,bh,next_log_block-1,last_commit_sec)) {
> +                                 printk(KERN_ERR "JBD2: Invalid checksum "
>                                  "recovering block %lu in log\n",
>                                  next_log_block);
> -                           err = -EFSBADCRC;
> -                           brelse(bh);
> -                           goto failed;
> +                                 err = -EFSBADCRC;
> +                                 brelse(bh);
> +                                 goto failed;
> +                          } else {
> +                                 /*if it's not belong to same journal, just end this recovery, return with success*/
> +                                 printk(KERN_ERR "JBD2: Invalid checksum "
> +                                 "found in block %lu in log, but not same journal %d\n",
> +                                 next_log_block,next_commit_ID);
> +                                 err = 0;
> +                                 brelse(bh);
> +                                 goto done;
> +                          }
>                    }
>                     /* If it is a valid descriptor block, replay it
> @@ -688,11 +719,15 @@ static int do_one_pass(journal_t *journa
>                     * are present verify them in PASS_SCAN; else not
>                     * much to do other than move on to the next sequence
>                     * number. */
> +                   if(pass == PASS_SCAN) {
> +                          struct commit_header *cbh =
> +                                 (struct commit_header *)bh->b_data;
> +                          last_commit_sec = be64_to_cpu(cbh->h_commit_sec);
> +                   }
>                    if (pass == PASS_SCAN &&
>                        jbd2_has_feature_checksum(journal)) {
>                           int chksum_err, chksum_seen;
> -                           struct commit_header *cbh =
> -                                  (struct commit_header *)bh->b_data;
> +
>                           unsigned found_chksum =
>                                  be32_to_cpu(cbh->h_chksum[0]);
> 
> 
> ________________________________
> 
> CONFIDENTIALITY NOTICE: This electronic message is intended to be viewed only by the individual or entity to whom it is addressed. It may contain information that is privileged, confidential and exempt from disclosure under applicable law. Any dissemination, distribution or copying of this communication is strictly prohibited without our prior permission. If the reader of this message is not the intended recipient, or the employee or agent responsible for delivering the message to the intended recipient, or if you have received this communication in error, please notify us immediately by return e-mail and delete the original message and any copies of it from your computer system. For further information about Hikvision company. please see our website at www.hikvision.com<http://www.hikvision.com>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
