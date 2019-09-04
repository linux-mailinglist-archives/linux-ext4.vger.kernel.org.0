Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260AAA8919
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2019 21:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfIDO7D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Sep 2019 10:59:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbfIDO7C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Sep 2019 10:59:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1i5WkO-00068I-Ku
        for linux-ext4@vger.kernel.org; Wed, 04 Sep 2019 14:59:00 +0000
Received: by mail-io1-f69.google.com with SMTP id f24so19086671ion.4
        for <linux-ext4@vger.kernel.org>; Wed, 04 Sep 2019 07:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sDrFAvQf0w1nVql3tAUzXcXvI1jIJ7MZ8Vpfy03Qgs=;
        b=GeLb2Eu3KaMthyz2yfqLwbCAiXewxiyJTGS0Sd6JzeeRdcATyrQRk9oFy/JB4xWpw4
         MTDYCo5Zf1l9N1GlLgVwu1845dna+A4iqxoPGu5kcLiw8b58e8RerWWbEr1PwB01WV72
         ZhzGXc0OXe9dYvYTNU2i6Wvh9DvJd/8vULfJgn6MqPpqf5mIHpro7rb1qli0pBUqwHXE
         n0K2lZyq/bCKo8tweh8nqi1V69S7F3RDzAiB6LMm5aAmfzBKRxjaWobam60yoT9fH3mH
         RQpOxchqkwTby6JBCatDGfKDcJqt4IVIfQzIvOrSaRjKUJlyipAG+9YLimy7+f2gIqKh
         R7rg==
X-Gm-Message-State: APjAAAXEW8zMOeeVw72IjpeT899eC5hN3stHGjoGelDGVlxMkuqDIhLN
        SJkqiWfzuhpvuuZk6uVfBRULpJOv5PmFl/8hx1HArqZyvzI2XwIU80NnuGrn0Ja4JSdZ9BKD03D
        HTAU30exal8eCQOv7tbkAiXJ+4jUZ1JyYRgbOY5Q=
X-Received: by 2002:a6b:b487:: with SMTP id d129mr3485088iof.223.1567609139450;
        Wed, 04 Sep 2019 07:58:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzP3foLbiKbo8yJmAClO7gBY2psxgTBFEGQLaS8Cfp9Qafz8DkETtTVf2DWyPgRiXksDWLEfg==
X-Received: by 2002:a6b:b487:: with SMTP id d129mr3485061iof.223.1567609139118;
        Wed, 04 Sep 2019 07:58:59 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id q8sm17355307ion.82.2019.09.04.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 07:58:58 -0700 (PDT)
Date:   Wed, 4 Sep 2019 08:58:57 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Colin King <colin.king@canonical.com>,
        Ryan Harper <ryan.harper@canonical.com>
Subject: Re: ext4 fsck vs. kernel recovery policy
Message-ID: <20190904145857.GA8297@xps13.dannf>
References: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
 <5FEB4E1B-B21B-418D-801D-81FF7C6C069F@dilger.ca>
 <20190829225348.GA13045@xps13.dannf>
 <20190830012236.GC10779@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830012236.GC10779@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 29, 2019 at 09:22:36PM -0400, Theodore Y. Ts'o wrote:
> (Changing the cc from linux-fsdevel to linux-ext4.)
> 
> On Thu, Aug 29, 2019 at 04:53:48PM -0600, dann frazier wrote:
> > JBD2: Invalid checksum recovering data block 517634 in log
> > 
> > So is it correct to say that the checksum errors were identifying
> > filesystem correctness issues, and therefore e2fsck was needed to
> > correct them?
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
> It's all relatively straightforward except for the part where we have to
> attach a list of pages to the currently running transaction.  That
> will require adding  some plumbing into the jbd2 layer.
> 
> Dann, any interest in trying to code this fix?

Thanks Ted. I've the interest, I'll see if I can find the time :)

  -dann
