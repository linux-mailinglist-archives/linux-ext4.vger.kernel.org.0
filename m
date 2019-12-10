Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE511816F
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLJHft (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Dec 2019 02:35:49 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50760 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLJHfs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Dec 2019 02:35:48 -0500
Received: by mail-wm1-f52.google.com with SMTP id p9so1973925wmg.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Dec 2019 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d+OM3TJFU1vkI9A89fT5ICGoCi5aHL4tqG7UgZRXYL0=;
        b=t8UqM11QS+yV0fc3CdiRNHuUj38nfErOyAWIneES11xK/WAI5MPlvpiVQQiN7Gq2po
         Fwm/MTnMsG1Oc2XfogvI9vyIF5eM9ATwaZBkcNWI//BEGm41Hfz4+yRwCTVSjGju+Vyc
         ERnb7XXHlWykXxHA3Om2vnmBkytMc+aC2WOY5BdJRGv3vc3T83QBn3zdtjeADpnVdDgA
         ja5TmDuwOUuYlzGg5srDKIswj/P+gYLZA+OdDXbrADNRCrEMMbI2K5Ae/EfeGv/eY1tB
         YV4OowJLd2hjgJ7GDey9YP11zASBz578iOBr1csG6u7D2GF+t56rt6hbsrvv1UB2Zudj
         uBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d+OM3TJFU1vkI9A89fT5ICGoCi5aHL4tqG7UgZRXYL0=;
        b=RxGVdtyH6eq1oHhJsKuatQBDJ+AMj/zMtFJZ+11sSGyZryMSWBViuzFCOP/lq1FMlC
         tEowxsKpTDVycQfzWY9/n4gc3bdyqvosbNDoXT2f7TtAUbeQMBKJO8t7qMpppZdYvmqO
         VqwiQEHuGObvlLlBWFajz9fGUMJJ2A11Bc2s3C1gPM4cxRXTbAThHCpxoPrdTYZiMY8U
         IjJUzD5r1L/gnctCS955xFib+lQOfZqBzg6LpvY/5n05dNGhN/rCy8OnMEKp5VbthRa2
         qFtuGnXXhMCpV3NwE1CNP+Vy7+y9E2RD3u3aEY13ZvN0Ql1RIHADHfNQeo5Cjgt3h8VR
         9BXA==
X-Gm-Message-State: APjAAAVKgqvefrdQIDiKMl0C1eytZRMUBZKZb/PYbORv9u6Somtpbb0p
        EL4d6BlI16zP2ABS4//zVyqLcA==
X-Google-Smtp-Source: APXvYqxk4VGoYiQytFKE5BR9zei7bG9EHliSlY2rPcmeje/05wJhrPc1NAH72jLiME24eqA9kZRLVQ==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr3194064wmb.41.1575963344842;
        Mon, 09 Dec 2019 23:35:44 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id y139sm2198041wmd.24.2019.12.09.23.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 23:35:44 -0800 (PST)
Message-ID: <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
From:   Andrea Vai <andrea.vai@unipv.it>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
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
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Date:   Tue, 10 Dec 2019 08:35:43 +0100
In-Reply-To: <20191203022337.GE25002@ming.t460p>
References: <20191126023253.GA24501@ming.t460p>
         <0598fe2754bf0717d81f7e72d3e9b3230c608cc6.camel@unipv.it>
         <alpine.LNX.2.21.1.1911271055200.8@nippy.intranet>
         <cb6e84781c4542229a3f31572cef19ab@SVR-IES-MBX-03.mgc.mentorg.com>
         <c1358b840b3a4971aa35a25d8495c2c8953403ea.camel@unipv.it>
         <20191128091712.GD15549@ming.t460p>
         <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
         <20191129005734.GB1829@ming.t460p> <20191129023555.GA8620@ming.t460p>
         <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
         <20191203022337.GE25002@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Il giorno mar, 03/12/2019 alle 10.23 +0800, Ming Lei ha scritto:
> On Fri, Nov 29, 2019 at 03:41:01PM +0100, Andrea Vai wrote:
> > Il giorno ven, 29/11/2019 alle 10.35 +0800, Ming Lei ha scritto:
> > > On Fri, Nov 29, 2019 at 08:57:34AM +0800, Ming Lei wrote:
> > > 
> > > > [...]
> > > 
> > > > Andrea, can you collect the following log when running the
> test
> > > > on current new(bad) kernel?
> > > > 
> > > > 	/usr/share/bcc/tools/stackcount  -K
> blk_mq_make_request
> > > 
> > > Instead, please run the following trace, given insert may be
> > > called from other paths, such as flush plug:
> > > 
> > > 	/usr/share/bcc/tools/stackcount -K t:block:block_rq_insert
> > 
> > Attached, for new (patched) bad kernel.
> > 
> > Produced by: start the trace script (with the pendrive already
> > plugged), wait some seconds, run the test (1 trial, 1 GB), wait
> for
> > the test to finish, stop the trace.
> > 
> > The copy took ~1700 seconds.
> 
> See the two path[1][2] of inserting request, and path[1] is
> triggered
> 4358 times, and the path[2] is triggered 5763 times.
> 
> The path[2] is expected behaviour. Not sure path [1] is correct,
> given
> ext4_release_file() is supposed to be called when this inode is
> released. That means the file is closed 4358 times during 1GB file
> copying to usb storage.
> 
> Cc filesystem list.
> 
> 
> [1] insert requests when returning to user mode from syscall
> 
>   b'blk_mq_sched_request_inserted'
>   b'blk_mq_sched_request_inserted'
>   b'dd_insert_requests'
>   b'blk_mq_sched_insert_requests'
>   b'blk_mq_flush_plug_list'
>   b'blk_flush_plug_list'
>   b'io_schedule_prepare'
>   b'io_schedule'
>   b'rq_qos_wait'
>   b'wbt_wait'
>   b'__rq_qos_throttle'
>   b'blk_mq_make_request'
>   b'generic_make_request'
>   b'submit_bio'
>   b'ext4_io_submit'
>   b'ext4_writepages'
>   b'do_writepages'
>   b'__filemap_fdatawrite_range'
>   b'ext4_release_file'
>   b'__fput'
>   b'task_work_run'
>   b'exit_to_usermode_loop'
>   b'do_syscall_64'
>   b'entry_SYSCALL_64_after_hwframe'
>     4358
> 
> [2] insert requests from writeback wq context
> 
>   b'blk_mq_sched_request_inserted'
>   b'blk_mq_sched_request_inserted'
>   b'dd_insert_requests'
>   b'blk_mq_sched_insert_requests'
>   b'blk_mq_flush_plug_list'
>   b'blk_flush_plug_list'
>   b'io_schedule_prepare'
>   b'io_schedule'
>   b'rq_qos_wait'
>   b'wbt_wait'
>   b'__rq_qos_throttle'
>   b'blk_mq_make_request'
>   b'generic_make_request'
>   b'submit_bio'
>   b'ext4_io_submit'
>   b'ext4_bio_write_page'
>   b'mpage_submit_page'
>   b'mpage_process_page_bufs'
>   b'mpage_prepare_extent_to_map'
>   b'ext4_writepages'
>   b'do_writepages'
>   b'__writeback_single_inode'
>   b'writeback_sb_inodes'
>   b'__writeback_inodes_wb'
>   b'wb_writeback'
>   b'wb_workfn'
>   b'process_one_work'
>   b'worker_thread'
>   b'kthread'
>   b'ret_from_fork'
>     5763
> 
> Thanks,
> Ming
> 

Is there any update on this? Sorry if I am making noise, but I would
like to help to improve the kernel (or fix it) if I can help.
Otherwise, please let me know how to consider this case,

Thanks, and bye
Andrea

