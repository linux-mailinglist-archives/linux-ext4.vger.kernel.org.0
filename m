Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF81D6675
	for <lists+linux-ext4@lfdr.de>; Sun, 17 May 2020 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEQHkQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 May 2020 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgEQHkQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 May 2020 03:40:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED258C061A0C
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 00:40:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so3209583pjb.3
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gYBEqdC545EbAPhSZ5uGGYGhBNROVO5LOwqBV1JLBPg=;
        b=1sVdcuWToB2EOCrzEkAXlx+SWxQmIE1dqFqEWyamjmMNsD5QtPrwlihyrB6CW1rVjh
         6e3QUrLFTcHwLvh3PH3TS3pPENEQBhKTBFdSYEwc34uvSlT67TEUQeDYz5yh36cv4nfD
         uo8u1Uj9l8sxVmdMeVK8bfOw5j2hnLNjsNHZj/dpHJMJbiTD/ahxwFijy87jQhFPcvwu
         8ptV/M48zgdrNsvHKa2vWnKs7Eh3oAfB/U80lQquI0LNOW0/QRuWS0M8mzWiPOgm1HR4
         CRs/VfS3uXUWMlNZVHFVBorGR5ZhaRtotgQqfBBTTNSRqhzgOV7fosywd5mHzpsnbfSN
         2cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gYBEqdC545EbAPhSZ5uGGYGhBNROVO5LOwqBV1JLBPg=;
        b=oyO1BcVgirXblK/v/JsBorrCGmKFdRcdaJsu8TXKjg0JdkcecNl/u1r4qSp1mXv+Gy
         4CJ0YLC2nUqXk88OM9tUDCmOMb1HIWtc/NiPVE9vYfHVLH8e/Zu1MVfd5rse20YiHFsh
         O0b+msLSbl2dLFMHh5JEByW/fiHtdavTsegRly8bEhjyCn5oo6KjCvXqcHz6YoUo30h4
         4vpO8L2E0wJQRwwasayJi1vA3lHiKnHMzgImB1gLxaKGFY9jtGe+c9MvPDfa184zcdkS
         6QIx1yob+Hhl3r09N8BH310M3f+yJGwbj+eb0Lz7qmQMwNn0RY5yp2/EA2SvDh0uC7Ik
         xaSg==
X-Gm-Message-State: AOAM533GhgHLNCm946bmhSTq+rTWjcVGCB6wHcELgVNUmn1H3pH394ls
        2XEYIH/kU7s9MhFNQqoviRImnZKt2y4QYg==
X-Google-Smtp-Source: ABdhPJywzio63VMbNqJ3zrA6DmZkiyrv1UQYlOj/7TBg8AhoyJy+NkGu/zQ0H0XOXIeQqKkZHttgVw==
X-Received: by 2002:a17:90a:b293:: with SMTP id c19mr13527788pjr.22.1589701215181;
        Sun, 17 May 2020 00:40:15 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z66sm5662775pfz.141.2020.05.17.00.40.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 00:40:14 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C9FEDED5-CDEE-449F-AE11-64BB56A42277@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_74BAF492-6146-429B-A0AD-020E5100FD50";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 00/11] ext4: data=journal: writeback mmap'ed pagecache
Date:   Sun, 17 May 2020 01:40:11 -0600
In-Reply-To: <CAO9xwp1Gj+tffyp0Q=99VBnhX3WvHaq7qg7pf4kpty9_0+-ACQ@mail.gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Jan Kara <jack@suse.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
 <CAO9xwp1Gj+tffyp0Q=99VBnhX3WvHaq7qg7pf4kpty9_0+-ACQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_74BAF492-6146-429B-A0AD-020E5100FD50
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 15, 2020, at 12:39 PM, Mauricio Faria de Oliveira =
<mfo@canonical.com> wrote:
>=20
> Hi,
>=20
> On Thu, Apr 23, 2020 at 8:37 PM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> [snip]
>> Summary:
>> -------
>>=20
>> The patchset is a bit long with 11 patches, but I tried to get
>> changes tiny to help with review, and better document how each
>> of them work, why and how this or that is done.  It's RFC as I
>> would like to ask for suggestions/feedback, if at all possible.
>=20
> If at all possible, may this patchset have at least a cursory look?
>=20
> I'm aware it's been a busy period for some of you, so I just wanted
> to friendly ping on it, in case this got buried deep under other =
stuff.


Hi Mauricio,
thank you for submitting the patch.  I've always thought data=3Djournal
is a useful feature, especially for the future with host-managed SMR
(which seems is being added to drives whether we want it or not), and
hybrid use cases (NVMe journal, large HDD size which may also be SMR).

That said, diving into the ext4/jbd2 code on your first adventure here
is certainly ambitious and it is great that you have taken this fix on.

I'd say that Jan is the resident expert on jbd2, so hopefully he will
have a chance to look at this patch series.

