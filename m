Return-Path: <linux-ext4+bounces-383-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3FD80D472
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Dec 2023 18:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5215D2820E9
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Dec 2023 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6304EB34;
	Mon, 11 Dec 2023 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mf5cRpVZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vlQqGyRm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mf5cRpVZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vlQqGyRm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA81E95;
	Mon, 11 Dec 2023 09:49:54 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BBA11FBA7;
	Mon, 11 Dec 2023 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702316993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkLrrI1gmexDEyXqv7RkIgYzgnlJqhMidUtAhq81i5Y=;
	b=Mf5cRpVZ5GM9ghuslV9oPpAafIYRuwI93WQVJf4B+qgNuAAF9Gzv6/kfc0QuDlTcTEuCRa
	c2mUzap33UGntnsg1iTuoM9srE/jJQ4sTOhS/OoOMBdlRulDMx3YTg7u/+klnrYExuMFzz
	1+qxUPTP/6GEAc1yB721gmcPZyGGao4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702316993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkLrrI1gmexDEyXqv7RkIgYzgnlJqhMidUtAhq81i5Y=;
	b=vlQqGyRmzMB4lY+KXhdWBUUhIgZZkJ41LWZtGOL3JvD4qcgQHLfeKzxUlfA2fPt9TIfs/D
	ML2z9OGUgqEMsaBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702316993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkLrrI1gmexDEyXqv7RkIgYzgnlJqhMidUtAhq81i5Y=;
	b=Mf5cRpVZ5GM9ghuslV9oPpAafIYRuwI93WQVJf4B+qgNuAAF9Gzv6/kfc0QuDlTcTEuCRa
	c2mUzap33UGntnsg1iTuoM9srE/jJQ4sTOhS/OoOMBdlRulDMx3YTg7u/+klnrYExuMFzz
	1+qxUPTP/6GEAc1yB721gmcPZyGGao4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702316993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkLrrI1gmexDEyXqv7RkIgYzgnlJqhMidUtAhq81i5Y=;
	b=vlQqGyRmzMB4lY+KXhdWBUUhIgZZkJ41LWZtGOL3JvD4qcgQHLfeKzxUlfA2fPt9TIfs/D
	ML2z9OGUgqEMsaBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B10D13A6B;
	Mon, 11 Dec 2023 17:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Q9d8CsFLd2VEIwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 17:49:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0B16A07E3; Mon, 11 Dec 2023 18:49:52 +0100 (CET)
Date: Mon, 11 Dec 2023 18:49:52 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, willy@infradead.org,
	akpm@linux-foundation.org, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <20231211174952.mdwyh7fmu7rjzfn3@quack3>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <20231204144106.fk4yxc422gppifsz@quack3>
 <70b274c2-c19a-103b-4cf4-b106c698ddcc@huawei.com>
 <20231206193757.k5cppxqew6zjmbx3@quack3>
 <63b1e234-e005-a62b-82c5-fa7acf26d53a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b1e234-e005-a62b-82c5-fa7acf26d53a@huawei.com>
X-Spam-Score: 5.80
X-Spamd-Result: default: False [5.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL9mptuuj8f371ag1nhgyt86ac)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,kvack.org,vger.kernel.org,mit.edu,dilger.ca,infradead.org,linux-foundation.org,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
X-Spam-Score: 5.80
Authentication-Results: smtp-out2.suse.de;
	none

