Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D522F140FCD
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 18:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAQRY4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 12:24:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40450 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727519AbgAQRYz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 Jan 2020 12:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579281894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xJSRhNfq8Tr3ojPfxyB93atGe8xjio+WX3BHwdtb3E=;
        b=fBfVQH3NTGthNIG5ljm1qBQ7yORU3jsNmq1M4QoJYscnbw0LaxGnRXLeVxa1iUtSF3jJe5
        mRffyAdG4v+b0HKvPgjAacz/poimYp6KaEToetcc4cRa/Vf+aVfZHhozybwuK9GCF8oavQ
        T50cDKBPuDjk1H3Al+oZvCl7ilPYLuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-ancvZ7HdO96rWud3lYvvqg-1; Fri, 17 Jan 2020 12:24:50 -0500
X-MC-Unique: ancvZ7HdO96rWud3lYvvqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5196A800D41;
        Fri, 17 Jan 2020 17:24:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E45A7DB34;
        Fri, 17 Jan 2020 17:24:48 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9262787092;
        Fri, 17 Jan 2020 17:24:47 +0000 (UTC)
Date:   Fri, 17 Jan 2020 12:24:47 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, tytso@mit.edu,
        adilger@dilger.ca
Cc:     LTP List <ltp@lists.linux.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, chrubis <chrubis@suse.cz>,
        linux-ext4@vger.kernel.org
Message-ID: <1555311261.2497849.1579281887353.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
References: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
Subject: Re: LTP: statx06: FAIL: Birth time < before time
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.25, 10.4.195.23]
Thread-Topic: statx06: FAIL: Birth time < before time
Thread-Index: BGRUuw3BMnr+jewWkQoEmCDnUAKxyQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



----- Original Message -----
> LTP syscalls statx06 test case getting failed from linux next 20200115
> tag onwards on all x86_64, i386, arm and arm64 devices
> 
> Test output:
> statx06.c:152: FAIL: Birth time < before time

[CC Theo & linux-ext4]

It's returning '0' in stx_btime for STATX_ALL or STATX_BTIME.

Looking at changes, I suspect:
  commit 927353987d503b24e1813245563cde0c6167af6e
  Author: Theodore Ts'o <tytso@mit.edu>
  Date:   Thu Nov 28 22:26:51 2019 -0500
    ext4: avoid fetching btime in ext4_getattr() unless requested

and that perhaps it should be instead...

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c8355f022e6e..6d76eb6d2e7f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5398,7 +5398,7 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
        struct ext4_inode_info *ei = EXT4_I(inode);
        unsigned int flags;

-       if ((query_flags & STATX_BTIME) &&
+       if ((request_mask & STATX_BTIME) &&
            EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime)) {
                stat->result_mask |= STATX_BTIME;
                stat->btime.tv_sec = ei->i_crtime.tv_sec;

That allows test to pass again.

> statx06.c:156: PASS: Modified time Passed
> statx06.c:156: PASS: Access time Passed
> statx06.c:156: PASS: Change time Passed
> 
> strace output snippet:
> [pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000})
> = 0
> [pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
> [pid   498] openat(AT_FDCWD, \"mount_ext/test_file.txt\",
> O_RDWR|O_CREAT, 0666) = 3
> [pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000})
> = 0
> [pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
> [pid   498] statx(AT_FDCWD, \"mount_ext/test_file.txt\",
> AT_STATX_SYNC_AS_STAT, STATX_ALL, {stx_mask=STATX_BASIC_STATS,
> stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=0, ...}) = 0
> [pid   498] write(2, \"statx06.c:152: \33[1;31mFAIL: \33[0m\"...,
> 57statx06.c:152: [1;31mFAIL: [0mBirth time < before time
> ) = 57
> 
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/1107634#L2276
> 
> Test results comparison link,
> https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-syscalls-tests/statx06
> 
> Test case link,
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/statx/statx06.c
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> 