Cheers, Andreas

>> Patch 01 and 02 implement the outlined fix, with a few changes
>> (fix first deadlock; use existing plumbing in jbd2 as the list.)
>>=20
>> Patch 03 fix a seconds-delay on msync().
>>=20
>> Patch 04 introduces helpers to handle the second deadlock.
>>=20
>> Patch 05-11 handle the second deadlock (three of these patches,
>> namely 07, 09 and 10 are changes not specific for data=3Djournal,
>> affecting other journaling modes, so it's not on their subject.)
>>=20
>> The order of the patches intentionally allow the issues on 03
>> and 05-11 to occur (while putting the core patches first), so
>> to allow issues to be reproduced/regression tested one by one,
>> as needed.  It can be changed, of course, so to enable actual
>> writeback changes in the last patch (when issues are patched.)
>>=20
>>=20
>> Testing:
>> -------
>>=20
>> This has been built and regression tested on next-20200417.
>> (Also rebased and build tested on next-20200423 / "today").
>>=20
>> On xfstests (commit b2faf204) quick group (and excluding
>> generic 430/431/434 which always hung): no regressions w/
>> data=3Dordered (default) nor data=3Djournal,journal_checksum.
>>=20
>> With data=3Dordered: (on both original and patched kernel)
>>=20
>>    Failures: generic/223 generic/465 generic/553 generic/554 =
generic/565 generic/570
>>=20
>> With data=3Djournal,journal_checksum: (likewise)
>>=20
>>    Failures: ext4/044 generic/223 generic/441 generic/553 generic/554 =
generic/565 generic/570
>>=20
>> The test-case for the problem (and deadlocks) and further
>> stress testing is stress-ng (with 512 workers on 16 vCPUs)
>>=20
>>    $ sudo mount -o data=3Djournal,journal_checksum $DEV $MNT
>>    $ cd $MNT
>>    $ sudo stress-ng --mmap 512 --mmap-file --timeout 1w
>>=20
>> To reproduce the problem (without patchset), run it a bit
>> and crash the kernel (to cause unclean shutdown) w/ sysrq,
>> and mount the device again (it should fail / need e2fsck):
>>=20
>> Original:
>>=20
>>    [   27.660063] JBD2: Invalid checksum recovering data block 79449 =
in log
>>    [   27.792371] JBD2: recovery failed
>>    [   27.792854] EXT4-fs (vdc): error loading journal
>>    mount: /tmp/ext4: can't read superblock on /dev/vdc.
>>=20
>> Patched:
>>=20
>>    [  33.111230] EXT4-fs (vdc): 512 orphan inodes deleted
>>    [  33.111961] EXT4-fs (vdc): recovery complete
>>    [  33.114590] EXT4-fs (vdc): mounted filesystem with journalled =
data mode. Opts: data=3Djournal,journal_checksum
>>=20
>>=20
>> RFC / Questions:
>> ---------------
>>=20
>> 0) Usage of ext4_inode_info.i_datasync_tid for checks
>>=20
>> We rely on the struct ext4_inode_info.i_datasync_tid field
>> (set by __ext4_journalled_writepage() and others) to check
>> it against the running transaction. Of course, other sites
>> set it too, and it might be that some of our checks return
>> false positives then (should be fine, just less efficient.)
>>=20
>> To avoid such false positives, we could add another field
>> to that structure, exclusively for this, but that is more
>> 8 bytes (pointer) for inodes and even on non-data=3Djournal
>> cases.. so it didn't seem good enough reason, but if that
>> is better/worth it for efficiency reasons (speed, in this
>> case, vs. memory consumption) we could do it.
>>=20
>> Maybe there are other ideas/better ways to do it?
>>=20
>> 1) Usage of ext4_force_commit() in ext4_writepages()
>>=20
>> Patch 03 describes/fixes an issue where the underlying problem is,
>> if __ext4_journalled_writepage() does set_page_writeback() but no
>> journal commit is triggered, wait_on_page_writeback() may wait up
>> to seconds until the periodic journal commit happens.
>>=20
>> The solution there, to fix the impact on msync(), is to just call
>> ext4_force_commit() (as it's done anyway in ext4_sync_file()), on
>> ext4_writepages().
>>=20
>> Is that a good enough solution?  Other ideas?
>>=20
>> 2) Similar issue (unhandled) in ext4_writepage()
>>=20
>> The other, related question is, what about direct callers of
>> ext4_writepage() that obviously do not use ext4_writepages() ?
>> (e.g., pageout() and writeout(); write_one_page() not used.)
>>=20
>> Those are memory-cleasing writeback, which should not wait,
>> however, as mentioned in that patch, if its writeback goes
>> on for seconds and an data-integrity writeback/system call
>> comes in, it is delayed/wait_on_page_writeback() that long.
>>=20
>> So, ideally, we should be trying to kick a journal commit?
>>=20
>> It looks like ext4_handle_sync() is not the answer, since
>> it waits for commit to finish, and pageout() is called on
>> a list of pages by shrinking.  So, not effective to block
>> on each one of them.
>>=20
>> We might not want to start anything right now, actually,
>> since the memory-cleasing writeback can be happening on
>> memory pressure scenarios, right?  But would need to do
>> something, to ensure that future wait_on_page_writeback()
>> do not wait too long.
>>=20
>> Maybe the answer is something similar to jbd2 sync transaction
>> batching (used by ext4_handle_sync()), but in *async* fashion,
>> say, possibly implemented/batching in the jbd2 worker thread.
>> Is that reasonable?
>>=20
>> ...
>>=20
>> Any comments/feedback/reviews are very appreciated.
>>=20
>> Thank you in advance,
>> Mauricio
>>=20
>> [1] =
https://lore.kernel.org/linux-ext4/20190830012236.GC10779@mit.edu/
>>=20
>> Mauricio Faria de Oliveira (11):
>>  ext4: data=3Djournal: introduce struct/kmem_cache
>>    ext4_journalled_wb_page/_cachep
>>  ext4: data=3Djournal: handle page writeback in
>>    __ext4_journalled_writepage()
>>  ext4: data=3Djournal: call ext4_force_commit() in ext4_writepages() =
for
>>    msync()
>>  ext4: data=3Djournal: introduce helpers for journalled writeback
>>    deadlock
>>  ext4: data=3Djournal: prevent journalled writeback deadlock in
>>    __ext4_journalled_writepage()
>>  ext4: data=3Djournal: prevent journalled writeback deadlock in
>>    ext4_write_begin()
>>  ext4: grab page before starting transaction handle in
>>    ext4_convert_inline_data_to_extent()
>>  ext4: data=3Djournal: prevent journalled writeback deadlock in
>>    ext4_convert_inline_data_to_extent()
>>  ext4: grab page before starting transaction handle in
>>    ext4_try_to_write_inline_data()
>>  ext4: deduplicate code with error legs in
>>    ext4_try_to_write_inline_data()
>>  ext4: data=3Djournal: prevent journalled writeback deadlock in
>>    ext4_try_to_write_inline_data()
>>=20
>> fs/ext4/ext4_jbd2.h |  88 +++++++++++++++++++++++++
>> fs/ext4/inline.c    | 153 =
+++++++++++++++++++++++++++++++-------------
>> fs/ext4/inode.c     | 137 +++++++++++++++++++++++++++++++++++++--
>> fs/ext4/page-io.c   |  11 ++++
>> 4 files changed, 341 insertions(+), 48 deletions(-)
>>=20
>> --
>> 2.20.1
>>=20
>=20
>=20
> --
> Mauricio Faria de Oliveira