On Thu 07-12-23 22:15:55, Baokun Li wrote:
> On 2023/12/7 3:37, Jan Kara wrote:
> > On Tue 05-12-23 20:50:30, Baokun Li wrote:
> > > On 2023/12/4 22:41, Jan Kara wrote:
> > > > On Mon 04-12-23 21:50:18, Baokun Li wrote:
> > > > > On 2023/12/4 20:11, Jan Kara wrote:
> > > > > The problem is with a one-master-twoslave MYSQL database with three
> > > > > physical machines, and using sysbench pressure testing on each of the
> > > > > three machines, the problem occurs about once every two to three hours.
> > > > > 
> > > > > The problem is with the relay log file, and when the problem occurs, the
> > > > > middle dozens of bytes of the file are read as all zeros, while the data on
> > > > > disk is not. This is a journal-like file where a write process gets the data
> > > > > from
> > > > > the master node and writes it locally, and another replay process reads the
> > > > > file and performs the replay operation accordingly (some SQL statements).
> > > > > The problem is that when replaying, it finds that the data read is
> > > > > corrupted,
> > > > > not valid SQL data, while the data on disk is normal.
> > > > > 
> > > > > It's not confirmed that buffered reads vs direct IO writes is actually
> > > > > causing this issue, but this is the only scenario that we can reproduce
> > > > > with our local simplified scripts. Also, after merging in patch 1, the
> > > > > MYSQL pressure test scenario has now been tested for 5 days and has not
> > > > > been reproduced.
> > > > > 
> > > > > I'll double-check the problem scenario, although buffered reads with
> > > > > buffered writes doesn't seem to have this problem.
> > > > Yeah, from what you write it seems that the replay code is using buffered
> > > > reads on the journal file. I guess you could confirm that with a bit of
> > > > kernel tracing but the symptoms look pretty convincing. Did you try talking
> > > > to MYSQL guys about why they are doing this?
> > > The operations performed on the relay log file are buffered reads and
> > > writes, which I confirmed with the following bpftrace script:
> > > ```
> > > #include <linux/fs.h>
> > > #include <linux/path.h>
> > > #include <linux/dcache.h>
> > > 
> > > kprobe:generic_file_buffered_read /!strncmp(str(((struct kiocb
> > > *)arg0)->ki_filp->f_path.dentry->d_name.name), "relay", 5)/ {
> > >      printf("read path: %s\n", str(((struct kiocb
> > > *)arg0)->ki_filp->f_path.dentry->d_name.name));
> > > }
> > > 
> > > kprobe:ext4_buffered_write_iter /!strncmp(str(((struct kiocb
> > > *)arg0)->ki_filp->f_path.dentry->d_name.name), "relay", 5)/ {
> > >      printf("write path: %s\n", str(((struct kiocb
> > > *)arg0)->ki_filp->f_path.dentry->d_name.name));
> > > }
> > > ```
> > > I suspect there are DIO writes causing the problem, but I haven't caught
> > > any DIO writes to such files via bpftrace.
> > Interesting. Not sure how your partially zeroed-out buffers could happen
> > with fully buffered IO.
> > 
> After looking at the code again and again, the following concurrency
> seems to bypass the memory barrier:
> 
> ext4_buffered_write_iter
>  generic_perform_write
>   copy_page_from_iter_atomic
>   ext4_da_write_end
>    ext4_da_do_write_end
>     block_write_end
>      __block_commit_write
>       folio_mark_uptodate
>        smp_wmb()
>        set_bit(PG_uptodate, folio_flags(folio, 0))
>     i_size_write(inode, pos + copied)
>     // write isize 2048
>     unlock_page(page)
> 
> ext4_file_read_iter
>  generic_file_read_iter
>   filemap_read
>    filemap_get_pages
>     filemap_get_read_batch
>     folio_test_uptodate(folio)
>      ret = test_bit(PG_uptodate, folio_flags(folio, 0));
>      if (ret)
>       smp_rmb();
>       // The read barrier here ensures
>       // that data 0-2048 in the page is synchronized.
>                            ext4_buffered_write_iter
>                             generic_perform_write
>                              copy_page_from_iter_atomic
>                              ext4_da_write_end
>                               ext4_da_do_write_end
>                                block_write_end
>                                 __block_commit_write
>                                  folio_mark_uptodate
>                                   smp_wmb()
>                                   set_bit(PG_uptodate, folio_flags(folio,
> 0))
>                                i_size_write(inode, pos + copied)
>                                // write isize 4096
>                                unlock_page(page)
>    // read isize 4096
>    isize = i_size_read(inode)
>    // But there is no read barrier here,
>    // so the data in the 2048-4096 range
>    // may not be synchronized yet !!!
>    copy_page_to_iter()
>    // copyout 4096
> 
> In the concurrency above, we read the updated i_size, but there is
> no read barrier to ensure that the data in the page is the same as
> the i_size at this point. Therefore, we may copy the unsynchronized
> page out. Is it normal for us to read zero-filled data in this case?

Indeed, I have checked and filemap_read() (but this dates back even to old
do_generic_file_read() code) indeed does copy data only after checking
uptodate flag and then sampling i_size so we may be copying state in the
middle of the racing write and indeed there is nothing which would prevent
prefetching page data before fetching inode size. I agree this is kind of
nasty so I think adding a read barrier between i_size_read() and
copy_page_to_iter() makes sense. Does it fix your issue with MYSQL?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

