Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC29889EC9
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHLMw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 08:52:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45548 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHLMw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 08:52:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so4375123pfq.12
        for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2019 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TfzP6zL2stFuMAxXlrUn2Ni5xIsBGWvPnSLkK4Zd43o=;
        b=B6bDBy4nOV1W2PvUjTzK7hL4Bw0VCO30D/Jl/onLBsFVu/D32+sxj8Eft8xzxKI5kH
         O4LAUY4ht9mBMqmaqMl2Tg/xwt2fSlhIebpXBLb5uUe1r82jH06FVgyiFGGdjYAXpIJ9
         PZiWKEgajZdf6IIYNrvqyIMkqfID7RuDaKV4UXpdYqo6s2T28kytAftC3ypvtG9p/raZ
         MQHA8sh139XjZ1MSmaF/1oByHGLQmOCZabgsVMS4D0T/oRKDhYUhVxZyU0W2D3KsCiks
         61ANjzk4yjcR6uSn+nAahRNEt8Ha0nPaw4wTQU92W+PzQGKBtNITKjPQYUOLf68DFQzI
         AKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TfzP6zL2stFuMAxXlrUn2Ni5xIsBGWvPnSLkK4Zd43o=;
        b=KzvGi4/HWl0mq47tU3c7BzHvhfQ7ZomGs3RaNHq7xYSjjy2wP2NR0rxHhD9+yC5aOT
         p+UlFD2Im/LVp+n2MOkmYp7nyZBufXAin+zRLtwZEZ1JJp2U0s7pjn9YWeISxrUL4moq
         VyrVs5h1LIcp1XP3shAeqUqe6UeHkCyXJpGZLPyzlJWwrrVJSdkKIAh67g+vss80csC5
         Nd09UnjxtQmwvA/AbqJG+TTGF0r7ev4AdzxkJaE22IDkiUAfQJ6D/SpmnyvrDdVAQZbK
         oXjACXzx/adDG6h8WvS9vjoLN1T/eSuONbajAXNVjc7yR5OtgH0m5Xz9Pb1737l+T7Bg
         GPjw==
X-Gm-Message-State: APjAAAUAxyX02I+czbmizgeEPu7ozQmM8WjoOLFKv0QYHyLc3gsBoahN
        6DIwLzBxqrIH8ulVypCIntMmJI00PA==
X-Google-Smtp-Source: APXvYqwcmZgbOg+gKnP5pE8QeF+hri9HRBIfRb5RHaJj2JY9E/KWJ3lsBoCv7VB7h4bS5k+2LHxsJg==
X-Received: by 2002:a65:680b:: with SMTP id l11mr30157906pgt.35.1565614346375;
        Mon, 12 Aug 2019 05:52:26 -0700 (PDT)
Received: from neo.home (n1-42-37-191.mas1.nsw.optusnet.com.au. [1.42.37.191])
        by smtp.gmail.com with ESMTPSA id g1sm172467638pgg.27.2019.08.12.05.52.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:52:25 -0700 (PDT)
Date:   Mon, 12 Aug 2019 22:52:19 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        riteshh@linux.ibm.com
Subject: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <cover.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series converts the ext4 direct IO code paths to make use of the
iomap infrastructure and removes the old buffer_head direct-io based
implementation. The result is that ext4 is converted to the newer framework
and that it may _possibly_ gain a performance boost for O_SYNC | O_DIRECT IO.

These changes have been tested using xfstests in both DAX and non-DAX modes
using various configurations i.e. 4k, dioread_nolock, dax.

Matthew Bobrowski (5):
  ext4: introduce direct IO read code path using iomap infrastructure
  ext4: move inode extension/truncate code out from ext4_iomap_end()
  iomap: modify ->end_io() calling convention
  ext4: introduce direct IO write code path using iomap infrastructure
  ext4: clean up redundant buffer_head direct IO code

 fs/ext4/ext4.h        |   3 -
 fs/ext4/extents.c     |   8 +-
 fs/ext4/file.c        | 329 +++++++++++++++++++++++++++-------
 fs/ext4/inode.c       | 488 +++++---------------------------------------------
 fs/iomap/direct-io.c  |   9 +-
 fs/xfs/xfs_file.c     |  17 +-
 include/linux/iomap.h |   4 +-
 7 files changed, 322 insertions(+), 536 deletions(-)

-- 
2.16.4


-- 
Matthew Bobrowski
