Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAE152811
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgBEJNy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 04:13:54 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:46662 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEJNx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Feb 2020 04:13:53 -0500
Received: by mail-pg1-f170.google.com with SMTP id z124so640278pgb.13;
        Wed, 05 Feb 2020 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=BfYP/sEy4/fJVwSiC+e7+jkNA60RhSADybG7LX07YSI=;
        b=N+DcHxnW2BJxY4co+tn82iKDNsynY1J/dWiGjcFnFPHvS4NIPuTLtRkDet0sfoO437
         02IplSiSBRdqD6MuFtYvOzhc2SCbQLRf49EG9wW0NwGWOAbd8n1gt+RyaM4VZ24c8/xn
         cWFN7ll+ErY2V3LyfYOk8iLpm/ePc75lNtgfE2E55idxLL6xZZmyx1A21mh03m27kLgd
         lMHeECqNpCTwuIcQs8QJDDFlYGJ21SY5JM1uVs1dY0TZjqLkCkT4dA2G4xiMYDBN8te8
         DLM2kMOAly8dE1+vyLHCJxahGwMC/aiS9EvtaJ9KjilWkuYxDYtRaZ0wb8jc78OzLpZE
         ChjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=BfYP/sEy4/fJVwSiC+e7+jkNA60RhSADybG7LX07YSI=;
        b=M1o7J+LQqeSUZ4WIyZhLsxFH1vBY9cU+DTHfNgvP236lb2VBdx3OE7zvgMZsOBw3Uq
         QcEQvhWci0zQz4TZhG2+5ZX7MvCMIq23YpwURsBuQV+dkmeLiQjAgPtBeTaWcGCzujai
         irJDg4Terg9bq2pGny9PXEZ0zx/ZalHaXI+FZWYY/f7QOk14jDlaQwEqfvn8GImpybdL
         UzouD6vsxQR3ickkZHlCS/sz4EPCQvp/Jb/3zROCBOU9RpdBRVaQ5j5/uUTxYg2FPZuJ
         P+VEXURt8HpxM8A6EGoDluQbr/wfYRFMsmIM+e9j4iRU82la25FcpbCcgquPDHFQsDxM
         xrQg==
X-Gm-Message-State: APjAAAWmh+Ii1l2TFciR24iPCpbtaBka9mTQclXjitpD42uZK+wptOdi
        Ow5xX9jE6X7PTEx8pgEEcLoBcX60
X-Google-Smtp-Source: APXvYqy8qXK5+bPfJ+6P9Wbjk+87I50cF81xoOfrU5Z7peu0sFm+qA8fPCkimotMO+rk/Dw94m2h9A==
X-Received: by 2002:a63:f551:: with SMTP id e17mr34932469pgk.162.1580894032684;
        Wed, 05 Feb 2020 01:13:52 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x10sm28081925pfi.180.2020.02.05.01.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:13:51 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:13:44 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: ext4 dio RWF_NOWAIT change
Message-ID: <20200205091344.u5c3nnblezzh5xgb@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Kernel commit 378f32bab3714f04c4e0c3aee4129f6703805550
Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date:   Tue Nov 5 23:02:39 2019 +1100

    ext4: introduce direct I/O write using iomap infrastructure


Changed the logic of dio+RWF_NOWAIT

from:

-       if (!inode_trylock(inode)) {
-               if (iocb->ki_flags & IOCB_NOWAIT)
-                       return -EAGAIN;
-               inode_lock(inode);
-       }


to:

+       if (iocb->ki_flags & IOCB_NOWAIT) {
+               if (!inode_trylock(inode))
+                       return -EAGAIN;
+       } else {
+               inode_lock(inode);
+       }


fstests generic/471 expecet EAGAIN on this situation, so it started to
fail since than.

The current logic is similar with other filesystems, but only ext4 fails
on geneirc/471.

Any thoughts how to fix this?

Thanks,
Murphy
