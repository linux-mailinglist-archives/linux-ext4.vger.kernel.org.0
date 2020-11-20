Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED4A2BAEF1
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 16:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgKTP2M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 10:28:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgKTP2M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 10:28:12 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kg8KX-0000a9-ES
        for linux-ext4@vger.kernel.org; Fri, 20 Nov 2020 15:28:09 +0000
Received: by mail-wr1-f70.google.com with SMTP id w5so3477799wrm.22
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 07:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJhlmQNXNjj2mjkZcqU8CxvLPDYzl52DW6HozfMG508=;
        b=foNyM46SbzPwjJh45+ymgzehuveH5dGsjT345XbkyF5LuSI0/X4a9fTBP8hS6EnPcN
         cK8kybafaycG80UrE7+W1iVWchc5K0D9Vdc1lU4bYpeKHVc/Ph6Eex4Z6rpZyT+D1T9R
         /J7yls2V16OJc63bfhxqUVrLzpeJ960El2HLRdizQWTpYTORzK6uSsKMXTVjZGRi5sbs
         M2M4rvqPf+n5kX6OgGPWi4ROxjnoPu6lm8lZDoyp57GkpWyqGr9kMPnPTFKhh07qOyQq
         P4Vucpi43XM3OV1H2wkYjIrkdo4Z2KyYa1m4mWM1amkZDYsBganygbIcX4/4bjx3Ul7Z
         NnBQ==
X-Gm-Message-State: AOAM530tczeThQDJ4Yfpw5KizG3hL9b1sZSAodwgciAOfR91LOpZknfv
        9Mi7nK4yD7+bo08zq0g2h4hlA8UCryeQvQwhOarx/2WyiuuiYyH1Xt8rBb1tvmdCdfQQaEV25kr
        yQD+h2yW64+7kyta7MBM4V1ujTfFvNTm/jseKTQ3uIN0xJgqMpFfV04Y=
X-Received: by 2002:a1c:f715:: with SMTP id v21mr10215429wmh.2.1605886088866;
        Fri, 20 Nov 2020 07:28:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygfELrlohemSp8Ux2JM+zYpF72nkLsl1EHpLn2VzKi7RiB3KI7mxfr2avwDaNrw5HAxjxTFI/EvtwEAhMErBk=
X-Received: by 2002:a1c:f715:: with SMTP id v21mr10215409wmh.2.1605886088608;
 Fri, 20 Nov 2020 07:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20201027132751.29858-1-jack@suse.cz> <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
In-Reply-To: <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Fri, 20 Nov 2020 12:27:56 -0300
Message-ID: <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan,

On Tue, Oct 27, 2020 at 1:10 PM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
> On Tue, Oct 27, 2020 at 10:27 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Commit afb585a97f81 "ext4: data=journal: write-protect pages on
> > j_submit_inode_data_buffers()") added calls ext4_jbd2_inode_add_write()
> > to track inode ranges whose mappings need to get write-protected during
> > transaction commits. However the added calls use wrong start of a range
> > (0 instead of page offset) and so write protection is not necessarily
> > effective. Use correct range start to fix the problem.
> >
> > Fixes: afb585a97f81 ("ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > Mauricio, I think this could be the reason for occasional test failures you
> > were still seeing. Can you try whether this patch fixes those for you? Thanks!
> >
>
> Thanks! Nice catch. Sure, I'll give it a try and follow up.

TL;DR:

1) Thanks! The patch fixed almost 100% of the checksum failures.
2) I can send a debug patch to verify buffer checksums before write-out.
3) The remaining, rare checksum failures seem to be due to
    a race between commit/write-protect and page writeback
    related to PageChecked(), clearing pagecache dirty tag used to
write-protect.
4) Test results statistics confirm that the occurrence of checksum
failures is really low.

...

Sorry for the delay in following up on this.

Thanks for the patch! The results with v5.10-rc4 are almost 100%:

There are now _very rare_ occasions of journal checksum failures detected; with
_zero_ recovery failures in stress-ng/crash/reboot/mount in 1187 loops
overnight.
(Previously I'd get 3-5 out of 10.)

I plan to send the debug patch used to verify the buffer checksum in the tag
before write-out (catches the checksum failures that fail recovery in advance),
if you think it might be useful. I thought of it under CONFIG_JBD2_DEBUG.

...

The remaining checksum changes due to write-protect failures _seem_ to be
a race between our write-protect with write_cache_pages() and writeback/sync.
But I'm not exactly sure as it's been hard to find the timing/steps
for both threads.
The idea is,

Our write_cache_pages() during commit /
ext4_journalled_submit_inode_data_buffers()
depends on PAGECACHE_TAG_DIRTY being set, for pagevec_lookup_range_tag()
to put such pages in the array to be write-protected with
clear_page_dirty_for_io().

With a debug patch to dump_stack() callers of
__test_set_page_writeback(), that can
xas_clear_mark() it, _while_ the page is still going in our call to
write_cache_pages(),
we see this: wb_workfn() -> ext4_writepage() -> ext4_ext4_bio_write_page(),

i.e., _not_ going through ext4_journalled_writepage(), which
knows/waits on journal.
The other leg of ext4_writepage()  _doesn't_, and thus can clear the
tag and prevent
write-protect while the journal commit / our write_cache_pages() is running.

Since the switch to either leg is PageChecked(), I guess this might be due to
clearing it right away in ext4_journalled_writepage(), before write-protection.

If that is the issue, perhaps that should be done in our writepage
callback or finish callback,
but I haven't thought much about it, until confirming if that's
actually the root cause.
(but it seems there's a problem if that bit is set again while we
process and clear it.)

...

And just details in the testing methodology, for documentation purposes.

The reproducer for the checksum errors is 'stress-ng --mmap $((4 *
$(nproc))) --mmap-file' on data=journal.
There's a test/wait/crash/reboot script that runs it and crashes in
$RANDOM <= 120 seconds.

This used to _often_ hit a journal recovery failure in mount on boot,
that prevents mount/boot.
Now that the checksum errors occur much less often, there's been
_zero_ recovery failures.

With the debug patch to check/report for checksum changes, the kernel
logs now show
such occurrences along with the (re)boot markers; e.g.,

[    0.000000] Linux version 5.10.0-rc4.rechecksum ...
[   80.534910] TESTCASE: checksum changed (tag3: 0x2d57bbdf, calc: 0xe0b4ddcb)
[    0.000000] Linux version 5.10.0-rc4.rechecksum ...

So it's relatively easy to convert those into numbers/statistics with
shell glue.

There's a total of 1187 reboots (i.e., stress-ng runs); 1131 had no
checksum errors; only 56 had.

The average number of reboots/runs between checksum errors being
detected is 20 (min 1, max 140, mean 16)
The average number of checksum errors per reboot/run _that has errors_
is 1 (95%), and max is 2 (5%).

So this confirms it's really rare now, to the point that it's even
harder to happen
in the moment that crash happened, and thus jbd2 recovery can finish correctly:

[    1.492521] EXT4-fs (vda1): INFO: recovery required on readonly filesystem
[    1.493906] EXT4-fs (vda1): write access will be enabled during recovery
[    1.826665] EXT4-fs (vda1): orphan cleanup on readonly fs
[    1.832006] EXT4-fs (vda1): 16 orphan inodes deleted
[    1.833050] EXT4-fs (vda1): recovery complete
[    1.837041] EXT4-fs (vda1): mounted filesystem with journalled data
mode. Opts: (null)

cheers,




--
Mauricio Faria de Oliveira
