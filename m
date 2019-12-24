Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2693129C70
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 02:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLXBdU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 20:33:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727034AbfLXBdU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Dec 2019 20:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577151199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWxN0VbsW7XFIgGXfEH7ot0HMoaDI1kn38g+Gr1vwVM=;
        b=RSpgKedOuLqS74+S+ZDI7DQlSew2Mgi2oFY27qdCxt2XobvgaPbkqnD8NfNbmDDX7M80au
        iHA+Qqu3Wur+v50dcAufAwug0c3OJKoZ1gJfkkB6yVeUAyFXZ3gA/PL5ztDJcSp1wFrdoK
        OMYi4w+UVFdvd06bh8nOfcWsxkP7VdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-EK5IlWkrOh-MNEN1GJKK1w-1; Mon, 23 Dec 2019 20:33:10 -0500
X-MC-Unique: EK5IlWkrOh-MNEN1GJKK1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E109418B5F69;
        Tue, 24 Dec 2019 01:33:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9407C805FF;
        Tue, 24 Dec 2019 01:32:45 +0000 (UTC)
Date:   Tue, 24 Dec 2019 09:32:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20191224013237.GB13083@ming.t460p>
References: <20191210080550.GA5699@ming.t460p>
 <20191211024137.GB61323@mit.edu>
 <20191211040058.GC6864@ming.t460p>
 <20191211160745.GA129186@mit.edu>
 <20191211213316.GA14983@ming.t460p>
 <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
 <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <fc6f73fc5f57ade8890b472d63c7f0bd559de538.camel@unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6f73fc5f57ade8890b472d63c7f0bd559de538.camel@unipv.it>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 23, 2019 at 03:02:35PM +0100, Andrea Vai wrote:
> Il giorno lun, 23/12/2019 alle 21.08 +0800, Ming Lei ha scritto:
> > On Mon, Dec 23, 2019 at 12:22:45PM +0100, Andrea Vai wrote:
> > > Il giorno mer, 18/12/2019 alle 17.48 +0800, Ming Lei ha scritto:
> > > > On Wed, Dec 18, 2019 at 09:25:02AM +0100, Andrea Vai wrote:
> > > > > Il giorno gio, 12/12/2019 alle 05.33 +0800, Ming Lei ha
> > scritto:
> > > > > > On Wed, Dec 11, 2019 at 11:07:45AM -0500, Theodore Y. Ts'o
> > > > wrote:
> > > > > > > On Wed, Dec 11, 2019 at 12:00:58PM +0800, Ming Lei wrote:
> > > > > > > > I didn't reproduce the issue in my test environment, and
> > > > follows
> > > > > > > > Andrea's test commands[1]:
> > > > > > > > 
> > > > > > > >   mount UUID=$uuid /mnt/pendrive 2>&1 |tee -a $logfile
> > > > > > > >   SECONDS=0
> > > > > > > >   cp $testfile /mnt/pendrive 2>&1 |tee -a $logfile
> > > > > > > >   umount /mnt/pendrive 2>&1 |tee -a $logfile
> > > > > > > > 
> > > > > > > > The 'cp' command supposes to open/close the file just
> > once,
> > > > > > however
> > > > > > > > ext4_release_file() & write pages is observed to run for
> > > > 4358
> > > > > > times
> > > > > > > > when executing the above 'cp' test.
> > > > > > > 
> > > > > > > Why are we sure the ext4_release_file() / _fput() is
> > coming
> > > > from
> > > > > > the
> > > > > > > cp command, as opposed to something else that might be
> > running
> > > > on
> > > > > > the
> > > > > > > system under test?  _fput() is called by the kernel when
> > the
> > > > last
> > > > > > 
> > > > > > Please see the log:
> > > > > > 
> > > > > > 
> > > > 
> > https://lore.kernel.org/linux-scsi/3af3666920e7d46f8f0c6d88612f143ffabc743c.camel@unipv.it/2-log_ming.zip
> > > > > > 
> > > > > > Which is collected by:
> > > > > > 
> > > > > > #!/bin/sh
> > > > > > MAJ=$1
> > > > > > MIN=$2
> > > > > > MAJ=$(( $MAJ << 20 ))
> > > > > > DEV=$(( $MAJ | $MIN ))
> > > > > > 
> > > > > > /usr/share/bcc/tools/trace -t -C \
> > > > > >     't:block:block_rq_issue (args->dev == '$DEV') "%s %d
> > %d",
> > > > args-
> > > > > > >rwbs, args->sector, args->nr_sector' \
> > > > > >     't:block:block_rq_insert (args->dev == '$DEV') "%s %d
> > %d",
> > > > args-
> > > > > > >rwbs, args->sector, args->nr_sector'
> > > > > > 
> > > > > > $MAJ:$MIN points to the USB storage disk.
> > > > > > 
> > > > > > From the above IO trace, there are two write paths, one is
> > from
> > > > cp,
> > > > > > another is from writeback wq.
> > > > > > 
> > > > > > The stackcount trace[1] is consistent with the IO trace log
> > > > since it
> > > > > > only shows two IO paths, that is why I concluded that the
> > write
> > > > done
> > > > > > via
> > > > > > ext4_release_file() is from 'cp'.
> > > > > > 
> > > > > > [1] 
> > > > > > 
> > > > 
> > https://lore.kernel.org/linux-scsi/320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it/2-log_ming_20191129_150609.zip
> > > > > > 
> > > > > > > reference to a struct file is released.  (Specifically, if
> > you
> > > > > > have a
> > > > > > > fd which is dup'ed, it's only when the last fd
> > corresponding
> > > > to
> > > > > > the
> > > > > > > struct file is closed, and the struct file is about to be
> > > > > > released,
> > > > > > > does the file system's f_ops->release function get
> > called.)
> > > > > > > 
> > > > > > > So the first question I'd ask is whether there is anything
> > > > else
> > > > > > going
> > > > > > > on the system, and whether the writes are happening to the
> > USB
> > > > > > thumb
> > > > > > > drive, or to some other storage device.  And if there is
> > > > something
> > > > > > > else which is writing to the pendrive, maybe that's why no
> > one
> > > > > > else
> > > > > > > has been able to reproduce the OP's complaint....
> > > > > > 
> > > > > > OK, we can ask Andrea to confirm that via the following
> > trace,
> > > > which
> > > > > > will add pid/comm info in the stack trace:
> > > > > > 
> > > > > > /usr/share/bcc/tools/stackcount
> > blk_mq_sched_request_inserted
> > > > > > 
> > > > > > Andrew, could you collect the above log again when running
> > > > new/bad
> > > > > > kernel for confirming if the write done by
> > ext4_release_file()
> > > > is
> > > > > > from
> > > > > > the 'cp' process?
> > > > > 
> > > > > You can find the stackcount log attached. It has been produced
> > by:
> > > > > 
> > > > > - /usr/share/bcc/tools/stackcount
> > blk_mq_sched_request_inserted >
> > > > trace.log
> > > > > - wait some seconds
> > > > > - run the test (1 copy trial), wait for the test to finish,
> > wait
> > > > some seconds
> > > > > - stop the trace (ctrl+C)
> > > > 
> > > > Thanks for collecting the log, looks your 'stackcount' doesn't
> > > > include
> > > > comm/pid info, seems there is difference between your bcc and
> > > > my bcc in fedora 30.
> > > > 
> > > > Could you collect above log again via the following command?
> > > > 
> > > > /usr/share/bcc/tools/stackcount -P -K t:block:block_rq_insert
> > > > 
> > > > which will show the comm/pid info.
> > > 
> > > ok, attached (trace_20191219.txt), the test (1 trial) took 3684
> > > seconds.
> > 
> > From the above trace:
> > 
> >   b'blk_mq_sched_request_inserted'
> >   b'blk_mq_sched_request_inserted'
> >   b'dd_insert_requests'
> >   b'blk_mq_sched_insert_requests'
> >   b'blk_mq_flush_plug_list'
> >   b'blk_flush_plug_list'
> >   b'io_schedule_prepare'
> >   b'io_schedule'
> >   b'rq_qos_wait'
> >   b'wbt_wait'
> >   b'__rq_qos_throttle'
> >   b'blk_mq_make_request'
> >   b'generic_make_request'
> >   b'submit_bio'
> >   b'ext4_io_submit'
> >   b'ext4_writepages'
> >   b'do_writepages'
> >   b'__filemap_fdatawrite_range'
> >   b'ext4_release_file'
> >   b'__fput'
> >   b'task_work_run'
> >   b'exit_to_usermode_loop'
> >   b'do_syscall_64'
> >   b'entry_SYSCALL_64_after_hwframe'
> >     b'cp' [19863]
> >     4400
> > 
> > So this write is clearly from 'cp' process, and it should be one
> > ext4 fs issue.
> > 
> > Ted, can you take a look at this issue?
> > 
> > > 
> > > > > I also tried the usual test with btrfs and xfs. Btrfs behavior
> > > > looks
> > > > > "good". xfs seems sometimes better, sometimes worse, I would
> > say.
> > > > I
> > > > > don't know if it matters, anyway you can also find the results
> > of
> > > > the
> > > > > two tests (100 trials each). Basically, btrfs is always
> > between 68
> > > > and
> > > > > 89 seconds, with a cyclicity (?) with "period=2 trials". xfs
> > looks
> > > > > almost always very good (63-65s), but sometimes "bad" (>300s).
> > > > 
> > > > If you are interested in digging into this one, the following
> > trace
> > > > should be helpful:
> > > > 
> > > > 
> > https://lore.kernel.org/linux-scsi/f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it/T/#m5aa008626e07913172ad40e1eb8e5f2ffd560fc6
> > > > 
> > > 
> > > Attached:
> > > - trace_xfs_20191223.txt (7 trials, then aborted while doing the
> > 8th),
> > > times to complete:
> > > 64s
> > > 63s
> > > 64s
> > > 833s
> > > 1105s
> > > 63s
> > > 64s
> > 
> > oops, looks we have to collect io insert trace with the following
> > bcc script
> > on xfs for confirming if there is similar issue with ext4, could you
> > run
> > it again on xfs? And only post the trace done in case of slow 'cp'.
> > 
> > 
> > #!/bin/sh
> > 
> > MAJ=$1
> > MIN=$2
> > MAJ=$(( $MAJ << 20 ))
> > DEV=$(( $MAJ | $MIN ))
> > 
> > /usr/share/bcc/tools/trace -t -C \
> >     't:block:block_rq_issue (args->dev == '$DEV') "%s %d %d", args-
> > >rwbs, args->sector, args->nr_sector' \
> >     't:block:block_rq_insert (args->dev == '$DEV') "%s %d %d", args-
> > >rwbs, args->sector, args->nr_sector'
> > 
> > 
> here it is (1 trial, 313 seconds to finish)

The above log shows similar issue with ext4 since there is another
writeback IO path from 'cp' process. And the following trace can show if
it is same with ext4's issue:

/usr/share/bcc/tools/stackcount -P -K t:block:block_rq_insert


Thanks,
Ming

