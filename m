Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B24630C35
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Nov 2022 06:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKSFkN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 19 Nov 2022 00:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSFkL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 19 Nov 2022 00:40:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33E327CD2
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 21:40:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so17806653eje.1
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 21:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIzX6c6waWX7bxyIJX3hZYmDwmr2FztwpXsHOijRs/4=;
        b=JsDupPU7cOsxJ5mDa+LC7I/0zi+YoI0anmIf2pR4MsZsnuh76Wo8xCSqjDK8Oo17xn
         WaEQS2tYM2wMN7ZZ96IvgkD2ScybOWTOO4+cDgVFE7vwClMu+3iqYCMw7FkfU/deIJOG
         oaflNvaJwCIi+lmskl+ig3FopPTscJoC5a1XnJvQVsFZqvLrZKdWr5IaEhoYrdiezbXc
         4Sd8ABc6c6MydAvYnrX+XksW+9hLKPB3nQ8v0fxeuEn4vuQJuPAy9Kd+IuLhZ1cPTEG7
         Aeo40iEQf55WpQRDPa9cN2ZXVTlyaZo/IJ04+KBjk8Q9mee3jI9roFcj/8S9GHKfuml9
         21UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIzX6c6waWX7bxyIJX3hZYmDwmr2FztwpXsHOijRs/4=;
        b=SB3xV55lJYLHEjS1vL7G7TD/jHPUztmQR+VFXoswDEkEpYPBphN+4DqbybiFRShiKY
         hlM6bVtg9fwfFsjWoMjXnWIhTn/GKuE9Xh+BTKnRxtXF6jbtjesc98PGrk6XEn9Z4gbr
         jTqFcaG2bXkNO+fOAaHOKfkUH3TGAmi4FlEP7uXZVwWjs5B2+rBKuBo1uwLSHKTSekWr
         AUO3UvHF1KF8/67oitgRMbrWpUgWdi5vBNvRkdjTMO5DSVTy5724MchqTZDJn3g8N1Jb
         5bPtCYqccKV67Y+/27Stdrzitb4p1qC3Ex29ibR+Eh3KYaqZsPHpJyq4rh8Fa7kLkW8p
         HYtQ==
X-Gm-Message-State: ANoB5pmyxQRB/MyPEzjBSZ2eRyEvFOZre+OTHqp7sceSe1j5LU6Cy3Dv
        r4VGlmdCLutbcOOB12chfssflQGkPAL46koXlPR6CjYO
X-Google-Smtp-Source: AA0mqf5eb/TVouMyKmUZr617za47w2QkHsC3qzG2ZBByFlnlASGe2LEgS1ZITqnDMDi2Uu0/8O0BBTw+zpd+MKSQuzI=
X-Received: by 2002:a17:906:ae93:b0:78a:3479:ec7d with SMTP id
 md19-20020a170906ae9300b0078a3479ec7dmr8425184ejb.671.1668836408110; Fri, 18
 Nov 2022 21:40:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1667822611.git.ritesh.list@gmail.com> <B4ED1C86-D3EC-4A0A-97B3-CFCB46617E1A@dilger.ca>
In-Reply-To: <B4ED1C86-D3EC-4A0A-97B3-CFCB46617E1A@dilger.ca>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Date:   Sat, 19 Nov 2022 11:09:56 +0530
Message-ID: <CALk7dXr+zL9ek=dq71N4iW3x-p+=TJDHRTNCyBrq+utGCzQrdg@mail.gmail.com>
Subject: Re: [RFCv1 00/72] e2fsprogs: Parallel fsck support
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 18, 2022 at 3:53 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wr=
ote:
>
>
> =EF=BB=BFHello,
>
> This is a RFC patch series which has the list of all pfsck related change=
s
> which should also address the problem statements mentioned by Ted and
> Harshad here [1]
>
> Below points will provide more details on how this patch series is laid o=
ut:-
>
> 1. This series is rebased on the latest e2fsprogs master branch.
>
> 2. Patch series is broken down into logical patches for easier review. Th=
e
> series contains libext2fs changes first, followed by e2fsck changes which
> utilizes libext2fs apis to add pfsck support to pass1.
>
> 3. Changes [0005] to [0012] addresses the problem statement laid out by T=
ed
> and Harshad [1] i.e. we now have a libext2fs API for clone and merge of
> ext2_filsys struct. (ext2fs_clone_fs() & ext2fs_merge_fs())
>
> 4. These two changes [0016] & [0026] uses above clone/merge api for test =
and
> for use in e2fsck.
>
> 5. For a lot of libext2fs changes (for e.g. bitmap merging logic or clone=
/merge apis),
> there are some unit tests added for it's functionality verification.
>
>
> Performance results:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. On nvme with 22M 0-byte inodes: 7sec v/s 19sec
> 2. On nvme with 22M 4KB-32KB inodes: 17sec v/s 30sec
> 3. On nvme with 11M 32KB inodes: 9sec v/s 15sec
> 4. On RAID HDD setups: (will get back with perf results for this. Althoug=
h, I had
> shared some numbers earlier, but I wanted to run pfsck with different FS =
layout
> and collect the numbers once again)
>
>
> Ritesh,
> Thanks for your work to update this patch series. I've been meaning to lo=
ok at it, but

