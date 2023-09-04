Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3A79113B
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 08:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbjIDGIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 02:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjIDGIs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 02:08:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA9E1
        for <linux-ext4@vger.kernel.org>; Sun,  3 Sep 2023 23:08:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38468K8g000566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 02:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1693807702; bh=8FOK8ZwU2F8j90ITve4Gg0SpbomBS5ivcppkFy7L10g=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=ckk+xfVU7q1ex6OaN64cK+9IOqiaR1Fw26OBXcQdwH9PjxiQW/dnqWHmG61gCAEfO
         5H5triWso75mUWwksQsEv1i+nrG7D5gSNDiQxM1wmmWUBdWrlgz2nRi4iohcrvxw0Y
         CqjO1XLpVdABiqkz9SAB9QSxVSul+Jrw97n2XvPjhoGWHLwGzuph093J1JGtiALInk
         5M1L6fHCEOVJ1fnTe/Fck4EDOrur4ZovJfw3yqlALgcB1tyoGiXByJBBo2CVXoZok3
         c+JkW/0tDICLVZFl/VcJdA9tWnWWjFyaC0MmmPesP/qsDYpevdsVn6F0Hd+tUyG3Ms
         M6tVJ0/BhiiBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E032C15C023F; Mon,  4 Sep 2023 02:08:19 -0400 (EDT)
Date:   Mon, 4 Sep 2023 02:08:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@kernel.org>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <20230904060819.GB701295@mit.edu>
References: <20230903120001.qjv5uva2zaqthgk2@zlang-mailbox>
 <ZPTvIb6hwIjY7T2M@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPTvIb6hwIjY7T2M@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#regzbot introduced: 8147c4c4546f9f05ef03bb839b741473b28bb560 ^

OK, I've isolated the regression of generic/455 failing with ext4/1k
to this commit, which came in via the mm tree.  Nothing seems
*obviously* wrong, but I'm not sure if there are any differences in
the semantics of the new folio functions such as kmap_local_folio,
offset_in_folio, set_folio_bh() which might be making a difference.

Using kvm-xfstests[1] I bisected this via the command:

% install-kconfig ; kbuild ; kvm-xfstests -c ext4/1k -C 10 generic/455

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md


And the bisection pointed me at this commit:

    commit 8147c4c4546f9f05ef03bb839b741473b28bb560 (refs/bisect/bad)
    Author: Matthew Wilcox (Oracle) <willy@infradead.org>
    AuthorDate: Thu Jul 13 04:55:11 2023 +0100
    Commit: Andrew Morton <akpm@linux-foundation.org>
    CommitDate: Fri Aug 18 10:12:30 2023 -0700

        jbd2: use a folio in jbd2_journal_write_metadata_buffer()
    
During the bisection, I treated a commit with 3+ failures as "bad",
and 0-2 commits as "good".  Running generic/455 50 times to get a
sense of the failure, with the first bad commit (8147c4c4546f), I got:

    ext4/1k: 50 tests, 21 failures, 223 seconds
      Flaky: generic/455: 42% (21/50)
    Totals: 50 tests, 0 skipped, 21 failures, 0 errors, 223s

While with the immediately preceding commit (07811230c3cd), I got:

    ext4/1k: 50 tests, 4 failures, 235 seconds
      Flaky: generic/455:  8% (4/50)
    Totals: 50 tests, 0 skipped, 4 failures, 0 errors, 235s



Comparing these two commits (8147c4c4546f vs 07811230c3cd) using the
ext4 with a 4k block size, I get:

    ext4/4k: 50 tests, 2 failures, 365 seconds
      Flaky: generic/455:  4% (2/50)
    Totals: 50 tests, 0 skipped, 2 failures, 0 errors, 365s

vs

    ext4/4k: 50 tests, 2 failures, 349 seconds
      Flaky: generic/455:  4% (2/50)
    Totals: 50 tests, 0 skipped, 2 failures, 0 errors, 349s

So issue seems to be specifically with a sub-page size block size,
since ext4/4k doesn't show any issues, while ext4/1k does.

   	       	     		       	 - Ted
