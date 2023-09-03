Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476DD790DEA
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Sep 2023 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjICUk2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242477AbjICUk1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 16:40:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B790D103
        for <linux-ext4@vger.kernel.org>; Sun,  3 Sep 2023 13:40:24 -0700 (PDT)
Received: from letrec.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 383Ke1oC004437
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Sep 2023 16:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1693773603; bh=Ppr8KeJeHsorQrVaGp9vsaGRferjzXALJp6n2MSlTSY=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=NuQxVZ9mclBiwaN7p4ANjPYWQNpqTpGtI8FNJ5u85Jv/3mpwTxcAb29K7n+Kna8C/
         4vI4MvqtUa4MgoeAF/xkGyWINR5UD3Ncjpfw0mEAkiW9LkFX4ctP3xS5cKfMvAGgJS
         90iGpbU7cHuoe7141EeQnEy74+fZXryjMe78sGlOw67jTfqKOMJ058BxwaGwk2ICWH
         J1lYxuwjpuEreXNGUSPY2daWoB/qGVkGejcIuhrGggVC65+o1dCkrLaKFcoHAKRDYB
         GKCGc3vNkwfFbY05T/dTtO7tMEYZdLLrfvULFg4b9pavzqH0HTCLRS9A0/mZKdCl93
         SGw/ApcX/Ch9A==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9BEC28C026E; Sun,  3 Sep 2023 16:40:01 -0400 (EDT)
Date:   Sun, 3 Sep 2023 16:40:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@kernel.org>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <ZPTvIb6hwIjY7T2M@mit.edu>
References: <20230903120001.qjv5uva2zaqthgk2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903120001.qjv5uva2zaqthgk2@zlang-mailbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 03, 2023 at 08:00:01PM +0800, Zorro Lang wrote:
> Hi ext4 folks,
> 
> Recently I found lots of fstests cases which belong to "recoveryloop" (e.g.
> g/388 [1], g/455 [2], g/475 [3] and g/482 [4]) or does fs shutdown/resize test
> (e.g. ext4/059 [5], g/530 [6]) failed ext4 with 1k blocksize, the kernel is
> linux v6.6-rc0+ (HEAD=b84acc11b1c9).
> 
> I tested with MKFS_OPTIONS="-b 1024", no specific MOUNT_OPTIONS. I hit these
> failure several times, and I didn't hit them on my last regression test on
> v6.5-rc7+. So I think this might be a regression problem. And I didn't hit
> this failures on xfs. If this's a known issue will be fixed soon, feel free
> to tell me.

TL;DR: there definitely seenms to be something going on with g/455 and
g/482 with the ext4/1k blocksize case in Linus's latest upstream tree,
although it wasn't there in the ext4 branch which I sent to Linus to
pull.


Unfortunately, generic/475 is a known failure, especially in the 1k
block size case.  The rate seems to change a bit over time.  For
example from 6.2:

ext4/1k: 522 tests, 2 failures, 45 skipped, 6153 seconds
  Flaky: generic/051: 40% (2/5)   generic/475: 60% (3/5)

and from 6.1.0-rc4:

ext4/1k: 522 tests, 2 failures, 45 skipped, 5660 seconds
  Flaky: generic/051: 60% (3/5)   generic/475: 40% (2/5)

In 6.5-rc3, it looks like the rate has gotten worse:

ext4/1k: 30 tests, 29 failures, 2402 seconds
  Flaky: generic/475: 97% (29/30)

Alas, finding a root cause for generic/475 has been challenging.  I
suspect that it happens when we crash while doing a large truncate on
a highly fragmented file system, such as that the truncate has to span
multiple truncates, with the inode on the orphan list so the kernel
can complete the truncate if we trash mid-truncate when we clean up
the orphan list.  However, that's just a theory, and I don't yet have
hard evidence.


The generic/388 test is very different.  It uses the shutdown ioctl,
and that's something that ext4 has never completely handled correctly.
Doing it right would require adding some locks in hot paths, so it's
one which I've suppressed for all of my ext4 tests[1].

[1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/exclude


The generic/455 and generic/482 tests work by using dm-log-writes, and
that was *not* failing on the branch (v6.5.0-rc3-60-g768d612f7982) for
which I sent a pull request to Linus:

ext4/1k: 10 tests, 63 seconds
  generic/455  Pass     4s
  generic/482  Pass     8s
  generic/455  Pass     5s
  generic/482  Pass     8s
  generic/455  Pass     5s
  generic/482  Pass     7s
  generic/455  Pass     5s
  generic/482  Pass     8s
  generic/455  Pass     5s
  generic/482  Pass     8s
Totals: 10 tests, 0 skipped, 0 failures, 0 errors, 63s

... but I can confirm that it's failing on Linus's upstream (I tested
commit 708283abf896):

ext4/1k: 2 tests, 2 failures, 31 seconds
  generic/455  Failed   4s
  generic/455  Failed   2s
  generic/455  Pass     5s
  generic/455  Failed   3s
  generic/455  Failed   2s
  generic/482  Failed   2s
  generic/482  Failed   3s
  generic/482  Failed   1s
  generic/482  Failed   3s
  generic/482  Failed   4s
Totals: 10 tests, 0 skipped, 9 failures, 0 errors, 29s

						- Ted


P.S.  After doing some digging, it appears generic/455 does have some
failures on 6.4 (20%) and 6.5-rc3 (5%) on the ext4/1k blocksize test
config.  But *something* is definitely causing a much greater failure
rate in Linus's upstream.  The good news is that should make it
relatively easy to bisect.  I'll look into it.  Thanks for flagging
this.