Thanks Andreas, I see you have already started reviewing. This is
super helpful :)

> have been traveling the past couple of weeks.
>
> Have you done any performance comparisons against the original pfsck patc=
h
> series?

Yes, I did, for the existing tests that I just mentioned above and
found the perf numbers to be
similar. I am also planning to take a RAID device setup from an
internal team and collect
some performance numbers there.

>
> I did make a patch against our original series to improve the workload ba=
lance between
> threads, so that they are assigned a roughly equal number of inodes, inst=
ead of an equal
> number of block groups, since my testing showed the processing time of th=
e threads
> was proportional to the inode count. This avoids uneven thread completion=
 and reduces overall processing time.

Yes, based on my testing so far. I too agree that to improve the
workload balance one should assign an equal
number of inodes to different threads.

>
> That patch is available in our Gerrit, and I can push it once this series=
 lands, or it could be
> merged into the original patch that adds the e2fsck_pass1_thread_prepare(=
) code.
>
> https://review.whamcloud.com/48806

Sure, I will keep a note of this patch too in my performance runs.

So, now given the number of patches are quite large, I am hoping that
we could review all libext2fs changes
for getting it in shape for merge. Then while we are at e2fsck change,
we can definitely look at the above patch
too.

Thanks again!!
-ritesh

>
> Cheers, Andreas.
>
> For review: Since these are large number of changes. So if the overall se=
ries looks
> good, then we can start reviewing changes in batches. For e.g. if we coul=
d review
> initial changes in libext2fs (from [001] - [0020]), that would be a good =
start.
>
>
> Patch-0073 adds support to all tests/* with "-m 2" mode to test pfsck as =
well.
> If pthread support is present, make check then test with "-m 2" fsck mode
> option as well (for tests which utilizes run_e2fsck script).
> This was mainly done for verifying that all existing tests passes with pf=
sck.
> In this only few tests are kept disabled by passing SKIP_MT=3Dtrue
> (Note: Last min. I have decided to drop this patch from sending. Although=
 this can
> still be found in the github branch [2] for any testing)
>
> On Threadsan: I had tested this patch series against threadsan as well. I=
t does
> lists few race conditions when running multi-threading (these doesn't loo=
ks
> to be any major problem). I have fixed a few [0070] and rest might either=
 need
> some minor fixing or marking it false positive.
>
> Here is the github link with all these commits (pfsck-RFCv1 branch) [2].
>
> [1]: https://lore.kernel.org/linux-ext4/YMN10sXgoTR%2FIPxr@mit.edu/
> [2]: https://github.com/riteshharjani/e2fsprogs/commits/pfsck-RFCv1
>
>
> Andreas Dilger (2):
>  libext2fs: Misc fixes for struct_ext2_filsys
>  e2fsck: misc cleanups for pfsck
>
> Li Xi (16):
>  dblist: add dblist merge logic
>  libext2fs: Add flush cleanup API
>  libext2fs: merge icounts after thread finishes
>  e2fsck: add -m option for multithread
>  e2fsck: copy context when using multi-thread fsck
>  e2fsck: create logs for multi-threads
>  e2fsck: configure one pfsck thread
>  e2fsck: Add asserts in open_channel_fs
>  e2fsck: add start/end group for thread
>  e2fsck: split groups to different threads
>  e2fsck: print thread log properly
>  e2fsck: do not change global variables
>  e2fsck: optimize the inserting of dir_info_db
>  e2fsck: merge dir_info after thread finishes
>  e2fsck: merge icounts after thread finishes
>  e2fsck: add debug codes for multiple threads
>
> Ritesh Harjani (IBM) (15):
>  e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
>  gen_bitmaps: Fix ext2fs_compare_generic_bmap/bitmap logic
>  blkmap64_ba: Add common helper for bits size calculation
>  badblocks: Remove unused badblocks_flags
>  tst_badblocks: Add unit test to verify badblocks list merge api
>  tst_bitmaps_standalone: Add copy and merge bitmaps test
>  tst_bitmaps_pthread: Add merge bitmaps test using pthreads
>  tst_libext2fs_pthread: Add libext2fs merge/clone unit tests
>  e2fsck: Add e2fsck_pass1_thread_join return value
>  e2fsck: Use merge/clone apis of libext2fs
>  e2fsck: Fix io->align assert check
>  e2fsck: Fix double free of inodes_to_process
>  e2fsck: Fix and simplify update_mmp in case of pfsck
>  e2fsck: Make threads call log_out after pthread_join
>  tests/f_multithread: Fix f_multithread related tests
>
> Saranya Muruganandam (3):
>  libext2fs: dupfs: Add fs clone & merge api
>  e2fsck: propagate number of threads
>  e2fsck: Annotating fields in e2fsck_struct
>
> Sebastien Buisson (1):
>  sec: support encrypted files handling in pfsck mode
>
> Wang Shilong (35):
>  badblocks: Add badblocks merge logic
>  libext2fs: Add rbtree bitmap merge logic
>  libext2fs: Add bitmaps merge ops
>  libext2fs: merge quota context after threads finish
>  libext2fs: Add support for ext2fs_test_block_bitmap_range2_valid()
>  libext2fs: Add support to get average group count
>  libext2fs: avoid too much memory allocation in case fs_num_threads
>  e2fsck: Add e2fsck_pass1_merge_bitmap() api
>  e2fsck: rbtree bitmap for dir
>  e2fsck: merge counts after threads finish
>  e2fsck: merge dx_dir_info after threads finish
>  e2fsck: merge dirs_to_hash when threads finish
>  e2fsck: merge context flags properly
>  e2fsck: merge quota context after threads finish
>  e2fsck: serialize fix operations
>  e2fsck: move some fixes out of parallel pthreads
>  e2fsck: split and merge invalid bitmaps
>  e2fsck: merge EA blocks properly
>  e2fsck: kickoff mutex lock for block found map
>  e2fsck: allow admin specify number of threads
>  e2fsck: adjust number of threads
>  e2fsck: fix readahead for pfsck of pass1
>  e2fsck: merge options after threads finish
>  e2fsck: reset lost_and_found after threads finish
>  e2fsck: merge extent depth count after threads finish
>  e2fsck: simplify e2fsck context merging codes
>  e2fsck: set E2F_FLAG_ALLOC_OK after threads
>  e2fsck: wait fix thread finish before checking
>  e2fsck: cleanup e2fsck_pass1_thread_join()
>  e2fsck: make default smallest RA size to 1M
>  e2fsck: update mmp block in one thread
>  e2fsck: reset @inodes_to_rebuild if restart
>  tests: add pfsck test
>  e2fsck: fix memory leaks with pfsck enabled
>  e2fsck: merge casefolded dir lists after thread finish
>
> e2fsck/dirinfo.c                        |  238 ++-
> e2fsck/dx_dirinfo.c                     |   64 +
> e2fsck/e2fsck.8.in                      |    8 +-
> e2fsck/e2fsck.c                         |   11 +
> e2fsck/e2fsck.h                         |  103 +-
> e2fsck/encrypted_files.c                |  139 ++
> e2fsck/logfile.c                        |   13 +-
> e2fsck/pass1.c                          | 1894 +++++++++++++++++++----
> e2fsck/problem.c                        |   11 +
> e2fsck/problem.h                        |    3 +
> e2fsck/readahead.c                      |    4 +
> e2fsck/unix.c                           |   58 +-
> e2fsck/util.c                           |  193 ++-
> lib/ext2fs/Makefile.in                  |   53 +-
> lib/ext2fs/badblocks.c                  |   81 +-
> lib/ext2fs/bitmaps.c                    |   10 +
> lib/ext2fs/bitops.h                     |    2 +
> lib/ext2fs/blkmap64_ba.c                |   20 +-
> lib/ext2fs/blkmap64_rb.c                |   65 +
> lib/ext2fs/bmap64.h                     |    4 +
> lib/ext2fs/dblist.c                     |   38 +
> lib/ext2fs/dupfs.c                      |  183 +++
> lib/ext2fs/ext2_err.et.in               |    3 +
> lib/ext2fs/ext2_io.h                    |    2 +
> lib/ext2fs/ext2fs.h                     |   66 +-
> lib/ext2fs/ext2fsP.h                    |    1 -
> lib/ext2fs/gen_bitmap.c                 |    9 +-
> lib/ext2fs/gen_bitmap64.c               |   72 +-
> lib/ext2fs/icount.c                     |  107 ++
> lib/ext2fs/tst_badblocks.c              |   61 +-
> lib/ext2fs/tst_bitmaps_pthread.c        |  247 +++
> lib/ext2fs/tst_bitmaps_standalone.c     |  170 ++
> lib/ext2fs/tst_libext2fs_pthread.c      |  315 ++++
> lib/ext2fs/undo_io.c                    |   19 +
> lib/ext2fs/unix_io.c                    |   25 +-
> lib/support/mkquota.c                   |   39 +
> lib/support/quotaio.h                   |    3 +
> tests/f_itable_collision/expect.1       |    3 -
> tests/f_multithread/expect.1            |   25 +
> tests/f_multithread/expect.2            |    7 +
> tests/f_multithread/image.gz            |    1 +
> tests/f_multithread/name                |    1 +
> tests/f_multithread/script              |    4 +
> tests/f_multithread_completion/expect.1 |    2 +
> tests/f_multithread_completion/expect.2 |   23 +
> tests/f_multithread_completion/image.gz |    1 +
> tests/f_multithread_completion/name     |    1 +
> tests/f_multithread_completion/script   |    4 +
> tests/f_multithread_logfile/expect.1    |   25 +
> tests/f_multithread_logfile/image.gz    |    1 +
> tests/f_multithread_logfile/name        |    1 +
> tests/f_multithread_logfile/script      |   32 +
> tests/f_multithread_no/expect.1         |   26 +
> tests/f_multithread_no/expect.2         |   23 +
> tests/f_multithread_no/image.gz         |    1 +
> tests/f_multithread_no/name             |    1 +
> tests/f_multithread_no/script           |    4 +
> tests/f_multithread_ok/expect.1         |   15 +
> tests/f_multithread_ok/image.gz         |  Bin 0 -> 796311 bytes
> tests/f_multithread_ok/name             |    1 +
> tests/f_multithread_ok/script           |    4 +
> tests/f_multithread_preen/expect.1      |   11 +
> tests/f_multithread_preen/expect.2      |   23 +
> tests/f_multithread_preen/image.gz      |    1 +
> tests/f_multithread_preen/name          |    1 +
> tests/f_multithread_preen/script        |    4 +
> tests/f_multithread_yes/expect.1        |    2 +
> tests/f_multithread_yes/expect.2        |   23 +
> tests/f_multithread_yes/image.gz        |    1 +
> tests/f_multithread_yes/name            |    1 +
> tests/f_multithread_yes/script          |    4 +
> tests/test_one.in                       |    8 +
> 72 files changed, 4186 insertions(+), 433 deletions(-)
> create mode 100644 lib/ext2fs/tst_bitmaps_pthread.c
> create mode 100644 lib/ext2fs/tst_bitmaps_standalone.c
> create mode 100644 lib/ext2fs/tst_libext2fs_pthread.c
> create mode 100644 tests/f_multithread/expect.1
> create mode 100644 tests/f_multithread/expect.2
> create mode 120000 tests/f_multithread/image.gz
> create mode 100644 tests/f_multithread/name
> create mode 100644 tests/f_multithread/script
> create mode 100644 tests/f_multithread_completion/expect.1
> create mode 100644 tests/f_multithread_completion/expect.2
> create mode 120000 tests/f_multithread_completion/image.gz
> create mode 100644 tests/f_multithread_completion/name
> create mode 100644 tests/f_multithread_completion/script
> create mode 100644 tests/f_multithread_logfile/expect.1
> create mode 120000 tests/f_multithread_logfile/image.gz
> create mode 100644 tests/f_multithread_logfile/name
> create mode 100644 tests/f_multithread_logfile/script
> create mode 100644 tests/f_multithread_no/expect.1
> create mode 100644 tests/f_multithread_no/expect.2
> create mode 120000 tests/f_multithread_no/image.gz
> create mode 100644 tests/f_multithread_no/name
> create mode 100644 tests/f_multithread_no/script
> create mode 100644 tests/f_multithread_ok/expect.1
> create mode 100644 tests/f_multithread_ok/image.gz
> create mode 100644 tests/f_multithread_ok/name
> create mode 100644 tests/f_multithread_ok/script
> create mode 100644 tests/f_multithread_preen/expect.1
> create mode 100644 tests/f_multithread_preen/expect.2
> create mode 120000 tests/f_multithread_preen/image.gz
> create mode 100644 tests/f_multithread_preen/name
> create mode 100644 tests/f_multithread_preen/script
> create mode 100644 tests/f_multithread_yes/expect.1
> create mode 100644 tests/f_multithread_yes/expect.2
> create mode 120000 tests/f_multithread_yes/image.gz
> create mode 100644 tests/f_multithread_yes/name
> create mode 100644 tests/f_multithread_yes/script
>
> --
> 2.37.3
>
