Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9149687A6F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406596AbfHIMrU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 08:47:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfHIMrU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Aug 2019 08:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC5C4AF79;
        Fri,  9 Aug 2019 12:47:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 127F11E46DD; Fri,  9 Aug 2019 14:38:46 +0200 (CEST)
Date:   Fri, 9 Aug 2019 14:38:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     kbuild test robot <lkp@intel.com>
Cc:     Jan Kara <jack@suse.cz>, kbuild-all@01.org,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 6/7] jbd2: Make state lock a spinlock
Message-ID: <20190809123846.GC17568@quack2.suse.cz>
References: <20190802151356.777-7-jack@suse.cz>
 <201908072002.2367CBNe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908072002.2367CBNe%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-08-19 20:57:29, kbuild test robot wrote:
> Hi Jan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc3 next-20190807]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Yeah, missing include of linux/spinlock.h. I'll send V2 of the series.

								Honza

> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Kara/jbd2-Bit-spinlock-conversions/20190804-170656
> config: i386-randconfig-h002-201931 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:0:0:
> >> include/linux/journal-head.h:29:2: error: unknown type name 'spinlock_t'
>      spinlock_t b_state_lock;
>      ^~~~~~~~~~
> 
> vim +/spinlock_t +29 include/linux/journal-head.h
> 
>     19	
>     20	struct journal_head {
>     21		/*
>     22		 * Points back to our buffer_head. [jbd_lock_bh_journal_head()]
>     23		 */
>     24		struct buffer_head *b_bh;
>     25	
>     26		/*
>     27		 * Protect the buffer head state
>     28		 */
>   > 29		spinlock_t b_state_lock;
>     30	
>     31		/*
>     32		 * Reference count - see description in journal.c
>     33		 * [jbd_lock_bh_journal_head()]
>     34		 */
>     35		int b_jcount;
>     36	
>     37		/*
>     38		 * Journalling list for this buffer [b_state_lock]
>     39		 * NOTE: We *cannot* combine this with b_modified into a bitfield
>     40		 * as gcc would then (which the C standard allows but which is
>     41		 * very unuseful) make 64-bit accesses to the bitfield and clobber
>     42		 * b_jcount if its update races with bitfield modification.
>     43		 */
>     44		unsigned b_jlist;
>     45	
>     46		/*
>     47		 * This flag signals the buffer has been modified by
>     48		 * the currently running transaction
>     49		 * [b_state_lock]
>     50		 */
>     51		unsigned b_modified;
>     52	
>     53		/*
>     54		 * Copy of the buffer data frozen for writing to the log.
>     55		 * [b_state_lock]
>     56		 */
>     57		char *b_frozen_data;
>     58	
>     59		/*
>     60		 * Pointer to a saved copy of the buffer containing no uncommitted
>     61		 * deallocation references, so that allocations can avoid overwriting
>     62		 * uncommitted deletes. [b_state_lock]
>     63		 */
>     64		char *b_committed_data;
>     65	
>     66		/*
>     67		 * Pointer to the compound transaction which owns this buffer's
>     68		 * metadata: either the running transaction or the committing
>     69		 * transaction (if there is one).  Only applies to buffers on a
>     70		 * transaction's data or metadata journaling list.
>     71		 * [j_list_lock] [b_state_lock]
>     72		 * Either of these locks is enough for reading, both are needed for
>     73		 * changes.
>     74		 */
>     75		transaction_t *b_transaction;
>     76	
>     77		/*
>     78		 * Pointer to the running compound transaction which is currently
>     79		 * modifying the buffer's metadata, if there was already a transaction
>     80		 * committing it when the new transaction touched it.
>     81		 * [t_list_lock] [b_state_lock]
>     82		 */
>     83		transaction_t *b_next_transaction;
>     84	
>     85		/*
>     86		 * Doubly-linked list of buffers on a transaction's data, metadata or
>     87		 * forget queue. [t_list_lock] [b_state_lock]
>     88		 */
>     89		struct journal_head *b_tnext, *b_tprev;
>     90	
>     91		/*
>     92		 * Pointer to the compound transaction against which this buffer
>     93		 * is checkpointed.  Only dirty buffers can be checkpointed.
>     94		 * [j_list_lock]
>     95		 */
>     96		transaction_t *b_cp_transaction;
>     97	
>     98		/*
>     99		 * Doubly-linked list of buffers still remaining to be flushed
>    100		 * before an old transaction can be checkpointed.
>    101		 * [j_list_lock]
>    102		 */
>    103		struct journal_head *b_cpnext, *b_cpprev;
>    104	
>    105		/* Trigger type */
>    106		struct jbd2_buffer_trigger_type *b_triggers;
>    107	
>    108		/* Trigger type for the committing transaction's frozen data */
>    109		struct jbd2_buffer_trigger_type *b_frozen_triggers;
>    110	};
>    111	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
