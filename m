Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0F340CB9
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Mar 2021 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhCRSQq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhCRSQQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 14:16:16 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40509C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 11:16:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 94so4829596qtc.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Z5JvJi+HTjCGsE7ucXOoCnR2oyC4fJqRuW05biMaRZg=;
        b=GnGHsls6FcTIVkyudqfwul4XqEW+otcbyxbYr1PXg/jQE77zQlXmE/bKqrjlyUpRiv
         sVAHU/H1GR1QOqtYR7O2T7MoEPJqns6T6537WXmuSJajXpothh6fTkmdM1qcOcJA4kJ9
         +R1HFEcSxnHaBjObWwGrikrzc3B1lcJ+qPuoLJq456qPD124nfE+eT+HhGVZVsqLH9j2
         lWtCmM0USTLozSj2WZhbJu+1ZdZzYuZCQpQHPMGpzRGiQKiLQlokZwuYFyzdh+ezUIGT
         R0uAq3MINUzfc6tN7x+1PfG64jns6ZaxzAgQuXv4OKxq0mEClDT7+H6hwkx5iKUjr5mN
         l3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z5JvJi+HTjCGsE7ucXOoCnR2oyC4fJqRuW05biMaRZg=;
        b=jnuz8vgh+iZps4g6+1DhY56IGaXoS8zFmH4d5h4kfVrK2C3C6zEaB8KBdRbmKBqlA7
         Bw/MRqO6k9/rWpK/FcVhUvcddfBnsqKwrh8uqUDWsWtGQ6ac0nzPwkZ+NlyrS3F63Or1
         7+AJdF9OG2jIE5S0njbqRV4YtXqWtKCAkpZYZ/qnoVdmr5k0stKUUQveJwwUDCenAWlp
         FvkuMuimPVfhbzByijh+4UpnFkFsLTjfiCVMFhOvfJ5z73j2bwnj/Mcg5h/S1ag8KUDG
         xpluLyp57CTXA4stdbu7FBaJ9SiJBk2wvyT+hXf00EHJzvRKEeQpHGsCnab1EGr8xdD+
         DHyg==
X-Gm-Message-State: AOAM533qOUdT4tYFWOAEfWxkhD5CFnMznuRlOr2JNEikUY8w2FaYNAjk
        AQqMEiXiORPOGQQx6DgQJsm3A9OOhvU=
X-Google-Smtp-Source: ABdhPJyYKXBF9UIsSlEH25YBfgn0IsU1o8lW3ONDVe2vQsgNKTRTxFy0nwfx8B+a3hodKxSA9+ot6g==
X-Received: by 2002:aed:20cd:: with SMTP id 71mr5072985qtb.346.1616091375344;
        Thu, 18 Mar 2021 11:16:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id i9sm2349320qko.69.2021.03.18.11.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:16:15 -0700 (PDT)
Date:   Thu, 18 Mar 2021 14:16:13 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, willy@infradead.org
Subject: generic/418 regression seen on 5.12-rc3
Message-ID: <20210318181613.GA13891@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
running the 1k test case using kvm-xfstests.  I was then able to bisect the
failure to a patch landed in the -rc1 merge window:

(bd8a1f3655a7) mm/filemap: support readpage splitting a page

Typical test output resulting from a failure looks like:

     QA output created by 418
    +cmpbuf: offset 0: Expected: 0x1, got 0x0
    +[6:0] FAIL - comparison failed, offset 3072
    +diotest -w -b 512 -n 8 -i 4 failed at loop 0
     Silence is golden
    ...

I've also been able to reproduce the failure on -rc3 in the 4k test case as
well.  The failure frequency there was 10 out of 100 runs.  It was anywhere
from 2 to 8 failures out of 100 runs in the 1k case.

So, the failure isn't dependent upon block size less than page size.

Eric
