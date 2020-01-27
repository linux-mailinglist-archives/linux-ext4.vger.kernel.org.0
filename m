Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFB14A317
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2020 12:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgA0Lee (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 06:34:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0Lee (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 06:34:34 -0500
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1iw2f2-0002SB-LT
        for linux-ext4@vger.kernel.org; Mon, 27 Jan 2020 11:34:32 +0000
Received: by mail-qt1-f197.google.com with SMTP id n4so774249qtv.5
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2020 03:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZSiRpNxTymFPV8y2OnlSYe8O6QEF9ESzz+EPrKDBb8=;
        b=Ai367q/gpDI2//2AOuVKsUShwZriHMBEBshbK8ReVcyeFI/IG3x/Gc8F9VgF6Y7Dn5
         C+egMzapdhg9bcbbpuJrO2DpekpM6g09rPz/T5yuwdMMnr+WgTCk+v4fCbLCY9wUV2Yp
         RC0s/J9aUc9DA8WiHjGlPAKskta50SrhR77qaZOALcN89SOnhyqQqZ5zu1JqYbcZ8dnu
         nNUwttXpfUKz4wqO22MCCdcldGRq111CDfL9MqIN6sY8drLBTohhVgGpcxH5uvFk30uc
         p9sZdWEvdBYOiU30kgrMGPc0rvOs3YReHKn4d8VSt36vhViQQJP5zFZvlFXEqhkJDOGI
         y4aA==
X-Gm-Message-State: APjAAAXFh93XmDcrFlyzKD/r+gNZrD/hhOOEH4FtcCNZ726VvbzwpUHI
        Gn9mhE2mSP/kuL3hBVp3Pr3x0DJhK8s7WVIja1385edDQ9S6uFzWd9mSPckYgSVuCI7mPBcwb87
        0/R7kPTXww4CENWWnJFf+lHCbMh/e8tpbotkCDCY=
X-Received: by 2002:a37:b8b:: with SMTP id 133mr15753019qkl.418.1580124871778;
        Mon, 27 Jan 2020 03:34:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwv+KfqbkV7m7O7OBZlqFUJ2K/D/+UZ/VYD5Vq7/Brmop6gDJW1C6TFWnjpx8yNLjb6LM3E6Q==
X-Received: by 2002:a37:b8b:: with SMTP id 133mr15753003qkl.418.1580124871520;
        Mon, 27 Jan 2020 03:34:31 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e7:1017:876:4f8b:50cb:9457])
        by smtp.gmail.com with ESMTPSA id d25sm9582003qtq.11.2020.01.27.03.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 03:34:30 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        linux-ext4@vger.kernel.org
Subject: Re: Re: ext4 fsck vs. kernel recovery policy
Date:   Mon, 27 Jan 2020 08:34:27 -0300
Message-Id: <20200127113427.20214-1-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830012236.GC10779@mit.edu>
References: <20190830012236.GC10779@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 29 Aug 2019 21:22:36 -0400, Theodore Y. Ts'o wrote:
> On Thu, Aug 29, 2019 at 04:53:48PM -0600, dann frazier wrote:
>> JBD2: Invalid checksum recovering data block 517634 in log
>> 
>> So is it correct to say that the checksum errors were identifying
>> filesystem correctness issues, and therefore e2fsck was needed to
>> correct them?
> 
> That's correct.  More precisely, checksum errors for journal blocks
> are presumed to mean that file system might be corrupt, so a full
> e2fsck check was needed to make sure the file system was consistent.
> 
> > You're probably right - this issue is very easy to reproduce w/
> > data=journal,journal_checksum. I was never able to reproduce it
> > otherwise.
> 
> I've looked at the data block numbers that you've reported, and they
> come from a journald file.  The problem is with data=journal +
> journal_checksum + mmap.  Unfortunately, we don't handle that
> combination correctly at the moment.
> 
> The fix is going to have to involve fixing __ext4_journalled_writepage()
> to call set_page_writeback() before it unlocks the page, adding a list of
> pages under data=journalled writeback which is attached to the
> transaction handle, have the jbd2 commit hook call end_page_writeback()
> on all of these pages, and then in the places where ext4 calls
> wait_for_stable_page() or grab_cache_page_write_begin(),
> we need to add:
> 
> 	if (ext4_should_journal_data(inode))
> 		wait_on_page_writeback(page);
> 

If I understood and wrote things correctly, this can hit a deadlock between

1) jbd2_journal_commit_transaction() -- waiting for t_updates to drop (i.e.,
   ext4_journal_stop() to be called), blocking commit / end_page_writeback().

and

2) ext4_write_begin() -- waiting in wait_on_page_writeback() in between the
   calls to ext4_journal_start()/stop(), blocking t_updates from dropping.

I worked around it moving wait_on_page_writeback() before ext4_journal_start(),
but wonder if this is really expected and the algorithm needs tuning/changes,
or not expected and thus an implementation error. (First time with ext4 code.)

P.S.: sorry to bother again about it (I already wrote/pinged on [1, 2]) but
this does seem interesting and shows an issue we're interested in fixing up.

Thanks again for your help/suggestions on this.

[1] https://lore.kernel.org/linux-ext4/20191221202630.30718-1-mfo@canonical.com/
[2] https://lore.kernel.org/linux-ext4/20191221202630.30718-2-mfo@canonical.com/

cheers,
Mauricio

> It's all relatively straightforward except for the part where we have to
> attach a list of pages to the currently running transaction.  That
> will require adding  some plumbing into the jbd2 layer.
> 
> Dann, any interest in trying to code this fix?
> 
>       	  	      	     	     	  - Ted