Cheers, Andreas






--Apple-Mail=_74BAF492-6146-429B-A0AD-020E5100FD50
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7A6lwACgkQcqXauRfM
H+DRog/7BVrfNtUkuypAx66urpXxyGEtpbc15aPJccGvlFPhwCoiIISrlnTNUnAz
vDXfHaHFcVAzpNgccvFW3P5oNmsbJzAz1iGeUt/jZwguOtbO8/Uqw+oSs+grd+yh
VGt99FrEKXwpnVY7xT/XM9naCnqEVxqNSljlwfgUFWHEnGOQkKI+7HrwLCkCwJDW
3eSP9tZUy9LXWZpTt9QLVlLXEMGkI+AN+Eu1PCs7c4F+faZ6lavlq4/0Fq7ZduSA
3yH1iKBLbH8QkTVeFyPvY1d91K8MpQpOMMLSEkQ7qqrVQN8qSO4Cwnc8R6Vf6nf7
rDOBMq6s5ivUkgH/8MMiyp3NkutJzQ3qw2j1AWRpDYriiK8Ajb0ofZ8vTltiFdKS
Ol0QmL51DQLBqE/lQIxoNoEKa+HgiLgWWNxkuJ5zW+HMh01rIUvct2EH3jFtXOzi
xZxijv+7PvtX5T0Tpx+Ha0AfAkW5OZaGml9w/md5NndESpR9HM1PuwDvTSEZGiIA
+upVdX4CTtjb5djBgezuQ/lF4VrflveFFDXPIb0L5O38EymkngT9N7/AXdzwR9kG
/09WfJwXa7Ks8DNZL+BOAkdX59Zi2YupX6twd6U2y7hp/x5DgqqsLWwFKuZgOHju
QBBVUUBqlzZIS49OYRXPiadr+e9j+B7YhOLvAExxT3bobQh0hFI=
=8cmE
-----END PGP SIGNATURE-----

--Apple-Mail=_74BAF492-6146-429B-A0AD-020E5100FD50--
